///
///  LineString+Geometry.swift
///
///  Copyright (c) 2016 Tony Stone
///
///  Licensed under the Apache License, Version 2.0 (the "License");
///  you may not use this file except in compliance with the License.
///  You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///  Unless required by applicable law or agreed to in writing, software
///  distributed under the License is distributed on an "AS IS" BASIS,
///  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  See the License for the specific language governing permissions and
///  limitations under the License.
///
///  Created by Tony Stone on 2/15/2016.
///
import Swift

enum Orientation: Int { case collinear = 0, clockwise, counterclockwise }

extension LineString: Geometry {

    public var dimension: Dimension { return .one }

    public func isEmpty() -> Bool {
        return self.count == 0
    }

    ///
    /// Returns true if point mid is in between the first and last points, endpoints included.
    ///
    /// This function assumes the three points are collinear.
    ///
    internal
    func inBetween(_ first: CoordinateType, _ mid: CoordinateType, _ last: CoordinateType) -> Bool {
        if  mid.x <= Swift.max(first.x, last.x) && mid.x >= Swift.min(first.x, last.x) &&   // in between x values
            mid.y <= Swift.max(first.y, last.y) && mid.y >= Swift.min(first.y, last.y) {    // in between y values
            return true
        }

        return false
    }

    ///
    /// Return the orientation of a sequence of three Points.
    ///
    /// The orientation is defined as:
    /// collinear, if the points fall on a straight line
    /// clockwise, if moving from c1 to c2 to c3 there is a right turn
    /// counterclockwise, if moving from c1 to c2 to c3 there is a left turn
    ///
    /// The formula for the calculation is based on comparing the slopes of the two line segments, c1c2 and c2c3.
    /// Rather than comparing the two slopes directly, a modified version of the slope comparison is used to
    /// allow comparison of slopes where one or both line segments may be vertical.
    ///
    internal
    func orientation(_ c1: CoordinateType, _ c2: CoordinateType, _ c3: CoordinateType) -> Orientation {
        let difference = (c2.y - c1.y) * (c3.x - c2.x) - (c2.x - c1.x) * (c3.y - c2.y)

        /// TODO: May want to check if "value" is near 0 because it is a Double
        if difference == 0 {
            return .collinear
        } else if difference > 0 {
            return .clockwise
        } else {
            return .counterclockwise
        }
    }

    ///
    /// When the line segments c1c2 and c3c4 intersect, true will be returned with the following exceptions.
    ///
    /// lastFirstOk set to true means its okay that c2 and c3 are the same point. This will be ignored for the intersection calculation.
    /// This will happen commonly in a LinearString.
    ///
    /// firstLastOk set to true means its okay that c1 and c4 are the same point. This will be ignored for the intersection calculation.
    /// This will happen commonly in a LinearRing.
    ///
    internal
    func segmentsIntersect(_ c1: CoordinateType, _ c2: CoordinateType, _ c3: CoordinateType, _ c4: CoordinateType, _ lastFirstOk: Bool = false, _ firstLastOk: Bool = false) -> Bool {

        /// Calculate various orientations
        let o123 = orientation(c1, c2, c3)    // collinear if c2 = c3 true
        let o124 = orientation(c1, c2, c4)    // collinear if c1 = c4 true
        let o341 = orientation(c3, c4, c1)    // collinear if c1 = c4 true
        let o342 = orientation(c3, c4, c2)    // collinear if c2 = c3 true

        /// Points touch cases
        /// c2 and c3 are the same point.
        if c2 == c3 {
            let lineSegment1 = (o341 == .collinear && inBetween(c3, c1, c4))
            let lineSegment2 = (o124 == .collinear && inBetween(c1, c4, c2))
            return (!lastFirstOk || lineSegment1 || lineSegment2)
        }

        /// c1 and c4 are the same point.
        if c1 == c4 {
            let lineSegment1 = (o342 == .collinear && inBetween(c3, c2, c4))
            let lineSegment2 = (o123 == .collinear && inBetween(c1, c3, c2))
            return (!firstLastOk || lineSegment1 || lineSegment2)
        }

        /// Normal intersection
        if o123 != o124 && o341 != o342 {
            return true
        }

        /// Collinear cases
        if  (o123 == .collinear && inBetween(c1, c3, c2)) ||
            (o124 == .collinear && inBetween(c1, c4, c2)) ||
            (o341 == .collinear && inBetween(c3, c1, c4)) ||
            (o342 == .collinear && inBetween(c3, c2, c4)) {
                return true
        }

        return false // No intersect
    }

    ///
    /// Determine whether this LineString is considered simple.
    ///
    /// A LineString is simple if no two lines segments share a common point,
    /// other than the common endpoint they naturally share.
    ///
    /// It is also acceptable that the very first point and the last point are the same,
    /// in the case of a LinearRing, assuming there are at least three segments.
    ///
    public
    func isSimple() -> Bool {
        return buffer.withUnsafeMutablePointers { (header, elements) -> Bool in

            /// If there are no more than two coordinates, there can be at most one line segment,
            /// so this line segment cannot self-intersect.
            guard header.pointee.count > 2 else {
                return true
            }

            /// There must be at least two line segments to get to this point.
            for i in 0..<header.pointee.count - 2 {
                let c1 = elements[i]
                let c2 = elements[i+1]
                for j in (i+1)..<header.pointee.count - 1 {
                    let c3 = elements[j]
                    let c4 = elements[j+1]
                    var intersect: Bool = false
                    if j == i+1 {
                        intersect = segmentsIntersect(c1, c2, c3, c4, true)
                    } else if i == 0 && j == header.pointee.count - 2 {
                        intersect = segmentsIntersect(c1, c2, c3, c4, false, true)
                    } else {
                        intersect = segmentsIntersect(c1, c2, c3, c4)
                    }
                    if intersect { return false }
                }
            }
            return true
        }
    }

    ///
    /// - Returns: the closure of the combinatorial boundary of this Geometry instance.
    ///
    /// - Note: The boundary of a LineString if empty is the empty MultiPoint. If not empty it is the first and last point.
    ///
    public func boundary() -> Geometry {

        var boundary = MultiPoint<CoordinateType>(precision: self.precision, coordinateSystem: self.coordinateSystem)

        if !self.isClosed() && self.coordinates.count >= 2 {

            /// Note: direct subscripts protected by self.count >= 2 above.
            boundary.append(Point<CoordinateType>(coordinate: self.coordinates[0], precision: self.precision, coordinateSystem: self.coordinateSystem))
            boundary.append(Point<CoordinateType>(coordinate: self.coordinates[self.coordinates.count - 1], precision: self.precision, coordinateSystem: self.coordinateSystem))
        }
        return boundary
    }

    public func equals(_ other: Geometry) -> Bool {
        if let other = other as? LineString<Iterator.Element> {
            return self.elementsEqual(other, by: { (lhs: Iterator.Element, rhs: Iterator.Element) -> Bool in
                return lhs == rhs
            })
        }
        return false
    }
}
