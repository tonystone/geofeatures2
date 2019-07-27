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
    /// - Note: The boundary of a MultiPolygon is a set of closed Curves (LineStrings) corresponding to the boundaries of its element Polygons. Each Curve in the boundary of the MultiPolygon is in the boundary of exactly 1 element Polygon, and every Curve in the boundary of an element Polygon is in the boundary of the MultiPolygon.
    ///
    public func boundary() -> Geometry {
        var boundary = GeometryCollection(precision: self.precision, coordinateSystem: self.coordinateSystem)

        for i in 0..<self.count {
            if let elementBoundary = self[i].boundary() as? GeometryCollection {
                for linearRings in elementBoundary {
                    boundary.append(linearRings)
                }
            }
        }
        return boundary
    }

    ///
    /// - Returns: true if `self` is equal to the `other`.
    ///
    public func equals(_ other: Geometry) -> Bool {
        if let other = other as? MultiPolygon{
            return self.elementsEqual(other, by: { (lhs: Polygon, rhs: Polygon) -> Bool in
                return lhs.equals(rhs)
            })
        }
        return false
    }

    ///
    /// - Returns: true if `multiPolygon1` is topologically equal to `multiPolygon2`.
    ///
    fileprivate func multiPolygonsMatchTopo(_ multiPolygon1: MultiPolygon, _ multiPolygon2: MultiPolygon) -> Bool {

        let simplifiedMultiPolygon1 = multiPolygon1.simplify(tolerance: 1.0)
        let simplifiedMultiPolygon2 = multiPolygon2.simplify(tolerance: 1.0)
        if simplifiedMultiPolygon1.count != simplifiedMultiPolygon2.count { return false }

        let count = simplifiedMultiPolygon1.count
        if count == 0 {
            return true
        } else if count == 1 {
            return simplifiedMultiPolygon1[0].equalsTopo(simplifiedMultiPolygon2[0])
        } else {
            /// See if each polygon from the first multi polygon matches a polygon from the second multi polygon.
            /// Note at this point the multi polygons have been simplified, so the polygons should be unique,
            /// and we know each multi polygon has the same number of polygons, so matching each polygon of the
            /// first with one in the second also means the reverse should also be true.
            for polgyon1 in simplifiedMultiPolygon1 {
                var polygonsMatch = false
                for polgyon2 in simplifiedMultiPolygon2 {
                    if polgyon1.equalsTopo(polgyon2) {
                        polygonsMatch = true
                        break
                    }
                }
                if !polygonsMatch { return false }
            }
            return true
        }
    }

    ///
    /// - Returns: true if `self` is equal to the `other` topologically.  The two geometries are visually identical.
    ///
    public func equalsTopo(_ other: Geometry) -> Bool {

        if let other = other as? Polygon {
            let simplifiedMultiPolygon = self.simplify(tolerance: 1.0)
            if simplifiedMultiPolygon.count == 1 {
                return simplifiedMultiPolygon[0].equalsTopo(other)
            }
        } else if let other = other as? MultiPolygon {
            return multiPolygonsMatchTopo(self, other)
        }

        return false
    }

    ///
    /// Reduces the geometry to its simplest form, the simplest sequence of points or coordinates,
    /// that is topologically equivalent to the original geometry.  In essence, this function removes
    /// duplication and intermediate coordinates that do not contribute to the overall definition.
    ///
    /// Reducing a MultiPolygon means reducing each Polygon.  Note that no combining of the Polygons
    /// is needed because we assume this is a valid MultiPolygon.
    ///
    /// - Returns: the simplified geometry of the same type as the original
    ///
    public func simplify(tolerance: Double) -> MultiPolygon {

        /// Part 1 - simplify each polygon
        var resultMultiPolygon1 = MultiPolygon()
        for polygon in self {
            let resultPolygon = polygon.simplify(tolerance: 1.0)
            resultMultiPolygon1.append(resultPolygon)
        }

        return resultMultiPolygon1
    }
}
