///
///  Segment.swift
///
///  Copyright 2017 Tony Stone
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
///  Created by Tony Stone on 4/24/17.
///
import Swift

///
/// Low level type to represent a segment of a line used in geometric computations.
///
internal class Segment {

    var leftCoordinate:  Coordinate
    var rightCoordinate: Coordinate

    ///
    /// Construct a line segment.
    ///
    /// - Parameters:
    ///     - left:  The first coordinate
    ///     - right: The second coordinate.
    ///
    init(left: Coordinate, right: Coordinate) {
        self.leftCoordinate  = left
        self.rightCoordinate = right
    }

    ///
    /// Construct a segment from a line string.
    /// A segment should have exactly two coordinates.  If not, dummy values will returned.
    ///
    /// - Parameters:
    ///     - other: A line string.
    ///
    public init(other: LineString) {
        guard other.count == 2 else {
            self.leftCoordinate  = Coordinate(x:0.0, y:0.0)
            self.rightCoordinate = Coordinate(x:0.0, y:0.0)
            return
        }
        self.leftCoordinate  = other[0]
        self.rightCoordinate = other[1]
    }
}
