///
///  LinearRing+Geometry.swift
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

///
/// `Geometry` protocol implementation.
///
/// Note: See `CoordinateCollectionType` for func implementations not present here.
///
extension LinearRing {

    ///
    /// - Returns: the y-intercept of the line with the given slope that passes through the given coordinate, if the line is not vertical.
    ///            Else, if vertical, the x-intercept is returned.
    ///            The second value in the input tuple is true if the line is vertical.
    ///
    fileprivate func intercept(_ slope: (Double, Bool), _ coordinate: Coordinate) -> (Double, Bool) {

        if slope.1 {
            return (coordinate.x, true)
        } else {
            return ((coordinate.y - slope.0 * coordinate.x), false)
        }
    }

    ///
    /// - Returns: the slope as a tuple.
    ///            The first value is the slope, if the line is not vertical.
    ///            The second value is a boolean flag indicating whether the line is vertical.  If it is, the first value is irrelevant and will typically be zero.
    ///
    fileprivate func slope(_ coordinate1: Coordinate, _ coordinate2: Coordinate) -> (Double, Bool) {

        /// Check for the vertical case
        guard coordinate1.x != coordinate2.x else {
            return (0, true)
        }

        /// Normal case
        return ((coordinate2.y - coordinate1.y) / (coordinate2.x - coordinate1.x), false)
    }

    ///
    /// - Returns: the slope as a tuple.
    ///            The first value is the slope, if the line is not vertical.
    ///            The second value is a boolean flag indicating whether the line is vertical.  If it is, the first value is irrelevant and will typically be zero.
    ///
    fileprivate func slope(_ segment: Segment) -> (Double, Bool) {

        return slope(segment.leftCoordinate, segment.rightCoordinate)
    }

    ///
    /// - Returns: true if the bounding boxes touch at just a single coordinate
    ///
    fileprivate func boundingBoxesTouchAtCoordinate(segment: Segment, other: Segment) -> Bool {
        let range1x = (Swift.min(segment.leftCoordinate.x, segment.rightCoordinate.x), Swift.max(segment.leftCoordinate.x, segment.rightCoordinate.x))
        let range1y = (Swift.min(segment.leftCoordinate.y, segment.rightCoordinate.y), Swift.max(segment.leftCoordinate.y, segment.rightCoordinate.y))
        let range2x = (Swift.min(other.leftCoordinate.x, other.rightCoordinate.x), Swift.max(other.leftCoordinate.x, other.rightCoordinate.x))
        let range2y = (Swift.min(other.leftCoordinate.y, other.rightCoordinate.y), Swift.max(other.leftCoordinate.y, other.rightCoordinate.y))

        if ((range1x.1 == range2x.0) && (range1y.1 == range2y.0)) ||
           ((range1x.1 == range2x.0) && (range1y.0 == range2y.1)) ||
           ((range1x.0 == range2x.1) && (range1y.0 == range2y.1)) ||
            ((range1x.0 == range2x.1) && (range1y.1 == range2y.0)) {
            return true
        }

        return false
    }

    ///
    /// - Returns: true if the bounding boxes overlap for two one dimensional line ranges.
    ///            The first value for each range is the minimum value and the second is the maximum value.
    ///
    fileprivate func boundingBoxesOverlap1D(range1: (Double, Double), range2: (Double, Double)) -> Bool {
        return range1.1 >= range2.0 && range2.1 >= range1.0
    }

    ///
    /// - Returns: true if the bounding boxes overlap for two line segments
    ///
    fileprivate func boundingBoxesOverlap2D(segment: Segment, other: Segment) -> Bool {
        let range1x = (Swift.min(segment.leftCoordinate.x, segment.rightCoordinate.x), Swift.max(segment.leftCoordinate.x, segment.rightCoordinate.x))
        let range1y = (Swift.min(segment.leftCoordinate.y, segment.rightCoordinate.y), Swift.max(segment.leftCoordinate.y, segment.rightCoordinate.y))
        let range2x = (Swift.min(other.leftCoordinate.x, other.rightCoordinate.x), Swift.max(other.leftCoordinate.x, other.rightCoordinate.x))
        let range2y = (Swift.min(other.leftCoordinate.y, other.rightCoordinate.y), Swift.max(other.leftCoordinate.y, other.rightCoordinate.y))
        let box1 = (range1x, range1y)
        let box2 = (range2x, range2y)

        return boundingBoxesOverlap1D(range1: box1.0, range2: box2.0) && boundingBoxesOverlap1D(range1: box1.1, range2: box2.1)
    }

    enum LocationType {
        case onBoundary, onInterior, onExterior
    }

    ///
    /// - Returns: a LocationType depending on where the coordinate is relative to the line segment.
    ///
    fileprivate func coordinateIsOnLineSegment(_ coordinate: Coordinate, segment: Segment) -> LocationType {

        /// Will likely use precision later, but use EPSILON for now.
        let EPSILON = 0.01

        /// Check if the coordinate is in between the line segment endpoints in both x and y.
        let segmentLeft     = segment.leftCoordinate
        let segmentRight    = segment.rightCoordinate
        let leftX           = segmentLeft.x
        let leftY           = segmentLeft.y
        let rightX          = segmentRight.x
        let rightY          = segmentRight.y
        if  (coordinate.x < leftX && coordinate.x < rightX) ||
            (coordinate.x > leftX && coordinate.x > rightX) ||
            (coordinate.y < leftY && coordinate.y < rightY) ||
            (coordinate.y > leftY && coordinate.y > rightY) {
            return .onExterior
        }

        /// Check if the coordinate is on the boundary of the line segment
        if (coordinate == segmentLeft) || (coordinate == segmentRight) {
            return .onBoundary
        }

        /// Check for the case where the line segment is horizontal
        if (leftY == rightY) && (coordinate.y == leftY) && ((coordinate.x <= leftX && coordinate.x >= rightX) || (coordinate.x >= leftX && coordinate.x <= rightX)) {
            return .onInterior
        }

        /// Check for the cases where the line segment is vertical
        if (leftX == rightX) && (coordinate.x == leftX) && ((coordinate.y <= leftY && coordinate.y >= rightY) || (coordinate.y >= leftY && coordinate.y <= rightY)) {
            return .onInterior
        }

        /// General case
        let slope = (rightY - leftY) / (rightX - leftX)
        let value = leftY - slope * leftX
        if abs(coordinate.y - (slope * coordinate.x + value)) < EPSILON {
            return .onInterior
        }

        return .onExterior
    }

    ///
    /// - Returns: the value of a 2x2 determinant
    ///
    /// | a b |
    /// | c d |
    ///
    fileprivate func det2d(a: Double, b: Double, c: Double, d: Double) -> Double {
        return a*d - b*c
    }

    ///
    /// - Returns: a numeric value indicating where point p2 is relative to the line determined by p0 and p1.
    ///            value > 0 implies p2 is on the left
    ///            value = 0 implies p2 is on the line
    ///            value < 0 implies p2 is to the right
    ///
    fileprivate func isLeft(p0: Coordinate, p1: Coordinate, p2: Coordinate) -> Double {
        return (p1.x - p0.x)*(p2.y - p0.y) - (p2.x - p0.x)*(p1.y -  p0.y)
    }

    ///
    /// - Returns: a Dimension of the intersection of the two line segments passed in.
    ///
    fileprivate func intersects(segment: Segment, other: Segment) -> Dimension {

        ///
        /// Check the bounding boxes.  They must overlap if there is an intersection.
        ///
        guard boundingBoxesOverlap2D(segment: segment, other: other) else {
            return .empty
        }

        ///
        /// Get location of endpoints
        ///
        let segment1Boundary1Location = coordinateIsOnLineSegment(segment.leftCoordinate, segment: other)
        let segment1Boundary2Location = coordinateIsOnLineSegment(segment.rightCoordinate, segment: other)
        let segment2Boundary1Location = coordinateIsOnLineSegment(other.leftCoordinate, segment: segment)
        let segment2Boundary2Location = coordinateIsOnLineSegment(other.rightCoordinate, segment: segment)

        ///
        /// Check cases where at least one boundary point of one segment touches the other line segment
        ///
        let leftSign   = isLeft(p0: segment.leftCoordinate, p1: segment.rightCoordinate, p2: other.leftCoordinate)
        let rightSign  = isLeft(p0: segment.leftCoordinate, p1: segment.rightCoordinate, p2: other.rightCoordinate)
        let leftSign2  = isLeft(p0: other.leftCoordinate, p1: other.rightCoordinate, p2: segment.leftCoordinate)
        let rightSign2 = isLeft(p0: other.leftCoordinate, p1: other.rightCoordinate, p2: segment.rightCoordinate)
        let oneLine    = leftSign == 0 && rightSign == 0 /// Both line segments lie on one line
        if  (segment1Boundary1Location != .onExterior) ||  (segment1Boundary2Location != .onExterior) ||
            (segment2Boundary1Location != .onExterior) ||  (segment2Boundary2Location != .onExterior) {

            if (segment1Boundary1Location != .onExterior) &&  (segment1Boundary2Location != .onExterior) {
                /// Segment is completely contained in other
                return .one
            } else if (segment2Boundary1Location != .onExterior) &&  (segment2Boundary2Location != .onExterior) {
                /// Other is completely contained in segment
                return .one
            } else if (segment1Boundary1Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                return .zero
            } else if (segment1Boundary1Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                return .zero
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                return .zero
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                return .zero
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) ||
                      (segment1Boundary2Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                return .zero
            } else if oneLine {
                /// If you reach here, the two line segments overlap by an amount > 0, but neither line segment is contained in the other.
                return .one
            } else {
                /// If you reach here, the two line segments touch at a single point that is on the boundary of one segment and the interior of the other.
                return .zero
            }
        }

        ///
        /// Check whether the two segments intersect at an interior point of each.
        /// Since the cases where the segments touch at a boundary point have all been handled, intersecting here is guaranteed to be in segments' interior.
        ///
        /// The two segments will intersect if and only if the signs of the isLeft function are non-zero and are different for both segments.
        /// This means one segment cannot be completely on one side of the other.
        ///
        /// TODO: We will need to separate out the = 0 cases below because these imply the segments fall on the same line.
        ///
        /// The line segments must intersect at a single point.  Calculate and return the point of intersection.
        ///
        let x1 = segment.leftCoordinate.x
        let y1 = segment.leftCoordinate.y
        let x2 = segment.rightCoordinate.x
        let y2 = segment.rightCoordinate.y
        let x3 = other.leftCoordinate.x
        let y3 = other.leftCoordinate.y
        let x4 = other.rightCoordinate.x
        let y4 = other.rightCoordinate.y

//        let det1 = det2d(a: x1, b: y1, c: x2, d: y2)
//        let det2 = det2d(a: x3, b: y3, c: x4, d: y4)
        let det3 = det2d(a: x1, b: 1, c: x2, d: 1)
        let det4 = det2d(a: x3, b: 1, c: x4, d: 1)
        let det5 = det2d(a: y1, b: 1, c: y2, d: 1)
        let det6 = det2d(a: y3, b: 1, c: y4, d: 1)

//        let numx = det2d(a: det1, b: det3, c: det2, d: det4)
//        let numy = det2d(a: det1, b: det5, c: det2, d: det6)
        let den  = det2d(a: det3, b: det5, c: det4, d: det6) // The denominator

        ///
        /// TODO: Add check for den = 0.
        /// The den is 0 when (x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4) = 0
        /// For now we will add guard statement to make sure the den is not zero.
        /// Note that if den is zero, it implies the two line segments are either parallel or
        /// fall on the same line and may or may not overlap.
        /// These cases must be addressed separately.
        ///
        guard den != 0 else {
            /// TODO: Might also have to check for near zero.
            return .empty
        }

//        let x = numx / den
//        let y = numy / den

        var interiorsIntersect = false
        if ((leftSign < 0 && rightSign > 0) || (leftSign > 0 && rightSign < 0)) && ((leftSign2 < 0 && rightSign2 > 0) || (leftSign2 > 0 && rightSign2 < 0)) {
            interiorsIntersect = true
        }

        if interiorsIntersect {
            return .zero
        } else {
            return .empty
        }
    }
    
    ///
    /// - Returns: an integer that is the zero-based index of the coordinate that starts the final non-zero length segment of the linear ring.
    ///            It is assumed that a check has already been performed to assure there are at least three distinct coordinates in the linear ring.
    ///            Note consecutive coordinates can be repeated.
    ///
    fileprivate func lastSegmentStartIndex() -> Int {

        guard self.count >= 4 else { return 0 }
        
        for index in (0..<self.count).reversed() {
            let firstCoord  = self[index]
            let secondCoord = self[index - 1]
            if firstCoord == secondCoord { continue }
            return index - 1
        }
        
        /// This should never happen
        return 0
    }


    ///
    /// - Returns: true if any interior point of the linear ring touches or crosses another interior point.
    ///            Note consecutive coordinates can be repeated.
    ///
    fileprivate func selfIntersects() -> Bool {

        guard self.count >= 4 else { return false }

        var firstSegmentCount = 0
        let finalSegmentStartIndex = lastSegmentStartIndex()
        for firstCoordIndex in 0..<self.count - 2 {

            let firstCoord  = self[firstCoordIndex]
            let secondCoord = self[firstCoordIndex + 1]
            if firstCoord == secondCoord { continue }
            let segment1 = Segment(left: firstCoord, right: secondCoord)
            firstSegmentCount += 1
            var segmentsAfterFirstSegment = 0

            for secondCoordIndex in (firstCoordIndex + 1)..<self.count - 1 {

                let thirdCoord  = self[secondCoordIndex]
                let fourthCoord = self[secondCoordIndex + 1]
                if thirdCoord == fourthCoord { continue }
                let segment2 = Segment(left: thirdCoord, right: fourthCoord)
                segmentsAfterFirstSegment += 1

                var segmentsTouchAtPoint = false
                if (segmentsAfterFirstSegment == 1) || ((firstSegmentCount == 1) && (secondCoordIndex == finalSegmentStartIndex)) {
                    segmentsTouchAtPoint = true
                }

                let intersectionDimension = intersects(segment: segment1, other: segment2)

                switch intersectionDimension {
                case .empty:
                    break
                case .zero:
                    if !segmentsTouchAtPoint {
                        return true
                    }
                case .one,
                     .two:
                    return true
                }
            }
        }

        return false
    }

    ///
    /// - Returns: true if this linear ring has at least three distinct coordinates.
    ///
    fileprivate func hasThreeDifferentCoordinates() -> Bool {

        let coordinate1 = self[0]
        var coordinate2 = coordinate1
        var twoDifferentCoordinates = false
        var threeDifferentCoordinates = false
        for index in 1..<self.count {
            let tempCoordinate = self[index]
            if !twoDifferentCoordinates && coordinate1 != tempCoordinate {
                coordinate2 = tempCoordinate
                twoDifferentCoordinates = true
                return true
            } else if !threeDifferentCoordinates && (coordinate1 != tempCoordinate) && (coordinate2 != tempCoordinate) {
                threeDifferentCoordinates = true
                return true
            }
        }

        return threeDifferentCoordinates
    }

    ///
    /// - Returns: true if this geometric object meets the following constraints:
    ///            • A linear ring must have either 0 or 4 or more coordinates.
    ///            • The first and last coordinates must be equal.
    ///            • Consecutive coordinates may be equal.
    ///            • The interior of the linear ring must not self intersect, ignoring repeated coordinates.
    ///            • If the number of coordinates is greater than 0, there must be at least three different coordinates.
    ///
    public func valid() -> Bool {
        let coordinateCount = self.count
        guard coordinateCount == 0 || coordinateCount >= 4 else {
            return false
        }

        if coordinateCount == 0 {
            return true
        }

        if self[0] != self[coordinateCount - 1] {
            return false
        }

        /// Check all coordinates are valid
        for coordinate in self {
            if coordinate.x.isNaN || coordinate.y.isNaN {
                return false
            }
        }

        /// Check for three different coordinates
        if !hasThreeDifferentCoordinates() {
            return false
        }

        /// Check for no self intersection
        return !selfIntersects()
    }
}
