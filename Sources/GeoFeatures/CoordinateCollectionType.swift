///
///  CoordinateCollectionType.swift
///
///  Copyright (c) 2018 Tony Stone
///
///   Licensed under the Apache License, Version 2.0 (the "License");
///   you may not use this file except in compliance with the License.
///   You may obtain a copy of the License at
///
///   http://www.apache.org/licenses/LICENSE-2.0
///
///   Unless required by applicable law or agreed to in writing, software
///   distributed under the License is distributed on an "AS IS" BASIS,
///   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///   See the License for the specific language governing permissions and
///   limitations under the License.
///
///  Created by Tony Stone on 3/28/18.
///
import Foundation

enum Orientation: Int { case collinear = 0, clockwise, counterclockwise }

///
/// A collection of `Coordinate`s.
///
/// This is the main internal type which represents lines, rings and points.
///
public protocol CoordinateCollectionType: MutableCollection where Element == Coordinate, Index == Int {}

///
/// Extension for all `CoordinateCollectionType` that are also a `Geometry` & `Curve` type.
///
/// - Remarks: This covers `LineString` and `LinearRing`.
///
public extension CoordinateCollectionType where Self: Geometry & Curve {

    ///
    /// The spatial dimension of `self`.
    ///
    /// - Returns: .one if non-empty, or .empty otherwise.
    ///
    /// - SeeAlso: Dimension
    ///
    public var dimension: Dimension {
        return self.isEmpty() ? .empty : .one
    }

    ///
    /// - Returns: true if this Geometry is an empty Geometry.
    ///
    public func isEmpty() -> Bool {
        return self.isEmpty
    }

    ///
    /// - Returns: the closure of the combinatorial boundary of this Geometry instance.
    ///
    /// - Note: The boundary of a LineString if empty is the empty MultiPoint. If not empty it is the first and last point.
    ///
    public func boundary() -> Geometry {

        var boundary = MultiPoint(precision: self.precision, coordinateSystem: self.coordinateSystem)

        if !self.isClosed() && self.count >= 2 {

            /// Note: direct subscripts protected by self.count >= 2 above.
            boundary.append(Point(self[0], precision: self.precision, coordinateSystem: self.coordinateSystem))
            boundary.append(Point(self[self.endIndex - 1], precision: self.precision, coordinateSystem: self.coordinateSystem))
        }
        return boundary
    }

    ///
    /// Returns whether this Geometry instance has anomalous geometric points, such as self intersection or self tangent.
    ///
    /// - Returns: true if the Geometry is considered simple, otherwise false.
    ///
    /// - Remarks: A LinearRing is simple if it does not self intersect (crosses itself).
    ///
    public func isSimple() -> Bool {

        /// If there are no more than two coordinates, there can be at most one line segment,
        /// so this line segment cannot self-intersect.
        guard self.count > 2 else {
            return true
        }

        /// There must be at least two line segments to get to this point.
        for i in 0..<self.endIndex - 2 {
            let c1 = self[i]
            let c2 = self[i+1]
            for j in (i+1)..<self.endIndex - 1 {
                let c3 = self[j]
                let c4 = self[j+1]
                var intersect: Bool = false
                if j == i+1 {
                    intersect = segmentsIntersect(c1, c2, c3, c4, lastFirstOk: true)
                } else if i == 0 && j == self.count - 2 {
                    intersect = segmentsIntersect(c1, c2, c3, c4, lastFirstOk: false, firstLastOk: true)
                } else {
                    intersect = segmentsIntersect(c1, c2, c3, c4)
                }
                if intersect { return false }
            }
        }
        return true
    }

    ///
    /// The min and max X Y values that make up the bounding coordinates of the geometry.
    ///
    /// - Returns: `Bounds` instance containing the minX, minY, maxX, maxY values bounding the geometry or nil if the geometry is empty.
    ///
    public func bounds() -> Bounds? {

        var iterator = self.makeIterator()

        guard let first = iterator.next()
            else { return nil }

        var minX = first.x, maxX = first.x
        var minY = first.y, maxY = first.y

        while let next = iterator.next() {

            minX = Swift.min(minX, next.x)
            maxX = Swift.max(maxX, next.x)

            minY = Swift.min(minY, next.y)
            maxY = Swift.max(maxY, next.y)
        }
        return Bounds(min: (x: minX, y: minY), max: (x: maxX, y: maxY))
    }
}

///
/// Extension for all `CoordinateCollectionType`'s.
///
/// - Remarks: This covers `LineString`, `LinearRing`, and `Point`.
///
internal extension CoordinateCollectionType {

    ///
    /// Returns true if point mid is in between the first and last points, endpoints included.
    ///
    /// This function assumes the three points are collinear.
    ///
    internal
    func inBetween(_ first: Coordinate, _ mid: Coordinate, _ last: Coordinate) -> Bool {
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
    func orientation(_ c1: Coordinate, _ c2: Coordinate, _ c3: Coordinate) -> Orientation {
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
    func segmentsIntersect(_ c1: Coordinate, _ c2: Coordinate, _ c3: Coordinate, _ c4: Coordinate, lastFirstOk: Bool = false, firstLastOk: Bool = false) -> Bool {

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
}
