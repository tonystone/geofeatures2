///
///  LineString+GeometryTests.swift
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

// MARK: - Coordinate 2D, FloatingPrecision, Cartesian -

class LineStringGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    // MARK: - Dimension

    func testDimension () {
        XCTAssertEqual(LineString([[1.0, 1.0]], precision: precision, coordinateSystem: cs).dimension, .one)
    }

    func testDimensionEmpty () {
        XCTAssertEqual(LineString(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    // MARK: - Boundary

    func testBoundaryWith1ElementInvalid() {
        let input = LineString([[1.0, 1.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith2Element() {
        let input = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint([Point([1.0, 1.0]), Point([2.0, 2.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith3ElementOpen() {
        let input = LineString([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint([Point([1.0, 1.0]), Point([3.0, 3.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith4ElementClosed() {
        let input = LineString([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = LineString(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    // MARK: - Bounds

    func testBoundsEmpty() {
        let input = LineString(precision: precision, coordinateSystem: cs)
        let expected: Bounds? = nil

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBoundsWithElements() {
        let input = LineString([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 1.0, y: 1.0), max: (x: 3.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    // MARK: - Equal

    func testEqualTrue() {
        let input1 = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let input2 = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point([1.0, 1.0], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }

    func testDisjointTrue() {
        let testLineString = LineString([[21.0, 21.0], [22.0, 22.0], [22.0, 24.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  -23.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLineString.disjoint(point))
        XCTAssertTrue(testLineString.disjoint(multiPoint))
        XCTAssertTrue(testLineString.disjoint(lineString))
        XCTAssertTrue(testLineString.disjoint(linearRing))
        XCTAssertTrue(testLineString.disjoint(multiLineString))
        XCTAssertTrue(testLineString.disjoint(polygon))
        XCTAssertTrue(testLineString.disjoint(multiPolygon))
    }

    func testDisjointFalse() {
        let testLineString = LineString([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  3.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLineString.disjoint(point))
        XCTAssertFalse(testLineString.disjoint(multiPoint))
        XCTAssertFalse(testLineString.disjoint(lineString))
        XCTAssertFalse(testLineString.disjoint(linearRing))
        XCTAssertFalse(testLineString.disjoint(multiLineString))
        XCTAssertFalse(testLineString.disjoint(polygon))
        XCTAssertFalse(testLineString.disjoint(multiPolygon))
    }

    func testIntersectsTrue() {
        let testLineString = LineString([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLineString.intersects(point))
        XCTAssertTrue(testLineString.intersects(multiPoint))
        XCTAssertTrue(testLineString.intersects(lineString))
        XCTAssertTrue(testLineString.intersects(linearRing))
        XCTAssertTrue(testLineString.intersects(multiLineString))
        XCTAssertTrue(testLineString.intersects(polygon))
        XCTAssertTrue(testLineString.intersects(multiPolygon))
    }

    func testIntersectsFalse() {
        let testLineString = LineString([[31.0, 1.0], [32.0, 2.0], [32.0, 4.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 11.0, y: 1.0)), Point(Coordinate(x: 12.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[11.0, 1.0], [12.0, 2.0], [12.0, 4.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLineString.intersects(point))
        XCTAssertFalse(testLineString.intersects(multiPoint))
        XCTAssertFalse(testLineString.intersects(lineString))
        XCTAssertFalse(testLineString.intersects(linearRing))
        XCTAssertFalse(testLineString.intersects(multiLineString))
        XCTAssertFalse(testLineString.intersects(polygon))
        XCTAssertFalse(testLineString.intersects(multiPolygon))
    }

    func testTouchesTrue() {
        let testLineString = LineString([[1.0, 1.0], [1.0, 6.0], [2.0, 6.0]], precision: precision, coordinateSystem: cs)

        let lineString = LineString([[1.0, 1.0], [1.5, 1.5]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLineString.touches(lineString))
        XCTAssertTrue(testLineString.touches(multiLineString))
        XCTAssertTrue(testLineString.touches(polygon))
        XCTAssertTrue(testLineString.touches(multiPolygon))
    }

    func testTouchesFalse() {
        let testLineString = LineString([[50.0, 150.0], [150.0, 50.0], [200.0, 50.0]], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [200.0, 200.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[1.0, 1.0], [2.0, 2.0], [300.0, 300.0], [300.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 110.0], [110.0, 110.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLineString.touches(point1))
        XCTAssertFalse(testLineString.touches(point2))
        XCTAssertFalse(testLineString.touches(multiPoint1))
        XCTAssertFalse(testLineString.touches(multiPoint2))
        XCTAssertFalse(testLineString.touches(lineString1))
        XCTAssertFalse(testLineString.touches(lineString2))
        XCTAssertFalse(testLineString.touches(linearRing1))
        XCTAssertFalse(testLineString.touches(linearRing2))
        XCTAssertFalse(testLineString.touches(multiLineString1))
        XCTAssertFalse(testLineString.touches(multiLineString2))
        XCTAssertFalse(testLineString.touches(polygon1))
        XCTAssertFalse(testLineString.touches(polygon2))
        XCTAssertFalse(testLineString.touches(multiPolygon1))
        XCTAssertFalse(testLineString.touches(multiPolygon2))
    }

    func testCrossesTrue() {
        let testLineString = LineString([[1.0, 1.0], [1.0, 6.0], [6.0, 6.0]], precision: precision, coordinateSystem: cs)

        let multiPoint = MultiPoint([Point(Coordinate(x: 11.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 6.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[0.0, 1.0], [6.0, 7.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[0.0, 2.0], [0.0, 8.0], [4.0, 8.0], [4.0, 2.0], [0.0, 2.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [0.5,  0.5]]), LineString([[1.0,  1.0], [3.0,  3.0]]), LineString([[5.0,  5.0], [5.0,  8.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLineString.crosses(multiPoint))
        XCTAssertTrue(testLineString.crosses(lineString))
        XCTAssertTrue(testLineString.crosses(linearRing))
        XCTAssertTrue(testLineString.crosses(multiLineString))
    }

    func testCrossesFalse() {
        let testLineString = LineString([[1.0, 1.0], [1.0, 6.0], [6.0, 6.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let multiPoint3 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.0, 1.5]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [200.0, 200.0]], precision: precision, coordinateSystem: cs)
        let lineString3 = LineString([[0.0, 1.0], [0.0, 200.0], [200.0, 200.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[-1.0, 1.0], [-2.0, 2.0], [-3.0, 3.0], [-3.0, 1.0], [-1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[1.0, 1.0], [1.0, 2.0], [300.0, 300.0], [300.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[0.0,  3.0], [1.0,  1.0], [0.0,  0.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString3 = MultiLineString([LineString([[0.0,  0.0], [0.0,  1.0]]), LineString([[1.5,  -1.5], [3.0,  -3.0]]), LineString([[6.0,  -6.0], [700.0,  -700.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [2.0, 1.0], [2.0, 1.5], [1.0, 1.5], [1.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [2.0, 1.0], [2.0, 2.0], [1.0, 2.0], [1.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [6.0, 1.0], [6.0, 6.0], [1.0, 6.0], [1.0, 1.0]]]), Polygon([[1.0, 1.0], [6.0, 1.0], [6.0, 6.0], [1.0, 6.0], [1.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[-4.0, 1.0], [-9.0, 1.0], [-9.0, 6.0], [-6.5, 6.0], [-4.0, 6.0], [-4.0, 1.0]], innerRings: [[[-5.0, 2.0], [-5.0, 3.0], [-6.5, 3.5], [-8.0, 3.0], [-8.0, 2.0], [-5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 80.0], [30.0, 80.0], [30.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 11.0], [2.0, 11.0], [2.0, 12.0], [1.0, 12.0], [1.0, 11.0]]], precision: precision, coordinateSystem: cs), Polygon([[0.0, 250.0], [0.0, 280.0], [110.0, 280.0], [110.0, 250.0], [0.0, 250.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLineString.crosses(point1))
        XCTAssertFalse(testLineString.crosses(point2))
        XCTAssertFalse(testLineString.crosses(multiPoint1))
        XCTAssertFalse(testLineString.crosses(multiPoint2))
        XCTAssertFalse(testLineString.crosses(multiPoint3))
        XCTAssertFalse(testLineString.crosses(lineString1))
        XCTAssertFalse(testLineString.crosses(lineString2))
        XCTAssertFalse(testLineString.crosses(lineString3))
        XCTAssertFalse(testLineString.crosses(linearRing1))
        XCTAssertFalse(testLineString.crosses(linearRing2))
        XCTAssertFalse(testLineString.crosses(multiLineString1))
        XCTAssertFalse(testLineString.crosses(multiLineString2))
        XCTAssertFalse(testLineString.crosses(multiLineString3))
        XCTAssertFalse(testLineString.crosses(polygon1))
        XCTAssertFalse(testLineString.crosses(polygon2))
        XCTAssertFalse(testLineString.crosses(polygon3))
        XCTAssertFalse(testLineString.crosses(multiPolygon1))
        XCTAssertFalse(testLineString.crosses(multiPolygon2))
        XCTAssertFalse(testLineString.crosses(multiPolygon3))
    }

    func testWithinTrue() {
        let testLineString = LineString([[1.2, 1.2], [2.0, 2.0]], precision: precision, coordinateSystem: cs)

        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.2,  1.2], [2.0,  2.0], [2.0,  4.0]]), LineString([[-10.0,  10.0], [0.0,  0.0], [1.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[6.0, 0.0], [0.0, 0.0], [0.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[26.0, 21.0], [21.0, 21.0], [21.0, 26.0], [23.5, 26.0], [26.0, 26.0], [26.0, 21.0]], innerRings: [[[25.0, 22.0], [25.0, 23.0], [23.5, 23.5], [22.0, 23.0], [22.0, 22.0], [25.0, 22.0]]]), Polygon([[10.0, 0.0], [0.0, 0.0], [0.0, 10.0], [10.0, 10.0], [10.0, 0.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[26.0, 21.0], [21.0, 21.0], [21.0, 26.0], [23.5, 26.0], [26.0, 26.0], [26.0, 21.0]], innerRings: [[[25.0, 22.0], [25.0, 23.0], [23.5, 23.5], [22.0, 23.0], [22.0, 22.0], [25.0, 22.0]]]), Polygon([[1.0, 1.0], [1.0, 2.0], [2.0, 2.0], [2.0, 1.0], [1.0, 1.0]], innerRings: [[[1.6, 1.7], [1.6, 1.8], [1.5, 1.8], [1.5, 1.7], [1.6, 1.7]]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLineString.within(lineString))
        XCTAssertTrue(testLineString.within(linearRing))
        XCTAssertTrue(testLineString.within(multiLineString))
        XCTAssertTrue(testLineString.within(polygon1))
        XCTAssertTrue(testLineString.within(polygon2))
        XCTAssertTrue(testLineString.within(multiPolygon1))
        XCTAssertTrue(testLineString.within(multiPolygon2))
    }

    func testWithinFalse() {
        let testLineString = LineString([[1.0, 1.0], [1.0, 6.0], [6.0, 6.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)

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

        XCTAssertFalse(testLineString.within(point))
        XCTAssertFalse(testLineString.within(multiPoint))
        XCTAssertFalse(testLineString.within(lineString1))
        XCTAssertFalse(testLineString.within(lineString2))
        XCTAssertFalse(testLineString.within(linearRing))
        XCTAssertFalse(testLineString.within(multiLineString1))
        XCTAssertFalse(testLineString.within(multiLineString2))
        XCTAssertFalse(testLineString.within(polygon1))
        XCTAssertFalse(testLineString.within(polygon2))
        XCTAssertFalse(testLineString.within(polygon3))
        XCTAssertFalse(testLineString.within(multiPolygon1))
        XCTAssertFalse(testLineString.within(multiPolygon2))
        XCTAssertFalse(testLineString.within(multiPolygon3))
        XCTAssertFalse(testLineString.within(multiPolygon4))
    }

    func testContainsTrue() {
        let testLineString = LineString([[1.0, 1.0], [1.0, 6.0], [6.0, 6.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.0, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.5))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 6.0)), Point(Coordinate(x: 6.0, y: 6.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[2.0, 6.0], [3.5, 6.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[6.0, 6.0], [1.0, 6.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 6.0], [6.0, 6.0], [1.0, 6.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  1.0], [1.0,  3.0], [1.0,  5.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[5.0,  6.0], [4.0,  6.0]]), LineString([[2.0,  6.0], [3.0,  6.0]]), LineString([[1.0,  5.0], [1.0,  2.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLineString.contains(point))
        XCTAssertTrue(testLineString.contains(multiPoint1))
        XCTAssertTrue(testLineString.contains(multiPoint2))
        XCTAssertTrue(testLineString.contains(lineString1))
        XCTAssertTrue(testLineString.contains(lineString2))
        XCTAssertTrue(testLineString.contains(linearRing))
        XCTAssertTrue(testLineString.contains(multiLineString1))
        XCTAssertTrue(testLineString.contains(multiLineString2))
    }

    func testContainsFalse() {
        let testLineString = LineString([[1.0, 1.0], [1.0, 6.0], [6.0, 6.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.0, 8.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[0.0, 6.0], [6.0, 6.0], [4.0, 6.0], [0.0, 6.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  0.0], [1.0,  6.0], [10.0,  6.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 8.0], [3.5, 8.0], [3.5, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[100.0, 0.0], [0.0, 0.0], [0.0, 40.0], [100.0, 40.0], [100.0, 0.0]], innerRings: [[[0.5, 0.5], [20.0, 0.5], [20.0, 10.0], [0.5, 10.0], [0.5, 0.5]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLineString.contains(point))
        XCTAssertFalse(testLineString.contains(multiPoint1))
        XCTAssertFalse(testLineString.contains(multiPoint2))
        XCTAssertFalse(testLineString.contains(lineString1))
        XCTAssertFalse(testLineString.contains(lineString2))
        XCTAssertFalse(testLineString.contains(linearRing1))
        XCTAssertFalse(testLineString.contains(linearRing2))
        XCTAssertFalse(testLineString.contains(multiLineString1))
        XCTAssertFalse(testLineString.contains(multiLineString2))
        XCTAssertFalse(testLineString.contains(polygon1))
        XCTAssertFalse(testLineString.contains(polygon2))
        XCTAssertFalse(testLineString.contains(multiPolygon1))
        XCTAssertFalse(testLineString.contains(multiPolygon2))
    }

    func testOverlapsTrue() {
        /// Overlaps can only be true for geometries of the same dimension, and each geometry must have points exterior to the other, and the interiors must touch.
        let testLineString = LineString([[1.0, 1.0], [1.0, 6.0], [6.0, 6.0]], precision: precision, coordinateSystem: cs)

        let lineString1 = LineString([[1.0, 1.0], [1.0, 8.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[4.0, 6.0], [1.0, 6.0], [1.0, 0.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 3.0], [-1.0, 3.0], [-1.0, 6.0], [1.0, 6.0], [1.0, 3.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[1.0, 3.0], [1.0, 6.0], [4.0, 6.0], [4.0, 3.0], [4.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0, 0.0], [1.0, 6.0], [10.0, 10.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.0, 1.5], [1.0, 3.0]]), LineString([[6.0, 6.0], [100.0, 100.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLineString.overlaps(lineString1))
        XCTAssertTrue(testLineString.overlaps(lineString2))
        XCTAssertTrue(testLineString.overlaps(linearRing1))
        XCTAssertTrue(testLineString.overlaps(linearRing2))
        XCTAssertTrue(testLineString.overlaps(multiLineString1))
        XCTAssertTrue(testLineString.overlaps(multiLineString2))
    }

    func testOverlapsFalse() {
        let testLineString = LineString([[1.0, 1.0], [1.0, 6.0], [6.0, 6.0]], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 6.0, y: 6.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 1.0, y: 6.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [6.0, 6.0]], precision: precision, coordinateSystem: cs)
        let lineString3 = LineString([[2.0, 2.0], [3.0, 3.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[-2.0, 2.0], [-2.0, 5.0], [0.0, 5.0], [0.0, 2.0], [-2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[0.0, 1.0], [0.0, 100.0], [100.0, 100.0], [100.0, 1.0], [0.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[2.0, 4.0], [2.0, 2.0], [3.0, 3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0, 0.0], [1.0, 1.0]]), LineString([[1.5, 1.5], [3.0, 3.0]]), LineString([[6.0, 6.0], [100.0, 100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[2.0, 2.0], [2.0, 1000.0], [1000.0, 1000.0], [1000.0, 2.0], [2.0, 2.0]], innerRings: [[[5.0, 5.0], [100.0, 5.0], [100.0, 100.0], [5.0, 100.0], [5.0, 5.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [110.0, 50.0], [110.0, 100.0], [0.0, 100.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [100.0, 25.0], [100.0, 100.0], [5.0, 100.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLineString.overlaps(point1))
        XCTAssertFalse(testLineString.overlaps(point2))
        XCTAssertFalse(testLineString.overlaps(multiPoint1))
        XCTAssertFalse(testLineString.overlaps(multiPoint2))
        XCTAssertFalse(testLineString.overlaps(lineString1))
        XCTAssertFalse(testLineString.overlaps(lineString2))
        XCTAssertFalse(testLineString.overlaps(lineString3))
        XCTAssertFalse(testLineString.overlaps(linearRing1))
        XCTAssertFalse(testLineString.overlaps(linearRing2))
        XCTAssertFalse(testLineString.overlaps(multiLineString1))
        XCTAssertFalse(testLineString.overlaps(multiLineString2))
        XCTAssertFalse(testLineString.overlaps(polygon1))
        XCTAssertFalse(testLineString.overlaps(polygon2))
        XCTAssertFalse(testLineString.overlaps(polygon3))
        XCTAssertFalse(testLineString.overlaps(multiPolygon1))
        XCTAssertFalse(testLineString.overlaps(multiPolygon2))
        XCTAssertFalse(testLineString.overlaps(multiPolygon3))
    }

    func testCoversTrue() {
        let testLineString = LineString([[1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 12.0, y: 12.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[100.0, 100.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[50.0, 50.0], [61.0, 61.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[100.0, 100.0], [1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[100.0, 100.0], [1.0, 1.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[100.0, 100.0], [80.0, 80.0]]), LineString([[70.0, 70.0], [40.0, 40.0], [30.0, 30.0]]), LineString([[1.0, 1.0], [2.0,  2.0], [3.0, 3.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLineString.covers(point))
        XCTAssertTrue(testLineString.covers(multiPoint1))
        XCTAssertTrue(testLineString.covers(multiPoint2))
        XCTAssertTrue(testLineString.covers(lineString1))
        XCTAssertTrue(testLineString.covers(lineString2))
        XCTAssertTrue(testLineString.covers(linearRing))
        XCTAssertTrue(testLineString.covers(multiLineString1))
        XCTAssertTrue(testLineString.covers(multiLineString2))
    }

    func testCoversFalse() {
        let testLineString = LineString([[1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 101.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 105.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[100.0, 100.0], [100.0, 101.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[100.0, 100.0], [100.0, 101.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[100.0, 100.0], [100.0, 101.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[100.0, 100.0], [90.0, 90.0]]), LineString([[100.0, 100.0], [100.0, 101.0]]), LineString([[1.0, 1.0], [2.0, 2.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[100.0, 100.0], [100.0, 101.0], [101.0, 101.0], [101.0, 100.0], [100.0, 100.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLineString.covers(point))
        XCTAssertFalse(testLineString.covers(multiPoint1))
        XCTAssertFalse(testLineString.covers(multiPoint2))
        XCTAssertFalse(testLineString.covers(lineString))
        XCTAssertFalse(testLineString.covers(linearRing))
        XCTAssertFalse(testLineString.covers(multiLineString1))
        XCTAssertFalse(testLineString.covers(multiLineString2))
        XCTAssertFalse(testLineString.covers(polygon))
        XCTAssertFalse(testLineString.covers(multiPolygon))
    }

    func testCoveredByTrue() {
        let testLineString = LineString([[1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)

        let lineString = LineString([[0.0, 0.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[-200.0, -200.0], [200.0, 200.0], [200.0, -200.0], [-200.0, -200.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[200.0, 200.0], [0.0, 0.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[1000.0, 100.0], [1000.0, 200.0]]), LineString([[0.0, 0.0], [500.0, 0.0], [500.0, 500.0], [0.5, 0.5]]), LineString([[0.0, 0.0], [-100.0, -100.0], [-100.0, -500.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[0.0, 0.0], [0.0, 200.0], [200.0, 200.0], [200.0, 0.0], [0.0, 0.0]], innerRings: [[[80.0, 10.0], [90.0, 10.0], [90.0, 20.0], [80.0, 20.0], [80.0, 10.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[-10.0, 10.0], [-50.0, 10.0], [-50.0, 50.0], [-10.0, 50.0], [-10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[1000.0, 1.0], [1.0, 1.0], [1.0, 200.0], [1000.0, 200.0], [1000.0, 1.0]], innerRings: []), Polygon([[0.0, 0.0], [0.0, 0.5], [0.5, 0.5], [0.5, 0.0], [0.0, 0.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLineString.coveredby(lineString))
        XCTAssertTrue(testLineString.coveredby(linearRing))
        XCTAssertTrue(testLineString.coveredby(multiLineString1))
        XCTAssertTrue(testLineString.coveredby(multiLineString2))
        XCTAssertTrue(testLineString.coveredby(polygon))
        XCTAssertTrue(testLineString.coveredby(multiPolygon))
    }

    func testCoveredByFalse() {
        let testLineString = LineString([[1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 100.0, y: 100.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 101.0, y: 100.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 100.0, y: 100.0)), Point(Coordinate(x: 50.0, y: 50.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[102.0, 102.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[102.0, 102.0], [102.0, 2.0], [2.0, 2.0], [102.0, 102.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[10.0, 10.0], [10.0, 11.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[1.0, 1.0], [1.0, -1.0]]), LineString([[100.0, 1000.0], [100.0, 100.0], [1.5, 1.5]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[1000.0, 1000.0], [1000.0, 1001.0], [1001.0, 1001.0], [1001.0, 100.0], [1000.0, 1000.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[10.0, 10.0], [10.0, 50.0], [50.0, 50.0], [50.0, 10.0], [10.0, 10.0]], innerRings: []), Polygon([[40.0, -40.0], [80.0, -40.0], [80.0, -80.0], [40.0, -80.0], [40.0, -40.0]], innerRings: [[[70.0, -70.0], [70.0, -50.0], [50.0, -50.0], [50.0, -70.0], [70.0, -70.0]]]), Polygon([[1000.0, 100.0], [100.0, 100.0], [100.0, 200.0], [1000.0, 200.0], [1000.0, 100.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLineString.coveredby(point))
        XCTAssertFalse(testLineString.coveredby(multiPoint1))
        XCTAssertFalse(testLineString.coveredby(multiPoint2))
        XCTAssertFalse(testLineString.coveredby(lineString))
        XCTAssertFalse(testLineString.coveredby(linearRing))
        XCTAssertFalse(testLineString.coveredby(multiLineString1))
        XCTAssertFalse(testLineString.coveredby(multiLineString2))
        XCTAssertFalse(testLineString.coveredby(polygon))
        XCTAssertFalse(testLineString.coveredby(multiPolygon))
    }

    func testValidTrue() {
        /// Empty case
        let testLineString1 = LineString([], precision: precision, coordinateSystem: cs)
        /// Two coordinates
        let testLineString2 = LineString([[102.0, 102.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        /// Repeating coordinates
        let testLineString3 = LineString([[1.0, 1.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        /// Normal line string with five coordinates
        let testLineString4 = LineString([[1.0, 1.0], [2.0, 2.0], [2.0, 4.0], [4.0, 4.0], [4.0, 20.0]], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testLineString1.valid())
        XCTAssertTrue(testLineString2.valid())
        XCTAssertTrue(testLineString3.valid())
        XCTAssertTrue(testLineString4.valid())
    }

    func testValidFalse() {
        let x1 = 0.0
        let y1 = x1 * .infinity // y1 is a NaN

        let x2 = Double.nan
        let y2 = 4.0

        /// Only one coordinate
        let testLineString1 = LineString([[-102.0, 102.0]], precision: precision, coordinateSystem: cs)
        /// Only one coordinate but repeated multiple times
        let testLineString2 = LineString([[2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        /// Invalid coordinate
        let testLineString3 = LineString([[1.0, 1.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], [2.0, 2.0], Coordinate(x: x1, y: y1)], precision: precision, coordinateSystem: cs)
        /// Invalid coordinate
        let testLineString4 = LineString([[1.0, 1.0], [2.0, 2.0], Coordinate(x: x2, y: y2), [2.0, 4.0], [4.0, 4.0], [4.0, 20.0]], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testLineString1.valid())
        XCTAssertFalse(testLineString2.valid())
        XCTAssertFalse(testLineString3.valid())
        XCTAssertFalse(testLineString4.valid())
    }
}
