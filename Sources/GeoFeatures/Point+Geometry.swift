///
///  Point+Geometry.swift
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
///  Created by Tony Stone on 2/15/2016.
///
import Swift

///
/// `Geometry` protocol implementation.
///
extension Point {

    ///
    /// The spatial dimension of `self`.
    ///
    /// - Returns: .zero
    ///
    /// - SeeAlso: Dimension
    ///
    public var dimension: Dimension {
        return .zero
    }

    ///
    /// - Returns: true if this Geometry is an empty Geometry.
    ///
    /// - Remarks: A point can never be empty so will always return false.
    ///
    public func isEmpty() -> Bool {
        return false
    }

    ///
    /// - Returns: the closure of the combinatorial boundary of this Geometry instance.
    ///
    /// - Note: The boundary of a Point is an empty set.
    ///
    public func boundary() -> Geometry {
        return MultiPoint(precision: self.precision, coordinateSystem: self.coordinateSystem)
    }

    ///
    /// The min and max X Y values that make up the bounding coordinates of the geometry.
    ///
    /// - Returns: `Bounds` instance containing the minX, minY, maxX, maxY values bounding the geometry or nil if the geometry is empty.
    ///
    public func bounds() -> Bounds? {
        return Bounds(min: self.coordinate, max: self.coordinate)
    }

    ///
    /// - Returns: true if this geometric object meets the following constraints:
    ///            • No coordinate value is NaN.
    ///
    public func valid() -> Bool {
        return !coordinate.x.isNaN && !coordinate.y.isNaN
    }
}
