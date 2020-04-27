///
///  LinearRing+GeometryTests.swift
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

class LinearRingGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    // MARK: - Dimension

    func testDimension () {
        XCTAssertEqual(LinearRing([[1.0, 1.0]],precision: precision, coordinateSystem: cs).dimension, .one)
    }

    func testDimensionEmpty () {
        XCTAssertEqual(LinearRing(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    // MARK: - Boundary

    func testBoundaryWith1ElementInvalid() {
        let input = LinearRing([[1.0, 1.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith2Element() {
        let input = LinearRing([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint([Point([1.0, 1.0]), Point([2.0, 2.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith3ElementOpen() {
        let input = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint([Point([1.0, 1.0]), Point([3.0, 3.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith4ElementClosed() {
        let input = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = LinearRing(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    // MARK: - Bounds

    func testBoundsEmpty() {
        let input = LinearRing(precision: precision, coordinateSystem: cs)
        let expected: Bounds? = nil

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBoundsWithElements() {
        let input = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 1.0, y: 1.0), max: (x: 3.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    // MARK: - Equal

    func testEqualTrue() {
        let input1 = LinearRing([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let input2 = LinearRing([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = LinearRing([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point([1.0, 1.0], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }

    // MARK: - Disjoint

    func testDisjointTrue() {
        let testLinearRing = LinearRing([[21.0, 21.0], [21.0, 22.0], [22.0, 22.0], [22.0, 21.0], [21.0, 21.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0], [10.0, -85.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLinearRing.disjoint(point))
        XCTAssertTrue(testLinearRing.disjoint(multiPoint))
        XCTAssertTrue(testLinearRing.disjoint(lineString))
        XCTAssertTrue(testLinearRing.disjoint(linearRing))
        XCTAssertTrue(testLinearRing.disjoint(multiLineString))
        XCTAssertTrue(testLinearRing.disjoint(polygon))
        XCTAssertTrue(testLinearRing.disjoint(multiPolygon))
    }

    func testDisjointFalse() {
        let testLinearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[3.0, 3.0], [3.0, 10.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[3.0, 4.0], [3.0, 10.0], [10.0, 10.0], [10.0, 4.0], [3.0, 4.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLinearRing.disjoint(point))
        XCTAssertFalse(testLinearRing.disjoint(multiPoint))
        XCTAssertFalse(testLinearRing.disjoint(lineString))
        XCTAssertFalse(testLinearRing.disjoint(linearRing))
        XCTAssertFalse(testLinearRing.disjoint(multiLineString))
        XCTAssertFalse(testLinearRing.disjoint(polygon))
        XCTAssertFalse(testLinearRing.disjoint(multiPolygon))
    }

    // MARK: - Intersects

    func testIntersectsTrue() {
        let testLinearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[3.0, 3.0], [3.0, 10.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[3.0, 4.0], [3.0, 10.0], [10.0, 10.0], [10.0, 4.0], [3.0, 4.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLinearRing.intersects(point))
        XCTAssertTrue(testLinearRing.intersects(multiPoint))
        XCTAssertTrue(testLinearRing.intersects(lineString))
        XCTAssertTrue(testLinearRing.intersects(linearRing))
        XCTAssertTrue(testLinearRing.intersects(multiLineString))
        XCTAssertTrue(testLinearRing.intersects(polygon))
        XCTAssertTrue(testLinearRing.intersects(multiPolygon))
    }

    func testIntersectsFalse() {
        let testLinearRing = LinearRing([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [24.0, 1.0], [21.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 11.0, y: 1.0)), Point(Coordinate(x: 12.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[11.0, 1.0], [12.0, 2.0], [12.0, 4.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLinearRing.intersects(point))
        XCTAssertFalse(testLinearRing.intersects(multiPoint))
        XCTAssertFalse(testLinearRing.intersects(lineString))
        XCTAssertFalse(testLinearRing.intersects(linearRing))
        XCTAssertFalse(testLinearRing.intersects(multiLineString))
        XCTAssertFalse(testLinearRing.intersects(polygon))
        XCTAssertFalse(testLinearRing.intersects(multiPolygon))
    }

    // MARK: - Touches

    func testTouchesTrue() {
        let testLinearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let lineString = LineString([[1.0, 1.0], [-1.5, 1.5]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[-1.5,  1.5], [-3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[8.0, 4.0], [4.0, 4.0], [4.0, 8.0], [8.0, 8.0], [8.0, 4.0]], innerRings: [[[7.0, 7.0], [5.0, 7.0], [5.0, 5.0], [5.0, 7.0], [7.0, 7.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[20.0, -20.0], [16.0, -20.0], [16.0, -10.0], [4.0, -10.0], [4.0, 1.0], [20.0, 1.0], [20.0, -20.0]], innerRings: [[[5.0, -2.0], [5.0, -3.0], [7.0, -3.0], [7.0, -2.0], [5.0, -2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLinearRing.touches(lineString))
        XCTAssertTrue(testLinearRing.touches(multiLineString))
        XCTAssertTrue(testLinearRing.touches(polygon))
        XCTAssertTrue(testLinearRing.touches(multiPolygon))
    }

    func testTouchesFalse() {
        let testLinearRing = LinearRing([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [24.0, 1.0], [21.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 24.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 22.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [24.0, 4.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[1.0, 1.0], [2.0, 2.0], [300.0, 2.0], [300.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  2.0], [700.0,  2.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[20.0, 20.0], [100.0, 20.0], [100.0, 0.0], [20.0, 0.0], [20.0, 20.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLinearRing.touches(point1))
        XCTAssertFalse(testLinearRing.touches(point2))
        XCTAssertFalse(testLinearRing.touches(multiPoint1))
        XCTAssertFalse(testLinearRing.touches(multiPoint2))
        XCTAssertFalse(testLinearRing.touches(lineString1))
        XCTAssertFalse(testLinearRing.touches(lineString2))
        XCTAssertFalse(testLinearRing.touches(linearRing1))
        XCTAssertFalse(testLinearRing.touches(linearRing2))
        XCTAssertFalse(testLinearRing.touches(multiLineString1))
        XCTAssertFalse(testLinearRing.touches(multiLineString2))
        XCTAssertFalse(testLinearRing.touches(polygon1))
        XCTAssertFalse(testLinearRing.touches(polygon2))
        XCTAssertFalse(testLinearRing.touches(multiPolygon1))
        XCTAssertFalse(testLinearRing.touches(multiPolygon2))
    }

    // MARK: - Crosses

    func testCrossesTrue() {
        let testLinearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let multiPoint = MultiPoint([Point(Coordinate(x: 11.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[0.0, 1.0], [4.0, 5.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[0.0, 2.0], [0.0, 8.0], [3.0, 8.0], [3.0, 2.0], [0.0, 2.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [0.5,  0.5]]), LineString([[1.0,  2.0], [3.0,  2.0]]), LineString([[5.0,  5.0], [5.0,  8.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLinearRing.crosses(multiPoint))
        XCTAssertTrue(testLinearRing.crosses(lineString))
        XCTAssertTrue(testLinearRing.crosses(linearRing))
        XCTAssertTrue(testLinearRing.crosses(multiLineString))
    }

    func testCrossesFalse() {
        let testLinearRing = LinearRing([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [24.0, 1.0], [21.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.0, 1.5]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[24.0, 1.0], [24.0, 4.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[-1.0, 1.0], [-2.0, 2.0], [-3.0, 3.0], [-3.0, 1.0], [-1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [24.0, 1.0], [21.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[0.0,  3.0], [1.0,  1.0], [0.0,  0.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[24.0,  1.0], [24.0,  4.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[21.0, 1.0], [22.0, 1.0], [22.0, 1.5], [21.0, 1.5], [21.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[30.0, 0.5], [30.0, 10.0], [20.0, 10.0], [20.0, 0.5], [30.0, 0.5]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[21.0, 1.0], [22.0, 1.0], [22.0, 1.5], [21.0, 1.5], [21.0, 1.0]]]), Polygon([[0.0, 50.0], [0.0, 110.0], [110.0, 110.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[30.0, 0.5], [30.0, 10.0], [20.0, 10.0], [20.0, 0.5], [30.0, 0.5]]], precision: precision, coordinateSystem: cs), Polygon([[0.0, 50.0], [0.0, 80.0], [110.0, 80.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLinearRing.crosses(point))
        XCTAssertFalse(testLinearRing.crosses(multiPoint))
        XCTAssertFalse(testLinearRing.crosses(lineString1))
        XCTAssertFalse(testLinearRing.crosses(lineString2))
        XCTAssertFalse(testLinearRing.crosses(linearRing1))
        XCTAssertFalse(testLinearRing.crosses(linearRing2))
        XCTAssertFalse(testLinearRing.crosses(multiLineString1))
        XCTAssertFalse(testLinearRing.crosses(multiLineString2))
        XCTAssertFalse(testLinearRing.crosses(polygon1))
        XCTAssertFalse(testLinearRing.crosses(polygon2))
        XCTAssertFalse(testLinearRing.crosses(polygon3))
        XCTAssertFalse(testLinearRing.crosses(multiPolygon1))
        XCTAssertFalse(testLinearRing.crosses(multiPolygon2))
        XCTAssertFalse(testLinearRing.crosses(multiPolygon3))
    }

    // MARK: - Within

    func testWithinTrue() {
        let testLinearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let testLinearRing2 = LinearRing([[1.0, 1.0], [1.0, 2.0], [2.0, 2.0], [2.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  1.2], [-1.0,  2.0], [-2.0,  4.0]]), LineString([[10.0,  10.0], [0.0,  0.0], [0.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[6.0, 0.0], [0.0, 0.0], [0.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[26.0, 21.0], [21.0, 21.0], [21.0, 26.0], [23.5, 26.0], [26.0, 26.0], [26.0, 21.0]], innerRings: [[[25.0, 22.0], [25.0, 23.0], [23.5, 23.5], [22.0, 23.0], [22.0, 22.0], [25.0, 22.0]]]), Polygon([[10.0, 0.0], [0.0, 0.0], [0.0, 10.0], [10.0, 10.0], [10.0, 0.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[26.0, 21.0], [21.0, 21.0], [21.0, 26.0], [23.5, 26.0], [26.0, 26.0], [26.0, 21.0]], innerRings: [[[25.0, 22.0], [25.0, 23.0], [23.5, 23.5], [22.0, 23.0], [22.0, 22.0], [25.0, 22.0]]]), Polygon([[1.0, 1.0], [1.0, 2.1], [2.1, 2.1], [2.1, 1.0], [1.0, 1.0]], innerRings: [[[1.6, 1.7], [1.6, 1.8], [1.5, 1.8], [1.5, 1.7], [1.6, 1.7]]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLinearRing1.within(lineString))
        XCTAssertTrue(testLinearRing1.within(linearRing))
        XCTAssertTrue(testLinearRing1.within(multiLineString))
        XCTAssertTrue(testLinearRing2.within(polygon1))
        XCTAssertTrue(testLinearRing2.within(polygon2))
        XCTAssertTrue(testLinearRing2.within(multiPolygon1))
        XCTAssertTrue(testLinearRing2.within(multiPolygon2))
    }

    func testWithinFalse() {
        let testLinearRing = LinearRing([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [24.0, 1.0], [21.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[0.0, 0.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [24.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [24.0, 1.0], [23.0, 0.0], [21.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [24.0, 1.0]]), LineString([[6.0,  6.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [100.0, 1.0], [100.0, 200.0], [1.0, 200.0], [1.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[3.0, 3.0], [200.0, 3.0], [200.0, 200.0], [3.0, 200.0], [3.0, 3.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 0.0], [10.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [10.0, 0.0]], innerRings: [[[20.0, 2.0], [200.0, 2.0], [200.0, 200.0], [20.0, 200.0], [20.0, 2.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 0.0], [10.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [10.0, 0.0]], innerRings: [[[20.0, 0.5], [200.0, 0.5], [200.0, 200.0], [20.0, 200.0], [20.0, 0.5]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLinearRing.within(point))
        XCTAssertFalse(testLinearRing.within(multiPoint))
        XCTAssertFalse(testLinearRing.within(lineString1))
        XCTAssertFalse(testLinearRing.within(lineString2))
        XCTAssertFalse(testLinearRing.within(linearRing1))
        XCTAssertFalse(testLinearRing.within(linearRing2))
        XCTAssertFalse(testLinearRing.within(multiLineString1))
        XCTAssertFalse(testLinearRing.within(multiLineString2))
        XCTAssertFalse(testLinearRing.within(polygon1))
        XCTAssertFalse(testLinearRing.within(polygon2))
        XCTAssertFalse(testLinearRing.within(polygon3))
        XCTAssertFalse(testLinearRing.within(multiPolygon1))
        XCTAssertFalse(testLinearRing.within(multiPolygon2))
        XCTAssertFalse(testLinearRing.within(multiPolygon3))
        XCTAssertFalse(testLinearRing.within(multiPolygon4))
    }

    // MARK: - Contains

    func testContainsTrue() {
        let testLinearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 4.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 3.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[4.0, 1.0], [4.0, 4.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[4.0, 4.0], [2.0, 4.0], [2.0, 2.0], [1.5, 1.5]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[4.0,  3.0], [4.0,  1.0], [3.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[4.0,  4.0], [4.0,  2.0]]), LineString([[2.0,  2.0], [2.0,  4.0]]), LineString([[1.7,  1.7], [1.0,  1.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLinearRing.contains(point))
        XCTAssertTrue(testLinearRing.contains(multiPoint1))
        XCTAssertTrue(testLinearRing.contains(multiPoint2))
        XCTAssertTrue(testLinearRing.contains(lineString1))
        XCTAssertTrue(testLinearRing.contains(lineString2))
        XCTAssertTrue(testLinearRing.contains(linearRing))
        XCTAssertTrue(testLinearRing.contains(multiLineString1))
        XCTAssertTrue(testLinearRing.contains(multiLineString2))
    }

    func testContainsFalse() {
        let testLinearRing = LinearRing([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [24.0, 1.0], [21.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.0, 8.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[22.0, 2.0], [22.0, 5.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[21.0, 1.0], [22.0, 2.0], [22.0, 4.0], [24.0, 4.0], [25.0, 3.0], [24.0, 1.0], [21.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  0.0], [1.0,  6.0], [10.0,  6.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[24.0, 4.0], [24.0, 1.0], [21.0, 1.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 8.0], [3.5, 8.0], [3.5, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[100.0, 0.0], [0.0, 0.0], [0.0, 40.0], [100.0, 40.0], [100.0, 0.0]], innerRings: [[[0.5, 0.5], [20.0, 0.5], [20.0, 10.0], [0.5, 10.0], [0.5, 0.5]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLinearRing.contains(point))
        XCTAssertFalse(testLinearRing.contains(multiPoint1))
        XCTAssertFalse(testLinearRing.contains(multiPoint2))
        XCTAssertFalse(testLinearRing.contains(lineString1))
        XCTAssertFalse(testLinearRing.contains(lineString2))
        XCTAssertFalse(testLinearRing.contains(linearRing1))
        XCTAssertFalse(testLinearRing.contains(linearRing2))
        XCTAssertFalse(testLinearRing.contains(multiLineString1))
        XCTAssertFalse(testLinearRing.contains(multiLineString2))
        XCTAssertFalse(testLinearRing.contains(polygon1))
        XCTAssertFalse(testLinearRing.contains(polygon2))
        XCTAssertFalse(testLinearRing.contains(multiPolygon1))
        XCTAssertFalse(testLinearRing.contains(multiPolygon2))
    }

    // MARK: - Overlaps

    func testOverlapsTrue() {
        /// Overlaps can only be true for geometries of the same dimension, and each geometry must have points exterior to the other, and the interiors must touch.
        let testLinearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let lineString1 = LineString([[1.0, 1.0], [8.0, 8.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 4.0], [10.0, 4.0], [10.0, 0.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[0.0, 1.0], [0.0, 10.0], [3.0, 10.0], [3.0, 1.0], [0.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 1.0], [1.0, 1.0],], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[10.0,  10.0], [0.0,  0.0], [0.0,  -10.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.0,  1.5], [1.0,  3.0]]), LineString([[2.0,  4.0], [100.0,  4.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLinearRing.overlaps(lineString1))
        XCTAssertTrue(testLinearRing.overlaps(lineString2))
        XCTAssertTrue(testLinearRing.overlaps(linearRing1))
        XCTAssertTrue(testLinearRing.overlaps(linearRing2))
        XCTAssertTrue(testLinearRing.overlaps(multiLineString1))
        XCTAssertTrue(testLinearRing.overlaps(multiLineString2))
    }

    func testOverlapsFalse() {
        let testLinearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 4.0, y: 4.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 1.0, y: 6.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[0.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[2.0, 4.0], [4.0, 4.0], [4.0, 1.0]], precision: precision, coordinateSystem: cs)
        let lineString3 = LineString([[2.0, 2.0], [2.0, 3.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[-2.0, 2.0], [-2.0, 5.0], [0.0, 5.0], [0.0, 2.0], [-2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[4.0,  8.0], [4.0,  4.0], [10.0,  4.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[2.0,  2.0], [1.0,  3.0]]), LineString([[4.0,  1.0], [100.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[26.0, 1.0], [21.0, 1.0], [21.0, 3.0], [23.5, 4.0], [26.0, 3.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 5.0], [10.0, 5.0], [10.0, 10.0], [5.0, 10.0], [5.0, 5.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[-2.0, -2.0], [-2.0, 1000.0], [1000.0, 1000.0], [1000.0, -2.0], [-2.0, -2.0]], innerRings: [[[0.0, 0.0], [100.0, 0.0], [100.0, 100.0], [0.0, 100.0], [0.0, 0.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[26.0, 1.0], [21.0, 1.0], [21.0, 3.0], [23.5, 4.0], [26.0, 3.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 1.0], [1.0, 1.0]], innerRings: []), Polygon([[0.0, 50.0], [110.0, 50.0], [110.0, 100.0], [0.0, 100.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[26.0, 1.0], [21.0, 1.0], [21.0, 6.0], [23.5, 26.0], [26.0, 6.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]]), Polygon([[-2.0, -2.0], [-2.0, 1000.0], [1000.0, 1000.0], [1000.0, -2.0], [-2.0, -2.0]], innerRings: [[[0.0, 0.0], [100.0, 0.0], [100.0, 100.0], [0.0, 100.0], [0.0, 0.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLinearRing.overlaps(point1))
        XCTAssertFalse(testLinearRing.overlaps(point2))
        XCTAssertFalse(testLinearRing.overlaps(multiPoint1))
        XCTAssertFalse(testLinearRing.overlaps(multiPoint2))
        XCTAssertFalse(testLinearRing.overlaps(lineString1))
        XCTAssertFalse(testLinearRing.overlaps(lineString2))
        XCTAssertFalse(testLinearRing.overlaps(lineString3))
        XCTAssertFalse(testLinearRing.overlaps(linearRing1))
        XCTAssertFalse(testLinearRing.overlaps(linearRing2))
        XCTAssertFalse(testLinearRing.overlaps(multiLineString1))
        XCTAssertFalse(testLinearRing.overlaps(multiLineString2))
        XCTAssertFalse(testLinearRing.overlaps(polygon1))
        XCTAssertFalse(testLinearRing.overlaps(polygon2))
        XCTAssertFalse(testLinearRing.overlaps(polygon3))
        XCTAssertFalse(testLinearRing.overlaps(multiPolygon1))
        XCTAssertFalse(testLinearRing.overlaps(multiPolygon2))
        XCTAssertFalse(testLinearRing.overlaps(multiPolygon3))
    }
}
