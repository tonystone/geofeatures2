///
///  MultiLineString+GeometryTests.swift
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

class MultiLineStringGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    // MARK: Dimension Tests

    func testDimension () {
        XCTAssertEqual(MultiLineString([LineString([[1.0,  1.0]])],precision: precision, coordinateSystem: cs).dimension, .one)
    }

    func testDimensionEmpty () {
        XCTAssertEqual(MultiLineString(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    // MARK: Boundary Tests

    func testBoundaryWith1ElementInvalid() {
        let input    = MultiLineString([LineString([[1.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith2Element() {
        let input    = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint([Point([1.0,  1.0]), Point([2.0,  2.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith3ElementOpen() {
        let input    = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint([Point([1.0,  1.0]), Point([3.0,  3.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith4ElementClosed() {
        let input    = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0], [3.0,  3.0], [1.0,  1.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith2EqualPoints() {
        let input    = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0]]), LineString([[1.0,  1.0], [3.0,  3.0]]), LineString([[1.0,  1.0], [3.0,  3.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint([Point([1.0,  1.0]), Point([2.0,  2.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input    = MultiLineString(precision: precision, coordinateSystem: cs)
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithOGCMultiCurveA() {
        let input = MultiLineString([LineString([[1.00,  1.0], [2.0,  2.0], [1.5,  3.0], [2.25,  4.0]]),
                                               LineString([[2.25,  4.0], [3.0,  3.0], [2.5,  2.0], [2.50,  1.5]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint([Point([1.0,  1.0]), Point([2.5,  1.5])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithOGCMultiCurveB() {
        let input = MultiLineString([LineString([[1.00,  1.0], [2.25,  4.0], [2.5,  3.0], [1.25,  3.5]]),
                                               LineString([[10.0,  10.0], [20.0,  20.0], [30.0,  30.0], [10.0,  10.0]])], precision: precision, coordinateSystem: cs)
        let expected = MultiPoint([Point([1.0,  1.0]), Point([1.25,  3.5])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithOGCMultiCurveC() {
        let input = MultiLineString([LineString([[1.5,  3.0], [1.0,  4.0], [2.5,  3.5], [1.5,  3.0]]),
                                               LineString([[1.0,  1.0], [0.5,  2.0], [2.5,  3.5], [3.0,  1.5], [1.0,  1.0]])], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWithOddIntersection() {
        let input = MultiLineString([LineString([[1.00,  1.0], [2.0,  2.0], [1.5,  3.0], [2.25,  4.0]]),
                                               LineString([[2.25,  4.0], [3.0,  3.0], [2.5,  2.0], [2.50,  1.5]]),
                                               LineString([[2.25,  4.0], [3.0,  5.0], [2.5,  5.0], [2.50,  6.0]])], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint([Point([1.0,  1.0]), Point([2.25,  4.0]), Point([2.5,  1.5]), Point([2.5,  6.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    // MARK: Bounds 

    func testBoundsEmpty() {
        let input = MultiLineString(precision: precision, coordinateSystem: cs)
        let expected: Bounds? = nil

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBoundsWithElements() {
        let input = MultiLineString([LineString([[1.00,  1.0], [2.0,  2.0], [1.5,  3.0], [2.25,  4.0]]),
                                               LineString([[2.25,  4.0], [3.0,  3.0], [2.5,  2.0], [2.50,  1.5]]),
                                               LineString([[2.25,  4.0], [3.0,  5.0], [2.5,  5.0], [2.50,  6.0]])], precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 1.0, y: 1.0), max: (x: 3.0, y: 6.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    // MARK: Boundary Tests

    func testEqualTrue() {
        let input1 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0]]), LineString([[3.0,  3.0], [4.0,  4.0]])], precision: precision, coordinateSystem: cs)
        let input2 = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0]]), LineString([[3.0,  3.0], [4.0,  4.0]])], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = MultiLineString([LineString([[1.0,  1.0], [2.0,  2.0]]), LineString([[3.0,  3.0], [4.0,  4.0]])], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = LineString([[1.0,  1.0], [2.0,  2.0]], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }
    
    // MARK: Simplify

    func testMultiLineStringSimplify_noLineStrings() {
        let multiLineString = MultiLineString()
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 0)
    }

    func testMultiLineStringSimplify_oneLineStringOnePoint() {
        let multiLineString = MultiLineString([LineString([[100, 100]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 1)
        XCTAssert(multiLineStringResult[0].count == 1)
    }

    func testMultiLineStringSimplify_oneLineStringTwoIdenticalPoints() {
        let multiLineString = MultiLineString([LineString([[100, 100], [100, 100]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 1)
        XCTAssert(multiLineStringResult[0].count == 2)
    }

    func testMultiLineStringSimplify_oneLineStringThreeIdenticalPoints() {
        let multiLineString = MultiLineString([LineString([[100, 100], [100, 100], [100, 100]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 1)
        XCTAssert(multiLineStringResult[0].count == 2)
    }

    func testMultiLineStringSimplify_oneLineStringFourIdenticalPoints() {
        let multiLineString = MultiLineString([LineString([[100, 100], [100, 100], [100, 100], [100, 100]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 1)
        XCTAssert(multiLineStringResult[0].count == 2)
    }

    func testMultiLineStringSimplify_fivePointsThreeUniqueSameSlope_fivePointsThreeUniqueTwoDifferentSlopes() {
        let multiLineString = MultiLineString([LineString([[100, 100], [100, 100], [150, 150], [200, 200], [200, 200]]), LineString([[100, 100], [100, 100], [150, 150], [200, 150], [200, 150]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 1)
        XCTAssert(multiLineStringResult[0].count == 4)
    }

    func testMultiLineStringSimplify_fourLineStrings() {
        let multiLineString = MultiLineString([LineString([[100, 100], [100, 100], [200, 200], [300, 300], [300, 300], [400, 300], [500, 300], [600, 300], [600, 300], [600, 400], [600, 600], [600, 800]]),
                                                LineString([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]]),
                                                LineString([[100, 100], [200, 200], [200, 200], [100, 100]]),
                                                LineString([[100, 100], [200, 200], [200, 200], [100, 100], [100, 100], [200, 200]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 1)
        XCTAssert(multiLineStringResult[0].count == 8)
    }

    /// Note that the order of LineStrings in a MultiLineString will result in different results once simplified.
    func testMultiLineStringSimplify_fourLineStrings_differentOrder() {
        let multiLineString = MultiLineString([LineString([[100, 100], [200, 200], [200, 200], [100, 100]]),
                                               LineString([[100, 100], [200, 200], [200, 200], [100, 100], [100, 100], [200, 200]]),
                                               LineString([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]]),
                                               LineString([[100, 100], [100, 100], [200, 200], [300, 300], [300, 300], [400, 300], [500, 300], [600, 300], [600, 300], [600, 400], [600, 600], [600, 800]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 1)
        XCTAssert(multiLineStringResult[0].count == 8)
    }

    func testMultiLineStringSimplify_fourLineStrings2() {
        let multiLineString = MultiLineString([LineString([[100, 100], [300, 300], [200, 200], [500, 500]]),
                                                LineString([[0, 1], [1, 1], [2, 2], [0, 0], [1, 1], [5, 1]]),
                                                LineString([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100], [100, 100], [100, 200], [200, 200], [200, 100], [100, 100]]),
                                                LineString([[0, 0], [0, 10], [20, 10], [20, 0], [8, 0], [8, 4], [12, 4], [12, 0], [0, 0], [0, 10], [20, 10], [20, 0], [0, 0], [0, 10]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 3)
        XCTAssert(multiLineStringResult[0].count == 8)
        XCTAssert(multiLineStringResult[1].count == 6)
        XCTAssert(multiLineStringResult[2].count == 13)
    }

    func testMultiLineStringSimplify_severalLineStringsFormingOneLineSegment() {
        let multiLineString = MultiLineString([LineString([[100, 10], [120, 10], [130, 10], [140, 10]]),
                                               LineString([[30, 10], [40, 10], [40, 10]]),
                                               LineString([[80, 10], [70, 10], [60, 10]]),
                                               LineString([[-10, 10], [0, 10], [30, 10]]),
                                               LineString([[100, 10], [75, 10]]),
                                               LineString([[60, 10], [40, 10]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 1)
        XCTAssert(multiLineStringResult[0].count == 2)
    }

    func testMultiLineStringSimplify_whyShapedLineStrings() {
        let multiLineString = MultiLineString([LineString([[4, 0], [4, 2], [4, 4]]),
                                               LineString([[8, 8], [4, 4], [4, 4]]),
                                               LineString([[4, 3], [4, 4], [2, 6], [0, 8]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 2)
        XCTAssert(multiLineStringResult[0].count == 3)
        XCTAssert(multiLineStringResult[1].count == 3)
    }

    func testMultiLineStringSimplify_whyShapedLineStrings_differentOrder() {
        let multiLineString = MultiLineString([LineString([[4, 3], [4, 4], [2, 6], [0, 8]]),
                                               LineString([[4, 0], [4, 2], [4, 4]]),
                                               LineString([[8, 8], [4, 4], [4, 4]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 2)
        XCTAssert(multiLineStringResult[0].count == 3)
        XCTAssert(multiLineStringResult[1].count == 2)
    }

    func testMultiLineStringSimplify_whyShapedLineStrings_meetAtPoint() {
        let multiLineString = MultiLineString([LineString([[4, 0], [4, 2], [4, 4]]),
                                               LineString([[8, 8], [4, 4], [4, 4]]),
                                               LineString([[4, 4], [4, 4], [2, 6], [0, 8]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 2)
        XCTAssert(multiLineStringResult[0].count == 3)
        XCTAssert(multiLineStringResult[1].count == 2)
    }

    func testMultiLineStringSimplify_lineStringsShouldNotBeMerged() {
        let multiLineString = MultiLineString([LineString([[-40, 40], [-20, 20], [0, 20], [20, 20], [40, 40]]),
                                               LineString([[-40, 0], [-20, 0], [0, 20], [10, 20], [10, 20], [20, 10], [40, 10]]),
                                               LineString([[30, 0], [0, 30], [30, 60], [40, 60]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 3)
        XCTAssert(multiLineStringResult[0].count == 4)
        XCTAssert(multiLineStringResult[1].count == 6)
        XCTAssert(multiLineStringResult[2].count == 4)
    }

    func testMultiLineStringSimplify_lineStringsShouldNotBeMergedYet() {
        let multiLineString = MultiLineString([LineString([[-40, 40], [-20, 20], [0, 20], [20, 20], [40, 40]]),
                                               LineString([[-40, 0], [-20, 0], [0, 20], [10, 20], [10, 20], [20, 10], [40, 10]]),
                                               LineString([[60, 10], [20, 10], [10, 20], [5, 20]])])
        let multiLineStringResult = multiLineString.simplify(tolerance: 1.0)

        XCTAssert(multiLineStringResult.count == 3)
        XCTAssert(multiLineStringResult[0].count == 4)
        XCTAssert(multiLineStringResult[1].count == 6)
        XCTAssert(multiLineStringResult[2].count == 4)
    }
}
