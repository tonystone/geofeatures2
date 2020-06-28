///
///  GeometryCollection+Geometry.swift
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

// MARK: - Geometry conformance

///
/// `Geometry` protocol implementation.
///
extension GeometryCollection {

    ///
    /// The spatial dimension of `self`.
    ///
    /// - Returns: The maximum dimension of the geonetries contained in or, or .empty if there are no geomentries.
    ///
    /// - SeeAlso: Dimension
    ///
    public var dimension: Dimension {
        return self.reduce(Dimension.empty, { Swift.max($0, $1.dimension) })
    }

    ///
    /// - Returns: the closure of the combinatorial boundary of this Geometry instance.
    ///
    /// - Note: GeometryCollection at this point does not implement boundary as there is no clear definition of what the boundary of this type would be.
    ///
    public func boundary() -> Geometry {
        /// Return an empty GeometryCollection
        return GeometryCollection(precision: self.precision, coordinateSystem: self.coordinateSystem)
    }

    ///
    /// - Returns: true if this geometric object meets the following constraints:
    ///            • A linear ring must have either 0 or 4 or more coordinates.
    ///            • The first and last coordinates must be equal.
    ///            • Consecutive coordinates may be equal.
    ///            • The interior of the linear ring must not self intersect, ignoring repeated coordinates.
    ///            • If the number of coordinates is greater than 0, there must be at least three different coordinates.
    ///
    public func valid() -> Bool {
        /// Placeholder
        return true
    }
}
