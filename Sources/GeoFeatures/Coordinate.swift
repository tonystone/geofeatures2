///
///  Coordinate.swift
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
///  Created by Tony Stone on 2/13/16.
///
import Swift

///
/// A low level Coordinate type which forms the internal storage for all `Geometry` types.
///
public struct Coordinate {

    ///
    /// The `x` Axis value.
    ///
    public var x: Double

    ///
    /// The `y` Axis value.
    ///
    public var y: Double

    ///
    /// The `z` Axis value, if available.
    ///
    public var z: Double?

    ///
    /// The `m` Axis value, if available.
    ///
    public var m: Double?

    public init(x: Double, y: Double, z: Double? = nil, m: Double? = nil) {
        self.x = x
        self.y = y
        self.z = z
        self.m = m
    }

    public init(other: Coordinate) {
        self.init(x: other.x, y: other.y, z: other.z, m: other.m)
    }
}

extension Coordinate: ExpressibleByArrayLiteral {

    /// Creates an instance initialized with the given elements.
    public init(arrayLiteral values: Double...) {
        precondition(values.count >= 2)

        self.init(x: values[0], y: values[1], z: values.count > 2 ? values[2] :  nil, m: values.count > 3 ? values[3] :  nil)
    }
}

extension Coordinate: ExpressibleByDictionaryLiteral {

    /// Creates an instance initialized with the given elements.
    public init(dictionaryLiteral elements: (String, Double)...) {
        precondition(elements.count >= 2)
        precondition(elements[0].0 == "x")
        precondition(elements[1].0 == "y")

        var z: Double? = nil
        var m: Double? = nil

        for (key, value) in elements[2...] {
            switch key {
            case "z": z = value; break
            case "m": m = value; break
            default: break
            }
        }
        self.init(x: elements[0].1, y: elements[1].1, z: z, m: m)
    }
}

extension Coordinate: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        var string =  "(x: \(self.x), y: \(self.y)"
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

extension Coordinate: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        if let z = self.z {
            hasher.combine(z)
        }
        if let m = self.m {
            hasher.combine(m)
        }
    }
}

extension Coordinate: Equatable {

    static public func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.m == rhs.m
    }
}
