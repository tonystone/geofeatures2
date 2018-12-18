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

///
/// `Geometry` protocol implementation.
///
/// Note: See `CoordinateCollectionType` for func implementations not present here.
///
extension LineString {

    ///
    /// - Returns: true if `self` is equal to the `other`.
    ///
    public func equals(_ other: Geometry) -> Bool {
        if let other = other as? LineString {
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
    /// Reducing a LineString means (1) removing identical consecutive points, (2) simplifying a sequence
    /// of segments that have the same slope to just a single segment, and (3) removing the end portion
    /// of a LineString that is completely contained in an earlier portion of that LineString.
    ///
    /// - Returns: the simplified geometry of the same type as the original
    ///
    public func simplify(tolerance: Double) -> LineString {

        /// Must have at least 3 points or two lines segments for this algorithm to apply
        guard self.count >= 3 else {
            return self
        }

        /// Part 1 - remove identical consecutive points
        var resultLineString1 = LineString()
        var lastCoordinate: Coordinate?
        for index in 0..<self.count {
            let currentCoordinate = self[index]
            if currentCoordinate != lastCoordinate {
                resultLineString1.append(currentCoordinate)
                lastCoordinate = currentCoordinate
            }
        }

        /// Make sure there is at least two points
        if resultLineString1.count == 1 {
            resultLineString1.append(resultLineString1[0])
        }

        /// Must have at least 3 points or two lines segments for this algorithm to apply
        guard resultLineString1.count >= 3 else {
            return resultLineString1
        }

        /// Part 2 - combine segments with the same slope into one segment, if the two segments do not overlap.
        /// If the two segments do overlap, they must be kept separate to capture the change in direction.
        var firstSlope: (Double, Bool)      /// The second value, if true, indicates a vertical line
        var secondSlope: (Double, Bool)
        var resultLineString2 = LineString()
        resultLineString2.append(resultLineString1[0])
        for lsFirstCoordIndex in 0..<resultLineString1.count - 2 {
            let lsFirstCoord  = resultLineString1[lsFirstCoordIndex]
            let lsSecondCoord = resultLineString1[lsFirstCoordIndex + 1]
            let lsThirdCoord  = resultLineString1[lsFirstCoordIndex + 2]
            firstSlope = slope(lsFirstCoord, lsSecondCoord)
            secondSlope = slope(lsSecondCoord, lsThirdCoord)
            
            if firstSlope != secondSlope {
                resultLineString2.append(resultLineString1[lsFirstCoordIndex + 1])
            } else {
                let segment1 = Segment(left: lsFirstCoord, right: lsSecondCoord)
                let segment2 = Segment(left: lsSecondCoord, right: lsThirdCoord)
                let lineSegmentIntersection = intersection(segment: segment1, other: segment2)
                if lineSegmentIntersection.firstSubsetOfSecond || lineSegmentIntersection.secondSubsetOfFirst {
                    resultLineString2.append(resultLineString1[lsFirstCoordIndex + 1])
                }
            }
        }

        /// Add the last coordinate
        resultLineString2.append(resultLineString1[resultLineString1.count - 1])

        /// Must have at least 3 points or two lines segments for this algorithm to apply
        guard resultLineString2.count >= 3 else {
            return resultLineString2
        }

        /// Part 3 - remove the end portion of the LineString that is completely contained in an earlier portion of that LineString
        /// Note this algorithm is not complete in that it will only remove end segments in the following circumstances:
        /// - When the end segment is completely contained in one other segment
        /// - (Possibly more to come)
        var finalIndexToRemove: Int?
        for reverseFirstCoordIndex in (2..<resultLineString2.count).reversed() {
            /// Get the line segment at or towards the end of the line string.
            let reverseFirstCoord  = resultLineString2[reverseFirstCoordIndex]
            let reverseSecondCoord = resultLineString2[reverseFirstCoordIndex - 1]
            let reverseSegment = Segment(left: reverseFirstCoord, right: reverseSecondCoord)
            let reverseBoundary = (reverseFirstCoordIndex == 0)

            /// Get the line segment at or towards the beginning of the line string.
            var done = true
            for forwardFirstCoordIndex in 0..<reverseFirstCoordIndex - 1 {
                let forwardFirstCoord  = resultLineString2[forwardFirstCoordIndex]
                let forwardSecondCoord = resultLineString2[forwardFirstCoordIndex + 1]
                let forwardSegment = Segment(left: forwardFirstCoord, right: forwardSecondCoord)
                let forwardBoundary = (forwardFirstCoordIndex == resultLineString2.count - 2)
                let lineSegmentIntersection = intersection(segment: reverseSegment, other: forwardSegment, firstCoordinateFirstSegmentBoundary: reverseBoundary, secondCoordinateSecondSegmentBoundary: forwardBoundary)
                if lineSegmentIntersection.firstSubsetOfSecond {
                    finalIndexToRemove = reverseFirstCoordIndex
                    done = false
                    break
                }
            }

            if done { break }
        }

        /// Build the new LineString
        var resultLineString3 = LineString()
        let finalIndex = (finalIndexToRemove != nil) ? finalIndexToRemove! - 1 : resultLineString2.count - 1
        for index in 0...finalIndex {
            resultLineString3.append(resultLineString2[index])
        }

        return resultLineString3
    }
}
