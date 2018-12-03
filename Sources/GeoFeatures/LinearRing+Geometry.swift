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
    /// - Returns: true if `self` is equal to the `other`.
    ///
    public func equals(_ other: Geometry) -> Bool {
        if let other = other as? LinearRing {
            return self.elementsEqual(other, by: { (lhs: Iterator.Element, rhs: Iterator.Element) -> Bool in
                return lhs == rhs
            })
        }
        return false
    }

    ///
    /// Reduces the geometry to its simplest form, the simplest sequence of points or coordinates,
    /// that is topologically equivalent to the original geometry.  In essence, this function removes
    /// duplication and intermediate coordinates that do not contribute to the overall definition.
    ///
    /// Reducing a LinearRing means (1) removing identical consecutive points, (2) simplifying a sequence
    /// of segments that have the same slope to just a single segment, and (3) removing the end portion
    /// of a LinearRing that is completely contained in an earlier portion of that LinearRing.
    ///
    /// - Returns: the simplified geometry of the same type as the original
    ///
    public func simplify(tolerance: Double) -> LinearRing {

        /// Must have at least 4 points or three lines segments for this algorithm to apply
        guard self.count >= 4 else {
            return self
        }

        /// Part 1 - remove identical consecutive points
        var resultLinearRing1 = LinearRing()
        var lastCoordinate: Coordinate?
        for index in 0..<self.count {
            let currentCoordinate = self[index]
            if currentCoordinate != lastCoordinate {
                resultLinearRing1.append(currentCoordinate)
                lastCoordinate = currentCoordinate
            }
        }

        /// Make sure there is at least two points
        if resultLinearRing1.count == 1 {
            resultLinearRing1.append(resultLinearRing1[0])
        }

        /// Must have at least 4 points or three lines segments for this algorithm to apply
        guard resultLinearRing1.count >= 4 else {
            return resultLinearRing1
        }

        /// Part 2 - combine segments with the same slope into one segment, if the two segments do not overlap.
        /// If the two segments do overlap, they must be kept separate to capture the change in direction.
        var firstSlope: (Double, Bool)      /// The second value, if true, indicates a vertical line
        var secondSlope: (Double, Bool)
        var resultLinearRing2 = LinearRing()
        resultLinearRing2.append(resultLinearRing1[0])
        for lsFirstCoordIndex in 0..<resultLinearRing1.count - 2 {
            let lsFirstCoord  = resultLinearRing1[lsFirstCoordIndex]
            let lsSecondCoord = resultLinearRing1[lsFirstCoordIndex + 1]
            let lsThirdCoord  = resultLinearRing1[lsFirstCoordIndex + 2]
            firstSlope = slope(lsFirstCoord, lsSecondCoord)
            secondSlope = slope(lsSecondCoord, lsThirdCoord)

            if firstSlope != secondSlope {
                resultLinearRing2.append(resultLinearRing1[lsFirstCoordIndex + 1])
            } else {
                let segment1 = Segment(left: lsFirstCoord, right: lsSecondCoord)
                let segment2 = Segment(left: lsSecondCoord, right: lsThirdCoord)
                let lineSegmentIntersection = intersection(segment: segment1, other: segment2)
                if lineSegmentIntersection.firstSubsetOfSecond || lineSegmentIntersection.secondSubsetOfFirst {
                    resultLinearRing2.append(resultLinearRing1[lsFirstCoordIndex + 1])
                }
            }
        }

        /// Add the last coordinate
        resultLinearRing2.append(resultLinearRing1[resultLinearRing1.count - 1])

        /// Must have at least 4 points or three lines segments for this algorithm to appl
        guard resultLinearRing2.count >= 4 else {
            return resultLinearRing2
        }

        /// Part 3 - remove the portions of the LinearRing that is completely contained in an earlier portion of that LinearRing
        /// Note this algorithm is not complete in that it will only remove segments in the following circumstances:
        /// - When the section of the LinearRing is a loop and that loop or its reverse matches a previous loop
        /// - (Possibly more to come)
        let resultLinearRing3 = removeDuplicateLoops(resultLinearRing2)

        return resultLinearRing3
    }

    /// Have to use class rather than struct here to update the values in an array.
    class Loop {
        var startingIndex: Int          /// The Int is the starting index of the loop in the LinearRing
        var coordinates: [Coordinate]   /// Array of coordinates in the loop.  The start and end coordinates will be the same, if the loop is closed.

        var closed: Bool {               /// The Bool indicates whether the loop has been closed.
            get {
                return (coordinates.count >= 2) && (coordinates[0] == coordinates[coordinates.count - 1])
            }
        }

        init(_ startingIndex: Int, _ coordinates: [Coordinate]) {
            self.startingIndex = startingIndex
            self.coordinates = coordinates
        }
    }

    /// Remove the duplicate loops of a LinearRing.
    /// It is assumed that duplicate consecutive points have been previously removed.
    /// Note that depending on the size of the LinearRing, this could be computationally expensive.
    fileprivate func removeDuplicateLoops(_ linearRing: LinearRing) -> LinearRing {
        var loops = [Loop]()
        for index in 0..<linearRing.count {
            /// Update all the loops
            let currentCoordinate = linearRing[index]
            for loop in loops {
                /// If the loop is not closed, append the new coordinate.
                if !loop.closed {
                    loop.coordinates.append(currentCoordinate)
                }
            }
            /// Add a new loop with just the current coordinate
            loops.append(Loop(index, [currentCoordinate]))
        }

        var closedLoops = [Loop]()
        for loop in loops {
            if loop.closed {
                closedLoops.append(loop)
            }
        }

        guard closedLoops.count > 1 else {
            return linearRing
        }

        var indicesToRemove = [Int]()
        for index1 in 0..<closedLoops.count - 1 {
            let loop1 = closedLoops[index1]
            for index2 in (index1 + 1)..<closedLoops.count {
                let loop2 = closedLoops[index2]
                if loop1.coordinates.count == loop2.coordinates.count {
                    /// Check whether the loops match in forward order
                    let coordinatesCount = loop1.coordinates.count
                    var coordinatesMatch = true
                    for index in 0..<coordinatesCount {
                        if loop1.coordinates[index] != loop2.coordinates[index] {
                            coordinatesMatch = false
                            break
                        }
                    }
                    if !coordinatesMatch {
                        /// Check whether the loops match in reverse order
                        coordinatesMatch = true
                        for index in 0..<coordinatesCount {
                            if loop1.coordinates[index] != loop2.coordinates[coordinatesCount - index - 1] {
                                coordinatesMatch = false
                                break
                            }
                        }
                    }
                    if coordinatesMatch {
                        for index in 1..<loop1.coordinates.count {
                            indicesToRemove.append(loop2.startingIndex + index)
                        }
                    }
                }
            }
        }

        guard indicesToRemove.count > 0 else {
            return linearRing
        }

        var resultLinearRing = LinearRing()
        for index in 0..<linearRing.count {
            if !indicesToRemove.contains(index) {
                resultLinearRing.append(linearRing[index])
            }
        }
 
        return resultLinearRing
    }

    /// Calculate the slope as a tuple.
    /// The first value is the slope, if the line is not vertical.
    /// The second value is a boolean flag indicating whether the line is vertical.  If it is, the first value is irrelevant and will typically be zero.
    fileprivate func slope(_ coordinate1: Coordinate, _ coordinate2: Coordinate) -> (Double, Bool) {

        /// Check for the vertical case
        guard coordinate1.x != coordinate2.x else {
            return (0, true)
        }

        /// Normal case
        return ((coordinate2.y - coordinate1.y) / (coordinate2.x - coordinate1.x), false)
    }

    fileprivate func slope(_ segment: Segment) -> (Double, Bool) {

        return slope(segment.leftCoordinate, segment.rightCoordinate)
    }

    enum LocationType {
        case onBoundary, onInterior, onExterior
    }

    /// Returns true if the coordinate is on the line segment.
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

    struct LineSegmentIntersection {

        var firstSegmentFirstBoundaryLocation: LocationType     // The location of the first boundary point of the first segment relative to the second segment
        var firstSegmentSecondBoundaryLocation: LocationType    // The location of the second boundary point of the first segment relative to the second segment
        var secondSegmentFirstBoundaryLocation: LocationType    // The location of the first boundary point of the second segment relative to the first segment
        var secondSegmentSecondBoundaryLocation: LocationType   // The location of the second boundary point of the second segment relative to the first segment
        var interiorsTouchAtPoint: Bool

        var segmentsIntersect: Bool {
            return  firstSegmentFirstBoundaryLocation   != .onExterior ||
                firstSegmentSecondBoundaryLocation  != .onExterior ||
                secondSegmentFirstBoundaryLocation  != .onExterior ||
                secondSegmentSecondBoundaryLocation != .onExterior ||
            interiorsTouchAtPoint
        }

        var firstSubsetOfSecond: Bool {
            return firstSegmentFirstBoundaryLocation  != .onExterior &&
                firstSegmentSecondBoundaryLocation != .onExterior
        }

        var secondSubsetOfFirst: Bool {
            return secondSegmentFirstBoundaryLocation  != .onExterior &&
                secondSegmentSecondBoundaryLocation != .onExterior
        }

        var geometry: Geometry?

        init(sb11: LocationType = .onExterior, sb12: LocationType = .onExterior, sb21: LocationType = .onExterior, sb22: LocationType = .onExterior, interiors: Bool = false, theGeometry: Geometry? = nil) {
            firstSegmentFirstBoundaryLocation   = sb11          /// Position of first boundary point of first segment relative to the second segment
            firstSegmentSecondBoundaryLocation  = sb12          /// Position of second boundary point of first segment relative to the second segment
            secondSegmentFirstBoundaryLocation  = sb21          /// Position of first boundary point of second segment relative to the first segment
            secondSegmentSecondBoundaryLocation = sb22          /// Position of second boundary point of first segment relative to the first segment
            interiorsTouchAtPoint               = interiors
            geometry                            = theGeometry
        }
    }

    ///
    /// Check if the bounding boxes overlap for two one dimensional line ranges.
    /// The first value for each range is the minimum value and the second is the maximum value.
    ///
    fileprivate func boundingBoxesOverlap1D(range1: (Double, Double), range2: (Double, Double)) -> Bool {
        return range1.1 >= range2.0 && range2.1 >= range1.0
    }

    ///
    /// Check if the bounding boxes overlap for two line segments
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

    ///
    /// 2x2 Determinant
    ///
    /// | a b |
    /// | c d |
    ///
    /// Returns a value of ad - bc
    ///
    fileprivate func det2d(a: Double, b: Double, c: Double, d: Double) -> Double {
        return a*d - b*c
    }

    ///
    /// Returns a numeric value indicating where point p2 is relative to the line determined by p0 and p1.
    /// value > 0 implies p2 is on the left
    /// value = 0 implies p2 is on the line
    /// value < 0 implies p2 is to the right
    ///
    fileprivate func isLeft(p0: Coordinate, p1: Coordinate, p2: Coordinate) -> Double {
        return (p1.x - p0.x)*(p2.y - p0.y) - (p2.x - p0.x)*(p1.y -  p0.y)
    }

    ///
    /// Two line segments are passed in.
    /// If the first coordinate of the first segment, "segment", is a boundary point, firstCoordinateFirstSegmentBoundary should be true.
    /// If the second coordinate of the first segment, "segment", is a boundary point, secondCoordinateFirstSegmentBoundary should be true.
    /// If the first coordinate of the second segment, "other", is a boundary point, firstCoordinateSecondSegmentBoundary should be true.
    /// If the second coordinate of the second segment, "other", is a boundary point, secondCoordinateSecondSegmentBoundary should be true.
    ///
    fileprivate func intersection(segment: Segment, other: Segment, firstCoordinateFirstSegmentBoundary: Bool = false, secondCoordinateFirstSegmentBoundary: Bool = false, firstCoordinateSecondSegmentBoundary: Bool = false, secondCoordinateSecondSegmentBoundary: Bool = false) -> LineSegmentIntersection {

        let precsion = Floating()
        let csystem  = Cartesian()

        ///
        /// Check the bounding boxes.  They must overlap if there is an intersection.
        ///
        guard boundingBoxesOverlap2D(segment: segment, other: other) else {
            return LineSegmentIntersection()
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

            var lineSegmentIntersection = LineSegmentIntersection(sb11: segment1Boundary1Location, sb12: segment1Boundary2Location, sb21: segment2Boundary1Location, sb22: segment2Boundary2Location)

            if (segment1Boundary1Location != .onExterior) &&  (segment1Boundary2Location != .onExterior) {
                /// Segment is completely contained in other
                lineSegmentIntersection.geometry = LineString([segment.leftCoordinate, segment.rightCoordinate], precision: precsion, coordinateSystem: csystem)
            } else if (segment2Boundary1Location != .onExterior) &&  (segment2Boundary2Location != .onExterior) {
                /// Other is completely contained in segment
                lineSegmentIntersection.geometry = LineString([segment.leftCoordinate, segment.rightCoordinate], precision: precsion, coordinateSystem: csystem)
            } else if (segment1Boundary1Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                lineSegmentIntersection.geometry = Point(segment.leftCoordinate, precision: precsion, coordinateSystem: csystem)
                if !firstCoordinateFirstSegmentBoundary && !firstCoordinateSecondSegmentBoundary {
                    lineSegmentIntersection.interiorsTouchAtPoint = true
                }
            } else if (segment1Boundary1Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                lineSegmentIntersection.geometry = Point(segment.leftCoordinate, precision: precsion, coordinateSystem: csystem)
                if !firstCoordinateFirstSegmentBoundary && !secondCoordinateSecondSegmentBoundary {
                    lineSegmentIntersection.interiorsTouchAtPoint = true
                }
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                lineSegmentIntersection.geometry = Point(segment.rightCoordinate, precision: precsion, coordinateSystem: csystem)
                if !secondCoordinateFirstSegmentBoundary && !firstCoordinateSecondSegmentBoundary {
                    lineSegmentIntersection.interiorsTouchAtPoint = true
                }
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                lineSegmentIntersection.geometry = Point(segment.rightCoordinate, precision: precsion, coordinateSystem: csystem)
                if !secondCoordinateFirstSegmentBoundary && !secondCoordinateSecondSegmentBoundary {
                    lineSegmentIntersection.interiorsTouchAtPoint = true
                }
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) ||
                (segment1Boundary2Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                lineSegmentIntersection.geometry = Point(segment.rightCoordinate, precision: precsion, coordinateSystem: csystem)
            } else if oneLine {
                /// If you reach here, the two line segments overlap by an amount > 0, but neither line segment is contained in the other.
                if (segment1Boundary1Location != .onExterior) &&  (segment2Boundary1Location != .onExterior) {
                    /// Line segments overlap from segment left to other left
                    lineSegmentIntersection.geometry = LineString([segment.leftCoordinate, other.leftCoordinate], precision: precsion, coordinateSystem: csystem)
                } else if (segment1Boundary1Location != .onExterior) &&  (segment2Boundary2Location != .onExterior) {
                    /// Line segments overlap from segment left to other right
                    lineSegmentIntersection.geometry = LineString([segment.leftCoordinate, other.rightCoordinate], precision: precsion, coordinateSystem: csystem)
                } else if (segment1Boundary2Location != .onExterior) &&  (segment2Boundary1Location != .onExterior) {
                    /// Line segments overlap from segment left to other left
                    lineSegmentIntersection.geometry = LineString([segment.rightCoordinate, other.leftCoordinate], precision: precsion, coordinateSystem: csystem)
                } else if (segment1Boundary2Location != .onExterior) &&  (segment2Boundary2Location != .onExterior) {
                    /// Line segments overlap from segment left to other right
                    lineSegmentIntersection.geometry = LineString([segment.rightCoordinate, other.rightCoordinate], precision: precsion, coordinateSystem: csystem)
                }
            } else {
                /// If you reach here, the two line segments touch at a single point that is on the boundary of one segment and the interior of the other.
                if segment1Boundary1Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point(segment.leftCoordinate, precision: precsion, coordinateSystem: csystem)
                    if !firstCoordinateFirstSegmentBoundary {
                        lineSegmentIntersection.interiorsTouchAtPoint = true
                    }
                } else if segment1Boundary2Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point(segment.rightCoordinate, precision: precsion, coordinateSystem: csystem)
                } else if segment2Boundary1Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point(other.leftCoordinate, precision: precsion, coordinateSystem: csystem)
                } else if segment2Boundary2Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point(other.rightCoordinate, precision: precsion, coordinateSystem: csystem)
                    if !secondCoordinateSecondSegmentBoundary {
                        lineSegmentIntersection.interiorsTouchAtPoint = true
                    }
                }
            }
            return lineSegmentIntersection
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

        let det1 = det2d(a: x1, b: y1, c: x2, d: y2)
        let det2 = det2d(a: x3, b: y3, c: x4, d: y4)
        let det3 = det2d(a: x1, b: 1, c: x2, d: 1)
        let det4 = det2d(a: x3, b: 1, c: x4, d: 1)
        let det5 = det2d(a: y1, b: 1, c: y2, d: 1)
        let det6 = det2d(a: y3, b: 1, c: y4, d: 1)

        let numx = det2d(a: det1, b: det3, c: det2, d: det4)
        let numy = det2d(a: det1, b: det5, c: det2, d: det6)
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
            return LineSegmentIntersection()
        }

        let x = numx / den
        let y = numy / den

        var interiorsIntersect = false
        if ((leftSign < 0 && rightSign > 0) || (leftSign > 0 && rightSign < 0)) && ((leftSign2 < 0 && rightSign2 > 0) || (leftSign2 > 0 && rightSign2 < 0)) {
            interiorsIntersect = true
        }

        return LineSegmentIntersection(sb11: segment1Boundary1Location, sb12: segment1Boundary2Location, sb21: segment2Boundary1Location, sb22: segment2Boundary2Location, interiors: interiorsIntersect, theGeometry: Point(Coordinate(x:x, y: y), precision: precsion, coordinateSystem: csystem))
    }
}
