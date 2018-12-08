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

    // MARK: - Simplify

    func testMultiPolygonSimplify_empty() {
        let multiPolygon = MultiPolygon()
        let multiPolygonResult = multiPolygon.simplify(tolerance: 1.0)

        XCTAssert(multiPolygonResult.count == 0)
    }

    func testMultiPolygonSimplify_onePolygonWithOnePoint() {
        let multiPolygon = MultiPolygon([Polygon([[1.0, 1.0]], innerRings: [])])
        let multiPolygonResult = multiPolygon.simplify(tolerance: 1.0)

        XCTAssert(multiPolygonResult.count == 1)
        XCTAssert(multiPolygonResult[0].count == 1)
    }

    /// This test will likely need to be updated when a definition of a Polygon that has the same point repeated is clearly defined.
    func testMultiPolygonSimplify_threePolygonsOnePointRepeated() {
        let multiPolygon = MultiPolygon([Polygon([[1.0, 1.0], [1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [1.0, 1.0], [1.0, 1.0]], innerRings: []), Polygon([[1.0, 1.0], [1.0, 1.0], [1.0, 1.0], [1.0, 1.0]], innerRings: [])])
        let multiPolygonResult = multiPolygon.simplify(tolerance: 1.0)

        XCTAssert(multiPolygonResult.count == 3)
        XCTAssert(multiPolygonResult[0].count == 1)
        XCTAssert(multiPolygonResult[0][0].count == 2)
        XCTAssert(multiPolygonResult[1].count == 1)
        XCTAssert(multiPolygonResult[1][0].count == 3)
        XCTAssert(multiPolygonResult[2].count == 1)
        XCTAssert(multiPolygonResult[2][0].count == 2)
    }

    func testMultiPolygonSimplify_twoPolygonsBothSquaresSecondWithHole() {
        let multiPolygon = MultiPolygon([Polygon([[1.0, 1.0], [1.0, 5.0], [5.0, 5.0], [5.0, 5.0], [5.0, 1.0], [5.0, 1.0], [1.0, 1.0], [1.0, 5.0], [1.0, 1.0]], innerRings: []),
                                         Polygon([[1.0, 1.0], [1.0, 5.0], [5.0, 5.0], [5.0, 5.0], [5.0, 1.0], [5.0, 1.0], [1.0, 1.0], [1.0, 5.0], [1.0, 1.0]], innerRings: [[[4.0, 2.0], [4.0, 4.0], [4.0, 4.0], [2.0, 4.0], [3.5, 3.5], [4.0, 2.0], [4.0, 2.0]]])])
        let multiPolygonResult = multiPolygon.simplify(tolerance: 1.0)

        XCTAssert(multiPolygonResult.count == 2)
        XCTAssert(multiPolygonResult[0].count == 1)
        XCTAssert(multiPolygonResult[0][0].count == 7)
        XCTAssert(multiPolygonResult[1].count == 2)
        XCTAssert(multiPolygonResult[1][0].count == 7)
        XCTAssert(multiPolygonResult[1][1].count == 5)
    }

    func testMultiPolygonSimplify_twoPolygonsWithMultipleHoles() {
        let multiPolygon = MultiPolygon([Polygon([[0.0, 0.0], [-10.0, 10.0], [-10.0, 10.0], [-10.0, 10.0], [0.0, 20.0], [10.0, 20.0], [20.0, 10.0], [10.0, 0.0], [0.0, 0.0]],
                              innerRings: [[[1.0, 1.0], [2.0, 1.0], [2.0, 2.0], [1.0, 2.0], [1.0, 1.0], [1.0, 1.0], [2.0, 1.0], [2.0, 2.0], [1.0, 2.0], [1.0, 1.0], [1.0, 1.0], [2.0, 1.0], [2.0, 2.0], [1.0, 2.0], [1.0, 1.0]],
                                           [[8.0, 2.0], [8.0, 1.0], [9.0, 1.0], [9.0, 1.0], [9.0, 1.0], [9.0, 1.0], [9.0, 2.0], [8.0, 2.0]],
                                           [[5.0, 19.0], [3.0, 17.0], [5.0, 15.0], [7.0, 17.0], [5.0, 19.0], [5.0, 19.0], [3.0, 17.0], [5.0, 15.0], [7.0, 17.0], [5.0, 19.0]]]),
                                         Polygon([[0.0, -10.0], [100.0, -10.0], [100.0, -100.0], [0.0, -100.0], [0.0, -10.0]],
                                                 innerRings: [[[10.0, -20.0], [5.0, -20.0], [5.0, -25.0], [10.0, -25.0], [10.0, -20.0]],
                                                              [[50.0, -20.0], [45.0, -20.0], [45.0, -25.0], [50.0, -25.0], [50.0, -25.0], [50.0, -25.0], [50.0, -20.0]],
                                                              [[10.0, -50.0], [5.0, -50.0], [5.0, -55.0], [10.0, -55.0], [10.0, -50.0]],
                                                              [[50.0, -50.0], [45.0, -50.0], [45.0, -55.0], [50.0, -55.0], [50.0, -50.0], [50.0, -50.0], [45.0, -50.0], [45.0, -55.0], [50.0, -55.0], [50.0, -50.0]]])])
        let multiPolygonResult = multiPolygon.simplify(tolerance: 1.0)

        XCTAssert(multiPolygonResult.count == 2)
        XCTAssert(multiPolygonResult[0].count == 4)
        XCTAssert(multiPolygonResult[0][0].count == 7)
        XCTAssert(multiPolygonResult[0][1].count == 5)
        XCTAssert(multiPolygonResult[0][2].count == 5)
        XCTAssert(multiPolygonResult[0][3].count == 5)
        XCTAssert(multiPolygonResult[1].count == 5)
        XCTAssert(multiPolygonResult[1][0].count == 5)
        XCTAssert(multiPolygonResult[1][1].count == 5)
        XCTAssert(multiPolygonResult[1][2].count == 5)
        XCTAssert(multiPolygonResult[1][3].count == 5)
        XCTAssert(multiPolygonResult[1][4].count == 5)
    }
}
