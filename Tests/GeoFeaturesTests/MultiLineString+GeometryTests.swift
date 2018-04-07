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

private let geometryDimension = Dimension.one    // MultiLineString are always 1 dimension

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class MultiLineStringGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    // MARK: Dimension Tests

    func testDimension () {
        XCTAssertEqual(MultiLineString(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
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
                                               LineString([[1.0,  1.0], [0.5,  2.0], [2.5,  3.5], [3.0,  1.5], [1.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithOddIntersection() {
        let input = MultiLineString([LineString([[1.00,  1.0], [2.0,  2.0], [1.5,  3.0], [2.25,  4.0]]),
                                               LineString([[2.25,  4.0], [3.0,  3.0], [2.5,  2.0], [2.50,  1.5]]),
                                               LineString([[2.25,  4.0], [3.0,  5.0], [2.5,  5.0], [2.50,  6.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint([Point([2.25,  4.0]), Point([2.5,  6.0]), Point([1.0,  1.0]), Point([2.5,  1.5])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
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
}
