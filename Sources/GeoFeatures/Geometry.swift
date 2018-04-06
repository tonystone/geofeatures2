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
public let defaultPrecision = FloatingPrecision()

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
    /// - Returns: true if this Geometry is an empty Geometry.
    ///
    func isEmpty() -> Bool

    ///
    /// - Returns: the closure of the combinatorial boundary of this Geometry instance.
    ///
    func boundary() -> Geometry

///    ///
///    /// - Returns:  true if this GeometryType instance has no anomalous geometric points, such
///    /// as self intersection or self tangent.
///    ///
///    func isSimple() -> Bool

    ///
    /// The min and max X Y values that make up the bounding coordinates of the geometry.
    ///
    /// - Returns: `Bounds` instance containing the minX, minY, maxX, maxY values bounding the geometry or nil if the geometry is empty.
    ///
    func bounds() -> Bounds?

    ///
    /// - Returns: true if this GeometryType instance is equal to the other Geometry instance.
    ///
    func equals(_ other: Geometry) -> Bool

///    ///
///    ///- Returns: true if this geometric object is “spatially disjoint” from the other Geometry.
///    ///
///    func disjoint(_ other: Geometry) -> Bool
///
///    ///
///    /// - Returns: true if this geometric object “spatially intersects” the other Geometry.
///    ///
///    func intersects(_ other: Geometry) -> Bool
///
///    ///
///    /// - Returns: true if this geometric object “spatially touches” the other Geometry.
///    /// - Returns: false is self and other are both 0-Dimensional (Point and MultiPoint)
///    ///
///    func touches(_ other: Geometry) -> Bool
///
///    ///
///    /// - Returns: true if this geometric object “spatially crosses" the other Geometry.
///    ///
///    func crosses(_ other: Geometry) -> Bool
///
///    ///
///    /// - Returns: true if this geometric object is “spatially within” the other Geometry.
///    ///
///    func within(_ other: Geometry) -> Bool
///
///    ///
///    /// - Returns: true if this geometric object “spatially contains” the other Geometry
///    ///
///    func contains(_ other: Geometry) -> Bool
///
///    ///
///    /// - Returns: true if this geometric object “spatially overlaps” the other Geometry.
///    ///
///    func overlaps(_ other: Geometry) -> Bool
///
///    ///
///    /// - Returns true if this geometric object is spatially related to the other Geometry by testing for intersections between the interior, boundary and exterior of the two geometric objects as specified by the values in the intersectionPatternMatrix.
///    /// - Returns: false if all the tested intersections are empty except exterior (this) intersect exterior (another).
///    ///
///    func relate(_ other: Geometry, pattern: String) -> Bool
///
///    ///
///    /// - Returns: A derived geometry collection value that matches the specified m coordinate value.
///    ///
///    @warn_unused_result
///    func locateAlong(mValue:Double) -> Geometry
///
///    ///
///    /// - Returns: A derived geometry collection value that matches the specified range of m coordinate values inclusively.
///    ///
///    @warn_unused_result
///    func locateBetween(mStart:Double, mEnd:Double) -> Geometry
///
///    @warn_unused_result
///    public func distance(other: Geometry) -> Distance
///
///    @warn_unused_result
///    public func buffer(distance:Distance): Geometry
///
///    @warn_unused_result
///    func convexHull() -> Geometry
///
///    @warn_unused_result
///    func intersection(other: Geometry) -> Geometry
///
///    func union(_ other: Geometry) -> Geometry
///
///    @warn_unused_result
///    func difference(other: Geometry) -> Geometry
///
///    @warn_unused_result
///    func symDifference(other: Geometry) -> Geometry
}
