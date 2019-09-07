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
    /// - Returns: true if `self` is equal to the `other`.
    ///
    public func equals(_ other: Geometry) -> Bool {
        if let other = other as? GeometryCollection {
            return self.elementsEqual(other, by: { (lhs: Geometry, rhs: Geometry) -> Bool in
                return lhs.equals(rhs)
            })
        }
        return false
    }

    ///
    /// - Returns: true if `self` is equal to the `other` topologically.
    ///
    public func equalsTopo(_ other: Geometry) -> Bool {
        /// This will be put on hold for a while.  For the time being, we will just use standard equals.
        /// One way to do this would be to reduce each GeometryCollection to a set of at most three GeometryCollections,
        /// one MultiPoint, for all zero-dimensional objects; one MultiLineString, for all one-dimensional objects; and
        /// one MultiPolygon for all two-dimensional objects.  Note this would contain no LinearRings.  They would
        /// all be converted to LineStrings.
        if let other = other as? GeometryCollection {
            return self.elementsEqual(other, by: { (lhs: Geometry, rhs: Geometry) -> Bool in
                return lhs.equals(rhs)
            })
        }
        return false
    }

    ///
    /// Appends a new geometry collection to the current geometry collection without mutating the original.
    ///
    /// - parameters:
    ///     - newGeometryCollection: A geometry collection consisting of a subset of one MultiPoint, one MultiLineString and one MultiPolygon.
    ///
    ///  - returns: A GeometryCollection consisting of at most three items: a MultiPoint, a MultiLineString, and a MultiPolygon.
    ///
    public func appendCollection(_ newGeometryCollection: GeometryCollection) -> GeometryCollection {
        /// Get the existing collections
        var multiPoint = MultiPoint()
        var multiLineString = MultiLineString()
        var multiPolygon = MultiPolygon()
        for geometryCollection in self {
            if let tempMultiPoint = geometryCollection as? MultiPoint {
                multiPoint = tempMultiPoint
            } else if let tempMultiLineString = geometryCollection as? MultiLineString {
                multiLineString = tempMultiLineString
            } else if let tempMultiPolygon = geometryCollection as? MultiPolygon {
                multiPolygon = tempMultiPolygon
            }
        }

        /// Get the new collections and append them to the existing collections
        for geometryCollection in newGeometryCollection {
            if let tempMultiPoint = geometryCollection as? MultiPoint {
                multiPoint += tempMultiPoint
            } else if let tempMultiLineString = geometryCollection as? MultiLineString {
                multiLineString += tempMultiLineString
            } else if let tempMultiPolygon = geometryCollection as? MultiPolygon {
                multiPolygon += tempMultiPolygon
            }
        }

        /// Return an updated collection
        var updatedGeometryCollection = GeometryCollection()
        if multiPoint.count > 0 {
            updatedGeometryCollection.append(multiPoint)
        }
        if multiLineString.count > 0 {
            updatedGeometryCollection.append(multiLineString)
        }
        if multiPolygon.count > 0 {
            updatedGeometryCollection.append(multiPolygon)
        }
        return updatedGeometryCollection
    }

    ///
    /// Appends a new geometry collection to the current geometry collection by mutating the original.
    ///
    /// - parameters:
    ///     - newGeometryCollection: A geometry collection consisting of a subset of one MultiPoint, one MultiLineString and one MultiPolygon.
    ///
    ///  - returns: An updated version of itself consisting of at most three items: a MultiPoint, a MultiLineString, and a MultiPolygon.
    ///
    public mutating func updateCollection(_ newGeometryCollection: GeometryCollection) {
        /// Get the existing collections
        var multiPoint = MultiPoint()
        var multiLineString = MultiLineString()
        var multiPolygon = MultiPolygon()
        for geometryCollection in self {
            if let tempMultiPoint = geometryCollection as? MultiPoint {
                multiPoint = tempMultiPoint
            } else if let tempMultiLineString = geometryCollection as? MultiLineString {
                multiLineString = tempMultiLineString
            } else if let tempMultiPolygon = geometryCollection as? MultiPolygon {
                multiPolygon = tempMultiPolygon
            }
        }

        /// Get the new collections and append them to the existing collections
        for geometryCollection in newGeometryCollection {
            if let tempMultiPoint = geometryCollection as? MultiPoint {
                multiPoint += tempMultiPoint
            } else if let tempMultiLineString = geometryCollection as? MultiLineString {
                multiLineString += tempMultiLineString
            } else if let tempMultiPolygon = geometryCollection as? MultiPolygon {
                multiPolygon += tempMultiPolygon
            }
        }

        /// Return an updated collection
        var updatedGeometryCollection = GeometryCollection()
        if multiPoint.count > 0 {
            updatedGeometryCollection.append(multiPoint)
        }
        if multiLineString.count > 0 {
            updatedGeometryCollection.append(multiLineString)
        }
        if multiPolygon.count > 0 {
            updatedGeometryCollection.append(multiPolygon)
        }
        self = updatedGeometryCollection
    }

    ///
    /// Appends a new geometry to the current geometry collection without mutating the original.
    ///
    /// - parameters:
    ///     - newGeometry: A geometry consisting which can be a Point, MultiPoint, LineString, LinearRing, MultiLineString, Polygon or MultiPolygon.
    ///                    This code does not currently address the case where the geometry is a GeometryCollection.
    ///                    For that, you should call the appendCollection function.
    ///
    ///  - returns: A GeometryCollection consisting of at most three items: a MultiPoint, a MultiLineString, and a MultiPolygon.
    ///
    public func appendGeometry(_ newGeometry: Geometry) -> GeometryCollection {
        /// Get the existing collections
        var multiPoint = MultiPoint()
        var multiLineString = MultiLineString()
        var multiPolygon = MultiPolygon()
        for geometryCollection in self {
            if let tempMultiPoint = geometryCollection as? MultiPoint {
                multiPoint = tempMultiPoint
            } else if let tempMultiLineString = geometryCollection as? MultiLineString {
                multiLineString = tempMultiLineString
            } else if let tempMultiPolygon = geometryCollection as? MultiPolygon {
                multiPolygon = tempMultiPolygon
            }
        }

        /// Append the new geometry to the correct collection
        if let point = newGeometry as? Point {
            multiPoint.append(point)
        } else if let multipoint = newGeometry as? MultiPoint {
            multiPoint += multipoint
        } else if let lineString = newGeometry as? LineString {
            multiLineString.append(lineString)
        } else if let linearRing = newGeometry as? LinearRing {
            let lineString = linearRing.convertToLineString()
            multiLineString.append(lineString)
        } else if let newMultiLineString = newGeometry as? MultiLineString {
            multiLineString += newMultiLineString
        } else if let polygon = newGeometry as? Polygon {
            multiPolygon.append(polygon)
        } else if let newMultiPolygon = newGeometry as? MultiPolygon {
            multiPolygon += newMultiPolygon
        }

        /// Return an updated collection
        var updatedGeometryCollection = GeometryCollection()
        if multiPoint.count > 0 {
            updatedGeometryCollection.append(multiPoint)
        }
        if multiLineString.count > 0 {
            updatedGeometryCollection.append(multiLineString)
        }
        if multiPolygon.count > 0 {
            updatedGeometryCollection.append(multiPolygon)
        }
        return updatedGeometryCollection
    }

    ///
    /// Appends a new geometry to the current geometry collection by mutating the original.
    ///
    /// - parameters:
    ///     - newGeometry: A geometry consisting which can be a Point, MultiPoint, LineString, LinearRing, MultiLineString, Polygon or MultiPolygon.
    ///                    This code does not currently address the case where the geometry is a GeometryCollection.
    ///                    For that, you should call the appendCollection function.
    ///
    ///  - returns: An updated version of itself consisting of at most three items: a MultiPoint, a MultiLineString, and a MultiPolygon.
    ///
    public mutating func update(_ newGeometry: Geometry) {
        /// Get the existing collections
        var multiPoint = MultiPoint()
        var multiLineString = MultiLineString()
        var multiPolygon = MultiPolygon()
        for geometryCollection in self {
            if let tempMultiPoint = geometryCollection as? MultiPoint {
                multiPoint = tempMultiPoint
            } else if let tempMultiLineString = geometryCollection as? MultiLineString {
                multiLineString = tempMultiLineString
            } else if let tempMultiPolygon = geometryCollection as? MultiPolygon {
                multiPolygon = tempMultiPolygon
            }
        }

        /// Append the new geometry to the correct collection
        if let point = newGeometry as? Point {
            multiPoint.append(point)
        } else if let multipoint = newGeometry as? MultiPoint {
            multiPoint += multipoint
        } else if let lineString = newGeometry as? LineString {
            multiLineString.append(lineString)
        } else if let linearRing = newGeometry as? LinearRing {
            let lineString = linearRing.convertToLineString()
            multiLineString.append(lineString)
        } else if let newMultiLineString = newGeometry as? MultiLineString {
            multiLineString += newMultiLineString
        } else if let polygon = newGeometry as? Polygon {
            multiPolygon.append(polygon)
        } else if let newMultiPolygon = newGeometry as? MultiPolygon {
            multiPolygon += newMultiPolygon
        }

        /// Return an updated collection
        var updatedGeometryCollection = GeometryCollection()
        if multiPoint.count > 0 {
            updatedGeometryCollection.append(multiPoint)
        }
        if multiLineString.count > 0 {
            updatedGeometryCollection.append(multiLineString)
        }
        if multiPolygon.count > 0 {
            updatedGeometryCollection.append(multiPolygon)
        }
        self = updatedGeometryCollection
    }

    ///
    /// Finds the multipoint in a geometry collection.
    ///
    ///  - returns: The multipoint in the geometry collection.
    ///
    public func getMultiPoint() -> MultiPoint? {
        for geometry in self {
            if let multiPointGeometry = geometry as? MultiPoint {
                return multiPointGeometry
            }
        }
        return nil
    }

    ///
    /// Finds the multilinestring in a geometry collection.
    ///
    ///  - returns: The multilinestring in the geometry collection.
    ///
    public func getMultiLineString() -> MultiLineString? {
        for geometry in self {
            if let multiLineStringGeometry = geometry as? MultiLineString {
                return multiLineStringGeometry
            }
        }
        return nil
    }

    ///
    /// Finds the multipolygon in a geometry collection.
    ///
    ///  - returns: The multipolygon in the geometry collection.
    ///
    public func getMultiPolygon() -> MultiPolygon? {
        for geometry in self {
            if let multipolygonGeometry = geometry as? MultiPolygon {
                return multipolygonGeometry
            }
        }
        return nil
    }

    ///
    /// Reduces the geometry collection to its simplest form that is topologically equivalent to the original geometry.
    /// In essence, this function removes duplication and intermediate coordinates that do not contribute to the overall definition.
    /// It also simplifies the items in the collection to at most a set of three items: a multipoint, multilinestring, and multipolygon.
    ///
    /// Reducing a GeometryCollection means (1) combining all points and multipoints into a single multipoint,
    /// (2) combining all line strings, multilinestrings, and linear rings into a single multilinestring, and
    /// (3) combining all polygons and multipolygons into a single multipolygon, and (4) simplifying each
    /// multipoint, multilinestring and multipolygon that is produced by the previous steps.
    ///
    /// The computational complexity of this algorithm is currently O(N**2).
    ///
    /// - Returns: the simplified geometry of the same type as the original
    ///
    public func simplify(tolerance: Double) -> GeometryCollection {

        /// Check the GeometryCollection has something in it.
        guard self.count > 0 else {
            return self
        }

        /// Create temporary collections
        var tempMultiPoint = MultiPoint()
        var tempMultiLineString = MultiLineString()
        var tempMultiPolygon = MultiPolygon()

        for tempCollectionItem in self {
            if let geometryCollection = tempCollectionItem as? GeometryCollection {
                let simplifiedGeometryCollection = geometryCollection.simplify(tolerance: tolerance)
                if let newMultiPoint = simplifiedGeometryCollection.getMultiPoint() {
                    tempMultiPoint += newMultiPoint
                } else if let newMultiLineString = simplifiedGeometryCollection.getMultiLineString() {
                    tempMultiLineString += newMultiLineString
                } else if let newMultiPolygon = simplifiedGeometryCollection.getMultiPolygon() {
                    tempMultiPolygon += newMultiPolygon
                }
            } else if let point = tempCollectionItem as? Point {
                tempMultiPoint.append(point)
            } else if let multipoint = tempCollectionItem as? MultiPoint {
                tempMultiPoint += multipoint
            } else if let lineString = tempCollectionItem as? LineString {
                tempMultiLineString.append(lineString)
            } else if let linearRing = tempCollectionItem as? LinearRing {
                let lineString = linearRing.convertToLineString()
                tempMultiLineString.append(lineString)
            } else if let multiLineString = tempCollectionItem as? MultiLineString {
                tempMultiLineString += multiLineString
            } else if let polygon = tempCollectionItem as? Polygon {
                tempMultiPolygon.append(polygon)
            } else if let multiPolygon = tempCollectionItem as? MultiPolygon {
                tempMultiPolygon += multiPolygon
            }
        }

        /// Create the final collections
        let finalMultiPoint = tempMultiPoint.simplify(tolerance: tolerance)
        let finalMultiLineString = tempMultiLineString.simplify(tolerance: tolerance)
        let finalMultiPolygon = tempMultiPolygon.simplify(tolerance: tolerance)

        /// Return a simplified collection
        var finalGeometryCollection = GeometryCollection()
        if finalMultiPoint.count > 0 {
            finalGeometryCollection.append(finalMultiPoint)
        }
        if finalMultiLineString.count > 0 {
            finalGeometryCollection.append(finalMultiLineString)
        }
        if finalMultiPolygon.count > 0 {
            finalGeometryCollection.append(finalMultiPolygon)
        }
        return finalGeometryCollection
    }
}
