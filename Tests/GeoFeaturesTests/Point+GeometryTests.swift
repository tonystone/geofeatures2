///
///  Point+GeometryTests.swift
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

private let geometryDimension = Dimension.zero   // Point always have a 0 dimension

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class PointGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testDimension() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    // MARK: - Bounds

    func testBounds() {
        let input = Point(Coordinate(x: 2.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 2.0, y: 3.0), max: (x: 2.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    func testIsEmpty() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs).isEmpty(), false)
    }

    func testEqualsTrue() {
        let testPoint = Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.001, y: 1.001)), Point(Coordinate(x: 1.001, y: 1.001))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.equals(point))
        XCTAssertTrue(testPoint.equals(multiPoint))
    }

    func testEqualsFalse() {
        let testPoint = Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 2.0, y: 2.0), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 3.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.equals(point))
        XCTAssertFalse(testPoint.equals(multiPoint))
        XCTAssertFalse(testPoint.equals(lineString))
        XCTAssertFalse(testPoint.equals(linearRing))
        XCTAssertFalse(testPoint.equals(multiLineString))
        XCTAssertFalse(testPoint.equals(polygon))
        XCTAssertFalse(testPoint.equals(multiPolygon))
    }

    func testBoundary() {
        let geometry = Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testDisjointTrue() {
        let testPoint = Point(Coordinate(x: 100.1, y: 100.2), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.disjoint(point))
        XCTAssertTrue(testPoint.disjoint(multiPoint))
        XCTAssertTrue(testPoint.disjoint(lineString))
        XCTAssertTrue(testPoint.disjoint(linearRing))
        XCTAssertTrue(testPoint.disjoint(multiLineString))
        XCTAssertTrue(testPoint.disjoint(polygon))
        XCTAssertTrue(testPoint.disjoint(multiPolygon))
    }

    func testDisjointFalse() {
        let testPoint = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.disjoint(point))
        XCTAssertFalse(testPoint.disjoint(multiPoint))
        XCTAssertFalse(testPoint.disjoint(lineString))
        XCTAssertFalse(testPoint.disjoint(linearRing))
        XCTAssertFalse(testPoint.disjoint(multiLineString))
        XCTAssertFalse(testPoint.disjoint(polygon))
        XCTAssertFalse(testPoint.disjoint(multiPolygon))
    }

    func testIntersectsTrue() {
        let testPoint = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.intersects(point))
        XCTAssertTrue(testPoint.intersects(multiPoint))
        XCTAssertTrue(testPoint.intersects(lineString))
        XCTAssertTrue(testPoint.intersects(linearRing))
        XCTAssertTrue(testPoint.intersects(multiLineString))
        XCTAssertTrue(testPoint.intersects(polygon))
        XCTAssertTrue(testPoint.intersects(multiPolygon))
    }

    func testIntersectsFalse() {
        let testPoint = Point(Coordinate(x: 100.1, y: 100.2), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.intersects(point))
        XCTAssertFalse(testPoint.intersects(multiPoint))
        XCTAssertFalse(testPoint.intersects(lineString))
        XCTAssertFalse(testPoint.intersects(linearRing))
        XCTAssertFalse(testPoint.intersects(multiLineString))
        XCTAssertFalse(testPoint.intersects(polygon))
        XCTAssertFalse(testPoint.intersects(multiPolygon))
    }

    func testTouchesTrue() {
        let testPoint = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)

        let lineString = LineString([[1.0, 1.0], [1.5, 1.5]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.touches(lineString))
        XCTAssertTrue(testPoint.touches(multiLineString))
        XCTAssertTrue(testPoint.touches(polygon))
        XCTAssertTrue(testPoint.touches(multiPolygon))
    }

    func testTouchesFalse() {
        let testPoint = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [200.0, 200.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[1.0, 1.0], [2.0, 2.0], [300.0, 300.0], [300.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 110.0], [110.0, 110.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.touches(point1))
        XCTAssertFalse(testPoint.touches(point2))
        XCTAssertFalse(testPoint.touches(multiPoint1))
        XCTAssertFalse(testPoint.touches(multiPoint2))
        XCTAssertFalse(testPoint.touches(lineString1))
        XCTAssertFalse(testPoint.touches(lineString2))
        XCTAssertFalse(testPoint.touches(linearRing1))
        XCTAssertFalse(testPoint.touches(linearRing2))
        XCTAssertFalse(testPoint.touches(multiLineString1))
        XCTAssertFalse(testPoint.touches(multiLineString2))
        XCTAssertFalse(testPoint.touches(polygon1))
        XCTAssertFalse(testPoint.touches(polygon2))
        XCTAssertFalse(testPoint.touches(multiPolygon1))
        XCTAssertFalse(testPoint.touches(multiPolygon2))
    }

    func testCrossesTrue() {
        /// There are no cases where a point can cross another geometry.
        /// Therefore, this test exists as a placeholder to indicate that this case was not overlooked.
    }

    func testCrossesFalse() {
        let testPoint = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [6.0,  700.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 110.0], [110.0, 110.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.crosses(point1))
        XCTAssertFalse(testPoint.crosses(point2))
        XCTAssertFalse(testPoint.crosses(multiPoint1))
        XCTAssertFalse(testPoint.crosses(multiPoint2))
        XCTAssertFalse(testPoint.crosses(lineString))
        XCTAssertFalse(testPoint.crosses(linearRing))
        XCTAssertFalse(testPoint.crosses(multiLineString))
        XCTAssertFalse(testPoint.crosses(polygon1))
        XCTAssertFalse(testPoint.crosses(polygon2))
        XCTAssertFalse(testPoint.crosses(multiPolygon1))
        XCTAssertFalse(testPoint.crosses(multiPolygon2))
    }

    func testWithinTrue() {
        let testPoint = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.within(point))
        XCTAssertTrue(testPoint.within(multiPoint))
        XCTAssertTrue(testPoint.within(lineString))
        XCTAssertTrue(testPoint.within(linearRing))
        XCTAssertTrue(testPoint.within(multiLineString))
        XCTAssertTrue(testPoint.within(polygon))
        XCTAssertTrue(testPoint.within(multiPolygon))
    }

    func testWithinFalse() {
        let testPoint = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 5.0], [100.0, 5.0], [100.0, 100.0], [5.0, 100.0], [5.0, 5.0]]], precision: precision, coordinateSystem: cs)
        let polygon4 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 5.0], [200.0, 5.0], [200.0, 200.0], [5.0, 200.0], [5.0, 5.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [100.0, 25.0], [100.0, 100.0], [5.0, 100.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [200.0, 25.0], [200.0, 200.0], [5.0, 200.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.within(point))
        XCTAssertFalse(testPoint.within(multiPoint))
        XCTAssertFalse(testPoint.within(lineString1))
        XCTAssertFalse(testPoint.within(lineString2))
        XCTAssertFalse(testPoint.within(linearRing))
        XCTAssertFalse(testPoint.within(multiLineString1))
        XCTAssertFalse(testPoint.within(multiLineString2))
        XCTAssertFalse(testPoint.within(polygon1))
        XCTAssertFalse(testPoint.within(polygon2))
        XCTAssertFalse(testPoint.within(polygon3))
        XCTAssertFalse(testPoint.within(polygon4))
        XCTAssertFalse(testPoint.within(multiPolygon1))
        XCTAssertFalse(testPoint.within(multiPolygon2))
        XCTAssertFalse(testPoint.within(multiPolygon3))
        XCTAssertFalse(testPoint.within(multiPolygon4))
    }

    func testContainsTrue() {
        /// A point can only contain another point or a multipoint with only one point
        let testPoint = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.contains(point))
        XCTAssertTrue(testPoint.contains(multiPoint))
    }

    func testContainsFalse() {
        let testPoint = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.within(point))
        XCTAssertFalse(testPoint.within(multiPoint1))
        XCTAssertFalse(testPoint.within(multiPoint2))
        XCTAssertFalse(testPoint.within(lineString1))
        XCTAssertFalse(testPoint.within(lineString2))
        XCTAssertFalse(testPoint.within(linearRing))
        XCTAssertFalse(testPoint.within(multiLineString1))
        XCTAssertFalse(testPoint.within(multiLineString2))
        XCTAssertFalse(testPoint.within(polygon1))
        XCTAssertFalse(testPoint.within(polygon2))
        XCTAssertFalse(testPoint.within(multiPolygon1))
        XCTAssertFalse(testPoint.within(multiPolygon2))
    }

    func testOverlapsTrue() {
        /// Overlaps can only be true for geometries of the same dimension, and each geometry must have points exterior to the other.
        /// Therefore, a single point can never overlap another point or another multipoint.
        /// This means there are no true cases for a point, and this test is here as a reminder of that.
    }

    func testOverlapsFalse() {
        let testPoint = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[1.0, 1.0], [1.0, 100.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 5.0], [100.0, 5.0], [100.0, 100.0], [5.0, 100.0], [5.0, 5.0]]], precision: precision, coordinateSystem: cs)
        let polygon4 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 5.0], [200.0, 5.0], [200.0, 200.0], [5.0, 200.0], [5.0, 5.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [110.0, 50.0], [110.0, 100.0], [0.0, 100.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [100.0, 25.0], [100.0, 100.0], [5.0, 100.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [200.0, 25.0], [200.0, 200.0], [5.0, 200.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.overlaps(point1))
        XCTAssertFalse(testPoint.overlaps(point2))
        XCTAssertFalse(testPoint.overlaps(multiPoint1))
        XCTAssertFalse(testPoint.overlaps(multiPoint2))
        XCTAssertFalse(testPoint.overlaps(lineString1))
        XCTAssertFalse(testPoint.overlaps(lineString2))
        XCTAssertFalse(testPoint.overlaps(linearRing1))
        XCTAssertFalse(testPoint.overlaps(linearRing2))
        XCTAssertFalse(testPoint.overlaps(multiLineString1))
        XCTAssertFalse(testPoint.overlaps(multiLineString2))
        XCTAssertFalse(testPoint.overlaps(polygon1))
        XCTAssertFalse(testPoint.overlaps(polygon2))
        XCTAssertFalse(testPoint.overlaps(polygon3))
        XCTAssertFalse(testPoint.overlaps(polygon4))
        XCTAssertFalse(testPoint.overlaps(multiPolygon1))
        XCTAssertFalse(testPoint.overlaps(multiPolygon2))
        XCTAssertFalse(testPoint.overlaps(multiPolygon3))
        XCTAssertFalse(testPoint.overlaps(multiPolygon4))
    }

    func testCoversTrue() {
        let testPoint = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.covers(point))
        XCTAssertTrue(testPoint.covers(multiPoint1))
        XCTAssertTrue(testPoint.covers(multiPoint2))
    }

    func testCoversFalse() {
        let testPoint = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 101.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 105.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[100.0, 100.0], [100.0, 101.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[100.0, 100.0], [100.0, 101.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[100.0,  100.0], [100.0,  101.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[100.0,  100.0], [100.0,  100.0]]), LineString([[100.0,  100.0], [100.0,  101.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[100.0, 100.0], [100.0, 101.0], [101.0, 101.0], [101.0, 100.0], [100.0, 100.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.covers(point))
        XCTAssertFalse(testPoint.covers(multiPoint1))
        XCTAssertFalse(testPoint.covers(multiPoint2))
        XCTAssertFalse(testPoint.covers(lineString))
        XCTAssertFalse(testPoint.covers(linearRing))
        XCTAssertFalse(testPoint.covers(multiLineString1))
        XCTAssertFalse(testPoint.covers(multiLineString2))
        XCTAssertFalse(testPoint.covers(polygon))
        XCTAssertFalse(testPoint.covers(multiPolygon))
    }

    func testCoveredByTrue() {
        let testPoint = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[0.0, 0.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[200.0, 200.0], [200.0, 100.0], [0.0, 100.0], [0.0, 200.0], [200.0, 200.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[0.0, 200.0], [200.0, 0.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[1000.0, 100.0], [1000.0, 200.0]]), LineString([[0.0, 0.0], [100.0, 0.0], [100.0, 500.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[0.0, 0.0], [0.0, 200.0], [200.0, 200.0], [200.0, 0.0], [0.0, 0.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[1000.0, 100.0], [100.0, 100.0], [100.0, 200.0], [1000.0, 200.0], [1000.0, 100.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.coveredby(point))
        XCTAssertTrue(testPoint.coveredby(multiPoint1))
        XCTAssertTrue(testPoint.coveredby(multiPoint2))
        XCTAssertTrue(testPoint.coveredby(lineString))
        XCTAssertTrue(testPoint.coveredby(linearRing))
        XCTAssertTrue(testPoint.coveredby(multiLineString1))
        XCTAssertTrue(testPoint.coveredby(multiLineString2))
        XCTAssertTrue(testPoint.coveredby(polygon))
        XCTAssertTrue(testPoint.coveredby(multiPolygon))
    }

    func testCoveredByFalse() {
        let testPoint = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 101.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 10.0)), Point(Coordinate(x: 105.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[100.0, 102.0], [100.0, 101.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[102.0, 102.0], [102.0, 101.0], [101.0, 101.0], [101.0, 102.0], [102.0, 102.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[10.0, 10.0], [10.0, 11.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[1.0, 1.0], [1.0, -1.0]]), LineString([[1000.0, 100.0], [1000.0, 101.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[1000.0, 1000.0], [1000.0, 1001.0], [1001.0, 1001.0], [1001.0, 100.0], [1000.0, 1000.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[1000.0, 100.0], [200.0, 100.0], [200.0, 200.0], [1000.0, 200.0], [1000.0, 100.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.coveredby(point))
        XCTAssertFalse(testPoint.coveredby(multiPoint1))
        XCTAssertFalse(testPoint.coveredby(multiPoint2))
        XCTAssertFalse(testPoint.coveredby(lineString))
        XCTAssertFalse(testPoint.coveredby(linearRing))
        XCTAssertFalse(testPoint.coveredby(multiLineString1))
        XCTAssertFalse(testPoint.coveredby(multiLineString2))
        XCTAssertFalse(testPoint.coveredby(polygon))
        XCTAssertFalse(testPoint.coveredby(multiPolygon))
    }

    func testValidTrue() {
        let testPoint = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.valid())
    }

    func testValidFalse() {
        let x1 = 0.0
        let y1 = x1 * .infinity // y1 is a NaN
        let testPoint1 = Point(Coordinate(x: x1, y: y1), precision: precision, coordinateSystem: cs)

        let x2 = Double.nan
        let y2 = 4.0
        let testPoint2 = Point(Coordinate(x: x2, y: y2), precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint1.valid())
        XCTAssertFalse(testPoint2.valid())
    }
}

// MARK: - Coordinate2DM, FloatingPrecision, Cartesian -

class PointGeometryCoordinate2DMFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testDimension() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testIsEmpty() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).isEmpty(), false)
    }

    // MARK: - Bounds

    func testBounds() {
        let input = Point(Coordinate(x: 2.0, y: 3.0, m: 0.0), precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 2.0, y: 3.0), max: (x: 2.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    func testEqualsTrue() {
        let testPoint = Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.001, y: 1.001, m: 1.001)), Point(Coordinate(x: 1.001, y: 1.001, m: 1.001))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.equals(point))
        XCTAssertTrue(testPoint.equals(multiPoint))
    }

    func testEqualsFalse() {
        let testPoint = Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 2.002, y: 2.002, m: 2.002), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0, m: 2.0)), Point(Coordinate(x: 3.0, y: 3.0, m: 3.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([Coordinate(x: 1.0, y: 1.0, m: 1.0), Coordinate(x: 2.0, y: 2.0, m: 2.0)], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([Coordinate(x: 1.0, y: 1.0, m: 1.0), Coordinate(x: 2.0, y: 2.0, m: 2.0), Coordinate(x: 2.0, y: 1.0, m: 1.0), Coordinate(x: 1.0, y: 1.0, m: 1.0)], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0, m: 1.0), Coordinate(x: 2.0, y: 2.0, m: 2.0), Coordinate(x: 2.0, y: 1.0, m: 1.0)])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([Coordinate(x: 6.0, y: 1.0, m: 1.0), Coordinate(x: 1.0, y: 1.0, m: 2.0), Coordinate(x: 1.0, y: 3.0, m: 1.0), Coordinate(x: 3.5, y: 4.0, m: 2.0), Coordinate(x: 6.0, y: 3.0, m: 1.0), Coordinate(x: 6.0, y: 1.0, m: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0, m: 1.0), Coordinate(x: 5.0, y: 3.0, m: 2.0), Coordinate(x: 3.5, y: 3.5, m: 1.0), Coordinate(x: 2.0, y: 3.0, m: 2.0), Coordinate(x: 2.0, y: 2.0, m: 1.0), Coordinate(x: 5.0, y: 2.0, m: 1.0)]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0, m: 1.0), Coordinate(x: 1.0, y: 1.0, m: 2.0), Coordinate(x: 1.0, y: 3.0, m: 1.0), Coordinate(x: 3.5, y: 4.0, m: 2.0), Coordinate(x: 6.0, y: 3.0, m: 1.0), Coordinate(x: 6.0, y: 1.0, m: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0, m: 1.0), Coordinate(x: 5.0, y: 3.0, m: 2.0), Coordinate(x: 3.5, y: 3.5, m: 1.0), Coordinate(x: 2.0, y: 3.0, m: 2.0), Coordinate(x: 2.0, y: 2.0, m: 1.0), Coordinate(x: 5.0, y: 2.0, m: 1.0)]]), Polygon([Coordinate(x: 10.0, y: 1.0, m: 1.0), Coordinate(x: 8.0, y: 1.0, m: 2.0), Coordinate(x: 8.0, y: 10.0, m: 1.0), Coordinate(x: 10.0, y: 10.0, m: 2.0), Coordinate(x: 10.0, y: 1.0, m: 1.0)], innerRings: [])], precision: precision, coordinateSystem: cs)
        let geometryCollection1 = GeometryCollection([Point(Coordinate(x: 1.0, y: 1.0))] as [Geometry], precision: precision, coordinateSystem: cs)
        let geometryCollection2 = GeometryCollection([LineString([[1.0, 1.0], [2.0, 2.0]])] as [Geometry], precision: precision, coordinateSystem: cs)
        let geometryCollection3 = GeometryCollection([LineString([[1.0, 1.0], [2.0, 2.0]]), Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0]], innerRings: [])] as [Geometry], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.equals(point))
        XCTAssertFalse(testPoint.equals(multiPoint))
        XCTAssertFalse(testPoint.equals(lineString))
        XCTAssertFalse(testPoint.equals(linearRing))
        XCTAssertFalse(testPoint.equals(multiLineString))
        XCTAssertFalse(testPoint.equals(polygon))
        XCTAssertFalse(testPoint.equals(multiPolygon))
        XCTAssertFalse(testPoint.equals(geometryCollection1))
        XCTAssertFalse(testPoint.equals(geometryCollection2))
        XCTAssertFalse(testPoint.equals(geometryCollection3))
    }

    func testBoundary() {
        let geometry = Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate3D, FloatingPrecision, Cartesian -

class PointGeometryCoordinate3DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testDimension() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testIsEmpty() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs).isEmpty(), false)
    }

    // MARK: - Bounds

    func testBounds() {
        let input = Point(Coordinate(x: 2.0, y: 3.0, z: 0.0), precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 2.0, y: 3.0), max: (x: 2.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    func testEqualsTrue() {
        let testPoint = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.001, y: 1.001, z: 1.001)), Point(Coordinate(x: 1.001, y: 1.001, z: 1.001))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.equals(point))
        XCTAssertTrue(testPoint.equals(multiPoint))
    }

    func testEqualsFalse() {
        let testPoint = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 2.002, y: 2.002, z: 2.002), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0, z: 2.0)), Point(Coordinate(x: 3.0, y: 3.0, z: 3.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([Coordinate(x: 1.0, y: 1.0, z: 1.0), Coordinate(x: 2.0, y: 2.0, z: 2.0)], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([Coordinate(x: 1.0, y: 1.0, z: 1.0), Coordinate(x: 2.0, y: 2.0, z: 2.0), Coordinate(x: 2.0, y: 1.0, z: 1.0), Coordinate(x: 1.0, y: 1.0, z: 1.0)], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0, z: 1.0), Coordinate(x: 2.0, y: 2.0, z: 2.0), Coordinate(x: 2.0, y: 1.0, z: 1.0)])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([Coordinate(x: 6.0, y: 1.0, z: 1.0), Coordinate(x: 1.0, y: 1.0, z: 2.0), Coordinate(x: 1.0, y: 3.0, z: 1.0), Coordinate(x: 3.5, y: 4.0, z: 2.0), Coordinate(x: 6.0, y: 3.0, z: 1.0), Coordinate(x: 6.0, y: 1.0, z: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0, z: 1.0), Coordinate(x: 5.0, y: 3.0, z: 2.0), Coordinate(x: 3.5, y: 3.5, z: 1.0), Coordinate(x: 2.0, y: 3.0, z: 2.0), Coordinate(x: 2.0, y: 2.0, z: 1.0), Coordinate(x: 5.0, y: 2.0, z: 1.0)]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0, z: 1.0), Coordinate(x: 1.0, y: 1.0, z: 2.0), Coordinate(x: 1.0, y: 3.0, z: 1.0), Coordinate(x: 3.5, y: 4.0, z: 2.0), Coordinate(x: 6.0, y: 3.0, z: 1.0), Coordinate(x: 6.0, y: 1.0, z: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0, z: 1.0), Coordinate(x: 5.0, y: 3.0, z: 2.0), Coordinate(x: 3.5, y: 3.5, z: 1.0), Coordinate(x: 2.0, y: 3.0, z: 2.0), Coordinate(x: 2.0, y: 2.0, z: 1.0), Coordinate(x: 5.0, y: 2.0, z: 1.0)]]), Polygon([Coordinate(x: 10.0, y: 1.0, z: 1.0), Coordinate(x: 8.0, y: 1.0, z: 2.0), Coordinate(x: 8.0, y: 10.0, z: 1.0), Coordinate(x: 10.0, y: 10.0, z: 2.0), Coordinate(x: 10.0, y: 1.0, z: 1.0)], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.equals(point))
        XCTAssertFalse(testPoint.equals(multiPoint))
        XCTAssertFalse(testPoint.equals(lineString))
        XCTAssertFalse(testPoint.equals(linearRing))
        XCTAssertFalse(testPoint.equals(multiLineString))
        XCTAssertFalse(testPoint.equals(polygon))
        XCTAssertFalse(testPoint.equals(multiPolygon))
    }

    func testBoundary() {
        let geometry = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate3DM, FloatingPrecision, Cartesian -

class PointGeometryCoordinate3DMFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testDimension() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testIsEmpty() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).isEmpty(), false)
    }

    // MARK: - Bounds

    func testBounds() {
        let input = Point(Coordinate(x: 2.0, y: 3.0, z: 0.0, m: 0.0), precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 2.0, y: 3.0), max: (x: 2.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    func testEqualsTrue() {
        let testPoint = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001)), Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testPoint.equals(point))
        XCTAssertTrue(testPoint.equals(multiPoint))
    }

    func testEqualsFalse() {
        let testPoint = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 2.002, y: 2.002, z: 2.002, m: 2.002), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 2.0)), Point(Coordinate(x: 3.0, y: 3.0, z: 3.0, m: 3.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0), Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 2.0)], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0), Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 2.0), Coordinate(x: 2.0, y: 1.0, z: 1.0, m: 2.0), Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0), Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 2.0), Coordinate(x: 2.0, y: 1.0, z: 1.0, m: 2.0)])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([Coordinate(x: 6.0, y: 1.0, z: 1.0, m: 2.0), Coordinate(x: 1.0, y: 1.0, z: 2.0, m: 2.0), Coordinate(x: 1.0, y: 3.0, z: 1.0, m: 2.0), Coordinate(x: 3.5, y: 4.0, z: 2.0, m: 2.0), Coordinate(x: 6.0, y: 3.0, z: 1.0, m: 2.0), Coordinate(x: 6.0, y: 1.0, z: 1.0, m: 2.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0, z: 1.0, m: 2.0), Coordinate(x: 5.0, y: 3.0, z: 2.0, m: 2.0), Coordinate(x: 3.5, y: 3.5, z: 1.0, m: 2.0), Coordinate(x: 2.0, y: 3.0, z: 2.0, m: 2.0), Coordinate(x: 2.0, y: 2.0, z: 1.0, m: 2.0), Coordinate(x: 5.0, y: 2.0, z: 1.0, m: 2.0)]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0, z: 1.0, m: 2.0), Coordinate(x: 1.0, y: 1.0, z: 2.0, m: 2.0), Coordinate(x: 1.0, y: 3.0, z: 1.0, m: 2.0), Coordinate(x: 3.5, y: 4.0, z: 2.0, m: 2.0), Coordinate(x: 6.0, y: 3.0, z: 1.0, m: 2.0), Coordinate(x: 6.0, y: 1.0, z: 1.0, m: 2.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0, z: 1.0, m: 2.0), Coordinate(x: 5.0, y: 3.0, z: 2.0, m: 2.0), Coordinate(x: 3.5, y: 3.5, z: 1.0, m: 2.0), Coordinate(x: 2.0, y: 3.0, z: 2.0, m: 2.0), Coordinate(x: 2.0, y: 2.0, z: 1.0, m: 2.0), Coordinate(x: 5.0, y: 2.0, z: 1.0, m: 2.0)]]), Polygon([Coordinate(x: 10.0, y: 1.0, z: 1.0, m: 2.0), Coordinate(x: 8.0, y: 1.0, z: 2.0, m: 2.0), Coordinate(x: 8.0, y: 10.0, z: 1.0, m: 2.0), Coordinate(x: 10.0, y: 10.0, z: 2.0, m: 2.0), Coordinate(x: 10.0, y: 1.0, z: 1.0, m: 2.0)], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testPoint.equals(point))
        XCTAssertFalse(testPoint.equals(multiPoint))
        XCTAssertFalse(testPoint.equals(lineString))
        XCTAssertFalse(testPoint.equals(linearRing))
        XCTAssertFalse(testPoint.equals(multiLineString))
        XCTAssertFalse(testPoint.equals(polygon))
        XCTAssertFalse(testPoint.equals(multiPolygon))
    }

    func testBoundary() {
        let geometry = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate2D, Fixed, Cartesian -

class PointGeometryCoordinate2DFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testIsEmpty() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs).isEmpty(), false)
    }

    // MARK: - Bounds

    func testBounds() {
        let input = Point(Coordinate(x: 2.001, y: 3.001), precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 2.0, y: 3.0), max: (x: 2.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBoundary() {
        let geometry = Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate2DM, Fixed, Cartesian -

class PointGeometryCoordinate2DMFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testIsEmpty() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).isEmpty(), false)
    }

    // MARK: - Bounds

    func testBounds() {
        let input = Point(Coordinate(x: 2.001, y: 3.001, m: 0.0), precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 2.0, y: 3.0), max: (x: 2.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBoundary() {
        let geometry = Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate3D, Fixed, Cartesian -

class PointGeometryCoordinate3DFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testIsEmpty() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs).isEmpty(), false)
    }

    // MARK: - Bounds

    func testBounds() {
        let input = Point(Coordinate(x: 2.001, y: 3.001, z: 0.0), precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 2.0, y: 3.0), max: (x: 2.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBoundary() {
        let geometry = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate3DM, Fixed, Cartesian -

class PointGeometryCoordinate3DMFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testIsEmpty() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).isEmpty(), false)
    }

    // MARK: - Bounds

    func testBounds() {
        let input = Point(Coordinate(x: 2.001, y: 3.001, z: 0.0, m: 0.0), precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 2.0, y: 3.0), max: (x: 2.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBoundary() {
        let geometry = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}
