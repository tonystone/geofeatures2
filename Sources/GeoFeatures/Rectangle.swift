///
///  Rectangle.swift
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
/// An axis aligned 2D rectangle.
///
internal struct Rectangle {

    ///
    /// Lower Left Corner of the rectangle
    ///
    public let lowerLeft:  Coordinate

    ///
    /// Upper Left Corner of a rectangle
    ///
    public var upperLeft: Coordinate {
        return Coordinate(x: lowerLeft.x,  y: upperRight.y)
    }

    ///
    /// Upper Right Corner of a rectangle
    ///
    public let upperRight: Coordinate

    ///
    /// Lower Left Corner of a rectangle
    ///
    public var lowerRight: Coordinate {
        return Coordinate(x: upperRight.x, y: lowerLeft.y)
    }

    ///
    /// Initialize a rectangle with the lower left and upper right.
    ///
    public init(_ lowerLeft: Coordinate, _ upperRight: Coordinate) {
        self.lowerLeft  = lowerLeft
        self.upperRight = upperRight
    }

    ///
    /// Returns the closed (first == last) set of coordinates representing this `Rectangle` as a `CoordinateCollection`.
    ///
    public  var coordinates: CoordinateCollection {
        return CoordinateCollection(coordinates: [lowerLeft, upperLeft, upperRight, lowerRight, lowerLeft])
    }
}

extension Rectangle {

    func union(other: Rectangle) -> Rectangle {
        return Rectangle(
            Coordinate(x: Swift.min(self.lowerLeft.x,  other.lowerLeft.x),  y: Swift.min(self.lowerLeft.y,  other.lowerLeft.y)),
            Coordinate(x: Swift.max(self.upperRight.x, other.upperRight.x), y: Swift.max(self.upperRight.y, other.upperRight.y)))
    }
}

extension Rectangle: Equatable {
    public static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.lowerLeft == rhs.lowerLeft && lhs.upperRight == rhs.upperRight
    }
}

extension Rectangle: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return "\(type(of: self))(\(self.lowerLeft), \(self.upperRight))"
    }

    public var debugDescription: String {
        return self.description
    }
}
