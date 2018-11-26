///
///  MultiPolygon+GeometryTests.swift
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

// MARK: - Coordinate 2D, FloatingPrecision, Cartesian -

class MultiPolygonGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs        = Cartesian()

    func testDimension () {
        XCTAssertEqual(MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [])], precision: precision, coordinateSystem: cs).dimension, .two)
    }

    func testDimensionEmpty () {
        XCTAssertEqual(MultiPolygon(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    func testBoundaryWithSinglePolygonNoInnerRings() {

        let input    = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [])], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiLineString([LineString([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithSinglePolygonInnerRings() {
        let input = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]])], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiLineString([LineString([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)]), LineString([Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithMultiplePolygons() {
        let input = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]]), Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [])], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiLineString([LineString([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)]), LineString([Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]), LineString([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let geometry = MultiPolygon(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiLineString(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(geometry == expected, "\(geometry) is not equal to \(expected)")
    }

    func testEqualTrue() {
        let input1 = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]]), Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [])], precision: precision, coordinateSystem: cs)
        let input2 = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]]), Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
    }

    func testEqualWithSameTypesFalse() {
        let input1            = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]]), Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [])], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = MultiPolygon(precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
    }

    func testEqualWithDifferentTypesFalse() {
        let input1            = MultiPolygon([Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 3.0), Coordinate(x: 3.5, y: 3.5), Coordinate(x: 5.0, y: 3.0)]]), Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], innerRings: [])], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
    }

    func testMultiPointSimplify_noPoints() {
        let multipoint = MultiPoint([])
        let multipointResult = multipoint.simplify(tolerance: 1.0)

        XCTAssert(multipointResult.count == 0)
    }

    func testMultiPointSimplify_onePoint() {
        let multipoint = MultiPoint([Point([0.0, 0.0])])
        let multipointResult = multipoint.simplify(tolerance: 1.0)

        XCTAssert(multipointResult.count == 1)
    }

    func testMultiPointSimplify_twoDifferentPoints() {
        let multipoint = MultiPoint([Point([0.0, 0.0]), Point([1.0, 1.0])])
        let multipointResult = multipoint.simplify(tolerance: 1.0)

        XCTAssert(multipointResult.count == 2)
    }

    func testMultiPointSimplify_twoIdenticalPoints() {
        let multipoint = MultiPoint([Point([1.0, 1.0]), Point([1.0, 1.0])])
        let multipointResult = multipoint.simplify(tolerance: 1.0)

        XCTAssert(multipointResult.count == 1)
    }

    func testMultiPointSimplify_mixtureOfPoints() {
        let multipoint = MultiPoint([Point([0.0, 0.0]), Point([0.0, 0.0]), Point([1.0, 1.0]), Point([0.0, 0.0]), Point([0.0, 0.0]), Point([0.0, 0.0]), Point([1.0, 1.0])])
        let multipointResult = multipoint.simplify(tolerance: 1.0)

        XCTAssert(multipointResult.count == 2)
    }
}
