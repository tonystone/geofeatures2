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

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class LineStringGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(LineString<Coordinate2D>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testBoundaryWith1ElementInvalid() {
        let geometry = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<Coordinate2D>(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryWith2Element() {
        let geometry = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<Coordinate2D>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryWith3ElementOpen() {
        let geometry = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 3.0, y: 3.0)], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<Coordinate2D>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 3.0))], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryWith4ElementClosed() {
        let geometry = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 3.0, y: 3.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<Coordinate2D>(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = LineString<Coordinate2D>(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<Coordinate2D>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testEqualTrue() {
        let input1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let input2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
    }

    func testEqualFalse() {
        let input1            = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
    }

    func testIsSimple_WithNoPoints() {

        let input = LineString<Coordinate2D>(elements: [] as [Coordinate2D], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithOnePoint() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithTwoPoints() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreeIdenticalPoints() {

        let input = LineString<Coordinate2D>(elements: [(x: 2.0, y: 2.0), (x: 2.0, y: 2.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_FirstSecondSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 1.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_FirstThirdSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_SecondThirdSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_AllDifferent() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 3.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFourPoints_FirstLastSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFourPoints_LastSegmentTouchesButGoesBeyondFirstPoint() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 2.0, y: 2.0), (x: 0.5, y: 0.5)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFourPoints_LastSegmentCrossedFirstSegment() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFivePoints_SecondLastSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 2.0), (x: 2.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFivePoints_FirstFourthSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 2.0, y: 2.0), (x: 2.0, y: 1.0), (x: 1.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFivePoints_ThirdSegmentTouchesFirstSegment() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.5, y: 1.0), (x: 1.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }
}

// MARK: - Coordinate2DM, FloatingPrecision, Cartesian -

class LineStringGeometryCoordinate2DMFloatingPrecisionCartesianTests: XCTestCase {

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(LineString<Coordinate2DM>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }
}

// MARK: - Coordinate3D, FloatingPrecision, Cartesian -

class LineStringGeometryCoordinate3DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(LineString<Coordinate3D>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }
}

// MARK: - Coordinate3DM, FloatingPrecision, Cartesian -

class LineStringGeometryCoordinate3DMFloatingPrecisionCartesianTests: XCTestCase {

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(LineString<Coordinate3DM>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }
}

// MARK: - Coordinate2D, FixedPrecision, Cartesian -

class LineStringGeometryCoordinate2DFixedPrecisionCartesianTests: XCTestCase {

    let precision = FixedPrecision(scale: 100)
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(LineString<Coordinate2D>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testIsSimple_WithNoPoints() {

        let input = LineString<Coordinate2D>(elements: [] as [Coordinate2D], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithOnePoint() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.002, y: 1.0)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithTwoPoints() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.001, y: 1.0), (x: 2.003, y: 2.001)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreeIdenticalPoints() {

        let input = LineString<Coordinate2D>(elements: [(x: 2.001, y: 2.0), (x: 2.0003, y: 2.001), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_FirstSecondSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.001, y: 1.002), (x: 1.0, y: 1.001), (x: 2.001, y: 2.0)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_FirstThirdSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.001, y: 1.002), (x: 2.001, y: 2.0), (x: 1.0, y: 1.003)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_SecondThirdSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.001, y: 1.0), (x: 2.001, y: 2.0), (x: 2.004, y: 2.003)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithThreePoints_AllDifferent() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.001, y: 1.0), (x: 2.003, y: 2.002), (x: 3.001, y: 3.0)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFourPoints_FirstLastSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.003, y: 1.001), (x: 2.001, y: 1.0), (x: 2.002, y: 2.003), (x: 1.001, y: 1.0)], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFourPoints_LastSegmentTouchesButGoesBeyondFirstPoint() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.003, y: 1.002), (x: 2.002, y: 1.0), (x: 2.0, y: 2.004), (x: 0.501, y: 0.502)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFourPoints_LastSegmentCrossedFirstSegment() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.001, y: 1.0), (x: 2.0007, y: 1.004), (x: 2.001, y: 2.003), (x: 1.004, y: 0.003)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFivePoints_SecondLastSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.001, y: 1.003), (x: 2.001, y: 1.003), (x: 2.003, y: 2.004), (x: 1.003, y: 2.0), (x: 2.004, y: 1.002)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFivePoints_FirstFourthSame() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.001, y: 1.0), (x: 2.004, y: 1.003), (x: 2.0, y: 2.002), (x: 2.0, y: 1.0), (x: 1.001, y: 2.001)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimple_WithFivePoints_ThirdSegmentTouchesFirstSegment() {

        let input = LineString<Coordinate2D>(elements: [(x: 1.003, y: 1.001), (x: 2.004, y: 1.0), (x: 2.003, y: 2.002), (x: 1.501, y: 1.0), (x: 1.002, y: 2.001)], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }
}

// MARK: - Coordinate2DM, FixedPrecision, Cartesian -

class LineStringGeometryCoordinate2DMFixedPrecisionCartesianTests: XCTestCase {

    let precision = FixedPrecision(scale: 100)
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(LineString<Coordinate2DM>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }
}

// MARK: - Coordinate3D, FixedPrecision, Cartesian -

class LineStringGeometryCoordinate3DFixedPrecisionCartesianTests: XCTestCase {

    let precision = FixedPrecision(scale: 100)
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(LineString<Coordinate3D>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }
}

// MARK: - Coordinate3DM, FixedPrecision, Cartesian -

class LineStringGeometryCoordinate3DMFixedPrecisionCartesianTests: XCTestCase {

    let precision = FixedPrecision(scale: 100)
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(LineString<Coordinate3DM>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }
}
