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

private let inputDimension = Dimension.one    // LineString are always 1 dimension

// MARK: - Coordinate 2D, FloatingPrecision, Cartesian -

class LineStringGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    // MARK: - Dimension

    func testDimension () {
        XCTAssertEqual(LineString(precision: precision, coordinateSystem: cs).dimension, inputDimension)
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
        let expected = Bounds(min: Coordinate(x: 1.0, y: 1.0), max: Coordinate(x: 3.0, y: 3.0))

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

     // MARK: - isSimple

    func testIsSimple_WithNoPoints() {

        let input = LineString([], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithOnePoint() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithTwoPoints() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreeIdenticalPoints() {

        let input = LineString([Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_FirstSecondSame() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_FirstThirdSame() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_SecondThirdSame() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_AllDifferent() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 3.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFourPoints_FirstLastSame() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFourPoints_LastSegmentTouchesButGoesBeyondFirstPoint() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 0.5, y: 0.5)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFourPoints_LastSegmentCrossedFirstSegment() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFivePoints_SecondLastSame() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 2.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFivePoints_FirstFourthSame() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 1.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFivePoints_ThirdSegmentTouchesFirstSegment() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.5, y: 1.0), Coordinate(x: 1.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }
}
