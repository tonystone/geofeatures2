///
///  LinearRing.swift
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
///  Created by Tony Stone on 2/14/2016.
///

///
/// NOTE: This file was auto generated by gyb from file CoordinateCollectionTypes.swift.gyb using the following command.
///
///     ~/gyb --line-directive '' -DSelf=LinearRing  -o LinearRing.swift CoordinateCollectionTypes.swift.gyb
///
/// Do NOT edit this file directly as it will be regenerated automatically when needed.
///
import Swift

///
/// A LinearRing is a Curve with linear interpolation between Coordinates. Each consecutive pair of
/// Coordinates defines a Line segment.
///
/// - Requires:
///     - `isSimple == true`
///     - `isClosed == true`
///
public struct LinearRing: Geometry, Curve {

    ///
    /// The `Precision` of this LinearRing
	///
    public let precision: Precision

    ///
    /// The `CoordinateSystem` of this LinearRing
	///
    public let coordinateSystem: CoordinateSystem

    ///
    /// Construct an empty `LinearRing`.
    ///
    public init() {
        self.init([], precision: defaultPrecision, coordinateSystem: defaultCoordinateSystem)
    }

    ///
    /// Construct an empty `LinearRing`.
    ///
    /// - parameters:
    ///     - precision: The `Precision` model this `LinearRing` should use in calculations on it's coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` this `LinearRing` should use in calculations on it's coordinates.
	///
    public init(precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
        self.init([], precision: precision, coordinateSystem: coordinateSystem)
    }

    ///
    /// Construct a LinearRing from another LinearRing (copy constructor) changing the precision and coordinateSystem.
    ///
    /// - parameters:
    ///     - other: The LinearRing of the same type that you want to construct a new LinearRing from.
    ///     - precision: Optionally change the `Precision` model this `LinearRing` should use in calculations on it's coordinates.
    ///     - coordinateSystem: Optionally change the 'CoordinateSystem` this `LinearRing` should use in calculations on it's coordinates.
	///
    public init(other: LinearRing, precision: Precision, coordinateSystem: CoordinateSystem) {
        self.init(other.coordinates, precision: precision, coordinateSystem: coordinateSystem)
    }

    ///
    /// Construct a LinearRing from any `CoordinateCollectionType` changing the precision and coordinateSystem.
    ///
    /// - parameters:
    ///     - other: The `CoordinateCollectionType` that you want to construct a new LinearRing from.
    ///     - precision: Optionally change the `Precision` model this `LinearRing` should use in calculations on it's coordinates.
    ///     - coordinateSystem: Optionally change the 'CoordinateSystem` this `LinearRing` should use in calculations on it's coordinates.
	///
    public init<T: CoordinateCollectionType>(converting other: T, precision: Precision, coordinateSystem: CoordinateSystem) {
        self.precision        = precision
        self.coordinateSystem = coordinateSystem

        /// Add the elements to our backing storage
        self.replaceSubrange(0..<0, with: other)
    }

    ///
    /// Construct a `LinearRing` from an `Array` which holds `Coordinate` objects.
    ///
    /// LinearRing can be constructed from any Swift.Collection type as
    /// long as it has an Element type equal the Coordinate type specified in Element.
    ///
    /// - parameters:
    ///     - elements: A\n `Array` of `Coordinate` coordinates.
    ///     - precision: The `Precision` model this `LinearRing` should use in calculations on it's coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` this `LinearRing` should use in calculations on it's coordinates.
	///
    public init(_ coordinates: [Coordinate], precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
        self.precision        = precision
        self.coordinateSystem = coordinateSystem

        /// Add the elements to our backing storage
        self.replaceSubrange(0..<0, with: coordinates)
    }

    private var coordinates: [Coordinate] = []
}

// MARK: - ExpressibleByArrayLiteral conformance

extension LinearRing: ExpressibleByArrayLiteral {

    /// Creates an instance initialized with the given elements.
    public init(arrayLiteral elements: Coordinate...) {
        self.init(elements)
    }
}

// MARK: `CoordinateCollectionType` and `RangeReplaceableCollection` conformance

extension LinearRing: CoordinateCollectionType, RangeReplaceableCollection {

    ///
    /// Returns the position immediately after `i`.
    ///
    /// - Precondition: `(startIndex..<endIndex).contains(i)`
    ///
    public func index(after i: Int) -> Int {
        return i+1
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
        return self.coordinates.count
    }

    ///
    /// Accesses the element at the specified position.
    ///
    public subscript(index: Int) -> Coordinate {
        get {
            return coordinates[index]
        }
        set (newElement) {
            self.replaceSubrange(index..<(index + 1), with: [newElement])
        }
    }

    ///
    /// Replaces the specified subrange of elements with the given collection.
    ///
    /// This method has the effect of removing the specified range of elements
    /// from the collection and inserting the new elements at the same location.
    /// The number of new elements need not match the number of elements being
    /// removed.
    ///
    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C : Collection, R : RangeExpression, Coordinate == C.Element, Int == R.Bound {
        self.coordinates.replaceSubrange(subrange, with: newElements.map({ self.precision.convert($0) }))
    }
}

// MARK: CustomStringConvertible & CustomDebugStringConvertible Conformance

extension LinearRing: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return "\(type(of: self))([\(self.map { String(describing: $0) }.joined(separator: ", "))])"
    }

    public var debugDescription: String {
        return self.description
    }
}

// MARK: Equatable Conformance

extension LinearRing: Equatable {

    static public func == (lhs: LinearRing, rhs: LinearRing) -> Bool {
        return lhs.equals(rhs)
    }
}
