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
    ///            • The MultiPolygon may be empty
    ///            • The Polygons in a MultiPolygon may not overlap by a one or two-dimensional region
    ///            • The Polygons in a MultiPolygon may only touch at a finite number of single points
    ///
    public func valid() -> Bool {

        let polygonCount = self.count
        guard polygonCount > 0 else { return true }

        /// Check all the polygons are valid.
        for polygon in self {
            if !polygon.valid() {
                return false
            }
        }

        /// Check no two polygons overlap and do not touch the boundary of another polygon by more than a finite set of points
        guard polygonCount >= 2 else { return true }

        for polygon1Index in 0..<polygonCount - 1 {
            let polygon1 = self[polygon1Index]
            for polygon2Index in (polygon1Index + 1)..<polygonCount {
                let polygon2 = self[polygon2Index]
                let matrix = IntersectionMatrix.generateMatrix(polygon1, polygon2)
                if (matrix[.interior, .interior] == .two) || (matrix[.boundary, .boundary] == .one) {
                    return false
                }
            }
        }

        return true
    }
}
