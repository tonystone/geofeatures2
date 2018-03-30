///
///  CoordinateCollection.swift
///
///  Copyright (c) 2018 Tony Stone
///
///   Licensed under the Apache License, Version 2.0 (the "License");
///   you may not use this file except in compliance with the License.
///   You may obtain a copy of the License at
///
///   http://www.apache.org/licenses/LICENSE-2.0
///
///   Unless required by applicable law or agreed to in writing, software
///   distributed under the License is distributed on an "AS IS" BASIS,
///   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///   See the License for the specific language governing permissions and
///   limitations under the License.
///
///  CCreated by Tony Stone on 3/28/18.
///

import Foundation

public struct CoordinateCollection {

    public init() {
        self.init(coordinates: [])
    }

    public init(coordinate: Coordinate) {
        self.init(coordinates: [coordinate])
    }

    public init<C: Swift.Collection>(coordinates: C) where C.Iterator.Element == Coordinate {
        self.init(coordinates: coordinates.map({ $0 }))
    }

    ///
    /// Designated init
    ///
    public init(coordinates: [Coordinate]) {
        self.coordinates = coordinates
    }

    private var coordinates: [Coordinate]
}

extension CoordinateCollection: ExpressibleByArrayLiteral {

    /// Creates an instance initialized with the given elements.
    public init(arrayLiteral elements: Coordinate...) {
        self.init(coordinates: elements)
    }
}

extension CoordinateCollection: Collection, MutableCollection {

    ///
    /// Prepares the collection to store the specified number of elements, when
    /// doing so is appropriate for the underlying type.
    ///
    public mutating func reserveCapacity(_ n: Int) {
        self.coordinates.reserveCapacity(n)
    }

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
            return coordinates[index]
        }
        set (newElement) {
            coordinates[index] = newElement
        }
    }

    ///
    /// Append `newElement` to LineString.
    ///
    public mutating func append(_ newElement: Coordinate) {
        self.coordinates.append(newElement)
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
        self.coordinates.insert(newElement, at: index)
    }
}

extension CoordinateCollection {

    enum Axis {
        case x, y, z, m
    }

    internal mutating func apply(precision: Precision) {
        for i in 0..<coordinates.count {
            self[i].x = precision.convert(self[i].x)
            self[i].y = precision.convert(self[i].y)
            self[i].z = precision.convert(self[i].z)
            self[i].m = precision.convert(self[i].m)
        }
    }

    internal func axes() -> [Axis] {
        var axes: [Axis] = [.x, .y]
        var z = false
        var m = false

        for i in 0..<coordinates.count {
            if coordinates[i].z != nil { z = true }
            if coordinates[i].m != nil { m = true }
        }
        if z { axes.append(.z) }
        if m { axes.append(.m) }

        return axes
    }
}
