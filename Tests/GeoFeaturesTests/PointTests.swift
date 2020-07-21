///
///  PointTests.swift
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
///  Created by Tony Stone on 2/10/2016.
///
import XCTest
import GeoFeatures

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class PointCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testInit() {
        let input = Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.x, 1.001)
        XCTAssertEqual(input.y, 1.001)
    }

    func testInitWithArrayLiteral () {
        let input: Point = [2.0, 3.0]

        XCTAssertEqual(input.x, 2.0)
        XCTAssertEqual(input.y, 3.0)
        XCTAssertEqual(input.z, nil)
        XCTAssertEqual(input.m, nil)
    }

    func testInitWithDictionaryLiteral () {
        let input: Point = ["x": 2.0, "y": 3.0]

        XCTAssertEqual(input.x, 2.0)
        XCTAssertEqual(input.y, 3.0)
        XCTAssertEqual(input.z, nil)
        XCTAssertEqual(input.m, nil)
    }

    func testInitWithDictionaryLiteralIncorrectElements () {
        let coordinate: Coordinate = ["x": 2.0, "y": 3.0, "incorrect": 1.0]

        XCTAssertEqual(coordinate.x, 2.0)
        XCTAssertEqual(coordinate.y, 3.0)
        XCTAssertEqual(coordinate.z, nil)
        XCTAssertEqual(coordinate.m, nil)
    }

    // MARK: MutableCollection Conformance

    func testStartIndex() {
        let input    = Point(Coordinate(x: 2.0, y: 2.0), precision: precision, coordinateSystem: cs)
        let expected = 0

        XCTAssertEqual(input.startIndex, expected)
    }

    func testEndIndex() {
        let input    = Point(Coordinate(x: 2.0, y: 2.0), precision: precision, coordinateSystem: cs)
        let expected = 1

        XCTAssertEqual(input.endIndex, expected)
    }

    func testIndexAfter() {
        let input    = 0
        let expected = 1

        XCTAssertEqual(Point(Coordinate(x: 2.0, y: 2.0), precision: precision, coordinateSystem: cs).index(after: input), expected)
    }

    func testSubscriptGet() {
        let input    = Point(Coordinate(x: 2.0, y: 2.0), precision: precision, coordinateSystem: cs)
        let expected = Coordinate(x: 2.0, y: 2.0)

        XCTAssertEqual(input[0], expected)
    }

    func testSubscriptSet() {
        var input = (point: Point(Coordinate(x: 2.0, y: 2.0), precision: precision, coordinateSystem: cs),coordnate:  Coordinate(x: 1.0, y: 1.0))
        let expected = Coordinate(x: 1.0, y: 1.0)

        input.point[0] = input.coordnate

        XCTAssertEqual(input.point[0], expected)
    }

    // MARK: CustomStringConvertible & CustomDebugStringConvertible

    func testDescription() {
        let input = Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.description, "Point(x: 1.001, y: 1.001)")
    }

    func testDebugDescription() {
        let input = Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.debugDescription, "Point(x: 1.001, y: 1.001)")
    }

    // MARK: Double Equals (==), Structural Equality

    func testDoubleEqualsWithIntOneTrue() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs), Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs))
    }

    func testDoubleEqualsWithIntOneFalse() {
        XCTAssertNotEqual(Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs), Point(Coordinate(x: 2.0, y: 2.0), precision: precision, coordinateSystem: cs))
    }
}

// MARK: - Coordinate2DM, FloatingPrecision, Cartesian -

class PointCoordinate2DMFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testInit() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.x, 1.001)
        XCTAssertEqual(input.y, 1.001)
        XCTAssertEqual(input.m, 1.001)
    }

    func testInitWithArrayLiteral () {
        /// 2DM is not supported using array literals because arrays are positional and Z comes before M in the array.  Use a dictionary instead.
    }

    func testInitWithDictionaryLiteral () {
        let input: Point = ["x": 2.0, "y": 3.0, "m": 5.0]

        XCTAssertEqual(input.x, 2.0)
        XCTAssertEqual(input.y, 3.0)
        XCTAssertEqual(input.z, nil)
        XCTAssertEqual(input.m, 5.0)
    }

    // MARK: CustomStringConvertible & CustomDebugStringConvertible

    func testDescription() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.description, "Point(x: 1.001, y: 1.001, m: 1.001)")
    }

    func testDebugDescription() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.debugDescription, "Point(x: 1.001, y: 1.001, m: 1.001)")
    }

    // MARK: Double Equals (==), Structural Equality

    func testDoubleEqualsWithIntOneTrue() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs), Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs))
    }

    func testDoubleEqualsWithIntOneFalse() {
        XCTAssertNotEqual(Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs), Point(Coordinate(x: 2.0, y: 2.0, m: 2.0), precision: precision, coordinateSystem: cs))
    }
}

// MARK: - Coordinate3D, FloatingPrecision, Cartesian -

class PointCoordinate3DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testInit() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.x, 1.001)
        XCTAssertEqual(input.y, 1.001)
        XCTAssertEqual(input.z, 1.001)
    }

    func testInitWithArrayLiteral3D () {
        let input: Point = [2.0, 3.0, 4.0]

        XCTAssertEqual(input.x, 2.0)
        XCTAssertEqual(input.y, 3.0)
        XCTAssertEqual(input.z, 4.0)
        XCTAssertEqual(input.m, nil)
    }

    func testInitWithDictionaryLiteral3D () {
        let input: Point = ["x": 2.0, "y": 3.0, "z": 4.0]

        XCTAssertEqual(input.x, 2.0)
        XCTAssertEqual(input.y, 3.0)
        XCTAssertEqual(input.z, 4.0)
        XCTAssertEqual(input.m, nil)
    }

    // MARK: CustomStringConvertible & CustomDebugStringConvertible

    func testDescription() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.description, "Point(x: 1.001, y: 1.001, z: 1.001)")
    }

    func testDebugDescription() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.debugDescription, "Point(x: 1.001, y: 1.001, z: 1.001)")
    }

    // MARK: Double Equals (==), Structural Equality

    func testDoubleEqualsWithIntOneTrue() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs), Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs))
    }

    func testDoubleEqualsWithIntOneFalse() {
        XCTAssertNotEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0), precision: precision, coordinateSystem: cs))
    }
}

// MARK: - Coordinate3DM, FloatingPrecision, Cartesian -

class PointCoordinate3DMFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testInit() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.x, 1.001)
        XCTAssertEqual(input.y, 1.001)
        XCTAssertEqual(input.z, 1.001)
        XCTAssertEqual(input.m, 1.001)
    }

    func testInitWithArrayLiteral3DM () {
        let input: Point = [2.0, 3.0, 4.0, 5.0]

        XCTAssertEqual(input.x, 2.0)
        XCTAssertEqual(input.y, 3.0)
        XCTAssertEqual(input.z, 4.0)
        XCTAssertEqual(input.m, 5.0)
    }

    func testInitWithDictionaryLiteral3DM () {
        let input: Point = ["x": 2.0, "y": 3.0, "z": 4.0, "m": 5.0]

        XCTAssertEqual(input.x, 2.0)
        XCTAssertEqual(input.y, 3.0)
        XCTAssertEqual(input.z, 4.0)
        XCTAssertEqual(input.m, 5.0)
    }

    // MARK: CustomStringConvertible & CustomDebugStringConvertible

    func testDescription() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.description, "Point(x: 1.001, y: 1.001, z: 1.001, m: 1.001)")
    }

    func testDebugDescription() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.debugDescription, "Point(x: 1.001, y: 1.001, z: 1.001, m: 1.001)")
    }

    // MARK: Double Equals (==), Structural Equality

    func testDoubleEqualsWithIntOneTrue() {
        XCTAssertEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs), Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs))
    }

    func testDoubleEqualsWithIntOneFalse() {
        XCTAssertNotEqual(Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 2.0), precision: precision, coordinateSystem: cs))
    }
}

// MARK: - Coordinate2D, Fixed, Cartesian -

class PointCoordinate2DFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testInit() {
        let input = Point(Coordinate(x: 1.001, y: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.x, 1.0)
        XCTAssertEqual(input.y, 1.0)
    }
}

// MARK: - Coordinate2DM, Fixed, Cartesian -

class PointCoordinate2DMFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testInit() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.x, 1.0)
        XCTAssertEqual(input.y, 1.0)
        XCTAssertEqual(input.m, 1.0)
    }
}

// MARK: - Coordinate3D, Fixed, Cartesian -

class PointCoordinate3DFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testInit() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.x, 1.0)
        XCTAssertEqual(input.y, 1.0)
        XCTAssertEqual(input.z, 1.0)
    }
}

// MARK: - Coordinate3DM, Fixed, Cartesian -

class PointCoordinate3DMFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testInit() {
        let input = Point(Coordinate(x: 1.001, y: 1.001, z: 1.001, m: 1.001), precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.x, 1.0)
        XCTAssertEqual(input.y, 1.0)
        XCTAssertEqual(input.z, 1.0)
        XCTAssertEqual(input.m, 1.0)
    }
}
