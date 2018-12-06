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

        let boundary = self.map({ LineString(converting: $0, precision: self.precision, coordinateSystem: self.coordinateSystem) })

        return MultiLineString(boundary, precision: self.precision, coordinateSystem: self.coordinateSystem)
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

        /// Part 1 - simplify each line string
        var resultPolygon1 = Polygon()
        for linearRing in self {
            let resultLinearRing = linearRing.simplify(tolerance: 1.0)
            resultPolygon1.append(resultLinearRing)
        }

        return resultPolygon1
    }
}
