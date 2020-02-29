///
///  Fixed.swift
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
///  Created by Tony Stone on 2/11/2016.
///
import Swift

#if os(Linux) || os(FreeBSD)
    import Glibc
#else
    import Darwin
#endif

///
/// Fixed Precision ensures coordinates have a fixed number of decimal places.
///
/// - Remarks: The number of decimal places is determined by the scale passed.
///
public struct Fixed: Precision {

    public let scale: Double

    public init(scale: Double) {
        self.scale = abs(scale)
    }

    @inline(__always)
    public func convert(_ value: Double) -> Double {
        return round(value * scale) / scale
    }

    @inline(__always)
    public func convert(_ value: Double?) -> Double? {
        guard let value = value
            else { return nil }
        return convert(value)
    }

    public func convert(_ coordinate: Coordinate) -> Coordinate {
        return Coordinate(x: self.convert(coordinate.x), y: self.convert(coordinate.y), z: self.convert(coordinate.z), m: self.convert(coordinate.m))
    }
}

extension Fixed: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(scale)
    }
}

extension Fixed: Equatable {}

extension Fixed: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return "\(type(of: self))(scale: \(self.scale))"
    }

    public var debugDescription: String {
        return self.description
    }
}
