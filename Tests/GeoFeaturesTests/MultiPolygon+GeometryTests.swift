///
///  MultiPolygon+GeometryTests.swift
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

// MARK: - Coordinate 2D, FloatingPrecision, Cartesian -

class MultiPolygonGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs        = Cartesian()

    func testDimension () {
        XCTAssertEqual(MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [])], precision: precision, coordinateSystem: cs).dimension, .two)
    }

    func testDimensionEmpty () {
        XCTAssertEqual(MultiPolygon(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundaryWithSinglePolygonNoInnerRings() {

        let input    = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [])], precision: precision, coordinateSystem: cs).boundary()
        let expected = GeometryCollection([LinearRing([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithSinglePolygonInnerRings() {
        let input = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]])], precision: precision, coordinateSystem: cs).boundary()
        let expected = GeometryCollection([LinearRing([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)]), LinearRing([Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithMultiplePolygons() {
        let input = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]]), Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [])], precision: precision, coordinateSystem: cs).boundary()
        let expected = GeometryCollection([LinearRing([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)]), LinearRing([Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]), LinearRing([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPolygon(precision: precision, coordinateSystem: cs).boundary()
        let expected = GeometryCollection(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testEqualsTrue() {

        let testMultiPolygon = MultiPolygon([Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)

        let multiPolygon1 = MultiPolygon([Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[-1.0, 1.0], [-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-4.0, -4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0], [3.0, -3.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon5 = MultiPolygon([Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon6 = MultiPolygon([Polygon([[-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0]], innerRings: []), Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPolygon.equals(multiPolygon1))
        XCTAssertTrue(testMultiPolygon.equals(multiPolygon2))
        XCTAssertTrue(testMultiPolygon.equals(multiPolygon3))
        XCTAssertTrue(testMultiPolygon.equals(multiPolygon4))
        XCTAssertTrue(testMultiPolygon.equals(multiPolygon5))
        XCTAssertTrue(testMultiPolygon.equals(multiPolygon6))
    }

    func testEqualsWithSameTypeFalse() {

        let testMultiPolygon = MultiPolygon([Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)

        let multiPolygon1 = MultiPolygon([Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.1], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[-1.0, 1.0], [-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-4.0, -4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.2, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.2, -3.0], [3.2, -3.0], [3.2, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -5.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.4, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon5 = MultiPolygon([Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [1.2, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon6 = MultiPolygon([Polygon([[-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0]], innerRings: []), Polygon([[1.0, 1.0], [1.0, -4.0], [4.0, -4.0], [4.0, 4.0], [2.0, 4.0], [2.0, 2.2], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [3.0, -2.0], [2.0, -2.0], [2.0, -3.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPolygon.equals(multiPolygon1))
        XCTAssertFalse(testMultiPolygon.equals(multiPolygon2))
        XCTAssertFalse(testMultiPolygon.equals(multiPolygon3))
        XCTAssertFalse(testMultiPolygon.equals(multiPolygon4))
        XCTAssertFalse(testMultiPolygon.equals(multiPolygon5))
        XCTAssertFalse(testMultiPolygon.equals(multiPolygon6))
    }

    func testEqualsWithDifferentTypesFalse() {

        let testMultiPolygon = MultiPolygon([Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 100.1, y: 100.2)), Point(Coordinate(x: 200.0, y: 200.1))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0], [1.0, 10.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.1], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.1]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0, 1.0], [2.0, 0.0], [3.0, 3.0]]), LineString([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]])], precision: precision, coordinateSystem: cs)

        let polygon1 = Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, -4.0], [1.0, -4.0], [1.0, 1.0]], innerRings: [[[3.0, -3.0], [2.0, -3.0], [2.0, -2.0], [3.0, -2.0], [3.0, -3.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[-1.0, 1.0], [-2.0, 2.0], [-2.0, 4.0], [-4.0, 4.0], [-4.0, -4.0], [-1.0, -4.0], [-1.0, 1.0]], innerRings: [])

        XCTAssertFalse(testMultiPolygon.equals(point))
        XCTAssertFalse(testMultiPolygon.equals(multiPoint))
        XCTAssertFalse(testMultiPolygon.equals(lineString))
        XCTAssertFalse(testMultiPolygon.equals(linearRing))
        XCTAssertFalse(testMultiPolygon.equals(multiLineString))
        XCTAssertFalse(testMultiPolygon.equals(polygon1))
        XCTAssertFalse(testMultiPolygon.equals(polygon2))
    }

    // MARK: - Disjoint

    func testDisjointTrue() {
        let testMultiPolygon = MultiPolygon([Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0], [10.0, -85.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.5, 1.5], [3.0, 3.0]]), LineString([[6.0, 6.0], [7.0, 7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPolygon.disjoint(point))
        XCTAssertTrue(testMultiPolygon.disjoint(multiPoint))
        XCTAssertTrue(testMultiPolygon.disjoint(lineString))
        XCTAssertTrue(testMultiPolygon.disjoint(linearRing))
        XCTAssertTrue(testMultiPolygon.disjoint(multiLineString))
        XCTAssertTrue(testMultiPolygon.disjoint(polygon))
        XCTAssertTrue(testMultiPolygon.disjoint(multiPolygon))
    }

    func testDisjointFalse() {
        let testMultiPolygon = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[3.0, 3.0], [3.0, 10.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[3.0, 4.0], [3.0, 10.0], [10.0, 10.0], [10.0, 4.0], [3.0, 4.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.5, 1.5], [3.0, 3.0]]), LineString([[6.0, 6.0], [7.0, 7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPolygon.disjoint(point))
        XCTAssertFalse(testMultiPolygon.disjoint(multiPoint))
        XCTAssertFalse(testMultiPolygon.disjoint(lineString))
        XCTAssertFalse(testMultiPolygon.disjoint(linearRing))
        XCTAssertFalse(testMultiPolygon.disjoint(multiLineString))
        XCTAssertFalse(testMultiPolygon.disjoint(polygon))
        XCTAssertFalse(testMultiPolygon.disjoint(multiPolygon))
    }

    // MARK: - Intersects

    func testIntersectsTrue() {
        let testMultiPolygon = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[3.0, 3.0], [3.0, 10.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[3.0, 4.0], [3.0, 10.0], [10.0, 10.0], [10.0, 4.0], [3.0, 4.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.5, 1.5], [3.0, 3.0]]), LineString([[6.0, 6.0], [7.0, 7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPolygon.intersects(point))
        XCTAssertTrue(testMultiPolygon.intersects(multiPoint))
        XCTAssertTrue(testMultiPolygon.intersects(lineString))
        XCTAssertTrue(testMultiPolygon.intersects(linearRing))
        XCTAssertTrue(testMultiPolygon.intersects(multiLineString))
        XCTAssertTrue(testMultiPolygon.intersects(polygon))
        XCTAssertTrue(testMultiPolygon.intersects(multiPolygon))
    }

    func testIntersectsFalse() {
        let testMultiPolygon = MultiPolygon([Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 11.0, y: 1.0)), Point(Coordinate(x: 12.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[11.0, 1.0], [12.0, 2.0], [12.0, 4.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.5, 1.5], [3.0, 3.0]]), LineString([[6.0, 6.0], [7.0, 7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPolygon.intersects(point))
        XCTAssertFalse(testMultiPolygon.intersects(multiPoint))
        XCTAssertFalse(testMultiPolygon.intersects(lineString))
        XCTAssertFalse(testMultiPolygon.intersects(linearRing))
        XCTAssertFalse(testMultiPolygon.intersects(multiLineString))
        XCTAssertFalse(testMultiPolygon.intersects(polygon))
        XCTAssertFalse(testMultiPolygon.intersects(multiPolygon))
    }

    // MARK: - Touches

    func testTouchesTrue() {
        let testMultiPolygon = MultiPolygon([Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]]), Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 34.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 60.0, y: 70.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, -1.0], [2.0, 0.0], [3.0, -1.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[61.0, 60.0], [62.0, 61.0], [61.0, 62.0], [60.0, 61.0], [61.0, 60.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [1.0, -1.0]]), LineString([[-1.5, 1.5], [-3.0, 3.0]]), LineString([[6.0, -6.0], [7.0, -7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[100.0, 40.0], [140.0, 80.0], [180.0, 80.0], [220.0, 40.0], [180.0, 0.0], [140.0, 0.0], [100.0, 40.0]], innerRings: [[[170.0, 70.0], [150.0, 70.0], [150.0, 50.0], [170.0, 50.0], [170.0, 70.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[40.0, -40.0], [0.0, -40.0], [0.0, -10.0], [20.0, -10.0], [20.0, -4.0], [40.0, -4.0], [40.0, -40.0]], innerRings: [[[30.0, -20.0], [20.0, -20.0], [20.0, -30.0], [30.0, -30.0], [30.0, -20.0]]]), Polygon([[100.0, 100.0], [100.0, 110.0], [110.0, 110.0], [110.0, 100.0], [100.0, 100.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPolygon.touches(point))
        XCTAssertTrue(testMultiPolygon.touches(multiPoint))
        XCTAssertTrue(testMultiPolygon.touches(lineString))
        XCTAssertTrue(testMultiPolygon.touches(linearRing))
        XCTAssertTrue(testMultiPolygon.touches(multiLineString))
        XCTAssertTrue(testMultiPolygon.touches(polygon))
        XCTAssertTrue(testMultiPolygon.touches(multiPolygon))
    }

    func testTouchesFalse() {
        let testMultiPolygon = MultiPolygon([Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]]), Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 24.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 110.0, y: 110.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 22.0, y: 103.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 100.0], [24.0, 140.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[0.0, 0.0], [0.0, 150.0], [100.0, 150.0], [100.0, 0.0], [0.0, 0.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0, 1.0], [2.0, 2.0], [3.0, 1.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.5, 1.5], [3.0, 3.0]]), LineString([[6.0, 2.0], [6.0, 700.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[20.0, 20.0], [100.0, 20.0], [100.0, 101.0], [20.0, 101.0], [20.0, 20.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPolygon.touches(point1))
        XCTAssertFalse(testMultiPolygon.touches(point2))
        XCTAssertFalse(testMultiPolygon.touches(multiPoint1))
        XCTAssertFalse(testMultiPolygon.touches(multiPoint2))
        XCTAssertFalse(testMultiPolygon.touches(lineString1))
        XCTAssertFalse(testMultiPolygon.touches(lineString2))
        XCTAssertFalse(testMultiPolygon.touches(linearRing1))
        XCTAssertFalse(testMultiPolygon.touches(linearRing2))
        XCTAssertFalse(testMultiPolygon.touches(multiLineString1))
        XCTAssertFalse(testMultiPolygon.touches(multiLineString2))
        XCTAssertFalse(testMultiPolygon.touches(polygon1))
        XCTAssertFalse(testMultiPolygon.touches(polygon2))
        XCTAssertFalse(testMultiPolygon.touches(multiPolygon1))
        XCTAssertFalse(testMultiPolygon.touches(multiPolygon2))
    }

    // MARK: - Crosses

    func testCrossesTrue() {
        let testMultiPolygon = MultiPolygon([Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]]), Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let multiPoint = MultiPoint([Point(Coordinate(x: 11.0, y: 1.0)), Point(Coordinate(x: 200.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[-8.0, 1.0], [4.0, 5.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[0.0, -2.0], [0.0, 8.0], [3.0, 8.0], [3.0, -2.0], [0.0, -2.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0, 0.0], [0.5, 0.5]]), LineString([[1.0, 2.0], [3.0, 2.0]]), LineString([[5.0, 5.0], [5.0, -8.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPolygon.crosses(multiPoint))
        XCTAssertTrue(testMultiPolygon.crosses(lineString))
        XCTAssertTrue(testMultiPolygon.crosses(linearRing))
        XCTAssertTrue(testMultiPolygon.crosses(multiLineString))
    }

    func testCrossesFalse() {
        let testMultiPolygon = MultiPolygon([Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]]), Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 20.0, y: 200.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.0, 1.5]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[24.0, 1.0], [100.0, 1.0], [100.0, 150.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[165.0, 165.0], [165.0, 175.0], [175.0, 175.0], [165.0, 175.0], [165.0, 165.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[40.0, 100.0], [0.0, 140.0], [100.0, 100.0], [40.0, 100.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[0.0, 3.0], [1.0, 1.0], [0.0, 0.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[100.0, 100.0], [100.0, 200.0]]), LineString([[24.0, 1.0], [24.0, 4.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[21.0, 1.0], [22.0, 1.0], [22.0, 1.5], [21.0, 1.5], [21.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[30.0, 0.5], [30.0, 10.0], [20.0, 10.0], [20.0, 0.5], [30.0, 0.5]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[21.0, 1.0], [22.0, 1.0], [22.0, 1.5], [21.0, 1.5], [21.0, 1.0]]]), Polygon([[-20.0, -50.0], [-20.0, -110.0], [-110.0, -110.0], [-110.0, -50.0], [-20.0, -50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[30.0, 0.5], [30.0, 10.0], [20.0, 10.0], [20.0, 0.5], [30.0, 0.5]]], precision: precision, coordinateSystem: cs), Polygon([[0.0, -80.0], [0.0, -50.0], [110.0, -50.0], [110.0, -80.0], [0.0, -80.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPolygon.crosses(point))
        XCTAssertFalse(testMultiPolygon.crosses(multiPoint1))
        XCTAssertFalse(testMultiPolygon.crosses(multiPoint2))
        XCTAssertFalse(testMultiPolygon.crosses(lineString1))
        XCTAssertFalse(testMultiPolygon.crosses(lineString2))
        XCTAssertFalse(testMultiPolygon.crosses(linearRing1))
        XCTAssertFalse(testMultiPolygon.crosses(linearRing2))
        XCTAssertFalse(testMultiPolygon.crosses(multiLineString1))
        XCTAssertFalse(testMultiPolygon.crosses(multiLineString2))
        XCTAssertFalse(testMultiPolygon.crosses(polygon1))
        XCTAssertFalse(testMultiPolygon.crosses(polygon2))
        XCTAssertFalse(testMultiPolygon.crosses(polygon3))
        XCTAssertFalse(testMultiPolygon.crosses(multiPolygon1))
        XCTAssertFalse(testMultiPolygon.crosses(multiPolygon2))
        XCTAssertFalse(testMultiPolygon.crosses(multiPolygon3))
    }

    // MARK: - Within

    func testWithinTrue() {
        let testMultiPolygon = MultiPolygon([Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]]), Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let polygon = Polygon([[-1000.0, -1000.0], [-1000.0, 1000.0], [1000.0, 1000.0], [1000.0, -1000.0], [-1000.0, -1000.0]], innerRings: [[[75.0, 175.0], [65.0, 175.0], [65.0, 165.0], [75.0, 165.0], [75.0, 175.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[0.0, 400.0], [400.0, 400.0], [400.0, 1000.0], [1000.0, 1000.0], [1000.0, -1000.0], [400.0, -1000.0], [400.0, -400.0], [0.0, -400.0], [0.0, 400.0]], innerRings: [[[500.0, 500.0], [400.0, 500.0], [400.0, 400.0], [500.0, 400.0], [500.0, 500.0]]]), Polygon([[-10.0, 10.0], [-50.0, 10.0], [-50.0, 50.0], [-10.0, 50.0], [-10.0, 10.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[-1000.0, -1000.0], [-1000.0, 1000.0], [1000.0, 1000.0], [1000.0, -1000.0], [-1000.0, -1000.0]], innerRings: [[[-100.0, -100.0], [-60.0, -100.0], [-60.0, -60.0], [-100.0, -60.0], [-100.0, -100.0]]]), Polygon([[2000.0, 2000.0], [2000.0, 2002.0], [2002.0, 2002.0], [2002.0, 2000.0], [2000.0, 2000.0]], innerRings: [[[2001.6, 2001.7], [2001.6, 2001.8], [2001.5, 2001.8], [2001.5, 2001.7], [2001.6, 2001.7]]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPolygon.within(polygon))
        XCTAssertTrue(testMultiPolygon.within(multiPolygon1))
        XCTAssertTrue(testMultiPolygon.within(multiPolygon2))
    }

    func testWithinFalse() {
        let testMultiPolygon = MultiPolygon([Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]]), Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 170.0, y: 170.0), precision: precision, coordinateSystem: cs)
        let point3 = Point(Coordinate(x: 160.0, y: 170.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 170.0, y: 170.0)), Point(Coordinate(x: 180.0, y: 180.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[0.0, 0.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[21.0, 1.0], [100.0, 2.0], [100.0, 200.0], [0.0, 200.0], [0.0, 180.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[65.0, 165.0], [75.0, 165.0], [75.0, 175.0], [65.0, 175.0], [65.0, 165.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [24.0, 1.0]]), LineString([[6.0,  6.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [100.0, 1.0], [100.0, 20.0], [1.0, 20.0], [1.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[-1000.0, 0.0], [-1000.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [-1000.0, 0.0]], innerRings: [[[-3.0, 3.0], [200.0, 3.0], [203.0, 203.0], [-3.0, 203.0], [-3.0, 3.0]], [[-51.0, 1.0], [-51.0, 20.0], [-100.0, 20.0], [-100.0, 1.0], [-51.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 0.0], [10.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [10.0, 0.0]], innerRings: [[[20.0, 2.0], [200.0, 2.0], [200.0, 200.0], [20.0, 200.0], [20.0, 2.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[-10.0, 10.0], [-10.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [-10.0, 10.0]], innerRings: [[[-5.0, 50.0], [-5.0, 500.0], [500.0, 500.0], [500.0, 50.0], [-5.0, 50.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)
        let multiPolygon5 = MultiPolygon([Polygon([[-10.0, 10.0], [-30.0, 10.0], [-30.0, 30.0], [-10.0, 30.0], [-10.0, 10.0]], innerRings: []), Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPolygon.within(point1))
        XCTAssertFalse(testMultiPolygon.within(point2))
        XCTAssertFalse(testMultiPolygon.within(point3))
        XCTAssertFalse(testMultiPolygon.within(multiPoint1))
        XCTAssertFalse(testMultiPolygon.within(multiPoint2))
        XCTAssertFalse(testMultiPolygon.within(lineString1))
        XCTAssertFalse(testMultiPolygon.within(lineString2))
        XCTAssertFalse(testMultiPolygon.within(linearRing1))
        XCTAssertFalse(testMultiPolygon.within(linearRing2))
        XCTAssertFalse(testMultiPolygon.within(multiLineString1))
        XCTAssertFalse(testMultiPolygon.within(multiLineString2))
        XCTAssertFalse(testMultiPolygon.within(polygon1))
        XCTAssertFalse(testMultiPolygon.within(polygon2))
        XCTAssertFalse(testMultiPolygon.within(polygon3))
        XCTAssertFalse(testMultiPolygon.within(multiPolygon1))
        XCTAssertFalse(testMultiPolygon.within(multiPolygon2))
        XCTAssertFalse(testMultiPolygon.within(multiPolygon3))
        XCTAssertFalse(testMultiPolygon.within(multiPolygon4))
        XCTAssertFalse(testMultiPolygon.within(multiPolygon5))
    }

    // MARK: - Contains

    func testContainsTrue() {
        let testMultiPolygon = MultiPolygon([Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]]), Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 4.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 3.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 80.0, y: 100.0)), Point(Coordinate(x: 9.0, y: -9.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[4.0, 1.0], [4.0, 4.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[60.0, 80.0], [60.0, 10.0], [2.0, 10.0], [1.5, 1.5]], precision: precision, coordinateSystem: cs)
        let lineString3 = LineString([[-39.0, 21.0], [-39.0, 39.0], [-21.0, 39.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[90.0, 90.0], [90.0, 50.0], [50.0, 50.0], [50.0, 90.0], [90.0, 90.0]], precision: precision, coordinateSystem: cs)
        let linearRing3 = LinearRing([[10.0, -1.0], [10.0, -8.0], [8.0, -8.0], [8.0, -1.0], [10.0, -1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[4.0,  3.0], [4.0,  1.0], [3.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[4.0, 4.0], [4.0, 2.0]]), LineString([[2.0, 2.0], [2.0, 4.0]]), LineString([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]]), LineString([[9.0, -9.0], [9.0, -7.0]]), LineString([[-21.0, 39.0], [-39.0, 39.0], [-39.0, 21.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[1.0, 1.0], [1.0, 100.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[50.0, 50.0], [50.0, 20.0], [20.0, 20.0], [20.0, 50.0], [50.0, 50.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[40.0, 40.0], [40.0, 10.0], [10.0, 10.0], [10.0, 40.0], [40.0, 40.0]], innerRings: [[[20.0, 30.0], [20.0, 20.0], [30.0, 20.0], [30.0, 30.0], [20.0, 2.0], [5.0, 2.0]]]), Polygon([[58.0, 1.0], [50.0, 1.0], [50.0, 10.0], [58.0, 10.0], [58.0, 1.0]], innerRings: []), Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPolygon.contains(point))
        XCTAssertTrue(testMultiPolygon.contains(multiPoint1))
        XCTAssertTrue(testMultiPolygon.contains(multiPoint2))
        XCTAssertTrue(testMultiPolygon.contains(lineString1))
        XCTAssertTrue(testMultiPolygon.contains(lineString2))
        XCTAssertTrue(testMultiPolygon.contains(lineString3))
        XCTAssertTrue(testMultiPolygon.contains(linearRing1))
        XCTAssertTrue(testMultiPolygon.contains(linearRing2))
        XCTAssertTrue(testMultiPolygon.contains(linearRing3))
        XCTAssertTrue(testMultiPolygon.contains(multiLineString1))
        XCTAssertTrue(testMultiPolygon.contains(multiLineString2))
        XCTAssertTrue(testMultiPolygon.contains(polygon1))
        XCTAssertTrue(testMultiPolygon.contains(polygon2))
        XCTAssertTrue(testMultiPolygon.contains(multiPolygon))
    }

    func testContainsFalse() {
        let testMultiPolygon = MultiPolygon([Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]]), Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([], precision: precision, coordinateSystem: cs)
        let multiPoint3 = MultiPoint([Point(Coordinate(x: 70.0, y: 170.0)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 80.0, y: 180.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.0, 8.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[100.0, 100.0], [0.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[-2.0, -2.0], [2.0, 2.0], [6.0, -2.0], [2.0, -6.0], [-2.0, -2.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0, 0.0], [1.0, 6.0], [10.0, 6.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0, 0.0], [0.0, 1.0]]), LineString([[50.0, 0.0], [40.0, 0.0]]), LineString([[162.0, 162.0], [162.0, 170.0], [170.0, 170.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[78.0, 178.0], [62.0, 178.0], [62.0, 162.0], [78.0, 162.0], [78.0, 178.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [-1.0, 1.0], [-1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[100.0, 0.0], [0.0, 0.0], [0.0, 40.0], [100.0, 40.0], [100.0, 0.0]], innerRings: [[[0.5, 0.5], [20.0, 0.5], [20.0, 10.0], [0.5, 10.0], [0.5, 0.5]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]]), Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [1.0, -10.0], [1.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPolygon.contains(point))
        XCTAssertFalse(testMultiPolygon.contains(multiPoint1))
        XCTAssertFalse(testMultiPolygon.contains(multiPoint2))
        XCTAssertFalse(testMultiPolygon.contains(multiPoint3))
        XCTAssertFalse(testMultiPolygon.contains(lineString1))
        XCTAssertFalse(testMultiPolygon.contains(lineString2))
        XCTAssertFalse(testMultiPolygon.contains(linearRing1))
        XCTAssertFalse(testMultiPolygon.contains(linearRing2))
        XCTAssertFalse(testMultiPolygon.contains(multiLineString1))
        XCTAssertFalse(testMultiPolygon.contains(multiLineString2))
        XCTAssertFalse(testMultiPolygon.contains(polygon1))
        XCTAssertFalse(testMultiPolygon.contains(polygon2))
        XCTAssertFalse(testMultiPolygon.contains(polygon3))
        XCTAssertFalse(testMultiPolygon.contains(multiPolygon1))
        XCTAssertFalse(testMultiPolygon.contains(multiPolygon2))
        XCTAssertFalse(testMultiPolygon.contains(multiPolygon3))
    }

    // MARK: - Overlaps

    func testOverlapsTrue() {
        /// Overlaps can only be true for geometries of the same dimension, and each geometry must have points exterior to the other, and the interiors must touch.
        let testMultiPolygon = MultiPolygon([Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]]), Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 80.0], [60.0, 80.0], [60.0, 60.0], [80.0, 60.0], [80.0, 80.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        let polygon1 = Polygon([[-6.0, -6.0], [-6.0, 6.0], [6.0, 6.0], [6.0, -6.0], [-6.0, -6.0]], innerRings: [[[0.0, -1.0], [0.0, 0.0], [-1.0, 0.0], [-1.0, -1.0], [0.0, -1.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[40.0, 20.0], [40.0, 40.0], [20.0, 40.0], [20.0, 20.0], [40.0, 20.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [-1.0, 1.0], [-1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[100.0, 0.0], [0.0, 0.0], [0.0, 40.0], [100.0, 40.0], [100.0, 0.0]], innerRings: [[[0.5, 0.5], [20.0, 0.5], [20.0, 10.0], [0.5, 10.0], [0.5, 0.5]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPolygon.overlaps(polygon1))
        XCTAssertTrue(testMultiPolygon.overlaps(polygon2))
        XCTAssertTrue(testMultiPolygon.overlaps(multiPolygon1))
        XCTAssertTrue(testMultiPolygon.overlaps(multiPolygon2))
    }

    func testOverlapsFalse() {
        let testMultiPolygon = MultiPolygon([Polygon([[-20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0], [-20.0, 40.0], [-20.0, 20.0]], innerRings: [[[-25.0, 25.0], [-25.0, 30.0], [-30.0, 30.0], [-30.0, 25.0], [-25.0, 25.0]]]), Polygon([[0.0, 100.0], [0.0, 200.0], [100.0, 200.0], [100.0, 100.0], [0.0, 100.0]], innerRings: [[[80.0, 180.0], [60.0, 180.0], [60.0, 160.0], [80.0, 160.0], [80.0, 180.0]]]), Polygon([[10.0, -1.0], [10.0, -10.0], [8.0, -10.0], [8.0, -1.0], [10.0, -1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

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
        let polygon3 = Polygon([[-20.0, -20.0], [-20.0, 0.0], [-1000.0, 0.0], [-1000.0, 1000.0], [1000.0, 1000.0], [1000.0, -20.0], [-20.0, -20.0]], innerRings: [[[0.0, 0.0], [50.0, 0.0], [50.0, 50.0], [0.0, 50.0], [0.0, 0.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[26.0, 1.0], [21.0, 1.0], [21.0, 3.0], [23.5, 4.0], [26.0, 3.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0]], innerRings: []), Polygon([[0.0, 50.0], [110.0, 50.0], [110.0, 100.0], [0.0, 100.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[26.0, 1.0], [21.0, 1.0], [21.0, 6.0], [23.5, 26.0], [26.0, 6.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]]), Polygon([[-2.0, -2.0], [-2.0, -200.0], [-200.0, -200.0], [-200.0, -2.0], [-2.0, -2.0]], innerRings: [[[-100.0, -10.0], [-150.0, -10.0], [-150.0, -50.0], [-100.0, -50.0], [-100.0, -10.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPolygon.overlaps(point1))
        XCTAssertFalse(testMultiPolygon.overlaps(point2))
        XCTAssertFalse(testMultiPolygon.overlaps(multiPoint1))
        XCTAssertFalse(testMultiPolygon.overlaps(multiPoint2))
        XCTAssertFalse(testMultiPolygon.overlaps(lineString1))
        XCTAssertFalse(testMultiPolygon.overlaps(lineString2))
        XCTAssertFalse(testMultiPolygon.overlaps(lineString3))
        XCTAssertFalse(testMultiPolygon.overlaps(linearRing1))
        XCTAssertFalse(testMultiPolygon.overlaps(linearRing2))
        XCTAssertFalse(testMultiPolygon.overlaps(multiLineString1))
        XCTAssertFalse(testMultiPolygon.overlaps(multiLineString2))
        XCTAssertFalse(testMultiPolygon.overlaps(polygon1))
        XCTAssertFalse(testMultiPolygon.overlaps(polygon2))
        XCTAssertFalse(testMultiPolygon.overlaps(polygon3))
        XCTAssertFalse(testMultiPolygon.overlaps(multiPolygon1))
        XCTAssertFalse(testMultiPolygon.overlaps(multiPolygon2))
        XCTAssertFalse(testMultiPolygon.overlaps(multiPolygon3))
    }

    func testCoversTrue() {
        let testMultiPolygon = MultiPolygon([Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]])], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 50.0, y: 50.0), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 72.0, y: -72.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 80.0, y: -40.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 30.0, y: 20.0)), Point(Coordinate(x: 50.0, y: 10.0)), Point(Coordinate(x: 42.0, y: -42.0)), Point(Coordinate(x: 60.0, y: -72.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[20.0, 40.0], [40.0, 20.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[60.0, -70.0], [62.0, -70.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[20.0, 20.0], [20.0, 30.0], [30.0, 30.0], [30.0, 20.0], [20.0, 20.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[10.0, 10.0], [50.0, 50.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[10.0, 50.0], [50.0, 10.0]]), LineString([[40.0, 40.0], [44.0, 44.0], [48.0, 40.0]]), LineString([[42.0, -42.0], [42.0, -72.0], [60.0, -72.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: [[[20.0, 20.0], [30.0, 20.0], [30.0, 30.0], [20.0, 30.0], [20.0, 20.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[40.0, -40.0], [40.0, -50.0], [50.0, -50.0], [50.0, -40.0], [40.0, -40.0]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: [[[20.0, 20.0], [22.0, 20.0], [22.0, 22.0], [20.0, 22.0], [20.0, 20.0]]]), Polygon([[40.0, -40.0], [50.0, -40.0], [50.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPolygon.covers(point1))
        XCTAssertTrue(testMultiPolygon.covers(point2))
        XCTAssertTrue(testMultiPolygon.covers(multiPoint1))
        XCTAssertTrue(testMultiPolygon.covers(multiPoint2))
        XCTAssertTrue(testMultiPolygon.covers(lineString1))
        XCTAssertTrue(testMultiPolygon.covers(lineString2))
        XCTAssertTrue(testMultiPolygon.covers(linearRing1))
        XCTAssertTrue(testMultiPolygon.covers(linearRing2))
        XCTAssertTrue(testMultiPolygon.covers(multiLineString1))
        XCTAssertTrue(testMultiPolygon.covers(multiLineString2))
        XCTAssertTrue(testMultiPolygon.covers(polygon1))
        XCTAssertTrue(testMultiPolygon.covers(polygon2))
        XCTAssertTrue(testMultiPolygon.covers(multiPolygon1))
        XCTAssertTrue(testMultiPolygon.covers(multiPolygon2))
    }

    func testCoversFalse() {
        let testMultiPolygon = MultiPolygon([Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]])], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 100.0, y: 101.0), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 60.0, y: -60.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 50.0, y: 50.0)), Point(Coordinate(x: 51.0, y: 51.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[10.0, 50.0], [10.0, 0.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[10.0, 50.0], [50.0, 50.0], [50.0, 0.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[70.0, -70.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[79.0, -79.0], [81.0, -81.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[70.0, -70.0], [50.0, -70.0]]), LineString([[10.0, 10.0], [10.0, 30.0], [30.0, 30.0], [30.0, 10.0]]), LineString([[80.0, -40.0], [80.0, -81.0], [40.0, -80.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[10.0, 10.0], [10.0, 50.0], [51.0, 51.0], [50.0, 10.0], [10.0, 10.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[-1000.0, -1000.0], [-1000.0, 1000.0], [1000.0, 1000.0], [1000.0, -1000.0], [-1000.0, -1000.0]], innerRings: [[[0.0, 0.0], [100.0, 0.0], [100.0, 100.0], [0.0, 100.0], [0.0, 0.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPolygon.covers(point1))
        XCTAssertFalse(testMultiPolygon.covers(point2))
        XCTAssertFalse(testMultiPolygon.covers(multiPoint1))
        XCTAssertFalse(testMultiPolygon.covers(multiPoint2))
        XCTAssertFalse(testMultiPolygon.covers(lineString1))
        XCTAssertFalse(testMultiPolygon.covers(lineString2))
        XCTAssertFalse(testMultiPolygon.covers(linearRing))
        XCTAssertFalse(testMultiPolygon.covers(multiLineString1))
        XCTAssertFalse(testMultiPolygon.covers(multiLineString2))
        XCTAssertFalse(testMultiPolygon.covers(polygon1))
        XCTAssertFalse(testMultiPolygon.covers(polygon2))
        XCTAssertFalse(testMultiPolygon.covers(multiPolygon))
    }

    func testCoveredByTrue() {
        let testMultiPolygon = MultiPolygon([Polygon([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]])], precision: precision, coordinateSystem: cs)

        let polygon1 = Polygon([[100.0, 100.0], [100.0, -100.0], [0.0, -100.0], [-100.0, 0.0], [0.0, 100.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 200.0], [200.0, 200.0], [200.0, -200.0], [0.0, -200.0], [0.0, 0.0]], innerRings: [[[180.0, 10.0], [190.0, 10.0], [190.0, 20.0], [180.0, 20.0], [180.0, 10.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[-10.0, 10.0], [-50.0, 10.0], [-50.0, 50.0], [-10.0, 50.0], [-10.0, 10.0]], innerRings: []), Polygon([[5.0, -5.0], [100.0, -5.0], [100.0, -100.0], [5.0, -100.0], [5.0, -5.0]], innerRings: [[[64.0, -64.0], [64.0, -60.0], [60.0, -60.0], [60.0, -64.0], [64.0, -64.0]]]), Polygon([[1000.0, 1.0], [1.0, 1.0], [1.0, 200.0], [1000.0, 200.0], [1000.0, 1.0]], innerRings: []), Polygon([[0.0, 0.0], [0.0, 0.5], [0.5, 0.5], [0.5, 0.0], [0.0, 0.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPolygon.coveredby(polygon1))
        XCTAssertTrue(testMultiPolygon.coveredby(polygon2))
        XCTAssertTrue(testMultiPolygon.coveredby(multiPolygon1))
        XCTAssertTrue(testMultiPolygon.coveredby(multiPolygon2))
    }

    func testCoveredByFalse() {
        let testMultiPolygon = MultiPolygon([Polygon([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 50.0, y: 50.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 10.0)), Point(Coordinate(x: 70.0, y: -70.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [69.0, -70.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[10.0, 10.0], [10.0, 11.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[1.0, 1.0], [1.0, -1.0]]), LineString([[100.0, 1000.0], [100.0, 100.0], [1.5, 1.5]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[1000.0, 100.0], [100.0, 100.0], [100.0, 200.0], [1000.0, 200.0], [1000.0, 100.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPolygon.coveredby(point))
        XCTAssertFalse(testMultiPolygon.coveredby(multiPoint1))
        XCTAssertFalse(testMultiPolygon.coveredby(multiPoint2))
        XCTAssertFalse(testMultiPolygon.coveredby(lineString))
        XCTAssertFalse(testMultiPolygon.coveredby(linearRing))
        XCTAssertFalse(testMultiPolygon.coveredby(multiLineString1))
        XCTAssertFalse(testMultiPolygon.coveredby(multiLineString2))
        XCTAssertFalse(testMultiPolygon.coveredby(polygon))
        XCTAssertFalse(testMultiPolygon.coveredby(multiPolygon))
    }

    func testValidTrue() {
        /// Empty case
        let testMultiPolygon1 = MultiPolygon([], precision: precision, coordinateSystem: cs)
        /// Single polygon
        let testMultiPolygon2 = MultiPolygon([Polygon([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        /// Two polygons, one with a hole
        let testMultiPolygon3 = MultiPolygon([Polygon([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]])], precision: precision, coordinateSystem: cs)
        /// Four polygons, two with holes.  Some repeated coordinates.
        let testMultiPolygon4 = MultiPolygon([Polygon([[1.0, 1.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[-1.0, -1.0], [-1.0, -1.0], [-1.0, -1.0], [-100.0, -1.0], [-100.0, -100.0], [-1.0, -100.0], [-1.0, -1.0]], innerRings: []), Polygon([[100.0, -100.0], [200.0, -100.0], [300.0, -200.0], [200.0, -300.0], [100.0, -300.0], [100.0, -100.0]], innerRings: [[[120.0, -120.0], [110.0, -120.0], [110.0, -110.0], [120.0, -110.0], [120.0, -120.0], [120.0, -120.0], [120.0, -120.0]]])], precision: precision, coordinateSystem: cs)
        /// Polygon with hole inside hole of another polygon.
        let testMultiPolygon5 = MultiPolygon([Polygon([[1.0, 1.0], [1.0, 100.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], innerRings: [[[10.0, 10.0], [10.0, 20.0], [20.0, 20.0], [20.0, 10.0], [10.0, 10.0]]]), Polygon([[-1000.0, -1000.0], [1000.0, -1000.0], [1000.0, 1000.0], [-1000.0, 1000.0], [-1000.0, -1000.0]], innerRings: [[[0.0, 0.0], [0.0, 200.0], [200.0, 200.0], [200.0, 0.0], [0.0, 0.0]]])], precision: precision, coordinateSystem: cs)
        /// Polygon with hole inside hole of another polygon.  Inner polygon touches the boundary of the hole it is inside of multiple times.
        let testMultiPolygon6 = MultiPolygon([Polygon([[1.0, 1.0], [0.0, 50.0], [1.0, 100.0], [50.0, 200.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], innerRings: [[[10.0, 10.0], [10.0, 20.0], [20.0, 20.0], [20.0, 10.0], [10.0, 10.0]]]), Polygon([[-1000.0, -1000.0], [1000.0, -1000.0], [1000.0, 1000.0], [-1000.0, 1000.0], [-1000.0, -1000.0]], innerRings: [[[0.0, 0.0], [0.0, 200.0], [200.0, 200.0], [100.0, 100.0], [200.0, 100.0], [200.0, 0.0], [60.0, 0.0], [50.0, 1.0], [40.0, 0.0], [0.0, 0.0]]])], precision: precision, coordinateSystem: cs)
        /// Five polygons whose outer rings touch each other at a variety of coordinates.
        let testMultiPolygon7 = MultiPolygon([Polygon([[0.0, 10.0], [10.0, 20.0], [20.0, 10.0], [10.0, 0.0], [0.0, 10.0]], innerRings: []), Polygon([[0.0, -10.0], [10.0, -20.0], [20.0, -10.0], [10.0, 0.0], [0.0, -10.0]], innerRings: []), Polygon([[-10.0, 0.0], [-20.0, -10.0], [-10.0, -20.0], [0.0, -10.0], [-10.0, 0.0]], innerRings: []), Polygon([[-10.0, 20.0], [0.0, 10.0], [-10.0, 0.0], [-20.0, 10.0], [-10.0, 20.0]], innerRings: []), Polygon([[-40.0, 40.0], [40.0, 40.0], [40.0, -40.0], [20.0, -40.0], [20.0, 20.0], [-40.0, 20.0], [-40.0, 40.0]], innerRings: [[[-30.0, 25.0], [-30.0, 30.0], [-25.0, 30.0], [-25.0, 25.0], [-30.0, 25.0]], [[30.0, 5.0], [30.0, 0.0], [25.0, 0.0], [25.0, 5.0], [30.0, 5.0]]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPolygon1.valid())
        XCTAssertTrue(testMultiPolygon2.valid())
        XCTAssertTrue(testMultiPolygon3.valid())
        XCTAssertTrue(testMultiPolygon4.valid())
        XCTAssertTrue(testMultiPolygon5.valid())
        XCTAssertTrue(testMultiPolygon6.valid())
        XCTAssertTrue(testMultiPolygon7.valid())
    }

    func testValidFalse() {
        let x1 = 0.0
        let y1 = x1 * .infinity // y1 is a NaN

        let x2 = Double.nan
        let y2 = 4.0

        /// One polygon, start and end coordinates don't match.
        let testMultiPolygon1 = MultiPolygon([Polygon([[1.0, 1.0], [1.0, -1.0], [-1.0, -1.0], [-1.0, 1.0], [1.0, 1.0], [1.0, 2.0]])], precision: precision, coordinateSystem: cs)
        /// Single polygon bad coordinate
        let testMultiPolygon2 = MultiPolygon([Polygon([[1.0, 1.0], [1.0, -1.0], [-1.0, -1.0], Coordinate(x: x1, y: y1), [1.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        /// Single polygon with repeated coordinates and another bad coordinate
        let testMultiPolygon3 = MultiPolygon([Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, -1.0], [-1.0, -1.0], Coordinate(x: x2, y: y2), [1.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        /// Two polygons, one with a hole.  First polygon crosses itself and has repeated coordinates.
        let testMultiPolygon4 = MultiPolygon([Polygon([[1.0, 1.0], [1.0, 1.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, -1.0], [-1.0, -1.0], [-1.0, 0.0], [4.0, 0.0], [1.0, 1.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]])], precision: precision, coordinateSystem: cs)
        /// Three polygons, the last one has holes outside of the polygon.
        let testMultiPolygon5 = MultiPolygon([Polygon([[1.0, 1.0], [1.0, 1.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, -1.0], [-1.0, -1.0], [-1.0, 1.0], [1.0, 1.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[100.0, 300.0], [100.0, 100.0], [-100.0, 100.0], [-100.0, 300.0], [100.0, 300.0]], innerRings: [[[200.0, 210.0], [200.0, 190.0], [220.0, 190.0], [220.0, 210.0], [200.0, 210.0]]])], precision: precision, coordinateSystem: cs)
        /// One polygon, inner ring touches outer ring at more than one place.
        let testMultiPolygon6 = MultiPolygon([Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[-100.0, 0.0], [0.0, 100.0], [100.0, 0.0], [0.0, -100.0], [-100.0, 0.0]]])], precision: precision, coordinateSystem: cs)
        /// Two polygons, both with holes.  First polygon's holes disconnect the polygon.
        let testMultiPolygon7 = MultiPolygon([Polygon([[100.0, 200.0], [100.0, 0.0], [-100.0, -0.0], [-100.0, 200.0], [100.0, 200.0]], innerRings: [[[0.0, 100.0], [-50.0, 150.0], [0.0, 200.0], [50.0, 150.0], [0.0, 100.0]], [[0.0, 100.0], [-50.0, 50.0], [0.0, 0.0], [50.0, 50.0], [0.0, 100.0]]]), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]])], precision: precision, coordinateSystem: cs)
        /// Two polygons, both with holes.  Second polygon's holes disconnect the polygon.
        let testMultiPolygon8 = MultiPolygon([Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[100.0, 200.0], [100.0, 0.0], [-100.0, 0.0], [-100.0, 200.0], [100.0, 200.0]], innerRings: [[[0.0, 100.0], [-50.0, 150.0], [0.0, 200.0], [50.0, 150.0], [0.0, 100.0]], [[0.0, 100.0], [-20.0, 80.0], [0.0, 60.0], [20.0, 80.0], [0.0, 100.0]], [[0.0, 0.0], [30.0, 30.0], [0.0, 60.0], [-30.0, 30.0], [0.0, 0.0]]])], precision: precision, coordinateSystem: cs)
        /// One polygon with holes.  Polygon's holes disconnect the polygon.
        let testMultiPolygon9 = MultiPolygon([Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 0.0], [-50.0, 50.0], [0.0, 100.0], [50.0, 50.0], [0.0, 0.0]], [[0.0, 0.0], [-20.0, -20.0], [0.0, -40.0], [20.0, -20.0], [0.0, 0.0]], [[20.0, -40.0], [100.0, -20.0], [20.0, 0.0], [20.0, 0.0], [20.0, -40.0]], [[-90.0, -90.0], [-80.0, -90.0], [-80.0, -80.0], [-90.0, -80.0], [-90.0, -90.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)
        /// Two polygons.  First polygon has hole that touches its outer ring with dimension one.
        let testMultiPolygon10 = MultiPolygon([Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[0.0, 10.0], [0.0, 10.0], [0.0, 10.0], [100.0, 10.0], [100.0, -10.0], [0.0, -10.0], [0.0, 10.0]]]), Polygon([[200.0, 200.0], [300.0, 200.0], [300.0, 300.0], [300.0, 300.0], [200.0, 300.0], [200.0, 200.0], [200.0, 200.0]])], precision: precision, coordinateSystem: cs)
        /// Two polygons.  First polygon has hole that crosses itself.  Second polygon has one-dimensional hole.
        let testMultiPolygon11 = MultiPolygon([Polygon([[100.0, 100.0], [100.0, -100.0], [-100.0, -100.0], [-100.0, 100.0], [100.0, 100.0]], innerRings: [[[-20.0, 0.0], [0.0, 20.0], [0.0, -20.0], [20.0, 0.0], [-20.0, 0.0]]], precision: precision, coordinateSystem: cs), Polygon([[200.0, 200.0], [300.0, 200.0], [300.0, 300.0], [300.0, 300.0], [200.0, 300.0], [200.0, 200.0], [200.0, 200.0]], innerRings: [[[220.0, 220.0], [250.0, 250.0], [220.0, 220.0], [220.0, 220.0]]])], precision: precision, coordinateSystem: cs)
        /// Two polygons that touch at a one-dimensional edge along their outer rings.
        let testMultiPolygon12 = MultiPolygon([Polygon([[0.0, 100.0], [100.0, 0.0], [-100.0, 0.0], [0.0, 100.0]], innerRings: [], precision: precision, coordinateSystem: cs), Polygon([[200.0, 0.0], [100.0, -200.0], [0.0, 0.0], [200.0, 0.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        /// Two polygons that touch at a one-dimensional edge inside a hole of one and the outer ring of the other.
        let testMultiPolygon13 = MultiPolygon([Polygon([[0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0], [0.0, 100.0]], innerRings: [[[80.0, 80.0], [80.0, 20.0], [20.0, 20.0], [20.0, 80.0], [80.0, 80.0]]], precision: precision, coordinateSystem: cs), Polygon([[60.0, 80.0], [70.0, 80.0], [70.0, 70.0], [60.0, 70.0], [60.0, 80.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        /// Two polygons that touch at a two-dimensional region
        let testMultiPolygon14 = MultiPolygon([Polygon([[0.0, 100.0], [100.0, 0.0], [-100.0, 0.0], [0.0, 100.0]], innerRings: [], precision: precision, coordinateSystem: cs), Polygon([[0.0, 0.0], [100.0, 100.0], [-100.0, 100.0], [0.0, 0.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPolygon1.valid())
        XCTAssertFalse(testMultiPolygon2.valid())
        XCTAssertFalse(testMultiPolygon3.valid())
        XCTAssertFalse(testMultiPolygon4.valid())
        XCTAssertFalse(testMultiPolygon5.valid())
        XCTAssertFalse(testMultiPolygon6.valid())
        XCTAssertFalse(testMultiPolygon7.valid())
        XCTAssertFalse(testMultiPolygon8.valid())
        XCTAssertFalse(testMultiPolygon9.valid())
        XCTAssertFalse(testMultiPolygon10.valid())
        XCTAssertFalse(testMultiPolygon11.valid())
        XCTAssertFalse(testMultiPolygon12.valid())
        XCTAssertFalse(testMultiPolygon13.valid())
        XCTAssertFalse(testMultiPolygon14.valid())
    }
}
