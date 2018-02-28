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
    func inBetween(_ first: Point<CoordinateType>, _ mid: Point<CoordinateType>, _ last: Point<CoordinateType>) -> Bool {
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
    /// clockwise, if moving from p1 to p2 to p3 there is a right turn
    /// counterclockwise, if moving from p1 to p2 to p3 there is a left turn
    ///
    /// The formula for the calculation is based on comparing the slopes of the two line segments, p1p2 and p2p3.
    /// Rather than comparing the two slopes directly, a modified version of the slope comparison is used to
    /// allow comparison of slopes where one or both line segments may be vertical.
    ///
    internal
    func orientation(_ p1: Point<CoordinateType>, _ p2: Point<CoordinateType>, _ p3: Point<CoordinateType>) -> Orientation {
        let difference = (p2.y - p1.y) * (p3.x - p2.x) - (p2.x - p1.x) * (p3.y - p2.y)

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
    /// When the line segments p1p2 and p3p4 intersect, true will be returned with the following exceptions.
    ///
    /// lastFirstOk set to true means its okay that p2 and p3 are the same point. This will be ignored for the intersection calculation.
    /// This will happen commonly in a LinearString.
    ///
    /// firstLastOk set to true means its okay that p1 and p4 are the same point. This will be ignored for the intersection calculation.
    /// This will happen commonly in a LinearRing.
    ///
    internal
    func segmentsIntersect(_ p1: Point<CoordinateType>, _ p2: Point<CoordinateType>, _ p3: Point<CoordinateType>, _ p4: Point<CoordinateType>, _ lastFirstOk: Bool = false, _ firstLastOk: Bool = false) -> Bool {

        /// Calculate various orientations
        let o123 = orientation(p1, p2, p3)    // collinear if p2 = p3 true
        let o124 = orientation(p1, p2, p4)    // collinear if p1 = p4 true
        let o341 = orientation(p3, p4, p1)    // collinear if p1 = p4 true
        let o342 = orientation(p3, p4, p2)    // collinear if p2 = p3 true

        /// Points touch cases
        /// p2 and p3 are the same point.
        if p2 == p3 {
            let lineSegment1 = (o341 == .collinear && inBetween(p3, p1, p4))
            let lineSegment2 = (o124 == .collinear && inBetween(p1, p4, p2))
            return (!lastFirstOk || lineSegment1 || lineSegment2)
        }

        /// p1 and p4 are the same point.
        if p1 == p4 {
            let lineSegment1 = (o342 == .collinear && inBetween(p3, p2, p4))
            let lineSegment2 = (o123 == .collinear && inBetween(p1, p3, p2))
            return (!firstLastOk || lineSegment1 || lineSegment2)
        }

        /// Normal intersection
        if o123 != o124 && o341 != o342 {
            return true
        }

        /// Collinear cases
        if  (o123 == .collinear && inBetween(p1, p3, p2)) ||
            (o124 == .collinear && inBetween(p1, p4, p2)) ||
            (o341 == .collinear && inBetween(p3, p1, p4)) ||
            (o342 == .collinear && inBetween(p3, p2, p4)) {
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
                let p1 = Point<CoordinateType>(coordinate: elements[i], precision: self.precision, coordinateSystem: self.coordinateSystem)
                let p2 = Point<CoordinateType>(coordinate: elements[i+1], precision: self.precision, coordinateSystem: self.coordinateSystem)
                for j in (i+1)..<header.pointee.count - 1 {
                    let p3 = Point<CoordinateType>(coordinate: elements[j], precision: self.precision, coordinateSystem: self.coordinateSystem)
                    let p4 = Point<CoordinateType>(coordinate: elements[j+1], precision: self.precision, coordinateSystem: self.coordinateSystem)
                    var intersect: Bool = false
                    if j == i+1 {
                        intersect = segmentsIntersect(p1, p2, p3, p4, true)
                    } else if i == 0 && j == header.pointee.count - 2 {
                        intersect = segmentsIntersect(p1, p2, p3, p4, false, true)
                    } else {
                        intersect = segmentsIntersect(p1, p2, p3, p4)
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

        return self.buffer.withUnsafeMutablePointers { (header, elements) -> Geometry in

            var multiPoint = MultiPoint<CoordinateType>(precision: self.precision, coordinateSystem: self.coordinateSystem)

            if !self.isClosed() && header.pointee.count >= 2 {

                /// Note: direct subscripts protected by self.count >= 2 above.
                multiPoint.append(Point<CoordinateType>(coordinate: elements[0], precision: self.precision, coordinateSystem: self.coordinateSystem))
                multiPoint.append(Point<CoordinateType>(coordinate: elements[header.pointee.count - 1], precision: self.precision, coordinateSystem: self.coordinateSystem))

            }
            return multiPoint
        }
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
