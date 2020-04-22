///
///  MultiLineString+GeometryTests.swift
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

class MultiLineStringGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    // MARK: Dimension Tests

    func testDimension () {
        XCTAssertEqual(MultiLineString([LineString([[1.0,  1.0]])],precision: precision, coordinateSystem: cs).dimension, .one)
    }

    func testDimensionEmpty () {
        XCTAssertEqual(MultiLineString(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    // MARK: Boundary Tests

    func testBoundaryWith1ElementInvalid() {
        let input    = MultiLineString([LineString([[1.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith2Element() {
        let input    = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint([Point([1.0,  1.0]), Point([2.0,  2.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith3ElementOpen() {
        let input    = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint([Point([1.0,  1.0]), Point([3.0,  3.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith4ElementClosed() {
        let input    = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0], [1.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith2EqualPoints() {
        let input    = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0]]), LineString([[1.0,  1.0], [3.0,  3.0]]), LineString([[1.0,  1.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint([Point([1.0,  1.0]), Point([2.0,  2.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input    = MultiLineString(precision: precision, coordinateSystem: cs)
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithOGCMultiCurveA() {
        let input = MultiLineString([LineString([[1.00,  1.0], [2.0,  2.0], [1.5,  3.0], [2.25,  4.0]]),
                                               LineString([[2.25,  4.0], [3.0,  3.0], [2.5,  2.0], [2.50,  1.5]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint([Point([1.0,  1.0]), Point([2.5,  1.5])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithOGCMultiCurveB() {
        let input = MultiLineString([LineString([[1.00,  1.0], [2.25,  4.0], [2.5,  3.0], [1.25,  3.5]]),
                                               LineString([[10.0,  10.0], [20.0,  20.0], [30.0,  30.0], [10.0,  10.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint([Point([1.0,  1.0]), Point([1.25,  3.5])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithOGCMultiCurveC() {
        let input = MultiLineString([LineString([[1.5,  3.0], [1.0,  4.0], [2.5,  3.5], [1.5,  3.0]]),
                                               LineString([[1.0,  1.0], [0.5,  2.0], [2.5,  3.5], [3.0,  1.5], [1.0,  1.0]])], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithOddIntersection() {
        let input = MultiLineString([LineString([[1.00,  1.0], [2.0,  2.0], [1.5,  3.0], [2.25,  4.0]]),
                                               LineString([[2.25,  4.0], [3.0,  3.0], [2.5,  2.0], [2.50,  1.5]]),
                                               LineString([[2.25,  4.0], [3.0,  5.0], [2.5,  5.0], [2.50,  6.0]])], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint([Point([1.0,  1.0]), Point([2.25,  4.0]), Point([2.5,  1.5]), Point([2.5,  6.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    // MARK: Bounds 

    func testBoundsEmpty() {
        let input = MultiLineString(precision: precision, coordinateSystem: cs)
        let expected: Bounds? = nil

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBoundsWithElements() {
        let input = MultiLineString([LineString([[1.00,  1.0], [2.0,  2.0], [1.5,  3.0], [2.25,  4.0]]),
                                               LineString([[2.25,  4.0], [3.0,  3.0], [2.5,  2.0], [2.50,  1.5]]),
                                               LineString([[2.25,  4.0], [3.0,  5.0], [2.5,  5.0], [2.50,  6.0]])], precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 1.0, y: 1.0), max: (x: 3.0, y: 6.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    // MARK: Boundary Tests

    func testEqualTrue() {
        let input1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0]]), LineString([[3.0,  3.0], [4.0,  4.0]])], precision: precision, coordinateSystem: cs)
        let input2 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0]]), LineString([[3.0,  3.0], [4.0,  4.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0]]), LineString([[3.0,  3.0], [4.0,  4.0]])], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = LineString([[1.0,  1.0], [2.0,  2.0]], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }

    // MARK: Disjoint

    func testDisjointTrue() {
        let testMultiLineString = MultiLineString([LineString([[20.0,  0.0], [21.0,  1.0]]), LineString([[21.5,  1.5], [23.0,  3.0]]), LineString([[26.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [1.0, 3.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  -23.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiLineString.disjoint(point))
        XCTAssertTrue(testMultiLineString.disjoint(multiPoint))
        XCTAssertTrue(testMultiLineString.disjoint(lineString))
        XCTAssertTrue(testMultiLineString.disjoint(linearRing))
        XCTAssertTrue(testMultiLineString.disjoint(multiLineString))
        XCTAssertTrue(testMultiLineString.disjoint(polygon))
        XCTAssertTrue(testMultiLineString.disjoint(multiPolygon))
    }

    func testDisjointFalse() {
        let testMultiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [1.0, 3.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[1.0,  3.0], [2.0,  2.0], [3.0,  3.0]]), LineString([[-1.0,  3.0], [-2.0,  2.0], [-3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiLineString.disjoint(point))
        XCTAssertFalse(testMultiLineString.disjoint(multiPoint))
        XCTAssertFalse(testMultiLineString.disjoint(lineString))
        XCTAssertFalse(testMultiLineString.disjoint(linearRing))
        XCTAssertFalse(testMultiLineString.disjoint(multiLineString))
        XCTAssertFalse(testMultiLineString.disjoint(polygon))
        XCTAssertFalse(testMultiLineString.disjoint(multiPolygon))
    }

    // MARK: Intersects

    func testIntersectsTrue() {
        let testMultiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [1.0, 3.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.5, 1.5], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.6, 1.6], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiLineString.intersects(point))
        XCTAssertTrue(testMultiLineString.intersects(multiPoint))
        XCTAssertTrue(testMultiLineString.intersects(lineString))
        XCTAssertTrue(testMultiLineString.intersects(linearRing))
        XCTAssertTrue(testMultiLineString.intersects(multiLineString))
        XCTAssertTrue(testMultiLineString.intersects(polygon))
        XCTAssertTrue(testMultiLineString.intersects(multiPolygon))
    }

    func testIntersectsFalse() {
        let testMultiLineString = MultiLineString([LineString([[20.0,  0.0], [21.0,  1.0]]), LineString([[21.5,  1.5], [23.0,  3.0]]), LineString([[26.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 11.0, y: 1.0)), Point(Coordinate(x: 12.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[11.0, 1.0], [12.0, 2.0], [12.0, 4.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [1.0, 3.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [7.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiLineString.intersects(point))
        XCTAssertFalse(testMultiLineString.intersects(multiPoint))
        XCTAssertFalse(testMultiLineString.intersects(lineString))
        XCTAssertFalse(testMultiLineString.intersects(linearRing))
        XCTAssertFalse(testMultiLineString.intersects(multiLineString))
        XCTAssertFalse(testMultiLineString.intersects(polygon))
        XCTAssertFalse(testMultiLineString.intersects(multiPolygon))
    }

    // MARK: Touches

    func testTouchesTrue() {
        let testMultiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 700.0, y: 700.0)), Point(Coordinate(x: 700.0, y: 1000.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[1.0, 1.0], [1.5, 1.5]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [1.0, 3.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [0.0,  1.0]]), LineString([[1.5,  1.5], [1.5,  3.0]]), LineString([[6.0,  6.0], [6.0,  7.0]])], precision: precision, coordinateSystem: cs)
        let polygon = Polygon([[6.0, 6.0], [6.0, 3.0], [3.0, 3.0], [3.0, 6.0], [6.0, 6.0]], innerRings: [[[5.0, 4.0], [5.0, 5.0], [4.0, 5.0], [4.0, 4.0], [5.0, 4.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon = MultiPolygon([Polygon([[6.0, 6.0], [6.0, 3.0], [3.0, 3.0], [3.0, 6.0], [6.0, 6.0]], innerRings: [[[5.0, 4.0], [5.0, 5.0], [4.0, 5.0], [4.0, 4.0], [5.0, 4.0]]], precision: precision, coordinateSystem: cs), Polygon([[4.0, 6.0], [4.0, 8.0], [6.0, 8.0], [6.0, 6.0], [4.0, 6.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiLineString.touches(point))
        XCTAssertTrue(testMultiLineString.touches(multiPoint))
        XCTAssertTrue(testMultiLineString.touches(lineString))
        XCTAssertTrue(testMultiLineString.touches(linearRing))
        XCTAssertTrue(testMultiLineString.touches(multiLineString))
        XCTAssertTrue(testMultiLineString.touches(polygon))
        XCTAssertTrue(testMultiLineString.touches(multiPolygon))
    }

    func testTouchesFalse() {
        let testMultiLineString = MultiLineString([LineString([[20.0,  0.0], [21.0,  1.0]]), LineString([[21.5,  1.5], [23.0,  3.0]]), LineString([[26.0,  26.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

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

        XCTAssertFalse(testMultiLineString.touches(point1))
        XCTAssertFalse(testMultiLineString.touches(point2))
        XCTAssertFalse(testMultiLineString.touches(multiPoint1))
        XCTAssertFalse(testMultiLineString.touches(multiPoint2))
        XCTAssertFalse(testMultiLineString.touches(lineString1))
        XCTAssertFalse(testMultiLineString.touches(lineString2))
        XCTAssertFalse(testMultiLineString.touches(linearRing1))
        XCTAssertFalse(testMultiLineString.touches(linearRing2))
        XCTAssertFalse(testMultiLineString.touches(multiLineString1))
        XCTAssertFalse(testMultiLineString.touches(multiLineString2))
        XCTAssertFalse(testMultiLineString.touches(polygon1))
        XCTAssertFalse(testMultiLineString.touches(polygon2))
        XCTAssertFalse(testMultiLineString.touches(multiPolygon1))
        XCTAssertFalse(testMultiLineString.touches(multiPolygon2))
    }

    // MARK: Crosses

    func testCrossesTrue() {
        let testMultiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 2.0, y: 2.0), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 11.0, y: 11.0)), Point(Coordinate(x: 22.0, y: 22.0)), Point(Coordinate(x: 22.0, y: 21.0))], precision: precision, coordinateSystem: cs)
        let lineString = LineString([[6.0, 8.0], [10.0, 4.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[0.0, 2.0], [0.0, 8.0], [4.0, 8.0], [4.0, 2.0], [0.0, 2.0]], precision: precision, coordinateSystem: cs)
        let multiLineString = MultiLineString([LineString([[0.0,  0.0], [0.0,  0.5]]), LineString([[1.5,  2.0], [3.0,  2.0]]), LineString([[5.0,  5.0], [5.0,  8.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiLineString.crosses(point))
        XCTAssertTrue(testMultiLineString.crosses(multiPoint))
        XCTAssertTrue(testMultiLineString.crosses(lineString))
        XCTAssertTrue(testMultiLineString.crosses(linearRing))
        XCTAssertTrue(testMultiLineString.crosses(multiLineString))
    }

    func testCrossesFalse() {
        let testMultiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 700.0, y: 700.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 3.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let multiPoint3 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 6.0, y: 6.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.0, 1.5]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [1.0, 200.0]], precision: precision, coordinateSystem: cs)
        let lineString3 = LineString([[0.0, 1.0], [0.0, 200.0], [100.0, 200.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[-1.0, 1.0], [-2.0, 2.0], [-3.0, 3.0], [-3.0, 1.0], [-1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[1.0, 100.0], [1.0, 300.0], [50.0, 300.0], [50.0, 100.0], [1.0, 100.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[0.0,  2.0], [1.0,  1.0], [1.0,  2.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  8.0], [1.0,  8.0]]), LineString([[1.5,  8.0], [3.0,  8.0]]), LineString([[6.0,  8.0], [6.0,  700.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString3 = MultiLineString([LineString([[-1.0,  1.0], [3.0,  -3.0]]), LineString([[0.0, 6.0], [6.0,  0.0]]), LineString([[6.0,  0.0], [6.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[26.0, 1.0], [21.0, 1.0], [21.5, 1.5], [21.0, 3.0], [23.5, 4.0], [26.0, 3.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [2.0, 1.0], [2.0, 1.5], [1.0, 1.5], [1.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[2.0, 0.0], [2.0, 3.0], [3.0, 3.0], [3.0, 0.0], [2.0, 0.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[26.0, 1.0], [21.0, 1.0], [21.5, 1.5], [21.0, 6.0], [23.5, 6.0], [26.0, 6.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 4.0], [10.0, 4.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 0.0], [6.0, 6.0], [12.0, 6.0], [12.0, 0.0], [6.0, 0.0]], innerRings: [[[8.0, 2.0], [10.0, 2.0], [10.0, 4.0], [8.0, 4.0], [8.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 80.0], [30.0, 80.0], [30.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 100.0], [100.0, 100.0], [100.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [2.0, 1.0], [2.0, 2.0], [1.0, 2.0], [1.0, 1.0]]], precision: precision, coordinateSystem: cs), Polygon([[0.0, 50.0], [0.0, 80.0], [110.0, 80.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiLineString.crosses(point1))
        XCTAssertFalse(testMultiLineString.crosses(point2))
        XCTAssertFalse(testMultiLineString.crosses(multiPoint1))
        XCTAssertFalse(testMultiLineString.crosses(multiPoint2))
        XCTAssertFalse(testMultiLineString.crosses(multiPoint3))
        XCTAssertFalse(testMultiLineString.crosses(lineString1))
        XCTAssertFalse(testMultiLineString.crosses(lineString2))
        XCTAssertFalse(testMultiLineString.crosses(lineString3))
        XCTAssertFalse(testMultiLineString.crosses(linearRing1))
        XCTAssertFalse(testMultiLineString.crosses(linearRing2))
        XCTAssertFalse(testMultiLineString.crosses(multiLineString1))
        XCTAssertFalse(testMultiLineString.crosses(multiLineString2))
        XCTAssertFalse(testMultiLineString.crosses(multiLineString3))
        XCTAssertFalse(testMultiLineString.crosses(polygon1))
        XCTAssertFalse(testMultiLineString.crosses(polygon2))
        XCTAssertFalse(testMultiLineString.crosses(polygon3))
        XCTAssertFalse(testMultiLineString.crosses(multiPolygon1))
        XCTAssertFalse(testMultiLineString.crosses(multiPolygon2))
        XCTAssertFalse(testMultiLineString.crosses(multiPolygon3))
    }

    // MARK: Within

    func testWithinTrue() {
        let testMultiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let lineString = LineString([[0.0, 0.0], [1000.0, 1000.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[0.0, 0.0], [0.0, 700.0], [700.0, 700.0], [0.0, 0.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [4.0,  4.0]]), LineString([[5.0,  5.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[0.0, 0.0], [0.0, 700.0], [700.0, 700.0], [2.0, 2.0], [2.0, 0.0], [0.0, 0.0]], innerRings: [[[100.0, 100.0], [200.0, 100.0], [200.0, 200.0], [100.0, 200.0], [100.0, 100.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[100.0, 500.0], [100.0, 600.0], [50.0, 600.0], [50.0, 500.0], [100.0, 500.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[0.0, 0.0], [0.0, 3.0], [3.0, 3.0], [3.0, 0.0], [0.0, 0.0]], innerRings: []), Polygon([[700.0, 700.0], [6.0, 6.0], [700.0, 6.0], [700.0, 700.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[-6.0, 10.0], [-6.0, 20.0], [-3.0, 20.0], [-3.0, 10.0], [-6.0, 10.0]], innerRings: [[[-4.0, 18.0], [-5.0, 18.0], [-5.0, 16.0], [-4.0, 16.0], [-4.0, 18.0]]]), Polygon([[0.0, -1000.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, -1000.0], [0.0, -1000.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiLineString.within(lineString))
        XCTAssertTrue(testMultiLineString.within(linearRing))
        XCTAssertTrue(testMultiLineString.within(multiLineString1))
        XCTAssertTrue(testMultiLineString.within(multiLineString2))
        XCTAssertTrue(testMultiLineString.within(polygon1))
        XCTAssertTrue(testMultiLineString.within(polygon2))
        XCTAssertTrue(testMultiLineString.within(multiPolygon1))
        XCTAssertTrue(testMultiLineString.within(multiPolygon2))
    }

    func testWithinFalse() {
        let testMultiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[0.0, 0.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [100.0, 100.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[1.0, 1.0], [1.0, 3.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [600.0,  600.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[1.0, 1.0], [100.0, 1.0], [100.0, 200.0], [1.0, 200.0], [1.0, 1.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[0.0, 0.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 5.0], [200.0, 5.0], [200.0, 200.0], [5.0, 200.0], [5.0, 5.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [100.0, 25.0], [100.0, 100.0], [5.0, 100.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)
        let multiPolygon4 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [200.0, 25.0], [200.0, 200.0], [5.0, 200.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiLineString.within(point))
        XCTAssertFalse(testMultiLineString.within(multiPoint))
        XCTAssertFalse(testMultiLineString.within(lineString1))
        XCTAssertFalse(testMultiLineString.within(lineString2))
        XCTAssertFalse(testMultiLineString.within(linearRing))
        XCTAssertFalse(testMultiLineString.within(multiLineString1))
        XCTAssertFalse(testMultiLineString.within(multiLineString2))
        XCTAssertFalse(testMultiLineString.within(polygon1))
        XCTAssertFalse(testMultiLineString.within(polygon2))
        XCTAssertFalse(testMultiLineString.within(polygon3))
        XCTAssertFalse(testMultiLineString.within(multiPolygon1))
        XCTAssertFalse(testMultiLineString.within(multiPolygon2))
        XCTAssertFalse(testMultiLineString.within(multiPolygon3))
        XCTAssertFalse(testMultiLineString.within(multiPolygon4))
    }

    // MARK: Contains

    func testContainsTrue() {
        let testMultiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 0.5, y: 0.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 10.0, y: 10.0)), Point(Coordinate(x: 6.0, y: 6.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[100.0, 100.0], [7.0, 7.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [0.5, 0.5], [0.0, 0.0]], precision: precision, coordinateSystem: cs)
        let linearRing = LinearRing([[60.0, 60.0], [6.0, 6.0], [60.0, 60.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[700.0,  700.0], [600.0,  600.0], [500.0,  500.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[1.5,  1.5], [2.0,  2.0]]), LineString([[20.0,  20.0], [30.0,  30.0]]), LineString([[400.0,  400.0], [40.0,  40.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiLineString.contains(point))
        XCTAssertTrue(testMultiLineString.contains(multiPoint1))
        XCTAssertTrue(testMultiLineString.contains(multiPoint2))
        XCTAssertTrue(testMultiLineString.contains(lineString1))
        XCTAssertTrue(testMultiLineString.contains(lineString2))
        XCTAssertTrue(testMultiLineString.contains(linearRing))
        XCTAssertTrue(testMultiLineString.contains(multiLineString1))
        XCTAssertTrue(testMultiLineString.contains(multiLineString2))
    }

    func testContainsFalse() {
        let testMultiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let point = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.5, y: 1.5))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.0, 8.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[1.0, 1.0], [-1.0, -1.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[1.0, 1.0], [1.0, 3.0], [3.0, 3.0], [3.0, 1.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[0.0, 6.0], [6.0, 6.0], [4.0, 6.0], [0.0, 6.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[1.0,  0.0], [1.0,  6.0], [10.0,  6.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[5.0,  5.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [0.0, 100.0], [1000.0, 100.0], [1000.0, 0.0], [0.0, 0.0]], innerRings: [[[5.0, 2.0], [5.0, 8.0], [3.5, 8.0], [3.5, 2.0], [5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 10.0], [10.0, 10.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[100.0, 0.0], [0.0, 0.0], [0.0, 40.0], [100.0, 40.0], [100.0, 0.0]], innerRings: [[[0.5, 0.5], [20.0, 0.5], [20.0, 10.0], [0.5, 10.0], [0.5, 0.5]]]), Polygon([[0.0, 50.0], [0.0, 100.0], [110.0, 100.0], [110.0, 50.0], [0.0, 50.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiLineString.contains(point))
        XCTAssertFalse(testMultiLineString.contains(multiPoint1))
        XCTAssertFalse(testMultiLineString.contains(multiPoint2))
        XCTAssertFalse(testMultiLineString.contains(lineString1))
        XCTAssertFalse(testMultiLineString.contains(lineString2))
        XCTAssertFalse(testMultiLineString.contains(linearRing1))
        XCTAssertFalse(testMultiLineString.contains(linearRing2))
        XCTAssertFalse(testMultiLineString.contains(multiLineString1))
        XCTAssertFalse(testMultiLineString.contains(multiLineString2))
        XCTAssertFalse(testMultiLineString.contains(polygon1))
        XCTAssertFalse(testMultiLineString.contains(polygon2))
        XCTAssertFalse(testMultiLineString.contains(multiPolygon1))
        XCTAssertFalse(testMultiLineString.contains(multiPolygon2))
    }

    // MARK: Overlaps

    func testOverlapsTrue() {
        /// Overlaps can only be true for geometries of the same dimension, and each geometry must have points exterior to the other, and the interiors must touch.
        let testMultiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let lineString1 = LineString([[1.0, 1.0], [8.0, 8.0]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[4.0, 6.0], [6.0, 6.0], [10.0, 10.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[3.0, 3.0], [3.0, 8.0], [8.0, 8.0], [3.0, 3.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[1.0, 1.0], [6.0, 6.0], [11.0, 1.0], [6.0, -4.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[10.0,  10.0], [10.0,  0.0], [0.0,  0.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.0,  1.5], [1.0,  3.0]]), LineString([[5.0,  5.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(testMultiLineString.overlaps(lineString1))
        XCTAssertTrue(testMultiLineString.overlaps(lineString2))
        XCTAssertTrue(testMultiLineString.overlaps(linearRing1))
        XCTAssertTrue(testMultiLineString.overlaps(linearRing2))
        XCTAssertTrue(testMultiLineString.overlaps(multiLineString1))
        XCTAssertTrue(testMultiLineString.overlaps(multiLineString2))
    }

    func testOverlapsFalse() {
        let testMultiLineString = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [700.0,  700.0]])], precision: precision, coordinateSystem: cs)

        let point1 = Point(Coordinate(x: 10.4, y: 20.5), precision: precision, coordinateSystem: cs)
        let point2 = Point(Coordinate(x: 6.0, y: 6.0), precision: precision, coordinateSystem: cs)
        let multiPoint1 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let multiPoint2 = MultiPoint([Point(Coordinate(x: 1.0, y: 6.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let lineString1 = LineString([[1.0, 1.0], [1.5, 1.5]], precision: precision, coordinateSystem: cs)
        let lineString2 = LineString([[100.0, 100.0], [60.0, 60.0]], precision: precision, coordinateSystem: cs)
        let lineString3 = LineString([[2.0, 2.0], [3.0, 3.0]], precision: precision, coordinateSystem: cs)
        let linearRing1 = LinearRing([[-2.0, 2.0], [-2.0, 5.0], [0.0, 5.0], [0.0, 2.0], [-2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let linearRing2 = LinearRing([[0.0, 1.0], [0.0, 700.0], [700.0, 700.0], [700.0, 1.0], [0.0, 1.0]], precision: precision, coordinateSystem: cs)
        let multiLineString1 = MultiLineString([LineString([[3.0,  4.0], [3.0,  3.0], [1.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let multiLineString2 = MultiLineString([LineString([[0.0,  0.0], [1.0,  1.0]]), LineString([[1.5,  1.5], [3.0,  3.0]]), LineString([[6.0,  6.0], [100.0,  100.0]])], precision: precision, coordinateSystem: cs)
        let polygon1 = Polygon([[26.0, 1.0], [21.0, 1.0], [21.0, 3.0], [23.5, 4.0], [26.0, 3.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon2 = Polygon([[0.0, 0.0], [-100.0, 0.0], [-100.0, 100.0], [0.0, 100.0], [0.0, 0.0]], innerRings: [[[-5.0, 2.0], [-5.0, 3.0], [-6.0, 3.0], [-6.0, 2.0], [-5.0, 2.0]]], precision: precision, coordinateSystem: cs)
        let polygon3 = Polygon([[1.0, 1.0], [100.0, 1.0], [100.0, -100.0], [1.0, -100.0], [1.0, 1.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let multiPolygon1 = MultiPolygon([Polygon([[26.0, 1.0], [21.0, 1.0], [21.0, 3.0], [23.5, 4.0], [26.0, 3.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]], precision: precision, coordinateSystem: cs), Polygon([[10.0, 1.0], [8.0, 1.0], [8.0, 2.0], [10.0, 2.0], [10.0, 1.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon2 = MultiPolygon([Polygon([[26.0, 1.0], [21.0, 1.0], [21.0, 3.0], [23.5, 4.0], [26.0, 3.0], [26.0, 1.0]], innerRings: [[[25.0, 2.0], [25.0, 3.0], [23.5, 3.5], [22.0, 3.0], [22.0, 2.0], [25.0, 2.0]]], precision: precision, coordinateSystem: cs), Polygon([[0.0, 0.0], [0.0, 700.0], [700.0, 700.0], [0.0, 0.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let multiPolygon3 = MultiPolygon([Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 6.0], [3.5, 6.0], [6.0, 6.0], [6.0, 1.0]], innerRings: [[[5.0, 2.0], [5.0, 3.0], [3.5, 3.5], [2.0, 3.0], [2.0, 2.0], [5.0, 2.0]]]), Polygon([[0.0, 10.0], [0.0, 1000.0], [1000.0, 1000.0], [1000.0, 10.0], [0.0, 10.0]], innerRings: [[[5.0, 25.0], [100.0, 25.0], [100.0, 100.0], [5.0, 100.0], [5.0, 25.0]]], precision: precision, coordinateSystem: cs)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(testMultiLineString.overlaps(point1))
        XCTAssertFalse(testMultiLineString.overlaps(point2))
        XCTAssertFalse(testMultiLineString.overlaps(multiPoint1))
        XCTAssertFalse(testMultiLineString.overlaps(multiPoint2))
        XCTAssertFalse(testMultiLineString.overlaps(lineString1))
        XCTAssertFalse(testMultiLineString.overlaps(lineString2))
        XCTAssertFalse(testMultiLineString.overlaps(lineString3))
        XCTAssertFalse(testMultiLineString.overlaps(linearRing1))
        XCTAssertFalse(testMultiLineString.overlaps(linearRing2))
        XCTAssertFalse(testMultiLineString.overlaps(multiLineString1))
        XCTAssertFalse(testMultiLineString.overlaps(multiLineString2))
        XCTAssertFalse(testMultiLineString.overlaps(polygon1))
        XCTAssertFalse(testMultiLineString.overlaps(polygon2))
        XCTAssertFalse(testMultiLineString.overlaps(polygon3))
        XCTAssertFalse(testMultiLineString.overlaps(multiPolygon1))
        XCTAssertFalse(testMultiLineString.overlaps(multiPolygon2))
        XCTAssertFalse(testMultiLineString.overlaps(multiPolygon3))
    }
}
