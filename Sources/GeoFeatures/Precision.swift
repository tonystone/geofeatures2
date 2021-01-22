///
///  Precision.swift
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
/// The precision model used for all `Geometry` types.
///
public protocol Precision {

    ///
    /// Convert a double into `self` precision.
    ///
    ///- Parameters:
    ///     - value: A double to convert.
    ///
    /// - Returns: A double converted to `self` precision.
    ///
    func convert(_ value: Double) -> Double

    ///
    /// Convert an optional double into `self` precision.
    ///
    /// - Parameters:
    ///     - value: An optional double to convert.
    ///
    /// - Returns: A double converted to `self` precision if a value was passed, or nil otherwise.
    ///
    func convert(_ value: Double?) -> Double?

    ///
    /// Convert a Coordinate into `self` precision.
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate to convert.
    ///
    /// - Returns: A Coordinate converted to `self` precision.
    ///
    func convert(_ coordinate: Coordinate) -> Coordinate
}

///
/// Compares to precision types for equality when both are Hashable.
///
public func == <T1: Precision & Hashable, T2: Precision & Hashable>(lhs: T1, rhs: T2) -> Bool {
    if type(of: lhs) == type(of: rhs) {
        return lhs.hashValue == rhs.hashValue
    }
    return false
}
