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

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs        = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate2DM, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate2DMFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()


    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, m: 2.0))],precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, m: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate3D, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate3DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))],precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate3DM, FloatingPrecision, Cartesian -

class MultiPointGeometryCoordinate3DMFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate2D, Fixed, Cartesian -

class MultiPointGeometryCoordinate2DFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))],precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate2DM, Fixed, Cartesian -

class MultiPointGeometryCoordinate2DMFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, m: 2.0))], precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, m: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }
}

// MARK: - Coordinate3D, Fixed, Cartesian -

class MultiPointGeometryCoordinate3DFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testEqualTrue() {
        let input1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs)
        let input2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0))], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point(Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }
}

// MARK: - Coordinate3DM, Fixed, Cartesian -

class MultiPointGeometryCoordinate3DMFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testDimension () {

        XCTAssertEqual(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))],precision: precision, coordinateSystem: cs).dimension, .zero)
    }

    func testDimensionEmpty () {

        XCTAssertEqual(MultiPoint(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundary() {
        let geometry = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPoint(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testEqualTrue() {
        let input1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs)
        let input2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 1.0)), Point(Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 1.0))], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point(Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }
}
