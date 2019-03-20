///
///  Polygon+Geometry.swift
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
extension Polygon {

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
    /// - Note: The boundary of a Polygon consists of a set of LinearRings that make up its exterior and interior boundaries
    ///
    public func boundary() -> Geometry {
        
        let boundary = self.map({ LinearRing(converting: $0, precision: self.precision, coordinateSystem: self.coordinateSystem) })
        
        return GeometryCollection(boundary, precision: self.precision, coordinateSystem: self.coordinateSystem)
    }
    
    ///
    /// - Returns: true if `self` is equal to the `other`.
    ///
    public func equals(_ other: Geometry) -> Bool {
        if let other = other as? Polygon {
            return self.outerRing.equals(other.outerRing) && self.innerRings.elementsEqual(other.innerRings, by: { (lhs: LinearRing, rhs: LinearRing) -> Bool in
                return lhs.equals(rhs)
            })
        }
        return false
    }

    ///
    /// - Returns: the holes for a polygon.  This will be an array of linear rings.
    ///
    fileprivate func holes(_ polygon: Polygon) -> [LinearRing] {

        guard let polygonBoundary = polygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 1 else {
                return []
        }

        var innerLinearRings = [LinearRing]()
        for index in 1..<polygonBoundary.count {
            guard let linearRing = polygonBoundary[index] as? LinearRing else { return [] }
            innerLinearRings.append(linearRing)
        }

        return innerLinearRings
    }

    ///
    /// - Returns: true if `polygon1` is topologically equal to `polygon2`.
    ///
    fileprivate func polygonsMatchTopo(_ polygon1: Polygon, _ polygon2: Polygon) -> Bool {

        let simplifiedPolygon1 = polygon1.simplify(tolerance: 1.0)
        let simplifiedPolygon2 = polygon2.simplify(tolerance: 1.0)
        if simplifiedPolygon1.count != simplifiedPolygon2.count { return false }

        let count = simplifiedPolygon1.count
        if count == 0 {
            return true
        } else if count == 1 {
            return simplifiedPolygon1[0].equalsTopo(simplifiedPolygon2[0])
        } else {
            /// See if the outer rings match
            if !simplifiedPolygon1[0].equalsTopo(simplifiedPolygon2[0]) { return false }

            /// Now see if the holes match
            let holes1 = holes(simplifiedPolygon1)
            let holes2 = holes(simplifiedPolygon2)
            if holes1.count != holes2.count { return false }

            for linearRing1 in holes1 {
                var linearRingsMatch = false
                for linearRing2 in holes2 {
                    if linearRing1.equalsTopo(linearRing2) {
                        linearRingsMatch = true
                        break
                    }
                }
                if !linearRingsMatch { return false }
            }
            return true
        }
    }

    ///
    /// - Returns: true if `self` is equal to the `other` topologically.  The two geometries are visually identical.
    ///
    public func equalsTopo(_ other: Geometry) -> Bool {

        if let other = other as? Polygon {
            return polygonsMatchTopo(self, other)
        } else if let other = other as? MultiPolygon {
            let simplifiedMultiPolygon = other.simplify(tolerance: 1.0)
            if simplifiedMultiPolygon.count == 1 {
                return polygonsMatchTopo(self, simplifiedMultiPolygon[0])
            }
        }

        return false
    }

    ///
    /// Reduces the geometry to its simplest form, the simplest sequence of points or coordinates,
    /// that is topologically equivalent to the original geometry.  In essence, this function removes
    /// duplication and intermediate coordinates that do not contribute to the overall definition.
    ///
    /// Reducing a Polygon means reducing each LinearRing that makes up that Polygon.
    /// The first LinearRing is the main ring, and all the others are holes.
    /// Note that no combining of the holes is needed because we assume this is a valid Polygon.
    ///
    /// - Returns: the simplified geometry of the same type as the original
    ///
    public func simplify(tolerance: Double) -> Polygon {

        /// Part 1 - simplify each linear ring
        var resultPolygon1 = Polygon()
        for linearRing in self {
            let resultLinearRing = linearRing.simplify(tolerance: 1.0)
            resultPolygon1.append(resultLinearRing)
        }

        return resultPolygon1
    }
}
