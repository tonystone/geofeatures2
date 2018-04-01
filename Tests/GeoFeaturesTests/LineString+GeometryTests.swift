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

private let geometryDimension = Dimension.one    // LineString are always 1 dimension

// MARK: - Coordinate 2D, FloatingPrecision, Cartesian -

class LineStringGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(LineString(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testBoundaryWith1ElementInvalid() {
        let geometry = LineString(coordinates: [[1.0, 1.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryWith2Element() {
        let geometry = LineString(coordinates: [[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(elements: [Point(coordinate: [1.0, 1.0]), Point(coordinate: [2.0, 2.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryWith3ElementOpen() {
        let geometry = LineString(coordinates: [[1.0, 1.0], [2.0, 2.0], [3.0, 3.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(elements: [Point(coordinate: [1.0, 1.0]), Point(coordinate: [3.0, 3.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryWith4ElementClosed() {
        let geometry = LineString(coordinates: [[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = LineString(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    // MARK: - Bounds

    func testBoundsEmpty() {
        let input = LineString(precision: precision, coordinateSystem: cs)
        let expected: Bounds? = nil

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBoundsWithElements() {
        let input = LineString(coordinates: [[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 1.0, y: 1.0), max: (x: 3.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    func testEqualTrue() {
        let input1 = LineString(coordinates: [[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let input2 = LineString(coordinates: [[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = LineString(coordinates: [[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point(coordinate: [1.0, 1.0], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }
}
