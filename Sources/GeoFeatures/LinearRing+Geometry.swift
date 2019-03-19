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
    /// - Returns: a LineString equivalent of the `linearRing.`
    ///
    public func convertToLineString() -> LineString {

        var newLineString = LineString()
        for coordinate in self {
            newLineString.append(coordinate)
        }
        return newLineString
    }

    ///
    /// - Returns: true if `self` is equal to the `other` topologically.  The two geometries are visually identical.
    ///
    public func equalsTopo(_ other: Geometry) -> Bool {

        let selfAsLineString = self.convertToLineString()
        return selfAsLineString.equalsTopo(other)
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
    /// Note there is a special case where we will simplify an invalid LinearRing.
    /// If a LinearRing has only two or more identical points, the LinearRing is invalid.
    /// However, we will simplify such a LinearRing to have exactly two points.
    /// The philosophy here being that once a LinearRing has two or more points, it should
    /// never be reduced to less than two points.
    ///
    /// - Returns: the simplified geometry of the same type as the original
    ///
    public func simplify(tolerance: Double) -> LinearRing {

        /// Must have at least 3 points or two line segments for this algorithm to apply
        guard self.count >= 3 else {
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

        /// Must have at least 4 points or three lines segments for further simplification to be done
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

        /// Must have at least 4 points or three lines segments for further simplification to be done
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
}
