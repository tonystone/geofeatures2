///
///  MultiPolygon+Geometry.swift
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
extension MultiPolygon {

    ///
    /// The spatial dimension of `self`.
    ///
    /// - Returns: .two if non-empty, or .empty otherwise.
    ///
    /// - SeeAlso: Dimension
    ///
    public var dimension: Dimension {
        return self.isEmpty() ? .empty : .two
    }

    ///
    /// - Returns: the closure of the combinatorial boundary of this Geometry instance.
    ///
    /// - Note: The boundary of a MultiPolygon is a set of closed Curves (LinearRings) corresponding to the boundaries of its element Polygons. Each Curve in the boundary of the MultiPolygon is in the boundary of exactly 1 element Polygon, and every Curve in the boundary of an element Polygon is in the boundary of the MultiPolygon.
    ///
    public func boundary() -> Geometry {
        var boundary = GeometryCollection(precision: self.precision, coordinateSystem: self.coordinateSystem)

        for i in 0..<self.count {
            if let elementBoundary = self[i].boundary() as? GeometryCollection {
                for lineString in elementBoundary {
                    boundary.append(lineString)
                }
            }
        }
        return boundary
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
