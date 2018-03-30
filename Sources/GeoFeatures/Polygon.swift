///
///  Polygon.swift
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
/// A polygon consists of an outer ring with it's coordinates in clockwise order and zero or more inner rings in counter clockwise order.
///
/// - requires: The "outerRing" be oriented clockwise
/// - requires: The "innerRings" be oriented counter clockwise
/// - requires: isSimple == true
/// - requires: isClosed == true for "outerRing" and all "innerRings"
///
public struct Polygon {

    ///
    /// - returns: The `Precision` of this Polygon
    ///
    /// - seealso: `Precision`
    ///
    public let precision: Precision

    ///
    /// - returns: The `CoordinateSystem` of this Polygon
    ///
    /// - seealso: `CoordinateSystem`
    ///
    public let coordinateSystem: CoordinateSystem

    ///
    /// - returns: The `LinearRing` representing the outerRing of this Polygon
    ///
    /// - seealso: `LinearRing`
    ///
    public var outerRing: LinearRing

    ///
    /// - returns: An Array of `LinearRing`s representing the innerRings of this Polygon
    ///
    /// - seealso: `LinearRing`
    ///
    public var innerRings: [LinearRing]

    ///
    /// A Polygon initializer to create an empty polygon.
    ///
    /// - parameters:
    ///     - precision: The `Precision` model this polygon should use in calculations on it's coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` this polygon should use in calculations on it's coordinates.
    ///
    /// - seealso: `CollectionType`
    /// - seealso: `CoordinateSystem`
    /// - seealso: `Precision`
    ///
    public init (precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
        self.init(outerRing: [] as [Coordinate], innerRings: [], precision: precision, coordinateSystem: coordinateSystem)
    }

    public init<IC: Swift.Collection>(outerRing: CoordinateCollection, innerRings: IC, precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem)
        where IC.Element == CoordinateCollection {
            self.precision        = precision
            self.coordinateSystem = coordinateSystem
            self.outerRing        = LinearRing(coordinates: outerRing, precision: precision, coordinateSystem: coordinateSystem)
            self.innerRings       = innerRings.map({ LinearRing(coordinates: $0, precision: precision, coordinateSystem: coordinateSystem) })
    }

    ///
    /// A Polygon can be constructed from a `Collection` of `Coordinate`s for it's outerRing and
    /// a an `Collection` of `Collection`s for the innerRings.
    ///
    /// This includes LinearRing and LineStrings
    ///
    /// - parameters:
    ///     - outerRing: A `Collection` who's elements are of type `Coordinate`.
    ///     - innerRings: An `Collection` of `Collection` who's elements are of type `Coordinate`.
    ///     - precision: The `Precision` model this polygon should use in calculations on it's coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` this polygon should use in calculations on it's coordinates.
    ///
    /// - seealso: `CollectionType`
    /// - seealso: `CoordinateSystem`
    /// - seealso: `Precision`
    ///
    public init<C: Swift.Collection, IC: Swift.Collection>(outerRing: C, innerRings: IC, precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem)
        where C.Element == Coordinate, IC.Element == C {
        self.precision        = precision
        self.coordinateSystem = coordinateSystem
        self.outerRing        = LinearRing(coordinates: CoordinateCollection(coordinates: outerRing), precision: precision, coordinateSystem: coordinateSystem)
        self.innerRings       = innerRings.map({ LinearRing(coordinates: CoordinateCollection(coordinates: $0), precision: precision, coordinateSystem: coordinateSystem) })
    }
}

// MARK: - Copy Construction

internal extension Polygon {

    ///
    /// Construct a Polygon from another Polygon (copy constructor) changing the precision and coordinateSystem.
    ///
    /// - parameters:
    ///     - other: The Polygon of the same type that you want to construct a new Polygon from.
    ///     - precision: Optionally change the `Precision` model this `LinearRing` should use in calculations on it's coordinates.
    ///     - coordinateSystem: Optionally change the 'CoordinateSystem` this `Polygon` should use in calculations on it's coordinates.
    ///
    /// - seealso: `CoordinateSystem`
    /// - seealso: `Precision`
    ///
    internal init(other: Polygon, precision: Precision, coordinateSystem: CoordinateSystem) {
        self.init(outerRing: other.outerRing, innerRings: other.innerRings, precision: precision, coordinateSystem: coordinateSystem)
    }
}

// MARK: CustomStringConvertible & CustomDebugStringConvertible Conformance

extension Polygon: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {

        let outerRingDescription = { () -> String in

            return "[\(self.outerRing.map { String(describing: $0) }.joined(separator: ", "))]"
        }

        let innerRingsDescription = { () -> String in
            var string: String = "["

            for i in stride(from: 0, to: self.innerRings.count, by: 1) {
                if !string.hasSuffix("[") { string += ", " }

                string += "[\(self.innerRings[i].map { String(describing: $0) }.joined(separator: ", "))]"
            }
            string += "]"
            return string
        }
        return "\(type(of: self))(\(outerRingDescription()), \(innerRingsDescription()))"
    }

    public var debugDescription: String {
        return  self.description
    }
}

extension Polygon: Equatable {

    static public func == (lhs: Polygon, rhs: Polygon) -> Bool {
        return lhs.equals(rhs)
    }
}
