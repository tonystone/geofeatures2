///
///  LinearRing+GeometryTests.swift
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

class LinearRingGeometryCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    // MARK: - Dimension

    func testDimension () {
        XCTAssertEqual(LinearRing([[1.0, 1.0]],precision: precision, coordinateSystem: cs).dimension, .one)
    }

    func testDimensionEmpty () {
        XCTAssertEqual(LinearRing(precision: precision, coordinateSystem: cs).dimension, .empty)
    }

    // MARK: - Boundary

    func testBoundaryWith1ElementInvalid() {
        let input = LinearRing([[1.0, 1.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith2Element() {
        let input = LinearRing([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint([Point([1.0, 1.0]), Point([2.0, 2.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith3ElementOpen() {
        let input = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint([Point([1.0, 1.0]), Point([3.0, 3.0])], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryWith4ElementClosed() {
        let input = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs) // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    func testBoundaryEmpty() {
        let input = LinearRing(precision: precision, coordinateSystem: cs).boundary()
        let expected = MultiPoint(precision: precision, coordinateSystem: cs)  // Empty Set

        XCTAssertTrue(input == expected, "\(input) is not equal to \(expected)")
    }

    // MARK: - Bounds

    func testBoundsEmpty() {
        let input = LinearRing(precision: precision, coordinateSystem: cs)
        let expected: Bounds? = nil

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBoundsWithElements() {
        let input = LinearRing([[1.0, 1.0], [2.0, 2.0], [3.0, 3.0], [1.0, 1.0]], precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 1.0, y: 1.0), max: (x: 3.0, y: 3.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    // MARK: - Equal

    func testEqualTrue() {
        let input1 = LinearRing([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let input2 = LinearRing([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
     }

     func testEqualFalse() {
        let input1            = LinearRing([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = Point([1.0, 1.0], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
     }

    // MARK: - Simplify

    func testLinearRingSimplify_noPoints() {
        let linearRing = LinearRing([])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 0)
    }

    func testLinearRingSimplify_onePoint() {
        let linearRing = LinearRing([[100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 1)
    }

    func testLinearRingSimplify_twoIdenticalPoints() {
        let linearRing = LinearRing([[100, 100], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 2)
    }

    func testLinearRingSimplify_threeIdenticalPoints() {
        let linearRing = LinearRing([[100, 100], [100, 100], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 2)
    }

    func testLinearRingSimplify_fourIdenticalPoints() {
        let linearRing = LinearRing([[100, 100], [100, 100], [100, 100], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 2)
    }

    func testLinearRingSimplify_sixPointsThreeUnique_sameSlope() {
        let linearRing = LinearRing([[100, 100], [100, 100], [150, 150], [200, 200], [200, 200], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 3)
    }

    func testLinearRingSimplify_sixPointsThreeUnique_threeDifferentSlopes() {
        let linearRing = LinearRing([[100, 100], [100, 100], [150, 150], [200, 150], [200, 150], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 4)
    }

    func testLinearRingSimplify_multipleIntermediatePoints_fourDifferentSlopes() {
        let linearRing = LinearRing([[100, 100], [100, 100], [200, 200], [300, 300], [300, 300], [400, 300], [500, 300], [600, 300], [600, 300], [600, 400], [600, 600], [600, 800], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 5)
    }

    func testLinearRingSimplify_square() {
        let linearRing = LinearRing([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 5)
    }

    func testLinearRingSimplify_sameLineSegmentTwice() {
        let linearRing = LinearRing([[100, 100], [200, 200], [200, 200], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 3)
    }

    func testLinearRingSimplify_sameLineSegmentFourTimes() {
        let linearRing = LinearRing([[100, 100], [200, 200], [200, 200], [100, 100], [100, 100], [200, 200], [200, 200], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 3)
    }

    func testLinearRingSimplify_sameSlopeTwoReversals() {
        let linearRing = LinearRing([[100, 100], [300, 300], [200, 200], [500, 500], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 5)
    }

    func testLinearRingSimplify_sameSlopeTwoReversalsAndOtherPoints() {
        let linearRing = LinearRing([[0, 1], [1, 1], [2, 2], [0, 0], [1, 1], [5, 1], [0, 1]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 7)
    }

    func testLinearRingSimplify_sameSquareTwice() {
        let linearRing = LinearRing([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100], [100, 100], [100, 200], [200, 200], [200, 100], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 5)
    }

    func testLinearRingSimplify_sameSquareTwice_secondTimeReversed() {
        let linearRing = LinearRing([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100], [100, 100], [200, 100], [200, 200], [100, 200], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 5)
    }

    /// Note this LinearRing could be simplified if we added a check for the reverse of a line segment to match a previous segment.
    func testLinearRingSimplify_overlappingRectangleWithLoop() {
        let linearRing = LinearRing([[0, 0], [0, 10], [20, 10], [20, 0], [8, 0], [8, 4], [12, 4], [12, 0], [0, 0], [0, 10], [20, 10], [20, 0], [0, 0], [0, 10], [0, 0]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)

        XCTAssert(linearRingResult.count == 15)
    }
}
