///
///  Polygon+Geometry.swift
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
extension Polygon {

    ///
    /// The spatial dimension of `self`.
    ///
    /// - Returns: .two if non-empty, or .empty otherwise.
    ///
    /// - SeeAlso: Dimension
    ///
    public var dimension: Dimension {
        return self.isEmpty() ? .empty : .two
    }

    ///
    /// - Returns: the closure of the combinatorial boundary of this Geometry instance.
    ///
    /// - Note: The boundary of a Polygon consists of a set of LinearRings that make up its exterior and interior boundaries
    ///
    public func boundary() -> Geometry {

        let boundary = self.map({ LinearRing(converting: $0, precision: self.precision, coordinateSystem: self.coordinateSystem) })

        return GeometryCollection(boundary, precision: self.precision, coordinateSystem: self.coordinateSystem)
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
    /// - Returns: a tuple consisting of (1) a Dimension of the intersection of the two line segments passed in, and (2) a coordinate where the two intersect, if the Dimension is .zero.
    ///            If it is not .zero, the Coordinate is irrelevant and will have a dummy value.
    ///
    fileprivate func intersects(segment: Segment, other: Segment) -> (Dimension, Coordinate) {

        ///
        /// Check the bounding boxes.  They must overlap if there is an intersection.
        ///
        let dummyCoordinate = Coordinate(x: 0.0, y: 0.0)
        guard boundingBoxesOverlap2D(segment: segment, other: other) else {
            return (.empty, dummyCoordinate)
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
                return (.one, dummyCoordinate)
            } else if (segment2Boundary1Location != .onExterior) &&  (segment2Boundary2Location != .onExterior) {
                /// Other is completely contained in segment
                return (.one, dummyCoordinate)
            } else if (segment1Boundary1Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                return (.zero, segment.leftCoordinate)
            } else if (segment1Boundary1Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                return (.zero, segment.leftCoordinate)
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                return (.zero, segment.rightCoordinate)
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                return (.zero, segment.rightCoordinate)
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) ||
                      (segment1Boundary2Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point.
                /// This section may be redundant.  Possibly remove it later.
                return (.zero, segment.rightCoordinate)
            } else if oneLine {
                /// If you reach here, the two line segments overlap by an amount > 0, but neither line segment is contained in the other.
                return (.one, dummyCoordinate)
            } else {
                /// If you reach here, the two line segments touch at a single point that is on the boundary of one segment and the interior of the other.
                var intersectionCoordinate = dummyCoordinate
                if segment1Boundary1Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    intersectionCoordinate = segment.leftCoordinate
                } else if segment1Boundary2Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    intersectionCoordinate = segment.rightCoordinate
                } else if segment2Boundary1Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    intersectionCoordinate = other.leftCoordinate
                } else if segment2Boundary2Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    intersectionCoordinate = other.rightCoordinate
                }
                return (.zero, intersectionCoordinate)
            }
        }

        ///
        /// There is no intersection.  Return an empty dimension with a dummy coordinate.

        return (.empty, dummyCoordinate)
    }

    ///
    /// - Returns: an integer that is the number of times one linear ring touches another at a point.
    ///            It is assumed that the intersection dimension of the linear rings is zero, and the two linear rings do not cross.
    ///            Note consecutive coordinates can be repeated.
    ///
    fileprivate func touchesCount(_ linearRing1: LinearRing, _ linearRing2: LinearRing) -> Int {

        guard (linearRing1.count >= 4) && (linearRing2.count >= 4) else { return 0 }

        var coordinateSet = Set<Coordinate>()
        for firstCoordIndex in 0..<linearRing1.count - 1 {

            let firstCoord  = linearRing1[firstCoordIndex]
            let secondCoord = linearRing1[firstCoordIndex + 1]
            if firstCoord == secondCoord { continue }
            let segment1 = Segment(left: firstCoord, right: secondCoord)

            for secondCoordIndex in 0..<linearRing2.count - 1 {

                let thirdCoord  = linearRing2[secondCoordIndex]
                let fourthCoord = linearRing2[secondCoordIndex + 1]
                if thirdCoord == fourthCoord { continue }
                let segment2 = Segment(left: thirdCoord, right: fourthCoord)

                let (intersectionDimension, intersectionCoordinate) = intersects(segment: segment1, other: segment2)

                switch intersectionDimension {
                case .empty:
                    break
                case .zero:
                    coordinateSet.insert(intersectionCoordinate)
                    break
                case .one,
                     .two:
                    /// This should never happen.  If it does, there is a problem with the input linear rings.
                    break
                }
            }
        }

        return coordinateSet.count
    }

    ///
    /// - Returns: an array of linear rings that touch the input linear ring.  All of these linear rings are holes in this polygon.  The array may be empty.
    ///
    fileprivate func holesTouchingHole(_ linearRing: LinearRing, _ touchesTuple: [(LinearRing, [LinearRing])]) -> [LinearRing] {

        for (tupleLinearRing, tupleLinearRingArray) in touchesTuple {

            if linearRing != tupleLinearRing { continue }

            return tupleLinearRingArray
        }

        /// No match was found.  Return an empty array.
        return []
    }

    ///
    /// - Returns: true if the given linear ring matches any of the linear rings in the array of linear rings that touch the outer ring.  All of these linear rings are holes in this polygon.  The array may be empty.
    ///
    fileprivate func holeTouchesOuterRing(_ linearRing: LinearRing, _ holesTouchingOuterRing: [LinearRing]) -> Bool {

        for holeTouchingOuterRing in holesTouchingOuterRing {

            if linearRing == holeTouchingOuterRing {
                return true
            }
        }

        /// No match was found.  Return false.
        return false
    }
    
    ///
    /// - Returns: true if any of the chains disconnect this polygon.
    ///
    ///            The input values are
    ///            (1) an array of LinearRing chains, such that each LinearRing (hole) in a chain touches the next, and
    ///            (2) an array of holes that touch the outer ring.
    ///
    fileprivate func chainsDisconnectPolygon(_ holeChains:[[LinearRing]], _ holesTouchingOuterRing: [LinearRing]) -> Bool {

        guard holeChains.count > 0 else {
            return false
        }

        for holeChain in holeChains {
            var holesTouchingOuterRingCount = 0
            /// Does the chain touch the outer ring of the polygon at two points of two different holes?
            for hole in holeChain {
                if holeTouchesOuterRing(hole, holesTouchingOuterRing) {
                    holesTouchingOuterRingCount += 1
                    if holesTouchingOuterRingCount >= 2 {
                        return true
                    }
                }
            }

            /// Does the chain loop back on itself?
            guard holeChain.count >= 3 else { return false }
            let lastHole = holeChain[holeChain.count - 1]
            for holeIndex in 0..<(holeChain.count - 1) {
                let hole = holeChain[holeIndex]
                if hole == lastHole {
                    return true
                }
            }
        }

        return false
    }

    ///
    /// - Returns: true if any of the chains disconnect this polygon.
    ///
    ///            The input values are
    ///            (1) an array of LinearRing chains, such that each LinearRing (hole) in a chain touches the next,
    ///            (2) an array of holes that touch the outer ring, and
    ///            (3) an array of tuples, where the first element of the tuple is a linear ring, and the second element of the tuple is the array of linear rings (holes) it touches.
    ///            Note that only LinearRing chains that are not yet complete will appear in the array of chains.
    ///
    fileprivate func generateChains(_ holeChains:[[LinearRing]], _ holesTouchingOuterRing: [LinearRing], _ touchesTuple: [(LinearRing, [LinearRing])]) -> Bool {

        guard holeChains.count > 0 else {
            return false
        }

        if chainsDisconnectPolygon(holeChains, holesTouchingOuterRing) {
            return true
        }

        var newHoleChains = [[LinearRing]]()
        for holeChain in holeChains {
            guard holeChain.count > 0 else { continue }
            let finalHole = holeChain[holeChain.count - 1]
            let touchingHoles = holesTouchingHole(finalHole, touchesTuple)
            if touchingHoles.count > 0 {
                for touchingHole in touchingHoles {
                    if holeChain.count >= 2 {
                        let almostFinalHole = holeChain[holeChain.count - 2]
                        if touchingHole == almostFinalHole { continue }
                    }
                    var newChain = holeChain
                    newChain.append(touchingHole)
                    newHoleChains.append(newChain)
                }
            }
        }

        if newHoleChains.count == 0 {
            return false
        } else {
            return generateChains(newHoleChains, holesTouchingOuterRing, touchesTuple)
        }
    }

    ///
    /// - Returns: true if there is no sequence of holes that separates part of the interior of the polygon from another part.
    ///            A disconnected interior can be formed by two or more holes that connect to each other and the outer ring,
    ///            or a collection of three or more holes that form a loop and may or may not touch the outer ring.
    ///
    ///            The input values are (1) an array of holes that touch the outer ring, and (2) an array of tuples, where the first element of the tuple is a linear ring,
    ///            and the second element of the tuple is the array of linear rings (holes) it touches.
    ///
    fileprivate func polygonIsConnected(_ holesTouchingOuterRing: [LinearRing], _ touchesTuple: [(LinearRing, [LinearRing])]) -> Bool {

        let allTupleHoles = touchesTuple.map { $0.0 }
        guard allTupleHoles.count >= 2 else {
            return true
        }

        var newChains = [[LinearRing]]()
        for hole in allTupleHoles {
            newChains.append([hole])
        }

        return !generateChains(newChains, holesTouchingOuterRing, touchesTuple)
    }

    ///
    /// - Returns: true if this geometric object meets the following constraints:
    ///            •    the coordinates which define it are valid coordinates
    ///            •    the linear rings for the shell and holes are valid (i.e. are closed and do not self-intersect)
    ///            •    the holes are completely contained inside the shell
    ///            •    holes touch the shell or another hole at at most one point (which implies that the rings of the shell and holes must not cross)
    ///            •    the interior of the polygon is connected, or equivalently no sequence of touching holes makes the interior of the polygon disconnected (i.e. effectively split the polygon into two pieces).
    ///
    public func valid() -> Bool {

        /// Check all linear rings are valid
        let outerRing = self.outerRing
        let innerRings = self.innerRings
        if !outerRing.valid() {
            return false
        }

        let holesCount = self.innerRings.count
        guard holesCount > 0 else {
            return true
        }

        for hole in innerRings {
            if !hole.valid() {
                return false
            }
        }

        /// Check all holes are inside the outer ring and do not touch the boundary of the outer ring by more than a set of points
        let outerRingPolygon = Polygon(outerRing)
        var holesTouchingOuterRing = [LinearRing]()
        for hole in innerRings {
            let holePolygon = Polygon(hole)
            let matrix = IntersectionMatrix.generateMatrix(outerRingPolygon, holePolygon)
            if (matrix[.exterior, .interior] == .two) || (matrix[.boundary, .boundary] == .one) {
                return false
            } else if matrix[.boundary, .boundary] == .zero {
                holesTouchingOuterRing.append(hole)
            }
        }

        /// Check no hole overlaps another hole by more than a set of points
        var holesTouchingOtherHoles = [(LinearRing, [LinearRing])]()
        if holesCount >= 2 {
            for hole1Index in 0..<holesCount {
                let hole1 = innerRings[hole1Index]
                let hole1Polygon = Polygon(hole1)
                var holesTouchingThisHole = [LinearRing]()
                for hole2Index in 0..<holesCount {
                    guard hole1Index != hole2Index else { continue }
                    let hole2 = innerRings[hole2Index]
                    let hole2Polygon = Polygon(hole2)
                    let matrix = IntersectionMatrix.generateMatrix(hole1Polygon, hole2Polygon)
                    if (matrix[.interior, .interior] == .two) || (matrix[.boundary, .boundary] == .one) {
                        return false
                    } else if matrix[.boundary, .boundary] == .zero {
                       holesTouchingThisHole.append(hole2)
                    }
                }
                if holesTouchingThisHole.count > 0 {
                    holesTouchingOtherHoles.append((hole1, holesTouchingThisHole))
                }
            }
        }

        /// At this point the holes are inside the outer ring, and holes touch the outer ring and each other by no more than a set of points.
        /// Check how many times each hole touches the outer ring.
        /// If greater than one, we have an invalid polygon.
        for hole in holesTouchingOuterRing {
            let touchCount = touchesCount(hole, outerRing)
            if touchCount >= 2 {
                return false
            }
        }

        /// Check how many times each hole touches another hole.
        /// If greater than one, we have an invalid polygon.
        for (hole1, touchingHoles) in holesTouchingOtherHoles {
            for hole2 in touchingHoles {
                let touchCount = touchesCount(hole1, hole2)
                if touchCount >= 2 {
                    return false
                }
            }
        }

        /// The last thing to check is whether the interior of the polygon is connected.
        /// It might not be, if there is a series of holes such that the first and final holes touch the outer ring,
        /// and for each hole in the series of holes, each one touches the next.
        /// There might also be a set of three or more holes that touch each other by a single point and form
        /// a loop that disconnectes its interior from the rest of the polygon interior.
        return polygonIsConnected(holesTouchingOuterRing, holesTouchingOtherHoles)
    }
}
