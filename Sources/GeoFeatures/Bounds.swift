///
///  Bounds.swift
///
///  Copyright (c) 2018 Tony Stone
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
///  Created by Tony Stone on 3/24/18.
///
import Swift

///
/// Represents the min and max X Y coordinates of a collection of Coordinates (any geometry).
///
/// This object can be thought of as the bounding box and represents the lower right and upper left coordinates of a Ractangle.
///
public struct Bounds {

    ///
    /// Min X Y values
    ///
    public let min: (x: Double, y: Double)

    ///
    /// Max  X Y values
    ///
    public let max: (x: Double, y: Double)

    ///
    /// Mid X Y values
    ///
    public var mid: (x: Double, y: Double) {
        return (x: (min.x + max.x) / 2, y: (min.y + max.y) / 2)
    }

    ///
    /// Initialize a Bounds struct with min and max coordinates.
    ///
    /// - Parameters:
    ///     - min: The minimum, or lower left, coordinate.
    ///     - max: The maximum, or upper right, coordinate.
    ///
    /// - Returns: A Bounds struct defined by the input min and max values.
    ///
    public init(min: Coordinate, max: Coordinate) {
        self.min = (x: min.x, y: min.y)
        self.max = (x: max.x, y: max.y)
    }

    ///
    /// Initialize a Bounds struct with min and max tuples.
    ///
    /// - Parameters:
    ///     - min: The minimum, or lower left, coordinate as a tuple.
    ///     - max: The maximum, or upper right, coordinate as a tuple.
    ///
    /// - Returns: A Bounds struct defined by the input min and max values.
    ///
    public init(min: (x: Double, y: Double), max: (x: Double, y: Double)) {
        self.min = (x: min.x, y: min.y)
        self.max = (x: max.x, y: max.y)
    }
}

extension Bounds {

    ///
    /// Creates a Bounds struct that encloses both Bounds structs "self" and "other."
    ///
    /// - Parameters:
    ///     - other: A Bounds struct
    ///
    /// - Returns: A Bounds struct that encloses both Bounds structs "self" and "other."
    ///
    public func expand(other: Bounds) -> Bounds {
        return Bounds(min: (x: Swift.min(self.min.x, other.min.x), y: Swift.min(self.min.y, other.min.y)),
                      max: (x: Swift.max(self.max.x, other.max.x), y: Swift.max(self.max.y, other.max.y)))
    }
}

extension Bounds: Equatable {

    public static func == (lhs: Bounds, rhs: Bounds) -> Bool {
        return lhs.min == rhs.min && lhs.max == rhs.max
    }
}

extension Bounds: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return "\(type(of: self))(min: \(self.min), max: \(self.max))"
    }

    public var debugDescription: String {
        return self.description
    }
}
