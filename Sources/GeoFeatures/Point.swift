///
///  Point.swift
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
///  Created by Tony Stone on 2/9/2016.
///
import Swift

///
/// Point
///
/// A Point is a 0-dimensional geometric object and represents a single location in coordinate space. A Point has an
/// x coordinate value, a y coordinate value. If called for by the associated Spatial Reference System, it may also
/// have coordinate values for z.
///
public struct Point {

    public let precision: Precision
    public let coordinateSystem: CoordinateSystem

    public var x: Double {
        return coordinate.x
    }
    public var y: Double {
        return coordinate.y
    }
    public var z: Double? {
        return coordinate.z
    }
    public var m: Double? {
        return coordinate.m
    }

    public var coordinate: Coordinate {
        precondition(coordinates.count == 1, "Invalid number of coordinates (\(coordinates.count)) in Point, Points must have 1 coordinate.")
        
        return coordinates[0]
    }

    ///
    /// Constructs a Point with a Coordinate of type Coordinate.
    ///
    /// - parameters:
    ///     - coordinate: The Coordinate to construct the Point with.
    ///     - precision: The `Precision` model this `Point` should use in calculations on it's coordinate.
    ///     - coordinateSystem: The 'CoordinateSystem` this `Pont` should use in calculations on it's coordinate.
    ///
    /// - seealso: `CoordinateSystem`
    /// - seealso: `Precision`
    ///
    public init(coordinate: Coordinate, precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
        self.init(coordinates: CoordinateCollection(coordinate: coordinate), precision: precision, coordinateSystem: coordinateSystem)
    }

    internal init(coordinates: CoordinateCollection, precision: Precision, coordinateSystem: CoordinateSystem) {
        precondition(coordinates.count == 1, "Invalid number of coordinates (\(coordinates.count)) in Point, Points must have 1 coordinate.")

        self.precision        = precision
        self.coordinateSystem = coordinateSystem
        self.coordinates      = coordinates

        self.coordinates.apply(precision: precision)
    }

    internal private(set) var coordinates: CoordinateCollection
}

// MARK: - Copy Construction

internal extension Point {

    ///
    /// Construct a Point from another Point (copy constructor) changing the precision and coordinateSystem.
    ///
    /// - parameters:
    ///     - other: The Point of the same type that you want to construct a new Point from.
    ///     - precision: The `Precision` model this `Point` should use in calculations on it's coordinate.
    ///     - coordinateSystem: The 'CoordinateSystem` this `Pont` should use in calculations on it's coordinate.
    ///
    /// - seealso: `CoordinateSystem`
    /// - seealso: `Precision`
    ///
    internal init(other: Point, precision: Precision, coordinateSystem: CoordinateSystem) {
        self.init(coordinates: other.coordinates, precision: precision, coordinateSystem: coordinateSystem)
    }
}

extension Point: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return "\(type(of: self))\(self.coordinate)"
    }

    public var debugDescription: String {
        return self.description
    }
}

extension Point: Equatable {

    static public func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.equals(rhs)
    }
}
