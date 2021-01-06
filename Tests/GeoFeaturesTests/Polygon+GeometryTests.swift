///
///  Polygon+GeometryTests.swift
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
///  Created by Tony Stone on 4/24/2016.
///
import XCTest
import GeoFeatures

#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS)) && SWIFT_PACKAGE
    /// Note: Resolution of GeoFeatures.Polygon is ambiguous when ApplicationsServices is included in the app (ApplicationsServices is used by XCTest), this resolves the ambiguity.
    import struct GeoFeatures.Polygon
#endif

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class PolygonGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    // MARK: - Dimension

    func testDimension () {
        XCTAssertEqual(Polygon([[[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]]], precision: precision, coordinateSystem: cs).dimension, .two)
    }

    func testDimensionEmpty () {
        XCTAssertEqual(Polygon(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    // MARK: - Boundary

    func testBoundaryWithOuterRing() {
        let input = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [], precision: precision, coordinateSystem: cs).boundary()
        let expected = GeometryCollection([LinearRing([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithOuterRingAnd1InnerRing() {
        let input = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [2.0, 2.0], [2.0, 3.0], [3.5, 3.5], [5.0, 3.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs).boundary()
        let expected = GeometryCollection([LinearRing([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]]), LinearRing([[5.0, 2.0], [2.0, 2.0], [2.0, 3.0], [3.5, 3.5], [5.0, 3.0], [5.0, 2.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = Polygon(precision: precision, coordinateSystem: cs).boundary()
        let expected = GeometryCollection(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    // MARK: - Bounds

    func testBoundsEmpty() {
        let input = Polygon(precision: precision, coordinateSystem: cs)
        let expected: Bounds? = nil

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBounds() {
        let input = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 1.0, y: 1.0), max: (x: 6.0, y: 4.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    // MARK: - Equals

    func testEqualsTrue() {

        let testPolygon = Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]], precision: precision, coordinateSystem: cs)

        let polygon1 = Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [3.0, -3.0]]], precision: precision, coordinateSystem: cs)
        let polygon4 = Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [3.0, -3.0]]], precision: precision, coordinateSystem: cs)

        let multiPolygon1 = MultiPolygon([Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPolygon.equals(polygon1))
        XCTAssertTrue(testPolygon.equals(polygon2))
        XCTAssertTrue(testPolygon.equals(polygon3))
        XCTAssertTrue(testPolygon.equals(polygon4))
        XCTAssertTrue(testPolygon.equals(multiPolygon1))
        XCTAssertTrue(testPolygon.equals(multiPolygon2))
        XCTAssertTrue(testPolygon.equals(multiPolygon3))
        XCTAssertTrue(testPolygon.equals(multiPolygon4))
     }

     func testEqualsFalse() {

        let testPolygon = Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 100.1, y: 100.2)), Point(Coordinate(x: 200.0, y: 200.1))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0], [1.0, 10.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.1], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.1]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0, 1.0], [2.0, 0.0], [3.0, 3.0]]), LineString([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]])], precision: precision, coordinateSystem: cs)

        let polygon1 = Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -5.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.1, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.1, -3.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[1.0, 1.0], [2.2, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [2.0, -3.0], [3.0, -3.0]]], precision: precision, coordinateSystem: cs)
        let polygon4 = Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.2], [3.0, -2.2], [2.0, -3.0], [3.0, -3.0]]], precision: precision, coordinateSystem: cs)

        let multiPolygon1 = MultiPolygon([Polygon([[2.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.5], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.2, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.4], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        
        let geometryCollection1 = GeometryCollection([Point(Coordinate(x: 10.4, y: 20.5))] as [Geometry], precision: precision, coordinateSystem: cs)
        let geometryCollection2 = GeometryCollection([LineString([[1.0, 1.0], [2.0, 2.0]]), Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0]], innerRings: [])] as [Geometry], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPolygon.equals(point))
        XCTAssertFalse(testPolygon.equals(multiPoint))
        XCTAssertFalse(testPolygon.equals(lineString))
        XCTAssertFalse(testPolygon.equals(linearRing))
        XCTAssertFalse(testPolygon.equals(multiLineString))
        XCTAssertFalse(testPolygon.equals(polygon1))
        XCTAssertFalse(testPolygon.equals(polygon2))
        XCTAssertFalse(testPolygon.equals(polygon3))
        XCTAssertFalse(testPolygon.equals(polygon4))
        XCTAssertFalse(testPolygon.equals(multiPolygon1))
        XCTAssertFalse(testPolygon.equals(multiPolygon2))
        XCTAssertFalse(testPolygon.equals(multiPolygon3))
        XCTAssertFalse(testPolygon.equals(multiPolygon4))
        XCTAssertFalse(testPolygon.equals(geometryCollection1))
        XCTAssertFalse(testPolygon.equals(geometryCollection2))
     }

    // MARK: - Disjoint

    func testDisjointTrue() {
        let testPolygon = Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0], [10.0, -85.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.5, 1.5], [3.0, 3.0]]), LineString([[6.0, 6.0], [7.0, 7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPolygon.disjoint(point))
        XCTAssertTrue(testPolygon.disjoint(multiPoint))
        XCTAssertTrue(testPolygon.disjoint(lineString))
        XCTAssertTrue(testPolygon.disjoint(linearRing))
        XCTAssertTrue(testPolygon.disjoint(multiLineString))
        XCTAssertTrue(testPolygon.disjoint(polygon))
        XCTAssertTrue(testPolygon.disjoint(multiPolygon))
    }

    func testDisjointFalse() {
        let testPolygon = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[3.0, 3.0], [3.0, 10.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[3.0, 4.0], [3.0, 10.0], [10.0, 10.0], [10.0, 4.0], [3.0, 4.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.5, 1.5], [3.0, 3.0]]), LineString([[6.0, 6.0], [7.0, 7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPolygon.disjoint(point))
        XCTAssertFalse(testPolygon.disjoint(multiPoint))
        XCTAssertFalse(testPolygon.disjoint(lineString))
        XCTAssertFalse(testPolygon.disjoint(linearRing))
        XCTAssertFalse(testPolygon.disjoint(multiLineString))
        XCTAssertFalse(testPolygon.disjoint(polygon))
        XCTAssertFalse(testPolygon.disjoint(multiPolygon))
    }

    // MARK: - Intersects

    func testIntersectsTrue() {
        let testPolygon = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[3.0, 3.0], [3.0, 10.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[3.0, 4.0], [3.0, 10.0], [10.0, 10.0], [10.0, 4.0], [3.0, 4.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.5, 1.5], [3.0, 3.0]]), LineString([[6.0, 6.0], [7.0, 7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPolygon.intersects(point))
        XCTAssertTrue(testPolygon.intersects(multiPoint))
        XCTAssertTrue(testPolygon.intersects(lineString))
        XCTAssertTrue(testPolygon.intersects(linearRing))
        XCTAssertTrue(testPolygon.intersects(multiLineString))
        XCTAssertTrue(testPolygon.intersects(polygon))
        XCTAssertTrue(testPolygon.intersects(multiPolygon))
    }

    func testIntersectsFalse() {
        let testPolygon = Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 11.0, y: 1.0)), Point(Coordinate(x: 12.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[11.0, 1.0], [12.0, 2.0], [12.0, 4.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.5, 1.5], [3.0, 3.0]]), LineString([[6.0, 6.0], [7.0, 7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPolygon.intersects(point))
        XCTAssertFalse(testPolygon.intersects(multiPoint))
        XCTAssertFalse(testPolygon.intersects(lineString))
        XCTAssertFalse(testPolygon.intersects(linearRing))
        XCTAssertFalse(testPolygon.intersects(multiLineString))
        XCTAssertFalse(testPolygon.intersects(polygon))
        XCTAssertFalse(testPolygon.intersects(multiPolygon))
    }

    // MARK: - Touches

    func testTouchesTrue() {
        let testPolygon = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 34.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 60.0, y: 70.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, -1.0], [2.0, 0.0], [3.0, -1.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[61.0, 60.0], [62.0, 61.0], [61.0, 62.0], [60.0, 61.0], [61.0, 60.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [1.0, -1.0]]), LineString([[-1.5, 1.5], [-3.0, 3.0]]), LineString([[6.0, -6.0], [7.0, -7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[100.0, 40.0], [140.0, 80.0], [180.0, 80.0], [220.0, 40.0], [180.0, 0.0], [140.0, 0.0], [100.0, 40.0]], innerRings: [[[170.0, 70.0], [150.0, 70.0], [150.0, 50.0], [170.0, 50.0], [170.0, 70.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[20.0, -20.0], [16.0, -20.0], [16.0, -10.0], [4.0, -10.0], [4.0, -1.0], [20.0, -1.0], [20.0, -20.0]], innerRings: [[[5.0, -2.0], [5.0, -3.0], [7.0, -3.0], [7.0, -2.0], [5.0, -2.0]]]), Polygon([[100.0, 100.0], [100.0, 110.0], [110.0, 110.0], [110.0, 100.0], [100.0, 100.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPolygon.touches(point))
        XCTAssertTrue(testPolygon.touches(multiPoint))
        XCTAssertTrue(testPolygon.touches(lineString))
        XCTAssertTrue(testPolygon.touches(linearRing))
        XCTAssertTrue(testPolygon.touches(multiLineString))
        XCTAssertTrue(testPolygon.touches(polygon))
        XCTAssertTrue(testPolygon.touches(multiPolygon))
    }

    func testTouchesFalse() {
        let testPolygon = Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 24.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 110.0, y: 110.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 22.0, y: 103.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 100.0], [24.0, 140.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[0.0, 0.0], [0.0, 150.0], [100.0, 150.0], [100.0, 0.0], [0.0, 0.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0, 1.0], [2.0, 2.0], [3.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.5, 1.5], [3.0, 3.0]]), LineString([[6.0, 2.0], [6.0, 700.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[20.0, 20.0], [100.0, 20.0], [100.0, 101.0], [20.0, 101.0], [20.0, 20.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPolygon.touches(point1))
        XCTAssertFalse(testPolygon.touches(point2))
        XCTAssertFalse(testPolygon.touches(multiPoint1))
        XCTAssertFalse(testPolygon.touches(multiPoint2))
        XCTAssertFalse(testPolygon.touches(lineString1))
        XCTAssertFalse(testPolygon.touches(lineString2))
        XCTAssertFalse(testPolygon.touches(linearRing1))
        XCTAssertFalse(testPolygon.touches(linearRing2))
        XCTAssertFalse(testPolygon.touches(multiLineString1))
        XCTAssertFalse(testPolygon.touches(multiLineString2))
        XCTAssertFalse(testPolygon.touches(polygon1))
        XCTAssertFalse(testPolygon.touches(polygon2))
        XCTAssertFalse(testPolygon.touches(multiPolygon1))
        XCTAssertFalse(testPolygon.touches(multiPolygon2))
    }

    // MARK: - Crosses

    func testCrossesTrue() {
        let testPolygon = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]], precision: precision, coordinateSystem: cs)

        let multiPoint = MultiPoint([Point(Coordinate(x: 11.0, y: 1.0)), Point(Coordinate(x: 200.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[-8.0, 1.0], [4.0, 5.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[0.0, -2.0], [0.0, 8.0], [3.0, 8.0], [3.0, -2.0], [0.0, -2.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [0.5, 0.5]]), LineString([[1.0, 2.0], [3.0, 2.0]]), LineString([[5.0, 5.0], [5.0, -8.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPolygon.crosses(multiPoint))
        XCTAssertTrue(testPolygon.crosses(lineString))
        XCTAssertTrue(testPolygon.crosses(linearRing))
        XCTAssertTrue(testPolygon.crosses(multiLineString))
    }

    func testCrossesFalse() {
        let testPolygon = Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 20.0, y: 200.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.0, 1.5]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[24.0, 1.0], [100.0, 1.0], [100.0, 150.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[165.0, 165.0], [165.0, 175.0], [175.0, 175.0], [165.0, 175.0], [165.0, 165.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[40.0, 100.0], [0.0, 140.0], [100.0, 100.0], [40.0, 100.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[0.0, 3.0], [1.0, 1.0], [0.0, 0.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[100.0, 100.0], [100.0,  200.0]]), LineString([[24.0,  1.0], [24.0,  4.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[21.0, 1.0], [22.0, 1.0], [22.0, 1.5], [21.0, 1.5], [21.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[30.0, 0.5], [30.0, 10.0], [20.0, 10.0], [20.0, 0.5], [30.0, 0.5]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[21.0, 1.0], [22.0, 1.0], [22.0, 1.5], [21.0, 1.5], [21.0, 1.0]]]), Polygon([[-20.0, -50.0], [-20.0, -110.0], [-110.0, -110.0], [-110.0, -50.0], [-20.0, -50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[30.0, 0.5], [30.0, 10.0], [20.0, 10.0], [20.0, 0.5], [30.0, 0.5]]], precision: precision, coordinateSystem: cs), Polygon([[0.0, -80.0], [0.0, -50.0], [110.0, -50.0], [110.0, -80.0], [0.0, -80.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPolygon.crosses(point))
        XCTAssertFalse(testPolygon.crosses(multiPoint1))
        XCTAssertFalse(testPolygon.crosses(multiPoint2))
        XCTAssertFalse(testPolygon.crosses(lineString1))
        XCTAssertFalse(testPolygon.crosses(lineString2))
        XCTAssertFalse(testPolygon.crosses(linearRing1))
        XCTAssertFalse(testPolygon.crosses(linearRing2))
        XCTAssertFalse(testPolygon.crosses(multiLineString1))
        XCTAssertFalse(testPolygon.crosses(multiLineString2))
        XCTAssertFalse(testPolygon.crosses(polygon1))
        XCTAssertFalse(testPolygon.crosses(polygon2))
        XCTAssertFalse(testPolygon.crosses(polygon3))
        XCTAssertFalse(testPolygon.crosses(multiPolygon1))
        XCTAssertFalse(testPolygon.crosses(multiPolygon2))
        XCTAssertFalse(testPolygon.crosses(multiPolygon3))
    }

    // MARK: - Within

    func testWithinTrue() {
        let testPolygon = Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]], precision: precision, coordinateSystem: cs)

        let polygon1 = Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[75.0, 175.0], [65.0, 175.0], [65.0, 165.0], [75.0, 165.0], [75.0, 175.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[26.0, 21.0], [21.0, 21.0], [21.0, 26.0], [23.5, 26.0], [26.0, 26.0], [26.0, 21.0]], innerRings: [[[25.0, 22.0], [25.0, 23.0], [23.5, 23.5], [22.0, 23.0], [22.0, 22.0], [25.0, 22.0]]]), Polygon([[1000.0, 90.0], [0.0, 90.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 90.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[500.0, 500.0], [500.0, 50.0], [-500.0, 50.0], [-500.0, 500.0], [500.0, 500.0]], innerRings: [[[-100.0, 20.0], [-90.0, 20.0], [-90.0, 30.0], [-100.0, 30.0], [-100.0, 20.0]]]), Polygon([[1.0, 1.0], [1.0, 2.1], [2.1, 2.1], [2.1, 1.0], [1.0, 1.0]], innerRings: [[[1.6, 1.7], [1.6, 1.8], [1.5, 1.8], [1.5, 1.7], [1.6, 1.7]]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPolygon.within(polygon1))
        XCTAssertTrue(testPolygon.within(polygon2))
        XCTAssertTrue(testPolygon.within(multiPolygon1))
        XCTAssertTrue(testPolygon.within(multiPolygon2))
    }

    func testWithinFalse() {
        let testPolygon = Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 170.0, y: 170.0), precision: precision, coordinateSystem: cs)
        let point3 = Point(Coordinate(x: 160.0, y: 170.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 170.0, y: 170.0)), Point(Coordinate(x: 180.0, y: 180.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[0.0, 0.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[21.0, 1.0], [100.0, 2.0], [100.0, 200.0], [0.0, 200.0], [0.0, 180.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[165.0, 165.0], [175.0, 165.0], [175.0, 175.0], [165.0, 175.0], [165.0, 165.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [24.0, 1.0]]), LineString([[6.0,  6.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [100.0, 1.0], [100.0, 20.0], [1.0, 20.0], [1.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[-1000.0, 0.0], [-1000.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [-1000.0, 0.0]], innerRings: [[[-3.0, 3.0], [200.0, 3.0], [203.0, 203.0], [-3.0, 203.0], [-3.0, 3.0]], [[-51.0, 1.0], [-51.0, 20.0], [-100.0, 20.0], [-100.0, 1.0], [-51.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 0.0], [10.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [10.0, 0.0]], innerRings: [[[20.0, 2.0], [200.0, 2.0], [200.0, 200.0], [20.0, 200.0], [20.0, 2.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[-10.0, 10.0], [-10.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [-10.0, 10.0]], innerRings: [[[-5.0, 50.0], [-5.0, 500.0], [500.0, 500.0], [500.0, 50.0], [-5.0, 50.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPolygon.within(point1))
        XCTAssertFalse(testPolygon.within(point2))
        XCTAssertFalse(testPolygon.within(point3))
        XCTAssertFalse(testPolygon.within(multiPoint1))
        XCTAssertFalse(testPolygon.within(multiPoint2))
        XCTAssertFalse(testPolygon.within(lineString1))
        XCTAssertFalse(testPolygon.within(lineString2))
        XCTAssertFalse(testPolygon.within(linearRing1))
        XCTAssertFalse(testPolygon.within(linearRing2))
        XCTAssertFalse(testPolygon.within(multiLineString1))
        XCTAssertFalse(testPolygon.within(multiLineString2))
        XCTAssertFalse(testPolygon.within(polygon1))
        XCTAssertFalse(testPolygon.within(polygon2))
        XCTAssertFalse(testPolygon.within(polygon3))
        XCTAssertFalse(testPolygon.within(multiPolygon1))
        XCTAssertFalse(testPolygon.within(multiPolygon2))
        XCTAssertFalse(testPolygon.within(multiPolygon3))
        XCTAssertFalse(testPolygon.within(multiPolygon4))
    }

    // MARK: - Contains

    func testContainsTrue() {
        let testPolygon = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 4.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 3.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 80.0, y: 100.0)), Point(Coordinate(x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[4.0, 1.0], [4.0, 4.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[60.0, 80.0], [60.0, 10.0], [2.0, 10.0], [1.5, 1.5]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[90.0, 90.0], [90.0, 50.0], [50.0, 50.0], [50.0, 90.0], [90.0, 90.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[4.0, 3.0], [4.0, 1.0], [3.0, 1.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[4.0, 4.0], [4.0, 2.0]]), LineString([[2.0, 2.0], [2.0, 4.0]]), LineString([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[50.0, 50.0], [50.0, 20.0], [20.0, 20.0], [20.0, 50.0], [50.0, 50.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[40.0, 40.0], [40.0, 10.0], [10.0, 10.0], [10.0, 40.0], [40.0, 40.0]], innerRings: [[[20.0, 30.0], [20.0, 20.0], [30.0, 20.0], [30.0, 30.0], [20.0, 2.0], [5.0, 2.0]]]), Polygon([[58.0, 1.0], [50.0, 1.0], [50.0, 10.0], [58.0, 10.0], [58.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPolygon.contains(point))
        XCTAssertTrue(testPolygon.contains(multiPoint1))
        XCTAssertTrue(testPolygon.contains(multiPoint2))
        XCTAssertTrue(testPolygon.contains(lineString1))
        XCTAssertTrue(testPolygon.contains(lineString2))
        XCTAssertTrue(testPolygon.contains(linearRing1))
        XCTAssertTrue(testPolygon.contains(linearRing2))
        XCTAssertTrue(testPolygon.contains(multiLineString1))
        XCTAssertTrue(testPolygon.contains(multiLineString2))
        XCTAssertTrue(testPolygon.contains(polygon1))
        XCTAssertTrue(testPolygon.contains(polygon2))
        XCTAssertTrue(testPolygon.contains(multiPolygon))
    }

    func testContainsFalse() {
        let testPolygon = Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([], precision: precision, coordinateSystem: cs)
        let multiPoint3 = MultiPoint([Point(Coordinate(x: 170.0, y: 170.0)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 80.0, y: 180.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.0, 8.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[100.0, 100.0], [0.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[-2.0, -2.0], [2.0, 2.0], [6.0, -2.0], [2.0, -6.0], [-2.0, -2.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  0.0], [1.0,  6.0], [10.0,  6.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [0.0,  1.0]]), LineString([[50.0, 0.0], [40.0, 0.0]]), LineString([[162.0, 162.0], [162.0, 170.0], [170.0, 170.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString3 = MultiLineString([LineString([[0.0,  0.0], [0.0,  200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 0.0]]), LineString([[50.0, 120.0], [40.0, 120.0]]), LineString([[42.0, 162.0], [42.0, 170.0], [50.0, 170.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[78.0, 178.0], [62.0, 178.0], [62.0, 162.0], [78.0, 162.0], [78.0, 178.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [-1.0, 1.0], [-1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[100.0, 0.0], [0.0, 0.0], [0.0, 40.0], [100.0, 40.0], [100.0, 0.0]], innerRings: [[[0.5, 0.5], [20.0, 0.5], [20.0, 10.0], [0.5, 10.0], [0.5, 0.5]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPolygon.contains(point))
        XCTAssertFalse(testPolygon.contains(multiPoint1))
        XCTAssertFalse(testPolygon.contains(multiPoint2))
        XCTAssertFalse(testPolygon.contains(multiPoint3))
        XCTAssertFalse(testPolygon.contains(lineString1))
        XCTAssertFalse(testPolygon.contains(lineString2))
        XCTAssertFalse(testPolygon.contains(linearRing1))
        XCTAssertFalse(testPolygon.contains(linearRing2))
        XCTAssertFalse(testPolygon.contains(multiLineString1))
        XCTAssertFalse(testPolygon.contains(multiLineString2))
        XCTAssertFalse(testPolygon.contains(multiLineString3))
        XCTAssertFalse(testPolygon.contains(polygon1))
        XCTAssertFalse(testPolygon.contains(polygon2))
        XCTAssertFalse(testPolygon.contains(multiPolygon1))
        XCTAssertFalse(testPolygon.contains(multiPolygon2))
    }

    // MARK: - Overlaps

    func testOverlapsTrue() {
        /// Overlaps can only be true for geometries of the same dimension, and each geometry must have points exterior to the other, and the interiors must touch.
        let testPolygon = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]], precision: precision, coordinateSystem: cs)

        let polygon1 = Polygon([[-6.0, -6.0], [-6.0, 6.0], [6.0, 6.0], [6.0, -6.0], [-6.0, -6.0]], innerRings: [[[0.0, -1.0], [0.0, 0.0], [-1.0, 0.0], [-1.0, -1.0], [0.0, -1.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[40.0, 20.0], [40.0, 40.0], [20.0, 40.0], [20.0, 20.0], [40.0, 20.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [-1.0, 1.0], [-1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[100.0, 0.0], [0.0, 0.0], [0.0, 40.0], [100.0, 40.0], [100.0, 0.0]], innerRings: [[[0.5, 0.5], [20.0, 0.5], [20.0, 10.0], [0.5, 10.0], [0.5, 0.5]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPolygon.overlaps(polygon1))
        XCTAssertTrue(testPolygon.overlaps(polygon2))
        XCTAssertTrue(testPolygon.overlaps(multiPolygon1))
        XCTAssertTrue(testPolygon.overlaps(multiPolygon2))
    }

    func testOverlapsFalse() {
        let testPolygon = Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 60.0, y: 160.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 70.0, y: 170.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[0.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[2.0, 4.0], [4.0, 4.0], [4.0, 100.0], [400.0, 400.0]], precision: precision, coordinateSystem: cs)
        let lineString3 = LineString([[0.0, 100.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[-2.0, 2.0], [-2.0, 5.0], [0.0, 5.0], [0.0, 2.0], [-2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[4.0, 8.0], [4.0, 4.0], [10.0, 4.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[2.0, 500.0], [10.0, 3.0]]), LineString([[0.0, 100.0], [100.0, 200.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[26.0, 1.0], [21.0, 1.0], [21.0, 3.0], [23.5, 4.0], [26.0, 3.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 5.0], [10.0, 5.0], [10.0, 10.0], [5.0, 10.0], [5.0, 5.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[-2.0, -2.0], [-2.0, 1000.0], [1000.0, 1000.0], [1000.0, -2.0], [-2.0, -2.0]], innerRings: [[[0.0, 0.0], [100.0, 0.0], [100.0, 100.0], [0.0, 100.0], [0.0, 0.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[26.0, 1.0], [21.0, 1.0], [21.0, 3.0], [23.5, 4.0], [26.0, 3.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0]], innerRings: []), Polygon([[0.0, 50.0], [110.0, 50.0], [110.0, 100.0], [0.0, 100.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[26.0, 1.0], [21.0, 1.0], [21.0, 6.0], [23.5, 26.0], [26.0, 6.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]]), Polygon([[-2.0, -2.0], [-2.0, -200.0], [-200.0, -200.0], [-200.0, -2.0], [-2.0, -2.0]], innerRings: [[[-100.0, -10.0], [-150.0, -10.0], [-150.0, -50.0], [-100.0, -50.0], [-100.0, -10.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPolygon.overlaps(point1))
        XCTAssertFalse(testPolygon.overlaps(point2))
        XCTAssertFalse(testPolygon.overlaps(multiPoint1))
        XCTAssertFalse(testPolygon.overlaps(multiPoint2))
        XCTAssertFalse(testPolygon.overlaps(lineString1))
        XCTAssertFalse(testPolygon.overlaps(lineString2))
        XCTAssertFalse(testPolygon.overlaps(lineString3))
        XCTAssertFalse(testPolygon.overlaps(linearRing1))
        XCTAssertFalse(testPolygon.overlaps(linearRing2))
        XCTAssertFalse(testPolygon.overlaps(multiLineString1))
        XCTAssertFalse(testPolygon.overlaps(multiLineString2))
        XCTAssertFalse(testPolygon.overlaps(polygon1))
        XCTAssertFalse(testPolygon.overlaps(polygon2))
        XCTAssertFalse(testPolygon.overlaps(polygon3))
        XCTAssertFalse(testPolygon.overlaps(multiPolygon1))
        XCTAssertFalse(testPolygon.overlaps(multiPolygon2))
        XCTAssertFalse(testPolygon.overlaps(multiPolygon3))
    }

    // MARK: - Covers

    func testCoversTrue() {
        let testPolygon = Polygon([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 50.0, y: 10.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 100.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 40.0, y: 12.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[100.0, 100.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[50.0, 1.0], [50.0, 10.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [100.0, 1.0], [100.0, 100.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[80.0, 10.0], [80.0, 20.0], [90.0, 20.0], [90.0, 10.0], [80.0, 10.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[100.0, 100.0], [1.0, 1.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[100.0, 100.0], [80.0, 80.0]]), LineString([[70.0, 70.0], [70.0, 40.0], [80.0, 40.0]]), LineString([[40.0, 2.0], [90.0,  2.0], [90.0, 3.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[90.0, 2.0], [90.0, 10.0], [82.0, 2.0], [90.0, 2.0]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [6.0, 6.0], [6.0, 1.0]], innerRings: []), Polygon([[60.0, 2.0], [60.0, 22.0], [80.0, 22.0], [80.0, 2.0], [60.0, 2.0]], innerRings: [[[62.0, 14.0], [62.0, 4.0], [72.0, 4.0], [72.0, 14.0], [62.0, 14.0]]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPolygon.covers(point1))
        XCTAssertTrue(testPolygon.covers(point2))
        XCTAssertTrue(testPolygon.covers(multiPoint1))
        XCTAssertTrue(testPolygon.covers(multiPoint2))
        XCTAssertTrue(testPolygon.covers(lineString1))
        XCTAssertTrue(testPolygon.covers(lineString2))
        XCTAssertTrue(testPolygon.covers(linearRing1))
        XCTAssertTrue(testPolygon.covers(linearRing2))
        XCTAssertTrue(testPolygon.covers(multiLineString1))
        XCTAssertTrue(testPolygon.covers(multiLineString2))
        XCTAssertTrue(testPolygon.covers(polygon1))
        XCTAssertTrue(testPolygon.covers(polygon2))
        XCTAssertTrue(testPolygon.covers(multiPolygon))
    }

    func testCoversFalse() {
        let testPolygon = Polygon([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 101.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 105.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[100.0, 100.0], [100.0, 0.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[50.0, 50.0], [50.0, 0.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[101.0, 101.0], [101.0, 1.0], [1.0, 1.0], [101.0, 101.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[100.0, 100.0], [100.0, 101.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[100.0, 100.0], [90.0, 90.0]]), LineString([[100.0, 100.0], [100.0, 101.0]]), LineString([[10.0, 2.0], [99.0, 2.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[100.0, 100.0], [100.0, 101.0], [101.0, 101.0], [101.0, 100.0], [100.0, 100.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[-1000.0, -1000.0], [-1000.0, 1000.0], [1000.0, 1000.0], [1000.0, -1000.0], [-1000.0, -1000.0]], innerRings: [[[0.0, 0.0], [100.0, 0.0], [100.0, 100.0], [0.0, 100.0], [0.0, 0.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPolygon.covers(point))
        XCTAssertFalse(testPolygon.covers(multiPoint1))
        XCTAssertFalse(testPolygon.covers(multiPoint2))
        XCTAssertFalse(testPolygon.covers(lineString1))
        XCTAssertFalse(testPolygon.covers(lineString2))
        XCTAssertFalse(testPolygon.covers(linearRing))
        XCTAssertFalse(testPolygon.covers(multiLineString1))
        XCTAssertFalse(testPolygon.covers(multiLineString2))
        XCTAssertFalse(testPolygon.covers(polygon1))
        XCTAssertFalse(testPolygon.covers(polygon2))
        XCTAssertFalse(testPolygon.covers(multiPolygon))
    }

    // MARK: - CoveredBy

    func testCoveredByTrue() {
        let testPolygon = Polygon([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let polygon1 = Polygon([[100.0, 100.0], [100.0, 1.0], [1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 200.0], [200.0, 200.0], [200.0, 0.0], [0.0, 0.0]], innerRings: [[[180.0, 10.0], [190.0, 10.0], [190.0, 20.0], [180.0, 20.0], [180.0, 10.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[-10.0, 10.0], [-50.0, 10.0], [-50.0, 50.0], [-10.0, 50.0], [-10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[1000.0, 1.0], [1.0, 1.0], [1.0, 200.0], [1000.0, 200.0], [1000.0, 1.0]], innerRings: []), Polygon([[0.0, 0.0], [0.0, 0.5], [0.5, 0.5], [0.5, 0.0], [0.0, 0.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPolygon.coveredby(polygon1))
        XCTAssertTrue(testPolygon.coveredby(polygon2))
        XCTAssertTrue(testPolygon.coveredby(multiPolygon))
    }

    func testCoveredByFalse() {
        let testPolygon = Polygon([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 50.0, y: 50.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[102.0, 102.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[10.0, 10.0], [10.0, 11.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[1.0, 1.0], [1.0, -1.0]]), LineString([[100.0, 1000.0], [100.0, 100.0], [1.5, 1.5]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[1000.0, 1000.0], [1000.0, 1001.0], [1001.0, 1001.0], [1001.0, 100.0], [1000.0, 1000.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[1000.0, 100.0], [100.0, 100.0], [100.0, 200.0], [1000.0, 200.0], [1000.0, 100.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPolygon.coveredby(point))
        XCTAssertFalse(testPolygon.coveredby(multiPoint1))
        XCTAssertFalse(testPolygon.coveredby(multiPoint2))
        XCTAssertFalse(testPolygon.coveredby(lineString))
        XCTAssertFalse(testPolygon.coveredby(linearRing))
        XCTAssertFalse(testPolygon.coveredby(multiLineString1))
        XCTAssertFalse(testPolygon.coveredby(multiLineString2))
        XCTAssertFalse(testPolygon.coveredby(polygon))
        XCTAssertFalse(testPolygon.coveredby(multiPolygon))
    }

    func testValidTrue() {
        /// Empty case
        let testPolygon1 = Polygon([], precision: precision, coordinateSystem: cs)
        /// Simple polygon
        let testPolygon2 = Polygon([[1.0, 1.0], [1.0, -1.0], [-1.0, -1.0], [-1.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        /// Simple polygon with repeated coordinates
        let testPolygon3 = Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, -1.0], [-1.0, -1.0], [-1.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        /// Simple polygon with repeated coordinates
        let testPolygon4 = Polygon([[1.0, 1.0], [1.0, 1.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, -1.0], [-1.0, -1.0], [-1.0, 1.0], [1.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        /// Polygon with hole
        let testPolygon5 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[10.0, 10.0], [10.0, -10.0], [-10.0, -10.0], [-10.0, 10.0], [10.0, 10.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with hole that touches outer ring at one coordinate
        let testPolygon6 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 0.0], [-50.0, 50.0], [0.0, 100.0], [50.0, 50.0], [0.0, 0.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with hole that touches outer ring and a second hole at one coordinate
        let testPolygon7 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 0.0], [-50.0, 50.0], [0.0, 100.0], [50.0, 50.0], [0.0, 0.0]], [[0.0, 0.0], [-20.0, -20.0], [0.0, -40.0], [20.0, -20.0], [0.0, 0.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with hole that touches outer ring and two other holes, each at one coordinate
        let testPolygon8 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 0.0], [-50.0, 50.0], [0.0, 100.0], [50.0, 50.0], [0.0, 0.0]], [[0.0, 0.0], [-20.0, -20.0], [0.0, -40.0], [20.0, -20.0], [0.0, 0.0]], [[70.0, 40.0], [50.0, 40.0], [50.0, 60.0], [70.0, 60.0], [70.0, 40.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with hole that touches outer ring and two other holes, each at one coordinate.  There is also a fourth hole that touches none of the others.
        let testPolygon9 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 0.0], [-50.0, 50.0], [0.0, 100.0], [50.0, 50.0], [0.0, 0.0]], [[0.0, 0.0], [-20.0, -20.0], [0.0, -40.0], [20.0, -20.0], [0.0, 0.0]], [[70.0, 40.0], [70.0, 40.0], [70.0, 40.0], [50.0, 40.0], [50.0, 40.0], [50.0, 60.0], [70.0, 60.0], [70.0, 40.0], [70.0, 40.0], [70.0, 40.0]], [[-90.0, -90.0], [-80.0, -90.0], [-80.0, -80.0], [-90.0, -80.0], [-90.0, -90.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with hole that touches second hole at one interior coordinate
        let testPolygon10 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 0.0], [0.0, 50.0], [50.0, 50.0], [50.0, 0.0], [0.0, 0.0]], [[60.0, 40.0], [40.0, 60.0], [60.0, 80.0], [80.0, 60.0], [60.0, 40.0]]], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPolygon1.valid())
        XCTAssertTrue(testPolygon2.valid())
        XCTAssertTrue(testPolygon3.valid())
        XCTAssertTrue(testPolygon4.valid())
        XCTAssertTrue(testPolygon5.valid())
        XCTAssertTrue(testPolygon6.valid())
        XCTAssertTrue(testPolygon7.valid())
        XCTAssertTrue(testPolygon8.valid())
        XCTAssertTrue(testPolygon9.valid())
        XCTAssertTrue(testPolygon10.valid())
    }

    func testValidFalse() {
        let x1 = 0.0
        let y1 = x1 * .infinity // y1 is a NaN

        let x2 = Double.nan
        let y2 = 4.0

        /// Polygon whose two endpoints don't match
        let testPolygon1 = Polygon([[1.0, 1.0], [1.0, -1.0], [-1.0, -1.0], [-1.0, 1.0], [1.0, 1.0], [1.0, 2.0]], precision: precision, coordinateSystem: cs)
        /// Polygon with invalid coordinate
        let testPolygon2 = Polygon([[1.0, 1.0], [1.0, -1.0], [-1.0, -1.0], Coordinate(x: x1, y: y1), [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        /// Polygon with invalid coordinate
        let testPolygon3 = Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, -1.0], [-1.0, -1.0], Coordinate(x: x2, y: y2), [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        /// Polygon that crosses itself
        let testPolygon4 = Polygon([[1.0, 1.0], [1.0, 1.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, -1.0], [-1.0, -1.0], [-1.0, 0.0], [4.0, 0.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        /// Polygon whose hole is outside of the outer ring
        let testPolygon5 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[200.0, 10.0], [200.0, -10.0], [220.0, -10.0], [220.0, 10.0], [200.0, 10.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon whose one hole touches the outer ring multiple times
        let testPolygon6 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[-100.0, 0.0], [0.0, 100.0], [100.0, 0.0], [0.0, -100.0], [-100.0, 0.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with two holes that disconnect the polygon
        let testPolygon7 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 0.0], [-50.0, 50.0], [0.0, 100.0], [50.0, 50.0], [0.0, 0.0]], [[0.0, 0.0], [-50.0, -50.0], [0.0, -100.0], [50.0, -50.0], [0.0, 0.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with three holes that disconnect the polygon
        let testPolygon8 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 0.0], [-50.0, 50.0], [0.0, 100.0], [50.0, 50.0], [0.0, 0.0]], [[0.0, 0.0], [-20.0, -20.0], [0.0, -40.0], [20.0, -20.0], [0.0, 0.0]], [[0.0, -100.0], [30.0, -70.0], [0.0, -40.0], [-30.0, -70.0], [0.0, -100.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with four holes, three of which disconnect the polygon.  The fourth is independent of the others.
        let testPolygon9 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 0.0], [-50.0, 50.0], [0.0, 100.0], [50.0, 50.0], [0.0, 0.0]], [[0.0, 0.0], [-20.0, -20.0], [0.0, -40.0], [20.0, -20.0], [0.0, 0.0]], [[20.0, -40.0], [100.0, -20.0], [20.0, 0.0], [20.0, 0.0], [20.0, -40.0]], [[-90.0, -90.0], [-80.0, -90.0], [-80.0, -80.0], [-90.0, -80.0], [-90.0, -90.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with hole that touches the outer ring with dimension one
        let testPolygon10 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 10.0], [0.0, 10.0], [0.0, 10.0], [100.0, 10.0], [100.0, -10.0], [0.0, -10.0], [0.0, 10.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with four holes that touch each in a circular pattern that disconnects part of the interior from another part of the interior
        let testPolygon11 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 10.0], [0.0, 10.0], [10.0, 0.0], [20.0, 10.0], [10.0, 20.0], [0.0, 10.0]], [[0.0, -10.0], [-10.0, 0.0], [-20.0, -10.0], [-20.0, -10.0], [-10.0, -20.0], [0.0, -10.0]], [[-10.0, 0.0], [-20.0, 10.0], [-10.0, 20.0], [0.0, 10.0], [-10.0, 0.0]], [[20.0, -10.0], [10.0, -20.0], [0.0, -10.0], [10.0, 0.0], [20.0, -10.0], [20.0, -10.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with hole that falls outside the outer ring
        let testPolygon12 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[-120.0, 0.0], [0.0, 120.0], [120.0, 0.0], [0.0, -120.0], [-120.0, 0.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with hole that crosses itself
        let testPolygon13 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[-20.0, 0.0], [0.0, 20.0], [0.0, -20.0], [20.0, 0.0], [-20.0, 0.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with a one-dimensional hole
        let testPolygon14 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[-20.0, 0.0], [0.0, 0.0], [-20.0, 0.0]]], precision: precision, coordinateSystem: cs)
        /// Polygon with two holes that touch each other twice
        let testPolygon15 = Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 0.0], [0.0, 50.0], [50.0, 50.0], [50.0, 0.0], [0.0, 0.0]], [[0.0, -30.0], [0.0, 0.0], [25.0, -25.0], [50.0, 0.0], [50.0, -30.0], [0.0, -30.0]]], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPolygon1.valid())
        XCTAssertFalse(testPolygon2.valid())
        XCTAssertFalse(testPolygon3.valid())
        XCTAssertFalse(testPolygon4.valid())
        XCTAssertFalse(testPolygon5.valid())
        XCTAssertFalse(testPolygon6.valid())
        XCTAssertFalse(testPolygon7.valid())
        XCTAssertFalse(testPolygon8.valid())
        XCTAssertFalse(testPolygon9.valid())
        XCTAssertFalse(testPolygon10.valid())
        XCTAssertFalse(testPolygon11.valid())
        XCTAssertFalse(testPolygon12.valid())
        XCTAssertFalse(testPolygon13.valid())
        XCTAssertFalse(testPolygon14.valid())
        XCTAssertFalse(testPolygon15.valid())
    }
}

