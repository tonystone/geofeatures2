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
public struct Polygon<CoordinateType: Coordinate & CopyConstructable> {

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
    public var outerRing: LinearRing<CoordinateType> {
        guard let first = self.rings.first
            else { return LinearRing<CoordinateType>(precision: self.precision, coordinateSystem: self.coordinateSystem) }
        return first
    }

    ///
    /// - returns: An Array of `LinearRing`s representing the innerRings of this Polygon
    ///
    /// - seealso: `LinearRing`
    ///
    public var innerRings: [LinearRing<CoordinateType>] {
        guard self.rings.count > 1
            else { return [] }
        return Array(self.rings.suffix(from: 1))
    }

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

        self.precision        = precision
        self.coordinateSystem = coordinateSystem
        self.rings            = []

        /// Note: No validation needed, an empty Polygon is always valid.
    }

    ///
    /// Construct a Polygon from another Polygon (copy constructor).
    ///
    /// - parameters:
    ///    - other: The Polygon of the same type that you want to construct a new Polygon from.
    ///
    public init(other: Polygon<CoordinateType>) {

        self.precision        = other.precision
        self.coordinateSystem = other.coordinateSystem
        self.rings            = other.rings
    }

    ///
    /// Construct a Polygon from another Polygon (copy constructor).
    ///
    /// - parameters:
    ///    - other: The Polygon of the same type that you want to construct a new Polygon from.
    ///
    /// - seealso: `CoordinateSystem`
    /// - seealso: `Precision`
    ///
    internal init(other: Polygon<CoordinateType>, precision: Precision, coordinateSystem: CoordinateSystem) {

        self.precision        = precision
        self.coordinateSystem = coordinateSystem
        self.rings            = other.rings.map({ LinearRing<CoordinateType>(other: $0, precision: precision, coordinateSystem: coordinateSystem) })
    }

    ///
    /// A Polygon can be constructed from any `CollectionType` for it's rings including Array as
    /// long as it has an Element type equal the `CoordinateType` specified.
    ///
    /// - parameters:
    ///     - outerRing: A `CollectionType` who's elements are of type `CoordinateType`.
    ///     - innerRings: An `Array` of `CollectionType` who's elements are of type `CoordinateType`.
    ///     - precision: The `Precision` model this polygon should use in calculations on it's coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` this polygon should use in calculations on it's coordinates.
    ///
    /// - seealso: `CollectionType`
    /// - seealso: `CoordinateSystem`
    /// - seealso: `Precision`
    ///
    public init<C: Swift.Collection>(outerRing: C, innerRings: [C] = [], precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem)
            where C.Iterator.Element == CoordinateType {

        self.precision = precision
        self.coordinateSystem = coordinateSystem
        self.rings = []

        rings.append(LinearRing<CoordinateType>(elements: outerRing, precision: precision, coordinateSystem: coordinateSystem))

        var innerRingsGenerator = innerRings.makeIterator()

        while let ring = innerRingsGenerator.next() {
            rings.append(LinearRing<CoordinateType>(elements: ring, precision: precision, coordinateSystem: coordinateSystem))
        }
    }

    internal var rings: [LinearRing<CoordinateType>]
}

extension Polygon where CoordinateType: TupleConvertible {

    ///
    /// A Polygon can be constructed from any `CollectionType` for it's rings including Array as
    /// long as it has an Element type equal the `CoordinateType` specified.
    ///
    /// - parameters:
    ///     - outerRing: A `CollectionType` who's elements are of type `CoordinateType.TupleType`.
    ///     - innerRings: An `Array` of `CollectionType` who's elements are of type `CoordinateType.TupleType`.
    ///     - precision: The `Precision` model this polygon should use in calculations on it's coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` this polygon should use in calculations on it's coordinates.
    ///
    /// - seealso: `CollectionType`
    /// - seealso: `CoordinateSystem`
    /// - seealso: `Precision`
    ///
    public init(outerRing: [CoordinateType.TupleType], innerRings: [[CoordinateType.TupleType]] = [], precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
        self.precision = precision
        self.coordinateSystem = coordinateSystem
        self.rings = []

        rings.append(LinearRing<CoordinateType>(elements: outerRing, precision: precision, coordinateSystem: coordinateSystem))

        var innerRingsGenerator = innerRings.makeIterator()

        while let ring = innerRingsGenerator.next() {
            rings.append(LinearRing<CoordinateType>(elements: ring, precision: precision, coordinateSystem: coordinateSystem))
        }
    }

    public init(rings tupleRings: ([CoordinateType.TupleType], [[CoordinateType.TupleType]]), precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
        self.precision = precision
        self.coordinateSystem = coordinateSystem

        self.rings = []

        self.rings.append(LinearRing<CoordinateType>(elements: tupleRings.0, precision: precision, coordinateSystem: coordinateSystem))

        var innerRingsGenerator = tupleRings.1.makeIterator()

        while let ring = innerRingsGenerator.next() {
            self.rings.append(LinearRing<CoordinateType>(elements: ring, precision: precision, coordinateSystem: coordinateSystem))
        }
    }
}

// MARK: CustomStringConvertible & CustomDebugStringConvertible Conformance

extension Polygon: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {

        let outerRingDescription = { () -> String in
            if self.rings.count > 0 {
                return "[\(self.rings[0].map { String(describing: $0) }.joined(separator: ", "))]"
            }
            return "[]"
        }

        let innerRingsDescription = { () -> String in
            var string: String = "["

            for i in stride(from: 1, to: self.rings.count, by: 1) {
                if !string.hasSuffix("[") { string += ", " }

                string += "[\(self.rings[i].map { String(describing: $0) }.joined(separator: ", "))]"
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

extension Polygon: Equatable {}

public func == <CoordinateType>(lhs: Polygon<CoordinateType>, rhs: Polygon<CoordinateType>) -> Bool {
    return lhs.equals(rhs)
}
