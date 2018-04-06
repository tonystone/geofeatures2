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
/// - Requires: The "outerRing" be oriented clockwise
/// - Requires: The "innerRings" be oriented counter clockwise
/// - Requires: isSimple == true
/// - Requires: isClosed == true for "outerRing" and all "innerRings"
///
public struct Polygon {

    ///
    /// - Returns: The `Precision` of this Polygon
    ///
    /// - SeeAlso: `Precision`
    ///
    public let precision: Precision

    ///
    /// - Returns: The `CoordinateSystem` of this Polygon
    ///
    /// - SeeAlso: `CoordinateSystem`
    ///
    public let coordinateSystem: CoordinateSystem

    ///
    /// - Returns: The `LinearRing` representing the outerRing of this Polygon
    ///
    /// - SeeAlso: `LinearRing`
    ///
    public var outerRing: LinearRing {
        guard self.count > 0
            else { return LinearRing([], precision: self.precision, coordinateSystem: self.coordinateSystem) }
        return self[0]
    }

    ///
    /// - Returns: An Array of `LinearRing`s representing the innerRings of this Polygon
    ///
    /// - SeeAlso: `LinearRing`
    ///
    public var innerRings: [LinearRing] {
        guard self.count > 1
            else { return [] }
        return Array(self.rings[1...])
    }

    ///
    /// A Polygon initializer to create an empty polygon.
    ///
    public init () {
        self.init([], precision: defaultPrecision, coordinateSystem: defaultCoordinateSystem)
    }

    ///
    /// A Polygon initializer to create an empty polygon.
    ///
    /// - Parameters:
    ///     - precision: The `Precision` model this polygon should use in calculations on its coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` this polygon should use in calculations on its coordinates.
    ///
    /// - SeeAlso: `CoordinateSystem`
    /// - SeeAlso: `Precision`
    ///
    public init (precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
        self.init([], precision: precision, coordinateSystem: coordinateSystem)
    }

    ///
    /// Designated initializer: A Polygon can be constructed from a `CoordinateCollectionType` for it's outerRing and
    /// an `Array` of  `CoordinateCollectionType`s for the innerRings.
    ///
    /// - Parameters:
    ///     - outerRing: A `CoordinateCollectionType` representing the exterior of the Polygon.
    ///     - innerRings: A `[CoordinateCollectionType]` representing the interior holes of the Polygon.
    ///     - precision: The `Precision` model this polygon should use in calculations on its coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` this polygon should use in calculations on it's coordinates.
    ///
    /// - SeeAlso: `CoordinateCollectionType`
    /// - SeeAlso: `CoordinateSystem`
    /// - SeeAlso: `Precision`
    ///
    public init(_ outerRing: LinearRing, innerRings: [LinearRing] = [], precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
            var rings = [outerRing]
            rings.append(contentsOf: innerRings)

            self.init(rings, precision: precision, coordinateSystem: coordinateSystem)
    }

    ///
    /// Construct a Polygon from another Polygon (copy constructor) changing the precision and coordinateSystem.
    ///
    /// - Parameters:
    ///     - other: The Polygon of the same type that you want to construct a new Polygon from.
    ///     - precision: Optionally change the `Precision` model this `LinearRing` should use in calculations on its coordinates.
    ///     - coordinateSystem: Optionally change the 'CoordinateSystem` this `Polygon` should use in calculations on its coordinates.
    ///
    /// - SeeAlso: `CoordinateSystem`
    /// - SeeAlso: `Precision`
    ///
    internal init(other: Polygon, precision: Precision, coordinateSystem: CoordinateSystem) {
        self.init(other.rings, precision: precision, coordinateSystem: coordinateSystem)
    }

    ///
    /// Designated initializer: A Polygon can be constructed from an Array of `CoordinateCollectionType` for its outer and inner rings.
    ///
    /// - Parameters:
    ///     - rings: A an `Array` of `CoordinateCollectionType` representing the exterior and interior rings of the Polygon.
    ///     - precision: The `Precision` model this polygon should use in calculations on its coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` this polygon should use in calculations on it's coordinates.
    ///
    /// - SeeAlso: `CoordinateCollectionType`
    /// - SeeAlso: `CoordinateSystem`
    /// - SeeAlso: `Precision`
    ///
    public init(_ rings: [LinearRing], precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
        self.precision        = precision
        self.coordinateSystem = coordinateSystem

        /// Add the elements to our backing storage
        self.replaceSubrange(0..<0, with: rings)
    }

    private var rings: [LinearRing] = []
}

// MARK: - ExpressibleByArrayLiteral conformance

extension Polygon: ExpressibleByArrayLiteral {

    /// Creates an instance initialized with the given elements.
    public init(arrayLiteral elements: LinearRing...) {
        self.init(elements)
    }
}

// MARK: `GeometryCollectionType` and `RangeReplaceableCollection` conformance.

extension Polygon: GeometryCollectionType, RangeReplaceableCollection {

    ///
    /// Returns the position immediately after `i`.
    ///
    /// - Precondition: `(startIndex..<endIndex).contains(i)`
    ///
    public func index(after i: Int) -> Int {
        return i + 1
    }

    ///
    /// Always zero, which is the index of the first element when non-empty.
    ///
    public var startIndex: Int {
        return 0
    }

    ///
    /// A "past-the-end" element index; the successor of the last valid subscript argument.
    ///
    public var endIndex: Int {
        return rings.endIndex
    }

    public subscript(index: Int) -> LinearRing {
        get {
            return self.rings[index]
        }
        set (newElement) {
            self.replaceSubrange(index..<(index + 1), with: [newElement])
        }
    }

    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C : Collection, R : RangeExpression, LinearRing == C.Element, Int == R.Bound {
        let preciseElements = newElements.map({ LinearRing(other: $0, precision: self.precision, coordinateSystem: self.coordinateSystem) })

        self.rings.replaceSubrange(subrange, with: preciseElements)
    }
}

// MARK: CustomStringConvertible & CustomDebugStringConvertible Conformance

extension Polygon: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return "\(type(of: self))(\(self.rings))"
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
