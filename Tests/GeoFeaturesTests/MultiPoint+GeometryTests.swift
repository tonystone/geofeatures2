///
///  MultiPoint+GeometryTests.swift
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

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs        = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testEqualsTrue() {
        ///  Note that equals means equals topologically and not structurally.
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 100.1, y: 100.2)), Point(Coordinate(x: 200.0, y: 200.0))], precision: precision, coordinateSystem: cs)

        let multiPoint1 = MultiPoint([Point(Coordinate(x: 100.1, y: 100.2)), Point(Coordinate(x: 200.0, y: 200.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 200.0, y: 200.0)), Point(Coordinate(x: 100.1, y: 100.2))], precision: precision, coordinateSystem: cs)
        let multiPoint3 = MultiPoint([Point(Coordinate(x: 200.0, y: 200.0)), Point(Coordinate(x: 100.1, y: 100.2)), Point(Coordinate(x: 200.0, y: 200.0)), Point(Coordinate(x: 100.1, y: 100.2))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPoint.equals(multiPoint1))
        XCTAssertTrue(testMultiPoint.equals(multiPoint2))
        XCTAssertTrue(testMultiPoint.equals(multiPoint3))
    }

    func testEqualsFalse() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 100.1, y: 100.2)), Point(Coordinate(x: 200.0, y: 200.0))], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 100.1, y: 100.2)), Point(Coordinate(x: 200.0, y: 200.1))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 200.1, y: 200.0)), Point(Coordinate(x: 100.1, y: 100.2))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPoint.equals(point))
        XCTAssertFalse(testMultiPoint.equals(multiPoint1))
        XCTAssertFalse(testMultiPoint.equals(multiPoint2))
        XCTAssertFalse(testMultiPoint.equals(lineString))
        XCTAssertFalse(testMultiPoint.equals(linearRing))
        XCTAssertFalse(testMultiPoint.equals(multiLineString))
        XCTAssertFalse(testMultiPoint.equals(polygon))
        XCTAssertFalse(testMultiPoint.equals(multiPolygon))
    }

    func testDisjointTrue() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 100.1, y: 100.2)), Point(Coordinate(x: 200.0, y: 200.0))], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPoint.disjoint(point))
        XCTAssertTrue(testMultiPoint.disjoint(multiPoint))
        XCTAssertTrue(testMultiPoint.disjoint(lineString))
        XCTAssertTrue(testMultiPoint.disjoint(linearRing))
        XCTAssertTrue(testMultiPoint.disjoint(multiLineString))
        XCTAssertTrue(testMultiPoint.disjoint(polygon))
        XCTAssertTrue(testMultiPoint.disjoint(multiPolygon))
    }

    func testDisjointFalse() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPoint.disjoint(point))
        XCTAssertFalse(testMultiPoint.disjoint(multiPoint))
        XCTAssertFalse(testMultiPoint.disjoint(lineString))
        XCTAssertFalse(testMultiPoint.disjoint(linearRing))
        XCTAssertFalse(testMultiPoint.disjoint(multiLineString))
        XCTAssertFalse(testMultiPoint.disjoint(polygon))
        XCTAssertFalse(testMultiPoint.disjoint(multiPolygon))
    }

    func testIntersectsTrue() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPoint.intersects(point))
        XCTAssertTrue(testMultiPoint.intersects(multiPoint))
        XCTAssertTrue(testMultiPoint.intersects(lineString))
        XCTAssertTrue(testMultiPoint.intersects(linearRing))
        XCTAssertTrue(testMultiPoint.intersects(multiLineString))
        XCTAssertTrue(testMultiPoint.intersects(polygon))
        XCTAssertTrue(testMultiPoint.intersects(multiPolygon))
    }

    func testIntersectsFalse() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 100.1, y: 100.2)), Point(Coordinate(x: 200.0, y: 200.0))], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPoint.intersects(point))
        XCTAssertFalse(testMultiPoint.intersects(multiPoint))
        XCTAssertFalse(testMultiPoint.intersects(lineString))
        XCTAssertFalse(testMultiPoint.intersects(linearRing))
        XCTAssertFalse(testMultiPoint.intersects(multiLineString))
        XCTAssertFalse(testMultiPoint.intersects(polygon))
        XCTAssertFalse(testMultiPoint.intersects(multiPolygon))
    }

    func testTouchesTrue() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 20.0, y: 20.0))], precision: precision, coordinateSystem: cs)

        let lineString = LineString([[1.0, 1.0], [1.5, 1.5]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPoint.touches(lineString))
        XCTAssertTrue(testMultiPoint.touches(multiLineString))
        XCTAssertTrue(testMultiPoint.touches(polygon))
        XCTAssertTrue(testMultiPoint.touches(multiPolygon))
    }

    func testTouchesFalse() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

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

        XCTAssertFalse(testMultiPoint.touches(point1))
        XCTAssertFalse(testMultiPoint.touches(point2))
        XCTAssertFalse(testMultiPoint.touches(multiPoint1))
        XCTAssertFalse(testMultiPoint.touches(multiPoint2))
        XCTAssertFalse(testMultiPoint.touches(lineString1))
        XCTAssertFalse(testMultiPoint.touches(lineString2))
        XCTAssertFalse(testMultiPoint.touches(linearRing1))
        XCTAssertFalse(testMultiPoint.touches(linearRing2))
        XCTAssertFalse(testMultiPoint.touches(multiLineString1))
        XCTAssertFalse(testMultiPoint.touches(multiLineString2))
        XCTAssertFalse(testMultiPoint.touches(polygon1))
        XCTAssertFalse(testMultiPoint.touches(polygon2))
        XCTAssertFalse(testMultiPoint.touches(multiPolygon1))
        XCTAssertFalse(testMultiPoint.touches(multiPolygon2))
    }

    func testCrossesTrue() {
        /// There are no cases where a point can cross another geometry.
        /// Therefore, this test exists as a placeholder to indicate that this case was not overlooked.
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [0.5,  0.5]]), LineString([[1.0,  1.0], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPoint.crosses(lineString))
        XCTAssertTrue(testMultiPoint.crosses(linearRing))
        XCTAssertTrue(testMultiPoint.crosses(multiLineString))
        XCTAssertTrue(testMultiPoint.crosses(polygon))
        XCTAssertTrue(testMultiPoint.crosses(multiPolygon))
    }

    func testCrossesFalse() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [1.5, 1.5]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[-1.0, 1.0], [-2.0, 2.0], [-3.0, 3.0], [-3.0, 1.0], [-1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  3.0], [1.0,  1.0], [1.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [2.0, 1.0], [2.0, 1.5], [1.0, 1.5], [1.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [2.0, 1.0], [2.0, 2.0], [1.0, 2.0], [1.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 110.0], [110.0, 110.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [2.0, 1.0], [2.0, 2.0], [1.0, 2.0], [1.0, 1.0]]], precision: precision, coordinateSystem: cs), Polygon([[0.0, 50.0], [0.0, 80.0], [110.0, 80.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPoint.crosses(point1))
        XCTAssertFalse(testMultiPoint.crosses(point2))
        XCTAssertFalse(testMultiPoint.crosses(multiPoint1))
        XCTAssertFalse(testMultiPoint.crosses(multiPoint2))
        XCTAssertFalse(testMultiPoint.crosses(lineString))
        XCTAssertFalse(testMultiPoint.crosses(linearRing))
        XCTAssertFalse(testMultiPoint.crosses(multiLineString))
        XCTAssertFalse(testMultiPoint.crosses(polygon1))
        XCTAssertFalse(testMultiPoint.crosses(polygon2))
        XCTAssertFalse(testMultiPoint.crosses(polygon3))
        XCTAssertFalse(testMultiPoint.crosses(multiPolygon1))
        XCTAssertFalse(testMultiPoint.crosses(multiPolygon2))
        XCTAssertFalse(testMultiPoint.crosses(multiPolygon3))
    }

    func testWithinTrue() {
        let testMultiPoint1 = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let testMultiPoint2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.2,  1.2], [2.0,  2.0], [2.0,  4.0]]), LineString([[-10.0,  10.0], [0.0,  0.0], [1.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[6.0, 0.0], [0.0, 0.0], [0.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[26.0, 21.0], [21.0, 21.0], [21.0, 26.0], [23.5, 26.0], [26.0, 26.0], [26.0, 21.0]], innerRings: [[[25.0, 22.0], [25.0, 23.0], [23.5, 23.5], [22.0, 23.0], [22.0, 22.0], [25.0, 22.0]]]), Polygon([[10.0, 0.0], [0.0, 0.0], [0.0, 10.0], [10.0, 10.0], [10.0, 0.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[26.0, 21.0], [21.0, 21.0], [21.0, 26.0], [23.5, 26.0], [26.0, 26.0], [26.0, 21.0]], innerRings: [[[25.0, 22.0], [25.0, 23.0], [23.5, 23.5], [22.0, 23.0], [22.0, 22.0], [25.0, 22.0]]]), Polygon([[1.0, 1.0], [1.0, 2.0], [2.0, 2.0], [2.0, 1.0], [1.0, 1.0]], innerRings: [[[1.6, 1.7], [1.6, 1.8], [1.5, 1.8], [1.5, 1.7], [1.6, 1.7]]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPoint1.within(point))
        XCTAssertTrue(testMultiPoint2.within(multiPoint))
        XCTAssertTrue(testMultiPoint2.within(lineString))
        XCTAssertTrue(testMultiPoint2.within(linearRing))
        XCTAssertTrue(testMultiPoint2.within(multiLineString))
        XCTAssertTrue(testMultiPoint2.within(polygon1))
        XCTAssertTrue(testMultiPoint2.within(polygon2))
        XCTAssertTrue(testMultiPoint2.within(multiPolygon1))
        XCTAssertTrue(testMultiPoint2.within(multiPolygon2))
    }

    func testWithinFalse() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[0.0, 0.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [100.0, 1.0], [100.0, 200.0], [1.0, 200.0], [1.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 5.0], [200.0, 5.0], [200.0, 200.0], [5.0, 200.0], [5.0, 5.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [100.0, 25.0], [100.0, 100.0], [5.0, 100.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [200.0, 25.0], [200.0, 200.0], [5.0, 200.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPoint.within(point))
        XCTAssertFalse(testMultiPoint.within(multiPoint))
        XCTAssertFalse(testMultiPoint.within(lineString1))
        XCTAssertFalse(testMultiPoint.within(lineString2))
        XCTAssertFalse(testMultiPoint.within(linearRing))
        XCTAssertFalse(testMultiPoint.within(multiLineString1))
        XCTAssertFalse(testMultiPoint.within(multiLineString2))
        XCTAssertFalse(testMultiPoint.within(polygon1))
        XCTAssertFalse(testMultiPoint.within(polygon2))
        XCTAssertFalse(testMultiPoint.within(polygon3))
        XCTAssertFalse(testMultiPoint.within(multiPolygon1))
        XCTAssertFalse(testMultiPoint.within(multiPolygon2))
        XCTAssertFalse(testMultiPoint.within(multiPolygon3))
        XCTAssertFalse(testMultiPoint.within(multiPolygon4))
    }

    func testContainsTrue() {
        /// A multipoint can only contain a point or a multipoint that is a subset of itself.
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPoint.contains(point))
        XCTAssertTrue(testMultiPoint.contains(multiPoint1))
        XCTAssertTrue(testMultiPoint.contains(multiPoint2))
    }

    func testContainsFalse() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

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

        XCTAssertFalse(testMultiPoint.contains(point))
        XCTAssertFalse(testMultiPoint.contains(multiPoint1))
        XCTAssertFalse(testMultiPoint.contains(multiPoint2))
        XCTAssertFalse(testMultiPoint.contains(lineString1))
        XCTAssertFalse(testMultiPoint.contains(lineString2))
        XCTAssertFalse(testMultiPoint.contains(linearRing))
        XCTAssertFalse(testMultiPoint.contains(multiLineString1))
        XCTAssertFalse(testMultiPoint.contains(multiLineString2))
        XCTAssertFalse(testMultiPoint.contains(polygon1))
        XCTAssertFalse(testMultiPoint.contains(polygon2))
        XCTAssertFalse(testMultiPoint.contains(multiPolygon1))
        XCTAssertFalse(testMultiPoint.contains(multiPolygon2))
    }

    func testOverlapsTrue() {
        /// Overlaps can only be true for geometries of the same dimension, and each geometry must have points exterior to the other, and the interiors must touch.
        /// A multipoint can never overlap a point because the point would have to be both interior and exterior to the multipoint.
        /// Therefore, a multipoint can only overlap another multipoint.
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPoint.overlaps(multiPoint))
    }

    func testOverlapsFalse() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let lineString3 = LineString([[2.0, 2.0], [3.0, 3.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[-2.0, 2.0], [2.0, 2.0], [3.0, 3.0], [-1.0, 3.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[1.0, 1.0], [1.0, 100.0], [100.0, 100.0], [100.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[0.0,  4.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[2.0, 2.0], [2.0, 1000.0], [1000.0, 1000.0], [1000.0, 2.0], [2.0, 2.0]], innerRings: [[[5.0, 5.0], [100.0, 5.0], [100.0, 100.0], [5.0, 100.0], [5.0, 5.0]]], precision: precision, coordinateSystem: cs)
        let polygon4 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 5.0], [200.0, 5.0], [200.0, 200.0], [5.0, 200.0], [5.0, 5.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [110.0, 50.0], [110.0, 100.0], [0.0, 100.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [100.0, 25.0], [100.0, 100.0], [5.0, 100.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [200.0, 25.0], [200.0, 200.0], [5.0, 200.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPoint.overlaps(point1))
        XCTAssertFalse(testMultiPoint.overlaps(point2))
        XCTAssertFalse(testMultiPoint.overlaps(multiPoint1))
        XCTAssertFalse(testMultiPoint.overlaps(multiPoint2))
        XCTAssertFalse(testMultiPoint.overlaps(lineString1))
        XCTAssertFalse(testMultiPoint.overlaps(lineString2))
        XCTAssertFalse(testMultiPoint.overlaps(lineString3))
        XCTAssertFalse(testMultiPoint.overlaps(linearRing1))
        XCTAssertFalse(testMultiPoint.overlaps(linearRing2))
        XCTAssertFalse(testMultiPoint.overlaps(multiLineString1))
        XCTAssertFalse(testMultiPoint.overlaps(multiLineString2))
        XCTAssertFalse(testMultiPoint.overlaps(polygon1))
        XCTAssertFalse(testMultiPoint.overlaps(polygon2))
        XCTAssertFalse(testMultiPoint.overlaps(polygon3))
        XCTAssertFalse(testMultiPoint.overlaps(polygon4))
        XCTAssertFalse(testMultiPoint.overlaps(multiPolygon1))
        XCTAssertFalse(testMultiPoint.overlaps(multiPolygon2))
        XCTAssertFalse(testMultiPoint.overlaps(multiPolygon3))
        XCTAssertFalse(testMultiPoint.overlaps(multiPolygon4))
    }

    func testCoversTrue() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPoint.covers(point))
        XCTAssertTrue(testMultiPoint.covers(multiPoint1))
        XCTAssertTrue(testMultiPoint.covers(multiPoint2))
    }

    func testCoversFalse() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 101.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 105.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[100.0, 100.0], [100.0, 101.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[100.0, 100.0], [100.0, 101.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[100.0, 100.0], [100.0, 101.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[100.0, 100.0], [100.0, 100.0]]), LineString([[100.0, 100.0], [100.0, 101.0]]), LineString([[1.0, 1.0], [1.0, 1.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[100.0, 100.0], [100.0, 101.0], [101.0, 101.0], [101.0, 100.0], [100.0, 100.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPoint.covers(point))
        XCTAssertFalse(testMultiPoint.covers(multiPoint1))
        XCTAssertFalse(testMultiPoint.covers(multiPoint2))
        XCTAssertFalse(testMultiPoint.covers(lineString))
        XCTAssertFalse(testMultiPoint.covers(linearRing))
        XCTAssertFalse(testMultiPoint.covers(multiLineString1))
        XCTAssertFalse(testMultiPoint.covers(multiLineString2))
        XCTAssertFalse(testMultiPoint.covers(polygon))
        XCTAssertFalse(testMultiPoint.covers(multiPolygon))
    }

    func testCoveredByTrue() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 102.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[0.0, 0.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[-200.0, -200.0], [200.0, 200.0], [200.0, -200.0], [-200.0, -200.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[200.0, 200.0], [0.0, 0.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[1000.0, 100.0], [1000.0, 200.0]]), LineString([[0.0, 0.0], [100.0, 0.0], [100.0, 500.0]]), LineString([[10.0, 10.0], [-100.0, -100.0], [-100.0, -500.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[0.0, 0.0], [0.0, 200.0], [200.0, 200.0], [200.0, 0.0], [0.0, 0.0]], innerRings: [[[60.0, 60.0], [40.0, 60.0], [40.0, 40.0], [60.0, 40.0], [60.0, 60.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[1000.0, 100.0], [100.0, 100.0], [100.0, 200.0], [1000.0, 200.0], [1000.0, 100.0]], innerRings: []), Polygon([[0.0, 0.0], [0.0, 4.0], [4.0, 4.0], [4.0, 0.0], [0.0, 0.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPoint.coveredby(multiPoint1))
        XCTAssertTrue(testMultiPoint.coveredby(multiPoint2))
        XCTAssertTrue(testMultiPoint.coveredby(lineString))
        XCTAssertTrue(testMultiPoint.coveredby(linearRing))
        XCTAssertTrue(testMultiPoint.coveredby(multiLineString1))
        XCTAssertTrue(testMultiPoint.coveredby(multiLineString2))
        XCTAssertTrue(testMultiPoint.coveredby(polygon))
        XCTAssertTrue(testMultiPoint.coveredby(multiPolygon))
    }

    func testCoveredByFalse() {
        let testMultiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 105.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[102.0, 102.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[102.0, 102.0], [102.0, 2.0], [2.0, 2.0], [102.0, 102.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[10.0, 10.0], [10.0, 11.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[1.0, 1.0], [1.0, -1.0]]), LineString([[1000.0, 100.0], [1000.0, 101.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[1000.0, 1000.0], [1000.0, 1001.0], [1001.0, 1001.0], [1001.0, 100.0], [1000.0, 1000.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[1000.0, 100.0], [100.0, 100.0], [100.0, 200.0], [1000.0, 200.0], [1000.0, 100.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPoint.coveredby(point))
        XCTAssertFalse(testMultiPoint.coveredby(multiPoint1))
        XCTAssertFalse(testMultiPoint.coveredby(multiPoint2))
        XCTAssertFalse(testMultiPoint.coveredby(lineString))
        XCTAssertFalse(testMultiPoint.coveredby(linearRing))
        XCTAssertFalse(testMultiPoint.coveredby(multiLineString1))
        XCTAssertFalse(testMultiPoint.coveredby(multiLineString2))
        XCTAssertFalse(testMultiPoint.coveredby(polygon))
        XCTAssertFalse(testMultiPoint.coveredby(multiPolygon))
    }

    func testValidTrue() {
        let testMultiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let testMultiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 105.0, y: 100.0)), Point(Coordinate(x: 5.0, y: -100.0))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiPoint1.valid())
        XCTAssertTrue(testMultiPoint2.valid())
    }

    func testValidFalse() {
        let x1 = 0.0
        let y1 = x1 * .infinity // y1 is a NaN
        let testPoint1 = Point(Coordinate(x: x1, y: y1), precision: precision, coordinateSystem: cs)
        let testMultiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0)), testPoint1], precision: precision, coordinateSystem: cs)

        let x2 = Double.nan
        let y2 = 4.0
        let testPoint2 = Point(Coordinate(x: x2, y: y2), precision: precision, coordinateSystem: cs)
        let testMultiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), testPoint2, Point(Coordinate(x: 105.0, y: 100.0)), Point(Coordinate(x: 5.0, y: -100.0))], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiPoint1.valid())
        XCTAssertFalse(testMultiPoint2.valid())
    }
}

// MARK: - Coordinate2DM, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate2DMFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()


    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, m: 2.0))],precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, m: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate3D, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate3DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))],precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate3DM, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate3DMFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate2D, Fixed, Cartesian -

class MultiPointGeometryCoordinate2DFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))],precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate2DM, Fixed, Cartesian -

class MultiPointGeometryCoordinate2DMFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, m: 2.0))], precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, m: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate3D, Fixed, Cartesian -

class MultiPointGeometryCoordinate3DFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testEqualTrue() {
        let input1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs)
        let input2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point(Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }
}

// MARK: - Coordinate3DM, Fixed, Cartesian -

class MultiPointGeometryCoordinate3DMFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))],precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testEqualTrue() {
        let input1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs)
        let input2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point(Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }
}
