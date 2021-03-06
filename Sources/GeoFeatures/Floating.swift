///
///  FloatingPrecision.swift
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

///
/// Floating precision corresponds to the standard Swift Double precision type. No conversion will be done.
///
public struct Floating: Precision {

    public init() {}

    @inline(__always)
    public func convert(_ value: Double) -> Double {
        return value
    }

    @inline(__always)
    public func convert(_ value: Double?) -> Double? {
        return value
    }

    public func convert(_ coordinate: Coordinate) -> Coordinate {
        return coordinate
    }
}

extension Floating: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(31)
    }
}

extension Floating:  Equatable {}

extension Floating: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return "\(type(of: self))()"
    }

    public var debugDescription: String {
        return self.description
    }
}
