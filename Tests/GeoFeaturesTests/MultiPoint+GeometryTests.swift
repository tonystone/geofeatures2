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

private let geometryDimension = Dimension.zero    // MultiPoint are always 0 dimension

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    private typealias CoordinateType = Coordinate2D

    let precision = FloatingPrecision()
    let cs        = Cartesian()

    func testDimension () {
        XCTAssertEqual(MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testBoundary() {
        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testIsSimpleWithNoEqualPoints() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.001, y: 1.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithNoEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.006, y: 2.006)), Point<CoordinateType>(coordinate: (x: 2.004, y: 2.004))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }
}

// MARK: - Coordinate2DM, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate2DMFloatingPrecisionCartesianTests: XCTestCase {

    private typealias CoordinateType = Coordinate2DM

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testBoundary() {
        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0, m: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0, m: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testIsSimpleWithNoEqualPoints() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.001, y: 1.001, m: 1.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, m: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithNoEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.006, y: 2.006, m: 2.006)), Point<CoordinateType>(coordinate: (x: 2.004, y: 2.004, m: 2.004))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, m: 2.002)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, m: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }
}

// MARK: - Coordinate3D, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate3DFloatingPrecisionCartesianTests: XCTestCase {

    private typealias CoordinateType = Coordinate3D

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testBoundary() {
        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0, z: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testIsSimpleWithNoEqualPoints() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.001, y: 1.001, z: 1.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, z: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithNoEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.006, y: 2.006, z: 2.006)), Point<CoordinateType>(coordinate: (x: 2.004, y: 2.004, z: 2.004))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, z: 2.002)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, z: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }
}

// MARK: - Coordinate3DM, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate3DMFloatingPrecisionCartesianTests: XCTestCase {

    private typealias CoordinateType = Coordinate3DM

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testBoundary() {
        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testIsSimpleWithNoEqualPoints() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.001, y: 1.001, z: 1.001, m: 1.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, z: 2.002, m: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithNoEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.006, y: 2.006, z: 2.006, m: 2.006)), Point<CoordinateType>(coordinate: (x: 2.004, y: 2.004, z: 2.004, m: 2.004))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, z: 2.002, m: 2.002)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, z: 2.002, m: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }
}

// MARK: - Coordinate2D, FixedPrecision, Cartesian -

class MultiPointGeometryCoordinate2DFixedPrecisionCartesianTests: XCTestCase {

    private typealias CoordinateType = Coordinate2D

    let precision = FixedPrecision(scale: 100)
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testBoundary() {
        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testIsSimpleWithNoEqualPoints() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.001, y: 1.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithNoEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.006, y: 2.006)), Point<CoordinateType>(coordinate: (x: 2.004, y: 2.004))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.001, y: 2.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }
}

// MARK: - Coordinate2DM, FixedPrecision, Cartesian -

class MultiPointGeometryCoordinate2DMFixedPrecisionCartesianTests: XCTestCase {

    private typealias CoordinateType = Coordinate2DM

    let precision = FixedPrecision(scale: 100)
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testBoundary() {
        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0, m: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0, m: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testIsSimpleWithNoEqualPoints() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.001, y: 1.001, m: 1.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, m: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithNoEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.006, y: 2.006, m: 2.006)), Point<CoordinateType>(coordinate: (x: 2.004, y: 2.004, m: 2.004))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.001, y: 2.001, m: 2.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, m: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }
}

// MARK: - Coordinate3D, FixedPrecision, Cartesian -

class MultiPointGeometryCoordinate3DFixedPrecisionCartesianTests: XCTestCase {

    private typealias CoordinateType = Coordinate3D

    let precision = FixedPrecision(scale: 100)
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testBoundary() {
        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0, z: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testEqualTrue() {
        let input1 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0, z: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs)
        let input2 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0, z: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0, z: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }

    func testIsSimpleWithNoEqualPoints() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.001, y: 1.001, z: 1.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, z: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithNoEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.006, y: 2.006, z: 2.006)), Point<CoordinateType>(coordinate: (x: 2.004, y: 2.004, z: 2.004))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.001, y: 2.001, z: 2.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, z: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }
}

// MARK: - Coordinate3DM, FixedPrecision, Cartesian -

class MultiPointGeometryCoordinate3DMFixedPrecisionCartesianTests: XCTestCase {

    private typealias CoordinateType = Coordinate3DM

    let precision = FixedPrecision(scale: 100)
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testBoundary() {
        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<CoordinateType>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = MultiPoint<Coordinate3DM>(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint<Coordinate3DM>(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testEqualTrue() {
        let input1 = MultiPoint<Coordinate3DM>(elements: [Point<Coordinate3DM>(coordinate: (x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point<Coordinate3DM>(coordinate: (x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs)
        let input2 = MultiPoint<Coordinate3DM>(elements: [Point<Coordinate3DM>(coordinate: (x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point<Coordinate3DM>(coordinate: (x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

    func testEqualFalse() {

        let input1            = MultiPoint<Coordinate3DM>(elements: [Point<Coordinate3DM>(coordinate: (x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point<Coordinate3DM>(coordinate: (x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }

    func testIsSimpleWithNoEqualPoints() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.001, y: 1.001, z: 1.001, m: 1.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, z: 2.002, m: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithNoEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.006, y: 2.006, z: 2.006, m: 2.006)), Point<CoordinateType>(coordinate: (x: 2.004, y: 2.004, z: 2.004, m: 2.004))], precision: precision, coordinateSystem: cs)
        let expected = true

        XCTAssertEqual(input.isSimple(), expected)
    }

    func testIsSimpleWithEqualPointsAfterPrecision() {

        let input = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 2.001, y: 2.001, z: 2.001, m: 2.001)), Point<CoordinateType>(coordinate: (x: 2.002, y: 2.002, z: 2.002, m: 2.002))], precision: precision, coordinateSystem: cs)
        let expected = false

        XCTAssertEqual(input.isSimple(), expected)
    }
}
