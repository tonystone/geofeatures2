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

private let geometryDimension = Dimension.one    // LinearRing are always 1 dimension

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class LinearRingGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    // MARK: - Dimension

    func testDimension () {
        XCTAssertEqual(LinearRing(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
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
}
