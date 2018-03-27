///
///  LineString.swift
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
import Swift

///
/// NOTE: This file was auto generated by gyb from file CoordinateCollection.swift.gyb using the following command.
///
///     ~/gyb --line-directive '' -DSelf=LineString  -o LineString.swift CoordinateCollection.swift.gyb
///
/// Do NOT edit this file directly as it will be regenerated automatically when needed.
///

///
/// LineString
///
/// A LineString is a Curve with linear interpolation between Coordinates. Each consecutive pair of
/// Coordinates defines a Line segment.
///
public struct LineString {

    ///
    /// - returns: The `Precision` of this LineString
    ///
    /// - seealso: `Precision`
    ///
    public let precision: Precision

    ///
    /// - returns: The `CoordinateSystem` of this LineString
    ///
    /// - seealso: `CoordinateSystem`
    ///
    public let coordinateSystem: CoordinateSystem

    ///
    /// Construct an empty `LineString`.
    ///
    /// - parameters:
    ///     - precision: The `Precision` model this `LineString` should use in calculations on it's coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` this `LineString` should use in calculations on it's coordinates.
    ///
    /// - seealso: `CoordinateSystem`
    /// - seealso: `Precision`
    ///
    public init(precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
        self.init(coordinates: CoordinateCollection(), precision: precision, coordinateSystem: coordinateSystem)
    }

    ///
    /// Construct a `LineString` from a any `Collection` type which holds `Coordinate` objects.
    ///
    /// LineString can be constructed from any Swift.Collection type as
    /// long as it has an Element type equal the Coordinate type specified in Element.
    ///
    /// - parameters:
    ///     - elements: A `Collection` of `Coordinate` coordinates.
    ///     - precision: The `Precision` model this `LineString` should use in calculations on it's coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` this `LineString` should use in calculations on it's coordinates.
    ///
    /// - seealso: `CoordinateSystem`
    /// - seealso: `Precision`
    ///
    public init(coordinates: CoordinateCollection, precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
        self.precision        = precision
        self.coordinateSystem = coordinateSystem
        self.coordinates      = coordinates

        self.coordinates.apply(precision: self.precision)
    }

    internal private(set) var coordinates: CoordinateCollection
}

// MARK: - Copy Construction

internal extension LineString {

    ///
    /// Construct a LineString from another LineString (copy constructor) changing the precision and coordinateSystem.
    ///
    /// - parameters:
    ///     - other: The LineString of the same type that you want to construct a new LineString from.
    ///     - precision: Optionally change the `Precision` model this `LineString` should use in calculations on it's coordinates.
    ///     - coordinateSystem: Optionally change the 'CoordinateSystem` this `LineString` should use in calculations on it's coordinates.
    ///
    /// - seealso: `CoordinateSystem`
    /// - seealso: `Precision`
    ///
    internal init(other: LineString, precision: Precision, coordinateSystem: CoordinateSystem) {
        self.init(coordinates: other.coordinates, precision: precision, coordinateSystem: coordinateSystem)
    }
}

// MARK: Collection conformance

extension LineString: Collection, MutableCollection {

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
        return coordinates.count
    }

    public subscript(index: Int) -> Coordinate {
        get {
            /// Note: we rely on the array to return an error for any index out of range.
            return coordinates[index]
        }
        set (newElement) {
            /// Note: we rely on the array to return an error for any index out of range.
            coordinates[index] = precision.convert(newElement)
        }
    }

    ///
    /// Append `newElement` to LineString.
    ///
    public mutating func append(_ newElement: Coordinate) {
        self.coordinates.append(precision.convert(newElement))
         }

    ///
    /// Append the elements of `newElements` to this LineString.
    ///
    public mutating func append<C: Swift.Collection>(contentsOf newElements: C)
            where C.Iterator.Element == Coordinate {

        self.coordinates.reserveCapacity(numericCast(newElements.count) + coordinates.count)

        var Iterator = newElements.makeIterator()

        while let coordinate = Iterator.next() {
            self.append(coordinate)
        }
    }

    ///
    /// Insert `newElement` at index `i` of this LineString.
    ///
    /// - Requires: `i <= count`.
    ///
    public mutating func insert(_ newElement: Coordinate, at index: Int) {
        self.coordinates.insert(precision.convert(newElement), at: index)
    }
}

// MARK: CustomStringConvertible & CustomDebugStringConvertible Conformance

extension LineString: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return "\(type(of: self))(\(self.map { String(describing: $0) }.joined(separator: ", ")))"
    }

    public var debugDescription: String {
        return self.description
    }
}

// MARK: Equatable Conformance

extension LineString: Equatable {

    static public func == (lhs: LineString, rhs: LineString) -> Bool {
        return lhs.equals(rhs)
    }
}
