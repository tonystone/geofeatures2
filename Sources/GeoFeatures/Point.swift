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

    ///
    /// - Returns: The `Precision` of this GeometryCollection
    ///
    /// - SeeAlso: `Precision`
    ///
    public let precision: Precision

    ///
    /// - Returns: The `CoordinateSystem` of this GeometryCollection
    ///
    /// - SeeAlso: `CoordinateSystem`
    ///
    public let coordinateSystem: CoordinateSystem

    ///
    /// - Returns: The `x` Axis value of the stored `Coordinate`.
    ///
    public var x: Double {
        return coordinate.x
    }

    ///
    /// - Returns: The `y` Axis value of the stored `Coordinate`.
    ///
    public var y: Double {
        return coordinate.y
    }

    ///
    /// - Returns: The `z` Axis value of the stored `Coordinate` or nil if not present.
    ///
    public var z: Double? {
        return coordinate.z
    }

    ///
    /// - Returns: The `m` Axis value of the stored `Coordinate` or nil if not present.
    ///
    public var m: Double? {
        return coordinate.m
    }

    ///
    /// Construct a Point from another Point (copy constructor).
    ///
    /// - parameters:
    ///     - other: The Point of the same type that you want to construct a new Point from.
    ///
    public init(_ other: Point) {
        self.init(other.coordinate, precision: other.precision, coordinateSystem: other.coordinateSystem)
    }

    ///
    /// Construct a Point from another Point (copy constructor) changing the precision and coordinateSystem.
    ///
    /// - Parameters:
    ///     - other: The Point of the same type that you want to construct a new Point from.
    ///     - precision: The `Precision` model this `Point` should use in calculations on it's coordinate.
    ///     - coordinateSystem: The 'CoordinateSystem` this `Pont` should use in calculations on it's coordinate.
    ///
    /// - SeeAlso: `CoordinateSystem`
    /// - SeeAlso: `Precision`
    ///
    internal init(other: Point, precision: Precision, coordinateSystem: CoordinateSystem) {
        self.init(other.coordinate, precision: precision, coordinateSystem: coordinateSystem)
    }

    ///
    /// Constructs a Point with a Coordinate of type Coordinate.
    ///
    /// - Parameters:
    ///     - coordinate: The Coordinate to construct the Point with.
    ///     - precision: The `Precision` model this `Point` should use in calculations on it's coordinate.
    ///     - coordinateSystem: The 'CoordinateSystem` this `Pont` should use in calculations on it's coordinate.
    ///
    /// - SeeAlso: `CoordinateSystem`
    /// - SeeAlso: `Precision`
    ///
    public init(_ coordinate: Coordinate, precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {

        self.precision        = precision
        self.coordinateSystem = coordinateSystem
        self.coordinate       = precision.convert(coordinate)
    }

    internal private(set) var coordinate: Coordinate
}

// MARK: - ExpressibleByArrayLiteral conformance

extension Point: ExpressibleByArrayLiteral {

    /// Creates an instance initialized with the given elements.
    public init(arrayLiteral values: Double...) {
        precondition(values.count >= 2)
        let count = values.count

        self.init(Coordinate(x: count > 0 ? values[0] : .nan, y: count > 1 ? values[1] : .nan, z: count > 2 ? values[2] :  nil, m: count > 3 ? values[3] :  nil))
    }
}

// MARK: - ExpressibleByDictionaryLiteral conformance

extension Point: ExpressibleByDictionaryLiteral {

    /// Creates an instance initialized with the given elements.
    public init(dictionaryLiteral elements: (String, Double)...) {
        precondition(elements.count >= 2)

        var x: Double  = .nan
        var y: Double  = .nan
        var z: Double? = nil
        var m: Double? = nil

        for (key, value) in elements {
            switch key {
            case "x": x = value; break
            case "y": y = value; break
            case "z": z = value; break
            case "m": m = value; break
            default: break
            }
        }
        self.init(Coordinate(x: x, y: y, z: z, m: m))
    }
}

extension Point: CoordinateCollectionType {

    public var startIndex: Int { return 0 }

    public var endIndex: Int { return 1 }

    public func index(after i: Int) -> Int { return i+1 }

    public subscript(index: Int) -> Coordinate {
        get {
            precondition(index == 0)

            return self.coordinate
        }
        set {
            precondition(index == 0)

            self.coordinate = self.precision.convert(newValue)
        }
    }
}

extension Point: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        var string =  "\(type(of: self))(x: \(self.x), y: \(self.y)"
        if let z = self.z {
            string.append(", z: \(z)")
        }
        if let m = self.m {
            string.append(", m: \(m)")
        }
        string.append(")")
        return string
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
