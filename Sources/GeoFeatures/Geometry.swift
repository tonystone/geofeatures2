///
///  Geometry.swift
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
///  Created by Tony Stone on 2/5/2016.
///
import Swift

///
/// Default Precision for all class
///
public let defaultPrecision = Floating()

///
/// Default CoordinateSystem
///
public let defaultCoordinateSystem = Cartesian()

///
/// Geometry
///
/// A protocol that represents a geometric shape. Geometry
/// is the abstract type that is implemented by all geometry classes.
///
public protocol Geometry {

    ///
    /// The Precision used to store the coordinates for this Geometry
    ///
    var precision: Precision { get }

    ///
    /// The Coordinate Reference System used in algorithms applied to this GeometryType
    ///
    var coordinateSystem: CoordinateSystem { get }

    ///
    /// The inherent dimension of this Geometry.
    ///
    var dimension: Dimension { get }

    ///
    /// Does this Geometry contain coordinates.
    ///
    /// - Returns: true if this Geometry is an empty Geometry.
    ///
    func isEmpty() -> Bool

    ///
    /// The closure of the combinatorial boundary of this Geometry instance.
    ///
    /// - Returns: A `Geometry` object representing the closure of the combinatorial boundary of this Geometry instance.
    ///
    func boundary() -> Geometry

    ///
    /// The min and max X Y values that make up the bounding coordinates of the geometry.
    ///
    /// - Returns: `Bounds` instance containing the minX, minY, maxX, maxY values bounding the geometry or nil if the geometry is empty.
    ///
    func bounds() -> Bounds?

    ///
    /// Is `other` equal to `self`.
    ///
    /// - Returns: true if `self` is equal to the `other`.
    ///
    func equals(_ other: Geometry) -> Bool

    ///
    ///- Returns: true if this geometric object is “spatially disjoint” from the other Geometry.    // MARK: Operators
    ///
    func disjoint(_ other: Geometry) -> Bool

    ///
    /// - Returns: true if this geometric object “spatially intersects” the other Geometry.
    ///
    func intersects(_ other: Geometry) -> Bool

    ///
    /// - Returns: true if this geometric object “spatially touches” the other Geometry.
    /// - Returns: false is self and other are both 0-Dimensional (Point and MultiPoint)
    ///
    func touches(_ other: Geometry) -> Bool

    ///
    /// - Returns: true if this geometric object “spatially crosses" the other Geometry.
    ///
    func crosses(_ other: Geometry) -> Bool

    ///
    /// - Returns: true if this geometric object is “spatially within” the other Geometry.
    ///
    func within(_ other: Geometry) -> Bool

    ///
    /// - Returns: true if this geometric object “spatially contains” the other Geometry
    ///
    func contains(_ other: Geometry) -> Bool

    ///
    /// - Returns: true if this geometric object “spatially overlaps” the other Geometry
    ///
    func overlaps(_ other: Geometry) -> Bool

    ///
    /// - Returns true if this geometric object is spatially related to the other Geometry by testing for intersections between the interior, boundary and exterior of the two geometric objects as specified by the values in the intersectionPatternMatrix.
    /// - Returns: false if all the tested intersections are empty except exterior (this) intersect exterior (another).
    ///
    func relate(_ other: Geometry, pattern: String) -> Bool
}


// MARK: Operators

public func == (lhs: Geometry, rhs: Geometry) -> Bool {

    switch (lhs, rhs) {

    case let (point1, point2) as (Point, Point):
        return point1 == point2

    case let (multiPoint1, multiPoint2) as (MultiPoint, MultiPoint):
        return multiPoint1 == multiPoint2

    case let (lineString1, lineString2) as (LineString, LineString):
        return lineString1 == lineString2

    case let (linearRing1, linearRing2) as (LinearRing, LinearRing):
        return linearRing1 == linearRing2

    case let (multiLineString1, multiLineString2) as (MultiLineString, MultiLineString):
        return multiLineString1 == multiLineString2

    case let (polygon1, polygon2) as (Polygon, Polygon):
        return polygon1 == polygon2

    case let (multiPolygon1, multiPolygon2) as (MultiPolygon, MultiPolygon):
        return multiPolygon1 == multiPolygon2

    case let (geometryCollection1, geometryCollection2) as (GeometryCollection, GeometryCollection):
        return geometryCollection1 == geometryCollection2

    default:
        return false
    }
}

///
/// Predicate implementation for `Geometry` protocol
///
/// - note: In the comments below P is used to refer to 0-dimensional geometries (Points and MultiPoints), \
///         L is used to refer to 1-dimensional geometries (LineStrings and MultiLineStrings) and A is used\
///         to refer to 2-dimensional geometries (Polygons and MultiPolygons).
///
extension Geometry {

    public func equals(_ other: Geometry) -> Bool {   // FIXME: equals is implemented but is still required to be implemented for a class implementing Geometry.  Figure out why it is.
        return relate(other, pattern: "TFFFTFFFT")
    }

    public func disjoint(_ other: Geometry) -> Bool {
        return relate(other, pattern: "FF*FF****")
    }

    public func intersects(_ other: Geometry) -> Bool {
        return !disjoint(other)
    }

    public func touches(_ other: Geometry) -> Bool {

        if self.dimension == .zero && other.dimension == .zero {
            return false
        }
        return relate(other, pattern: "FT*******") || relate(other, pattern: "F**T*****") || relate(other, pattern: "F***T****")
    }

    public func crosses(_ other: Geometry) -> Bool {

        if self.dimension == .zero && other.dimension == .one ||
           self.dimension == .zero && other.dimension == .two ||
           self.dimension == .one  && other.dimension == .two {

            return relate(other, pattern: "T*T******")

        } else if self.dimension == .one && other.dimension == .one {

            return relate(other, pattern: "0********")
        }
        return false
    }

    public func within(_ other: Geometry) -> Bool {
        return relate(other, pattern: "T*F**F***")
    }

    public func contains(_ other: Geometry) -> Bool {
        return other.within(self)
    }

    public func overlaps(_ other: Geometry) -> Bool {

        if self.dimension == .zero && other.dimension == .zero ||
           self.dimension == .two  && other.dimension == .two {

            return relate(other, pattern: "T*T***T**")

        } else if self.dimension == .one && other.dimension == .one {

            return relate(other, pattern: "1*T***T**")
        }
        return false
    }

    public func relate(_ other: Geometry, pattern: String) -> Bool {
        let matrix = calculateIntersectionMatrix(other)

        return matrix.matches(pattern)
    }

    fileprivate func calculateIntersectionMatrix(_ other: Geometry) -> IntersectionMatrix {
        return IntersectionMatrix.generateMatrix(self, other)
    }
}
