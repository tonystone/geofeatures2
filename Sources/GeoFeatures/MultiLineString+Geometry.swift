///
///  MultiLineString+Geometry.swift
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
extension MultiLineString {

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
    /// - Returns: the closure of the combinatorial boundary of this Geometry instance.
    ///
    /// - Note: The boundary of a MultiCurve is obtained by applying the “mod 2” union rule: A Point is in the boundary of a
    ///         MultiCurve if it is in the boundaries of an odd number of elements of the MultiCurve (Reference [1], section
    ///         3.12.3.2).
    ///
    public func boundary() -> Geometry {

        var endCoordinates = [Coordinate: Int]()
        var endCoordinatesOrdered = [Coordinate]()

        for i in 0 ..< self.count {
            let lineString = self[i]

            if lineString.count >= 2 && !lineString.isClosed() {
                var i = 0

                /// Start point
                if var count = endCoordinates[lineString[i]] {
                    count += 1

                    endCoordinates[lineString[i]] = count

                } else {
                    endCoordinates[lineString[i]] = 1
                    endCoordinatesOrdered.append(lineString[i])
                }

                i = lineString.count - 1

                /// End point
                if var count = endCoordinates[lineString[i]] {
                    count += 1

                    endCoordinates[lineString[i]] = count

                } else {
                    endCoordinates[lineString[i]] = 1
                    endCoordinatesOrdered.append(lineString[i])
                }
            }
        }

        var boundary = MultiPoint(precision: self.precision, coordinateSystem: self.coordinateSystem)

        for coordinate in endCoordinatesOrdered {
            if let count = endCoordinates[coordinate] {

                if count % 2 == 1 {
                    boundary.append(Point(coordinate, precision: self.precision, coordinateSystem: self.coordinateSystem))
                }
            }
        }
        return boundary
    }

    ///
    /// - Returns: true if `self` is equal to the `other`.
    ///
    public func equals(_ other: Geometry) -> Bool {
        if let other = other as? MultiLineString {
            return self.elementsEqual(other)
        }
        return false
    }

    /// ***************************************************************************

    /// The code that lies between the two lines with asterisks was borrowed from
    /// IntersectionMatrix+Helpers.swift.  It can be removed once this code has been
    /// merged with a branch that contains that file.

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
    
    /// Is segment1 contained in or a subset of segment2?
    fileprivate func subset(_ segment1: Segment, _ segment2: Segment) -> Bool {

        /// If the slopes are not the same one segment being contained in another is not possible
        let slope1 = slope(segment1)
        let slope2 = slope(segment2)
        guard slope1 == slope2 else {
            return false
        }

        /// Slopes are the same.  Check if both coordinates of the first segment lie on the second
        let location1 = coordinateIsOnLineSegment(segment1.leftCoordinate, segment: segment2)
        let location2 = coordinateIsOnLineSegment(segment1.rightCoordinate, segment: segment2)
        if location1 != .onExterior && location2 != .onExterior {
            return true
        } else {
            return false
        }
    }

    /// Is line string 1 contained in or a subset of line string 2?
    /// The algorithm here assumes that both line strings have been reduced, so that no two consecutive segments have the same slope.
    fileprivate func subset(_ lineString1: LineString, _ lineString2: LineString) -> Bool {

        for ls1FirstCoordIndex in 0..<lineString1.count - 1 {
            let ls1FirstCoord  = lineString1[ls1FirstCoordIndex]
            let ls1SecondCoord = lineString1[ls1FirstCoordIndex + 1]
            let segment1 = Segment(left: ls1FirstCoord, right: ls1SecondCoord)

            var segment1IsSubsetOfOtherSegment = false
            for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                let ls2FirstCoord  = lineString2[ls2FirstCoordIndex]
                let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1]
                let segment2 = Segment(left: ls2FirstCoord, right: ls2SecondCoord)

                if subset(segment1, segment2) {
                    segment1IsSubsetOfOtherSegment = true
                    break
                }
            }

            if !segment1IsSubsetOfOtherSegment {
                return false
            }
        }

        return true
    }

    /// ************************************************************************************

    ///
    /// Reduces the geometry to its simplest form, the simplest sequence of points or coordinates,
    /// that is topologically equivalent to the original geometry.  In essence, this function removes
    /// duplication and intermediate coordinates that do not contribute to the overall definition.
    ///
    /// Reducing a MultiLineString means (1) reducing each LineString and (2) combining one or more LineStrings
    /// that overlap at either a single point or a single end segment into a single LineString.
    /// Note that (2) can be extended to consider the case where multiple end segments overlap, but we will
    /// not handle that case for now.
    ///
    /// The computational complexity of this algorithm is currently O(N**2).
    ///
    /// - Returns: the simplified geometry of the same type as the original
    ///
    public func simplify(tolerance: Double) -> MultiLineString {

        /// Part 1 - simplify each line string
        var resultMultiLineString1 = MultiLineString()
        for lineString in self {
            let resultLineString = lineString.simplify(tolerance: 1.0)
            resultMultiLineString1.append(resultLineString)
        }

        /// Part 2 - merge the line strings
        let resultMultiLineString2 = resultMultiLineString1.mergeLineStrings()

        /// Part 3 - simplify each line string again
        var resultMultiLineString3 = MultiLineString()
        for lineString in resultMultiLineString2 {
            let resultLineString = lineString.simplify(tolerance: 1.0)
            resultMultiLineString3.append(resultLineString)
        }

        return resultMultiLineString3
    }

    ///
    /// Combines overlapping LineStrings into a single LineString.
    /// To do this, it must be the case that at least one of the following conditions must be true:
    /// (1) the ends of two LineStrings touch at a single point,
    /// (2) the ends of two LineStrings are completely contained in each other (overlap at a segment including endpoints)
    /// Note that it is assumed the LineStrings have been simplified before being merged.
    ///
    /// The computational complexity of this algorithm is currently O(N**2).
    fileprivate func mergeLineStrings() -> MultiLineString {

        guard self.count >= 2 else {
            /// Nothing to merge
            return self
        }

        var finalMultiLineString = MultiLineString()
        var lineStringArray = [LineString]()
        for lineString in self {
            lineStringArray.append(lineString)
        }

        while lineStringArray.count >= 2 {

            let lineString1 = lineStringArray[0]
            var index = 0
            var firstLineStringMerged = false
            for lineString2 in lineStringArray[1...] {
                index += 1
                let (resultLineString, lineStringsMerged) = mergeLineStrings(lineString1, lineString2)
                if lineStringsMerged {
                    firstLineStringMerged = true
                    lineStringArray[0] = resultLineString
                    lineStringArray.remove(at: index)
                    break
                }
            }

            if !firstLineStringMerged {
                finalMultiLineString.append(lineString1)
                lineStringArray.remove(at: 0)
            }
        }

        /// The lineStringArray size is now down to one.
        return finalMultiLineString + lineStringArray
    }

    ///
    /// Combines overlapping LineStrings into a single LineString.
    /// To do this, it must be the case that at least one of the following conditions must be true:
    /// (1) the ends of two LineStrings touch at a single point,
    /// (2) the ends of two LineStrings are completely contained in each other (overlap at a segment including endpoints)
    /// Note that it is assumed the LineStrings have been simplified before being merged.
    ///
    /// The computational complexity of this algorithm is currently O(N**2).
    ///
    /// The result is a LineString and a boolean value indicating whether the two line strings were merged.
    /// If the two line strings were not merged, the returned LineString value should be ignored.
    fileprivate func mergeLineStrings(_ lineString1: LineString, _ lineString2: LineString) -> (LineString, Bool) {

        /// Make sure the two line strings are valid, else refuse to merge.
        let ls1Count = lineString1.count
        let ls2Count = lineString2.count
        guard ls1Count >= 2 && ls2Count >= 2 else {
            return (lineString1, false)
        }

        /// Check if the first line string is a subset of the second line string.
        if subset(lineString1, lineString2) { return (lineString2, true) }

        /// Check if the second line string is a subset of the first line string.
        if subset(lineString2, lineString1) { return (lineString1, true) }

        /// At this point, neither line string is a subset of the other.
        /// Now check if the two line strings meet at just end points.

        /// Check whether the first segments of each line string intersect
        let ls1FirstCoord  = lineString1[0]
        let ls1SecondCoord = lineString1[1]
        let segment1 = Segment(left: ls1FirstCoord, right: ls1SecondCoord)

        let ls2FirstCoord  = lineString2[0]
        let ls2SecondCoord = lineString2[1]
        let segment2 = Segment(left: ls2FirstCoord, right: ls2SecondCoord)

        let lineSegmentIntersectionFirstFirst = intersection(segment: segment1, other: segment2, firstCoordinateFirstSegmentBoundary: true, firstCoordinateSecondSegmentBoundary: true)

        /// Check whether the last segments of each line string intersect
        let ls1SecondLastCoord  = lineString1[ls1Count - 2]
        let ls1LastCoord = lineString1[ls1Count - 1]
        let segment3 = Segment(left: ls1SecondLastCoord, right: ls1LastCoord)

        let ls2SecondLastCoord  = lineString2[ls2Count - 2]
        let ls2LastCoord = lineString2[ls2Count - 1]
        let segment4 = Segment(left: ls2SecondLastCoord, right: ls2LastCoord)

        let lineSegmentIntersectionLastLast = intersection(segment: segment3, other: segment4, secondCoordinateFirstSegmentBoundary: true, secondCoordinateSecondSegmentBoundary: true)

        let firstSegmentsTouchAtBoundaryPoints = (ls1FirstCoord == ls2FirstCoord)
        let lastSegmentsTouchAtBoundaryPoints = (ls1LastCoord == ls2LastCoord)
        let firstSegmentsIntersectAtSegment = (lineSegmentIntersectionFirstFirst.geometry?.dimension == .one)
        let lastSegmentsIntersectAtSegment = (lineSegmentIntersectionLastLast.geometry?.dimension == .one)
        let firstSegmentsIntersectAtSegmentOverlappingEndpoints = firstSegmentsIntersectAtSegment &&
            lineSegmentIntersectionFirstFirst.firstSegmentFirstBoundaryLocation != .onExterior &&
            lineSegmentIntersectionFirstFirst.secondSegmentFirstBoundaryLocation != .onExterior
        let lastSegmentsIntersectAtSegmentOverlappingEndpoints = lastSegmentsIntersectAtSegment &&
            lineSegmentIntersectionLastLast.firstSegmentSecondBoundaryLocation != .onExterior &&
            lineSegmentIntersectionLastLast.secondSegmentSecondBoundaryLocation != .onExterior
        if firstSegmentsTouchAtBoundaryPoints {
            if lastSegmentsTouchAtBoundaryPoints {
                /// The shape is really a linear ring
                return (lineString1 + lineString2.reversed(), true)
            } else if lastSegmentsIntersectAtSegmentOverlappingEndpoints {
                let newLineString1 = LineString(lineString1[0..<(ls1Count - 1)]) + LineString([ls2SecondLastCoord])
                let newLineString2 = LineString(lineString2[0..<(ls2Count - 1)])
                return (newLineString1.reversed() + newLineString2, true)
            } else {
                return (lineString1.reversed() + LineString(lineString2[1..<ls2Count]), true)
            }
        } else if lastSegmentsTouchAtBoundaryPoints {
            if firstSegmentsIntersectAtSegmentOverlappingEndpoints {
                let newLineString1 = LineString([ls2SecondCoord]) + LineString(lineString1[1..<ls1Count])
                let newLineString2 = LineString(lineString2[1..<(ls2Count - 1)])
                return (newLineString1 + newLineString2.reversed(), true)
            } else {
                return (lineString1 + LineString(lineString2[0..<(ls2Count - 1)]), true)
            }
        } else if firstSegmentsIntersectAtSegmentOverlappingEndpoints {
            let newLineString1 = LineString([ls2SecondCoord]) + LineString(lineString1[1..<ls1Count])
            let newLineString2 = LineString(lineString2[1..<ls2Count])
            return (newLineString1.reversed() + newLineString2, true)
        } else if lastSegmentsIntersectAtSegmentOverlappingEndpoints {
            let newLineString1 = LineString(lineString1[0..<(ls1Count - 1)]) + LineString([ls2SecondLastCoord])
            let newLineString2 = LineString(lineString2[0..<(ls2Count - 1)])
            return (newLineString1 + newLineString2.reversed(), true)
        }

        /// Check whether the first segment of the first line string intersects the last segment of the second line string
        let lineSegmentIntersectionFirstLast = intersection(segment: segment1, other: segment4, firstCoordinateFirstSegmentBoundary: true, secondCoordinateSecondSegmentBoundary: true)

        /// Check whether the last segment of the first line string intersects the first segment of the second line string
        let lineSegmentIntersectionLastFirst = intersection(segment: segment2, other: segment3, secondCoordinateFirstSegmentBoundary: true, firstCoordinateSecondSegmentBoundary: true)

        let firstLastSegmentsTouchAtBoundaryPoints = (ls1FirstCoord == ls2LastCoord)
        let lastFirstSegmentsTouchAtBoundaryPoints = (ls1LastCoord == ls2FirstCoord)
        let firstLastSegmentsIntersectAtSegment = (lineSegmentIntersectionFirstLast.geometry?.dimension == .one)
        let lastFirstSegmentsIntersectAtSegment = (lineSegmentIntersectionLastFirst.geometry?.dimension == .one)
        let firstLastSegmentsIntersectAtSegmentOverlappingEndpoints = firstLastSegmentsIntersectAtSegment &&
            lineSegmentIntersectionFirstLast.firstSegmentFirstBoundaryLocation != .onExterior &&
            lineSegmentIntersectionFirstLast.secondSegmentSecondBoundaryLocation != .onExterior
        let lastFirstSegmentsIntersectAtSegmentOverlappingEndpoints = lastFirstSegmentsIntersectAtSegment &&
            lineSegmentIntersectionLastLast.firstSegmentSecondBoundaryLocation != .onExterior &&
            lineSegmentIntersectionLastLast.secondSegmentFirstBoundaryLocation != .onExterior
        if firstLastSegmentsTouchAtBoundaryPoints {
            if lastFirstSegmentsTouchAtBoundaryPoints {
                /// The shape is really a linear ring
                return (lineString1 + lineString2, true)
            } else if lastFirstSegmentsIntersectAtSegmentOverlappingEndpoints {
                let newLineString1 = LineString(lineString1[0..<(ls1Count - 1)]) + LineString([ls2SecondCoord])
                let newLineString2 = LineString(lineString2[1..<ls2Count])
                return (newLineString1 + newLineString2, true)
            } else {
                return (lineString1.reversed() + LineString(lineString2[1..<ls2Count]), true)
            }
        } else if lastFirstSegmentsTouchAtBoundaryPoints {
            if firstLastSegmentsIntersectAtSegmentOverlappingEndpoints {
                let newLineString1 = LineString([ls2SecondCoord]) + LineString(lineString1[1..<ls1Count])
                let newLineString2 = LineString(lineString2[1..<(ls2Count - 1)])
                return (newLineString1 + newLineString2, true)
            } else {
                return (lineString1 + LineString(lineString2[1..<ls2Count]), true)
            }
        } else if firstLastSegmentsIntersectAtSegmentOverlappingEndpoints {
            let newLineString1 = LineString([ls2SecondLastCoord]) + LineString(lineString1[1..<ls1Count])
            let newLineString2 = LineString(lineString2[0..<(ls2Count - 1)])
            return (LineString(newLineString1.reversed() + newLineString2.reversed()), true)
        } else if lastFirstSegmentsIntersectAtSegmentOverlappingEndpoints {
            let newLineString1 = LineString(lineString1[0..<(ls1Count - 1)]) + LineString([ls2SecondLastCoord])
            let newLineString2 = LineString(lineString2[1..<ls2Count])
            return (newLineString1 + newLineString2, true)
        }

        /// At this point, we have checked for the cases where the line strings meet at an endpoint and
        /// where two end segments overlap such that each endpoint is in the other segment and the dimension
        /// of the overlap in each case has dimension one.
        ///
        /// We will now check for the case where the two line strings overlap by more than a single segment.

        /// Make sure the two line strings have at least two segments each.
        guard ls1Count >= 3 && ls2Count >= 3 else {
            return (lineString1, false)
        }

        /// Phase 1:
        /// Take the first segment of the first line string and walk through all the segments of the second line string,
        /// keeping track of the segment indexes (second) where the first line string segment overlaps the second such that
        /// the endpoint of the first is in the second and the other end of the first matches one of the endpoints
        /// of the second segment.  If there are no such indexes, then no overlap exists, so move on to the next phase.
        /// If there are such indexes, do the same thing again, but choose the first segment of the second line string and
        /// walk through all of the segments of the first line string. If there are no matches, then move on to the next phase.
        /// If there are, then starting with the highest index for the second line string and the first index of the first line
        /// string, loop through the indexes and check whether the two segments overlap by a full or partial amount.
        /// For the two line strings to line up on several line segments, it should be the case that a partial overlap
        /// occurs at only the end segments of each, and the segments in between match exactly, except for a reversal of the
        /// segment endpoints.  If this fails at any point, start over with the next index in the collection we first made.
        /// If we go through all indexes and they all fail, then no overlap.  If something does overlap completely, build
        /// a new line string and return that.

        let (resultLineString1, lineStringsMerged1) = combineOverlappingLineStrings(lineString1, lineString2)
        if lineStringsMerged1 { return (resultLineString1, lineStringsMerged1) }

        /// Phase 2:
        /// Repeat the above starting with the last segments of each line string.

        let (resultLineString2, lineStringsMerged2) = combineOverlappingLineStrings(lineString1, LineString(lineString2.reversed()))
        if lineStringsMerged2 { return (resultLineString2, lineStringsMerged2) }

        /// Phase 3:
        /// Repeat the above starting with the first segment of the first line string and the last segment of the
        /// second line string.

        let (resultLineString3, lineStringsMerged3) = combineOverlappingLineStrings(LineString(lineString1.reversed()), lineString2)
        if lineStringsMerged3 { return (resultLineString3, lineStringsMerged3) }

        /// Phase 4:
        /// Repeat the above starting with the last segment of the first line string and the first segment of the
        /// second line string.

        let (resultLineString4, lineStringsMerged4) = combineOverlappingLineStrings(LineString(lineString1.reversed()), LineString(lineString2.reversed()))
        if lineStringsMerged4 { return (resultLineString4, lineStringsMerged4) }

        /// No overlap
        return (lineString1, false)
    }

    /// This handles the case where two line strings overlap by one or more segments, or partial segments, at one or both
    /// of the ends of the two line strings.
    fileprivate func combineOverlappingLineStrings(_ lineString1: LineString, _ lineString2: LineString) -> (LineString, Bool) {

        /// Make sure the two line strings are valid, else refuse to combine them.
        let ls1Count = lineString1.count
        let ls2Count = lineString2.count
        guard ls1Count >= 2 && ls2Count >= 2 else {
            return (lineString1, false)
        }

        /// Get the first segment of the first line string.
        let ls1FirstCoord  = lineString1[0]
        let ls1SecondCoord = lineString1[1]
        let segment1 = Segment(left: ls1FirstCoord, right: ls1SecondCoord)

        /// Check whether the first segment of the first line string overlaps with any of the segments of the second line string
        var firstTouchesSecond = [Int]() /// An array of indexes of the segments of the second line string where the first segment of the first line string touches it with dimension one.  May not need an array.  A single value may work.
        for index2 in 0..<(ls2Count - 1) {
            let ls2FirstCoord  = lineString2[index2]
            let ls2SecondCoord = lineString2[index2 + 1]
            let segment2 = Segment(left: ls2FirstCoord, right: ls2SecondCoord)
            let firstSecondIsBoundaryPoint = (index2 == 0)

            let lineSegmentIntersection = intersection(segment: segment1, other: segment2, firstCoordinateFirstSegmentBoundary: true, firstCoordinateSecondSegmentBoundary: firstSecondIsBoundaryPoint)

            let firstOfFirstTouchesSecond = (lineSegmentIntersection.firstSegmentFirstBoundaryLocation != .onExterior)
            let secondOfFirstTouchesSecondAtBoundaryPoint = ((ls1SecondCoord == ls2FirstCoord) || (ls1SecondCoord == ls2SecondCoord))
            let segmentsIntersectAtSegment = (lineSegmentIntersection.geometry?.dimension == .one) /// Necessary?
            if firstOfFirstTouchesSecond && secondOfFirstTouchesSecondAtBoundaryPoint && segmentsIntersectAtSegment {
                firstTouchesSecond.append(index2)
            }
        }

        /// The maximum index of at which the first line string touches the second line string cannot be greater than the count of
        /// segments in the first line string and have the line strings overlap with the first being a subset of the second.
        /// Therefore, we will check that case and exit if true

        let maxIndex = firstTouchesSecond.last
        guard let validMaxIndex = maxIndex, validMaxIndex <= ls1Count else {
            return (lineString1, false)
        }

        /// We need to check that the first line string overlaps the second from the validMaxIndex to either 0 or to ls2Count - 1.
        /// This means we check the overlap occurs in either of two directions.

        var index1 = 1
        for index2 in (0...validMaxIndex).reversed() {
            if lineString1[index1] == lineString2[index2] {
                if index2 == 0 {
                    /// Everything lines up.  Build a new a line string.
                    let newLineString1 = LineString(lineString1[(index1 + 1)..<ls1Count])
                    let newLineString2 = lineString2.reversed()
                    return (newLineString2 + newLineString1, true)
                } else {
                    index1 += 1
                    continue
                }
            } else if index2 != 0 {
                /// Non-overlapping case.  Go to next phase.
                return (lineString1, false)
            } else {
                /// Index2 == 0.  If the two final segments overlap, this must be in the first segment of the second line string.
                let ls1FirstCoord  = lineString1[index1]
                let ls1SecondCoord = lineString1[index1 - 1]
                let segment1 = Segment(left: ls1FirstCoord, right: ls1SecondCoord)
                let firstFirstIsBoundaryPoint = (index1 == (ls1Count - 1))

                let ls2FirstCoord  = lineString2[index2]
                let ls2SecondCoord = lineString2[index2 + 1]
                let segment2 = Segment(left: ls2FirstCoord, right: ls2SecondCoord)
                let firstSecondIsBoundaryPoint = true

                let lineSegmentIntersection = intersection(segment: segment1, other: segment2, firstCoordinateFirstSegmentBoundary: firstFirstIsBoundaryPoint, firstCoordinateSecondSegmentBoundary: firstSecondIsBoundaryPoint)

                let firstOfSecondTouchesFirstAtInterior = (lineSegmentIntersection.secondSegmentFirstBoundaryLocation == .onInterior)
                if firstOfSecondTouchesFirstAtInterior {
                    /// Segments line up.  Build a new line string.
                    let newLineString1 = LineString(lineString1[index1..<ls1Count])
//                    let newLineString1 = LineString(lineString1[(index1 + 1)..<ls1Count])
                    let newLineString2 = lineString2.reversed()
                    return (newLineString2 + newLineString1, true)
                }
            }
        }

        /// No overlap
        return (lineString1, false)
    }
}
