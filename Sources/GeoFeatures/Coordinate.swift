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
/// 2D Coordinate
///
/// Low level 2 dimensional Coordinate type
///
public struct Coordinate {

    public var x: Double
    public var y: Double
    public var z: Double?
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
        let count = values.count
        
        self.x = count > 0 ? values[0] : .nan
        self.y = count > 1 ? values[1] : .nan
        self.z = count > 2 ? values[2] :  nil
        self.m = count > 3 ? values[3] :  nil
    }
}

extension Coordinate: ExpressibleByDictionaryLiteral {

    /// Creates an instance initialized with the given elements.
    public init(dictionaryLiteral elements: (String, Double)...) {
        self.init(x: .nan, y: .nan)

        for (key, value) in elements {
            switch key {
            case "x": self.x = value; break
            case "y": self.y = value; break
            case "z": self.z = value; break
            case "m": self.m = value; break
            default: break
            }
        }
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

    public var hashValue: Int {
        var hash = 31 &* x.hashValue ^ 37 &* y.hashValue
        if let z = self.z {
            hash = hash ^ 41 &* z.hashValue
        }
        if let m = self.m {
            hash = hash ^ 53 &* m.hashValue
        }
        return hash
    }
}

extension Coordinate: Equatable {

    static public func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.m == rhs.m
    }
}
