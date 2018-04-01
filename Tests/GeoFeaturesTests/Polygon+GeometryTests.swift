///
///  Polygon+GeometryTests.swift
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

#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS)) && SWIFT_PACKAGE
    /// Note: Resolution of GeoFeatures.Polygon is ambiguous when ApplicationsServices is included in the app (ApplicationsServices is used by XCTest), this resolves the ambiguity.
    import struct GeoFeatures.Polygon
#endif

private let geometryDimension = Dimension.two    // Polygon are always 2 dimension

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class PolygonGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = FloatingPrecision()
    let cs       = Cartesian()

    func testDimension () {
        XCTAssertEqual(Polygon(precision: precision, coordinateSystem: cs).dimension, geometryDimension)
    }

    func testBoundaryWithOuterRing() {
        let geometry = Polygon(outerRing: [Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiLineString(elements: [LineString(coordinates: [Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryWithOuterRingAnd1InnerRing() {
        let geometry = Polygon(outerRing: [Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiLineString(elements: [LineString(coordinates: [Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)]), LineString(coordinates: [Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = Polygon(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiLineString(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    // MARK: - Bounds

    func testBoundsEmpty() {
        let input = Polygon(precision: precision, coordinateSystem: cs)
        let expected: Bounds? = nil

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBounds() {
        let input = Polygon(outerRing: [[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0]], innerRings: [], precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 1.0, y: 1.0), max: (x: 6.0, y: 4.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    func testEqualTrue() {
        let input1 = Polygon(outerRing: [Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let input2 = Polygon(outerRing: [Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = Polygon(outerRing: [Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point(coordinate: Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }
}

