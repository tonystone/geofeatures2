///
///  IntersectionMatrix+HelpersTests.swift
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
///  Created by Ed Swiss on 9/4/17.
///
import XCTest
@testable import GeoFeatures

#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS)) && SWIFT_PACKAGE
    /// TODO: Remove this after figuring out why there seems to be a symbol conflict (error: cannot specialize a non-generic definition) with another Polygon on Swift PM on Apple platforms only.
    import struct GeoFeatures.Polygon
#endif

// MARK: - All

private typealias CoordinateType = Coordinate2D

class IntersectionMatrixHelperTests: XCTestCase {

    let precision = FloatingPrecision()
    let cs        = Cartesian()

    ///
    /// Point Point tests
    ///

    func testPoint_Point_noIntersection() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_Point_identicalPoints() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// Point MultiPoint tests
    ///

    func testPoint_MultiPoint_noIntersection() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_MultiPoint_firstProperSubsetOfSecond() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.zero, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_MultiPoint_firstImproperSubsetOfSecond() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiPoint Point tests
    ///

    func testMultiPoint_Point_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Point_secondProperSubsetOfFirst() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Point_secondImproperSubsetOfFirst() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiPoint MultiPoint tests
    ///

    func testMultiPoint_MultiPoint_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0)), Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 3.0, y: 3.0)), Point<CoordinateType>(coordinate: (x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPoint_firstIntersectsSecondButNotSubset() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 1.0, y: 1.0)), Point<CoordinateType>(coordinate: (x: 3.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 3.0, y: 3.0)), Point<CoordinateType>(coordinate: (x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.zero, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPoint_firstProperSubsetOfSecond() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 3.0, y: 3.0)), Point<CoordinateType>(coordinate: (x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 3.0, y: 3.0)), Point<CoordinateType>(coordinate: (x: 4.0, y: 4.0)), Point<CoordinateType>(coordinate: (x: 5.0, y: 5.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.zero, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPoint_secondProperSubsetOfFirst() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 3.0, y: 3.0)), Point<CoordinateType>(coordinate: (x: 4.0, y: 4.0)), Point<CoordinateType>(coordinate: (x: 5.0, y: 5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 3.0, y: 3.0)), Point<CoordinateType>(coordinate: (x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPoint_firstImproperSubsetOfSecond() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 3.0, y: 3.0)), Point<CoordinateType>(coordinate: (x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<CoordinateType>(coordinate: (x: 3.0, y: 3.0)), Point<CoordinateType>(coordinate: (x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// Point LineString tests
    ///

    func testPoint_LineString_noIntersection() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_LineString_firstSubsetOfSecondInterior() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 1.0, y: 1.5), precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_LineString_firstSubsetOfSecondBoundary() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 1.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// Point LinearRing tests
    ///

    func testPoint_LinearRing_noIntersection() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_LinearRing_firstSubsetOfSecondInterior() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 1.5, y: 1.0), precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// Point MultiLineString tests
    ///

    func testPoint_MultiLineString_noIntersection() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_MultiLineString_firstSubsetOfSecondInterior() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_MultiLineString_firstSubsetOfSecondBoundary() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 3.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiPoint LineString tests
    ///

    func testMultiPoint_LineString_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 0.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 3.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LineString_firstSubsetOfSecondInterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.5, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 3.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LineString_firstProperSubsetOfSecondBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LineString_firstImproperSubsetOfSecondBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondInteriorAndBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondInteriorAndCoversBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondInteriorAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondBoundaryAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .zero],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LineString_firstCoversSecondBoundaryAndTouchesExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .zero],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondInteriorAndBoundaryAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondInteriorAndExteriorAndCoversBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.5)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.one,   .empty,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiPoint LinearRing tests
    ///

    func testMultiPoint_LinearRing_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 0.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LinearRing_firstSubsetOfSecondInterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.5, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_LinearRing_firstTouchesSecondInteriorAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MutliPoint MultiLineString tests
    ///

    func testMultiPoint_MultiLineString_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 0.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 4.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiLineString_firstSubsetOfSecondInterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.5, y: 1.5)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiLineString_firstProperSubsetOfSecondBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiLineString_firstImproperSubsetOfSecondBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.8, y: 1.8))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndCoversBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.5, y: 1.5)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondBoundaryAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 5.0, y: 5.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 4.0), (x: 2.0, y: 4.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .zero],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiLineString_firstCoversSecondBoundaryAndTouchesExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 10.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 0.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 10.0, y: 0.0), (x: 0.0, y: 10.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .zero],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndBoundaryAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.5, y: 4.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 4.0), (x: 2.0, y: 4.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 5.0), (x: 3.0, y: 5.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndExteriorAndCoversBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 6.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 7.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.5)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 6.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 2.0), (x: 3.0, y: 7.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// Point Polygon tests
    ///

    func testPoint_Polygon_outerRingOnly_noIntersection() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_Polygon_outerRingAndInnerRing_outsideMainRing_noIntersection() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: -20.0, y: -20.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_Polygon_outerRingAndInnerRing_insideInnerRing_noIntersection() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: -3.0, y: 0.0), (x: 0.0, y: -3.0), (x: 3.0, y: 0.0), (x: 0.0, y: 3.0), (x: -3.0, y: 0.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_Polygon_outerRingOnly_intersectsBoundary() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 2.0, y: 2.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_Polygon_outerRingAndInnerRing_intersectsOuterBoundary() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: -10.0, y: 5.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_Polygon_outerRingAndInnerRing_intersectsInnerBoundary() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 4.0, y: 4.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_Polygon_outerRingOnly_intersectsInterior() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 2.5, y: 2.5), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_Polygon_outerRingAndInnerRing_intersectsInterior() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: -1.0, y: 4.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// Point MultiPolygon tests
    ///

    func testPoint_MultiPolygon_outerRingsOnly_noIntersection() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: -6.0, y: 2.0), (x: -4.0, y: 6.0), (x: -2.0, y: 2.0), (x: -6.0, y: 2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_MultiPolygon_outerRingAndInnerRings_outsideMainRings_noIntersection() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: -20.0, y: -20.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_MultiPolygon_outerRingAndInnerRing_insideInnerRing_noIntersection() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 6.0, y: -4.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_MultiPolygon_outerRingOnly_intersectsBoundary() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: -5.0, y: 4.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: -6.0, y: 2.0), (x: -4.0, y: 6.0), (x: -2.0, y: 2.0), (x: -6.0, y: 2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterBoundary() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 6.0, y: -2.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_MultiPolygon_outerRingAndInnerRing_intersectsInnerBoundary() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 5.0, y: -4.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_MultiPolygon_outerRingOnly_intersectsInterior() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: -4.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: -6.0, y: 2.0), (x: -4.0, y: 6.0), (x: -2.0, y: 2.0), (x: -6.0, y: 2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testPoint_MultiPolygon_outerRingAndInnerRing_intersectsInterior() {

        let geometry1 = Point<CoordinateType>(coordinate: (x: 6.0, y: -9.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiPoint Polygon tests
    ///

    func testMultiPoint_Polygon_outerRingOnly_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 10.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 0.5, y: 4.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_outsideMainRing_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 11.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 0.5, y: 14.0)), Point<Coordinate2D>(coordinate: (x: -11.0, y: -5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_insideInnerRing_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: -0.5, y: 0.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: -3.0, y: 0.0), (x: 0.0, y: -3.0), (x: 3.0, y: 0.0), (x: 0.0, y: 3.0), (x: -3.0, y: 0.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 11.0, y: 11.0)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5)), Point<Coordinate2D>(coordinate: (x: -5.0, y: -3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -6.0, y: -1.0), (x: -6.0, y: -5.0), (x: -2.0, y: -5.0), (x: -2.0, y: -1.0), (x: -6.0, y: -1.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsBoundaryOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 4.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsOuterBoundaryOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -10.0, y: 3.4)), Point<Coordinate2D>(coordinate: (x: 2.5, y: -10.0)), Point<Coordinate2D>(coordinate: (x: 10.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInnerBoundaryOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 4.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 4.0, y: 4.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 4.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 4.0, y: -10.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -2.0, y: -3.0)), Point<Coordinate2D>(coordinate: (x: 10.0, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -6.0, y: -1.0), (x: -6.0, y: -5.0), (x: -2.0, y: -5.0), (x: -2.0, y: -1.0), (x: -6.0, y: -1.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsInteriorOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 4.0, y: 2.2))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -2.0, y: -3.0)), Point<Coordinate2D>(coordinate: (x: 6.0, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 4.0, y: 0.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -8.0, y: -8.0)), Point<Coordinate2D>(coordinate: (x: 6.0, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 4.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: -0.5, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -6.0, y: -1.0), (x: -6.0, y: -5.0), (x: -2.0, y: -5.0), (x: -2.0, y: -1.0), (x: -6.0, y: -1.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 4.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -10.0, y: 3.4)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 5.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -9.0, y: -9.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 8.0, y: 7.0)), Point<Coordinate2D>(coordinate: (x: 4.0, y: -10.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -2.0, y: -3.0)), Point<Coordinate2D>(coordinate: (x: 10.0, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 4.0, y: 4.0)), Point<Coordinate2D>(coordinate: (x: -1.0, y: -0.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -6.0, y: -1.0), (x: -6.0, y: -5.0), (x: -2.0, y: -5.0), (x: -2.0, y: -1.0), (x: -6.0, y: -1.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -2.0, y: -2.0)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -9.0, y: 3.4)), Point<Coordinate2D>(coordinate: (x: 12.5, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 5.0, y: -8.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -9.0, y: 9.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -4.0, y: -2.0)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5)), Point<Coordinate2D>(coordinate: (x: -5.0, y: -11.0)), Point<Coordinate2D>(coordinate: (x: -1.0, y: -0.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -6.0, y: -1.0), (x: -6.0, y: -5.0), (x: -2.0, y: -5.0), (x: -2.0, y: -1.0), (x: -6.0, y: -1.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsBoundaryAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 0.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 10.0, y: 8.6)), Point<Coordinate2D>(coordinate: (x: 12.5, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 5.0, y: -10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 10.0, y: 9.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -6.0, y: -2.0)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5)), Point<Coordinate2D>(coordinate: (x: -5.0, y: -3.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -6.0, y: -1.0), (x: -6.0, y: -5.0), (x: -2.0, y: -5.0), (x: -2.0, y: -1.0), (x: -6.0, y: -1.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndBoundaryAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 10.0, y: 8.6)), Point<Coordinate2D>(coordinate: (x: 12.5, y: 0.0)), Point<Coordinate2D>(coordinate: (x: -8.0, y: -8.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 10.0, y: 9.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 7.0, y: 4.3)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 12.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -6.0, y: -2.0)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5)), Point<Coordinate2D>(coordinate: (x: -5.0, y: -3.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 5.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: -1.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 13.0, y: -5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -10.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: -10.0), (x: -10.0, y: -10.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -6.0, y: -1.0), (x: -6.0, y: -5.0), (x: -2.0, y: -5.0), (x: -2.0, y: -1.0), (x: -6.0, y: -1.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiPoint MultiPolygon tests
    ///

    func testMultiPoint_MultiPolygon_outerRingOnly_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 10.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 0.5, y: -4.0)), Point<Coordinate2D>(coordinate: (x: -1.0, y: 5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: -6.0, y: 2.0), (x: -4.0, y: 6.0), (x: -2.0, y: 2.0), (x: -6.0, y: 2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_outsideMainRing_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 11.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 0.5, y: 14.0)), Point<Coordinate2D>(coordinate: (x: -11.0, y: -5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_insideInnerRing_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 5.5, y: -3.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 11.0, y: 11.0)), Point<Coordinate2D>(coordinate: (x: 6.0, y: -3.5)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -8.0, y: 3.0), (x: -2.0, y: 3.0), (x: -5.0, y: 9.0), (x: -8.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 10.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)], [(x: 3.0, y: -10.0), (x: 3.0, y: -15.0), (x: 7.0, y: -15.0), (x: 7.0, y: -10.0), (x: 3.0, y: -10.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsBoundaryOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 4.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: -3.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: -6.0, y: 2.0), (x: -4.0, y: 6.0), (x: -2.0, y: 2.0), (x: -6.0, y: 2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterBoundaryOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -10.0, y: 3.4)), Point<Coordinate2D>(coordinate: (x: 4.0, y: -6.0)), Point<Coordinate2D>(coordinate: (x: 10.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInnerBoundaryOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 6.0, y: -3.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 4.0)), Point<Coordinate2D>(coordinate: (x: 5.0, y: -4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 6.0, y: -3.0)), Point<Coordinate2D>(coordinate: (x: 5.0, y: -4.0)), Point<Coordinate2D>(coordinate: (x: -9.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -7.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 6.0, y: -10.0)), Point<Coordinate2D>(coordinate: (x: 10.0, y: 9.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -8.0, y: 3.0), (x: -2.0, y: 3.0), (x: -5.0, y: 9.0), (x: -8.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 10.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)], [(x: 3.0, y: -10.0), (x: 3.0, y: -15.0), (x: 7.0, y: -15.0), (x: 7.0, y: -10.0), (x: 3.0, y: -10.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -4.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: -4.0, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.2))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: -6.0, y: 2.0), (x: -4.0, y: 6.0), (x: -2.0, y: 2.0), (x: -6.0, y: 2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -9.0, y: 9.0)), Point<Coordinate2D>(coordinate: (x: 6.0, y: -9.0)), Point<Coordinate2D>(coordinate: (x: 0.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorOnly() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -9.0, y: 9.0)), Point<Coordinate2D>(coordinate: (x: 2.5, y: -3.5)), Point<Coordinate2D>(coordinate: (x: 9.0, y: -19.0)), Point<Coordinate2D>(coordinate: (x: 8.0, y: -8.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -8.0, y: 3.0), (x: -2.0, y: 3.0), (x: -5.0, y: 9.0), (x: -8.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 10.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)], [(x: 3.0, y: -10.0), (x: 3.0, y: -15.0), (x: 7.0, y: -15.0), (x: 7.0, y: -10.0), (x: 3.0, y: -10.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -4.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: -2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: -4.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: -6.0, y: 2.0), (x: -4.0, y: 6.0), (x: -2.0, y: 2.0), (x: -6.0, y: 2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 6.0, y: -2.4)), Point<Coordinate2D>(coordinate: (x: 10.0, y: 4.0)), Point<Coordinate2D>(coordinate: (x: 5.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -9.0, y: 9.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -9.0, y: 7.0)), Point<Coordinate2D>(coordinate: (x: 6.0, y: -10.0)), Point<Coordinate2D>(coordinate: (x: 5.0, y: -4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 9.1, y: -2.8)), Point<Coordinate2D>(coordinate: (x: 6.0, y: -10.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: -18.0)), Point<Coordinate2D>(coordinate: (x: 2.5, y: -2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -8.0, y: 3.0), (x: -2.0, y: 3.0), (x: -5.0, y: 9.0), (x: -8.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 10.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)], [(x: 3.0, y: -10.0), (x: 3.0, y: -15.0), (x: 7.0, y: -15.0), (x: 7.0, y: -10.0), (x: 3.0, y: -10.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .empty],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -2.0, y: -2.0)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5)), Point<Coordinate2D>(coordinate: (x: -4.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: -6.0, y: 2.0), (x: -4.0, y: 6.0), (x: -2.0, y: 2.0), (x: -6.0, y: 2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -9.0, y: 3.4)), Point<Coordinate2D>(coordinate: (x: 6.0, y: -2.5)), Point<Coordinate2D>(coordinate: (x: 15.0, y: -8.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: -9.0, y: 9.0)), Point<Coordinate2D>(coordinate: (x: 6.0, y: -4.0)), Point<Coordinate2D>(coordinate: (x: 6.5, y: -4.8))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 5.0, y: -11.0)), Point<Coordinate2D>(coordinate: (x: 6.0, y: -4.0)), Point<Coordinate2D>(coordinate: (x: -25.0, y: -11.0)), Point<Coordinate2D>(coordinate: (x: 9.5, y: 9.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -8.0, y: 3.0), (x: -2.0, y: 3.0), (x: -5.0, y: 9.0), (x: -8.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 10.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)], [(x: 3.0, y: -10.0), (x: 3.0, y: -15.0), (x: 7.0, y: -15.0), (x: 7.0, y: -10.0), (x: 3.0, y: -10.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsBoundaryAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 0.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: -4.0, y: 6.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: -6.0, y: 2.0), (x: -4.0, y: 6.0), (x: -2.0, y: 2.0), (x: -6.0, y: 2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 10.0, y: 8.6)), Point<Coordinate2D>(coordinate: (x: 12.5, y: 0.0)), Point<Coordinate2D>(coordinate: (x:7.0, y: -4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 6.0, y: -4.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 4.0, y: -6.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 4.0, y: -12.0)), Point<Coordinate2D>(coordinate: (x: 6.0, y: -4.0)), Point<Coordinate2D>(coordinate: (x: 11.0, y: -21.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: -11.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -8.0, y: 3.0), (x: -2.0, y: 3.0), (x: -5.0, y: 9.0), (x: -8.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 10.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)], [(x: 3.0, y: -10.0), (x: 3.0, y: -15.0), (x: 7.0, y: -15.0), (x: 7.0, y: -10.0), (x: 3.0, y: -10.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero, .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndBoundaryAndExterior() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5)), Point<Coordinate2D>(coordinate: (x: -4.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: 1.0, y: 3.0), (x: 3.0, y: 5.0), (x: 5.0, y: 3.0), (x: 3.0, y: 1.0), (x: 1.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: -6.0, y: 2.0), (x: -4.0, y: 6.0), (x: -2.0, y: 2.0), (x: -6.0, y: 2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 10.0, y: 8.6)), Point<Coordinate2D>(coordinate: (x: 12.5, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 5.0, y: -2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 9.0, y: 9.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 6.0, y: -11.0)), Point<Coordinate2D>(coordinate: (x: 7.0, y: -4.3)), Point<Coordinate2D>(coordinate: (x: 9.0, y: -2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 6.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 9.0, y: -19.0)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 6.0, y: -4.0)), Point<Coordinate2D>(coordinate: (x: 13.0, y: 5.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: -11.0)), Point<Coordinate2D>(coordinate: (x: 10.0, y: -18.0)), Point<Coordinate2D>(coordinate: (x: -9.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -10.0, y: 0.0), (x: -10.0, y: 10.0), (x: 10.0, y: 10.0), (x: 10.0, y: 0.0), (x: -10.0, y: 0.0)], [[(x: 1.0, y: 3.0), (x: 3.0, y: 1.0), (x: 5.0, y: 3.0), (x: 3.0, y: 5.0), (x: 1.0, y: 3.0)], [(x: -8.0, y: 3.0), (x: -2.0, y: 3.0), (x: -5.0, y: 9.0), (x: -8.0, y: 3.0)]])), Polygon<Coordinate2D>(rings: ([(x: 10.0, y: -2.0), (x: 10.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)], [[(x: 5.0, y: -3.0), (x: 5.0, y: -5.0), (x: 7.0, y: -5.0), (x: 7.0, y: -3.0), (x: 5.0, y: -3.0)], [(x: 3.0, y: -10.0), (x: 3.0, y: -15.0), (x: 7.0, y: -15.0), (x: 7.0, y: -10.0), (x: 3.0, y: -10.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .zero,  .zero],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LineString Point tests
    ///

    func testLineString_Point_noIntersection() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Point_firstSubsetOfSecondInterior() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 1.0, y: 1.5), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Point_firstSubsetOfSecondBoundary() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 1.0, y: 3.0), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LineString MultiPoint tests
    ///

    func testLineString_MultiPoint_noIntersection() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 3.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 0.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPoint_firstSubsetOfSecondInterior() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 1.0), (x: 3.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.5, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPoint_firstProperSubsetOfSecondBoundary() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPoint_firstImproperSubsetOfSecondBoundary() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPoint_firstTouchesSecondInteriorAndBoundary() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.zero,  .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPoint_firstTouchesSecondInteriorAndCoversBoundary() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 2.5)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.zero,  .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPoint_firstTouchesSecondInteriorAndExterior() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPoint_firstTouchesSecondBoundaryAndExterior() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPoint_firstCoversSecondBoundaryAndTouchesExterior() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .empty],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPoint_firstTouchesSecondInteriorAndBoundaryAndExterior() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.5))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.zero,  .empty, .zero],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPoint_firstTouchesSecondInteriorAndExteriorAndCoversBoundary() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.5)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 3.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero, .empty, .one],
            [.zero, .empty, .empty],
            [.zero, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LineString LineString tests
    ///

    func testLineString_LineString_noIntersection() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_interiorsIntersectAtOnePointFirstSegments() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -2.0, y: 0.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_interiorsIntersectAtOnePointSecondSegments() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 10.0, y: 6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    /// TODO: Add more tests like this one, where the line strings touch at a point but do not cross.
    func testLineString_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -2.0, y: 0.0), (x: -2.0, y: -2.0), (x: -5.0, y: -2.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_interiorsIntersectAtTwoPointsBothSegments() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -2.0, y: 0.0), (x: 2.0, y: -2.0), (x: 10.0, y: 6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_firstInteriorIntersectsSecondBoundary() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 0.0, y: -12.0), (x: 2.0, y: -2.0), (x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_firstInteriorIntersectsSecondBoundary_FirstBoundaryPoint() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -3.0, y: -3.0), (x: 2.0, y: -8.0), (x: 2.0, y: -10.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_firstInteriorIntersectsSecondBoundary_SecondBoundaryPoint() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 0.0, y: -12.0), (x: 2.0, y: -2.0), (x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -3.0, y: -3.0), (x: 2.0, y: -8.0), (x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.empty, .zero,  .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesFirstBoundaryPoint() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 6.0, y: -2.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.zero,  .zero,  .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesSecondBoundaryPoint() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.zero,  .zero,  .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: 2.0, y: 2.0), (x: 6.0, y: -2.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.zero,  .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -7.0, y: -7.0), (x: 2.0, y: 2.0), (x: 6.0, y: -2.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: 2.0, y: 2.0), (x: 12.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LineString_secondProperSubsetOfFirst() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -10.0, y: -10.0), (x: 2.0, y: 2.0), (x: 12.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LineString LinearRing tests
    ///

    func testLineString_LinearRing_noIntersection() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -2.0, y: 0.0), (x: -2.0, y: -2.0), (x: -5.0, y: -2.0), (x: -2.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LinearRing_interiorsIntersectAtOnePointSecondSegments() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 10.0, y: 6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    /// TODO: Add more tests like this one, where the line string and linear ring touch at a point but do not cross.
    func testLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 4.0, y: -8.0), (x: -3.0, y: -3.0), (x: 10.0, y: -3.0), (x: 4.0, y: -8.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LinearRing_interiorsIntersectAtTwoPointsBothSegments() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -2.0, y: 0.0), (x: 2.0, y: -2.0), (x: 10.0, y: 6.0), (x: -2.0, y: 6.0), (x: -2.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LinearRing_firstInteriorIntersectsSecondInteriorAtSegmentEndpoint() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 0.0, y: -12.0), (x: 2.0, y: -2.0), (x: 4.0, y: 0.0), (4.0, -8.0), (x: 0.0, y: -12.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_FirstBoundaryPoint() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: -5.0), (x: 2.0, y: -10.0), (x: -5.0, y: -10.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_SecondBoundaryPoint() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -6.0), (x: 10.0, y: -6.0), (x: 10.0, y: -10.0), (x: 1.0, y: -10.0), (x: 1.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_BothBoundaryPoints() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -8.0, y: -5.0), (x: -1.0, y: -5.0), (x: -1.0, y: -6.0), (x: 10.0, y: -6.0), (x: 10.0, y: -8.0), (x: -8.0, y: -8.0), (x: -8.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.zero,  .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing2() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 10.0, y: -6.0), (x: -5.0, y: -5.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.zero,  .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing3() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 10.0, y: -6.0), (x: 2.0, y: 2.0), (x: -4.9, y: -4.9)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.zero,  .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing4() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.zero,  .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LineString MultiLineString tests
    ///

    func testLineString_MultiLineString_noIntersection() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -1.5), (x: 10.0, y: -1.5), (x: 10.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: 2.0), (x: -3.0, y: 2.0), (x: -3.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -4.0, y: -8.0), (x: -4.0, y: -2.5), (x: 10.0, y: -2.5)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -12.0, y: -8.0), (x: -3.0, y: -8.0), (x: -3.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    /// TODO: Add more tests like this one, where the line strings touch at a point but do not cross.
    func testLineString_MultiLineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -7.0, y: 8.0), (x: -3.0, y: 4.0), (x: 1.0, y: 8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -2.0, y: 7.0), (x: -2.0, y: -2.5), (x: 5.0, y: -2.5)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString1() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: 4.0, y: -1.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString2() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 0.0, y: -10.0), (x: 0.0, y: -3.0), (x: 12.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString1() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -2.0, y: 1.0), (x: -9.0, y: 1.0), (x: -9.0, y: -9.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString2() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -2.0, y: -10.0), (x: -2.0, y: 1.0), (x: 0.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_FirstLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 1.0, y: -5.0), (x: 1.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_SecondLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: -5.0, y: 1.0), (x: 0.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_AllBoundaryPoints() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -5.0, y: 1.0), (x: 1.0, y: 1.0), (x: 1.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings_FirstLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.empty, .zero,  .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings_SecondLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.empty, .zero,  .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesFirstBoundaryPointOfSecondLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -2.0, y: 4.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.zero,  .zero,  .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesSecondBoundaryPointOfFirstLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.5, y: -1.5), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.zero,  .zero,  .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint_FirstLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.5, y: -1.5), (x: 2.0, y: -2.0), (x: 1.5, y: -2.5)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.zero,  .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint_SecondLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -3.0, y: 4.0), (x: -2.0, y: 4.0), (x: -1.5, y: 4.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.zero,  .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap_FirstLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 0.0, y: 0.0), (x: 4.0, y: -4.0), (x: 4.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap_SecondLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -1.0, y: 9.0), (x: -1.0, y: -4.0), (x: -5.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiLineString_secondProperSubsetOfFirst() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -10.0, y: -10.0), (x: 2.0, y: 2.0), (x: 12.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -9.0, y: -9.0), (x: -7.0, y: -7.0), (x: -3.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 1.0), (x: 4.0, y:0.0), (x: 5.0, y: -1.0), (x: 7.0, y: -3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LineString Polygon tests
    ///

    func testLineString_Polygon_noIntersection() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_withHole_noIntersection_lineStringOutsideMainPolygon() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_withHole_noIntersection_lineStringInsideHole() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -7.0, y: -5.0), (x: -5.0, y: -5.0), (x: -7.0, y: -7.0), (x: -5.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_interiorsIntersect_lineStringFirstSegment() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 4.0, y: -4.0), (x: 7.0, y: -1.0), (x: 12.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_interiorsIntersect_lineStringSecondSegment() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 4.0, y: -4.0), (x: 7.0, y: -7.0), (x: 12.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    /// TODO: Add more tests like this one, where the line string and polygon touch at a point but do not cross.
    func testLineString_Polygon_interiorIntersectsBoundaryAtOnePoint_lineStringFirstSegment_doNotCross() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 5.5, y: 5.0), (x: 5.5, y: -2.5), (x: 10.0, y: -2.5)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_interiorIntersectsBoundaryAtOnePoint_lineStringInsideHole_doNotCross() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -7.0, y: -7.0), (x: -8.0, y: -6.0), (x: -7.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringOutsideMainLinearRing() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 12.0, y: 10.0), (x: 12.0, y: -7.0), (x: 4.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringOutsideMainLinearRing() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 4.0, y: -1.0), (x: 12.0, y: -1.0), (x: 12.0, y: -7.0), (x: 4.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringInsideHole() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -7.0, y: -7.0), (x: -7.0, y: -6.0), (x: -4.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringInsideHole() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -7.0, y: -8.0), (x: -7.0, y: -6.0), (x: -4.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_intersectsPolygonBoundaryInteriorExterior() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 4.0, y: -4.0), (x: 0.0, y: 0.0), (x: 0.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -9.0, y: -9.0), (x: -7.0, y: -7.0), (x: -6.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -4.0, y: -6.0), (x: 10.0, y: -6.0), (x: 10.0, y: -4.0), (x: 0.0, y: -4.0), (x: 0.0, y: -3.0), (x: 12.0, y: -3.0), (x: 12.0, y: 5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -7.0, y: -7.0), (x: 0.0, y: -14.0), (x: 0.0, y: -6.0), (x: -6.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LineString MultiPolygon tests
    ///

    func testLineString_MultiPolygon_noIntersection() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_withHoles_noIntersection_lineStringOutsideMainPolygon() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [[(x: -9.0, y: 12.0), (x: -9.0, y: 10.0), (x: -7.0, y: 10.0), (x: -7.0, y: 12.0), (x: -9.0, y: 12.0)], [(x: -3.0, y: 4.0), (x: -3.0, y: 8.0), (x: -6.0, y: 8.0), (x: -6.0, y: 4.0), (x: -3.0, y: 4.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 20.0, y: -2.0)], [[(x: 11.0, y: -12.0), (x: 5.0, y: -18.0), (x: 11.0, y: -18.0), (x: 11.0, y: -12.0)], [(x: 12.0, y: -11.0), (x: 12.0, y: -19.0), (x: 19.0, y: -19.0), (x: 19.0, y: -11.0), (x: 12.0, y: -11.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_withHoles_noIntersection_lineStringInsideHole() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 13.0, y: -12.0), (x: 18.0, y: -15.0), (x: 13.0, y: -18.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [[(x: -9.0, y: 12.0), (x: -9.0, y: 10.0), (x: -7.0, y: 10.0), (x: -7.0, y: 12.0), (x: -9.0, y: 12.0)], [(x: -3.0, y: 4.0), (x: -3.0, y: 8.0), (x: -6.0, y: 8.0), (x: -6.0, y: 4.0), (x: -3.0, y: 4.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 20.0, y: -2.0)], [[(x: 11.0, y: -12.0), (x: 5.0, y: -18.0), (x: 11.0, y: -18.0), (x: 11.0, y: -12.0)], [(x: 12.0, y: -11.0), (x: 12.0, y: -19.0), (x: 19.0, y: -19.0), (x: 19.0, y: -11.0), (x: 12.0, y: -11.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersect_firstPolygon() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 4.0, y: 0.0), (x: 0.0, y: 7.0), (x: -5.0, y: 5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersect_firstPolygon_withHole() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -10.0, y: 10.0), (x: -10.0, y: 12.0), (x: -5.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersect_secondPolygon() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 0.0, y: 10.0), (x: 6.0, y: 0.0), (x: 6.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersect_secondPolygon_withHole() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 15.0, y: -15.0), (x: 14.0, y: -18.0), (x: 18.0, y: -18.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -3.0, y: 10.0), (x: 0.0, y: 12.0), (x: 10.0, y: -18.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .empty],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_boundariesIntersect_firstPolygon_withHoles() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -20.0, y: 18.0), (x: -30.0, y: 30.0), (x: -50.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero,  .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_boundariesIntersect_secondPolygon_withHoles() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 0.0, y: -40.0), (x: 22.0, y: -30.0), (x: 15.0, y: -20.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero,  .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_boundariesIntersect_bothPolygons_withHoles() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 20.0, y: -20.0), (x: 0.0, y: -50.0), (x: -100.0, y: 0.0), (x: -18.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero,  .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 21.0, y: -3.0), (x: 10.0, y: 8.0), (x: 5.0, y: 20.0), (x: -34.0, y: 20.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .one,   .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 21.0, y: -3.0), (x: 10.0, y: 8.0), (x: 5.0, y: 20.0), (x: -34.0, y: 20.0), (x: -12.0, y: 12.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .one,   .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersectAndBoundariesIntersect_withHoles() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 21.0, y: -3.0), (x: 10.0, y: 8.0), (x: 5.0, y: 20.0), (x: -34.0, y: 20.0), (x: -8.0, y: 9.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .one,  .one],
            [.empty, .zero, .zero],
            [.two,   .one,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLineString_MultiPolygon_boundaryIntersectsInteriorAndBoundary_withHoles() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: 20.0, y: -2.0), (x: 10.0, y: 8.0), (x: 5.0, y: 20.0), (x: -34.0, y: 20.0), (x: -7.0, y: 9.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .one,  .one],
            [.zero, .zero, .empty],
            [.two,  .one,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LinearRing Point tests
    ///

    func testLinearRing_Point_noIntersection() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 4.0), (x: 4.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Point_secondSubsetOfFirstInterior_firstSegment() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 4.0), (x: 4.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 1.0, y: 1.5), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Point_secondSubsetOfFirstInterior_lastSegment() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 4.0), (x: 4.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 3.0, y: 1.0), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LinearRing MultiPoint tests
    ///

    func testLinearRing_MultiPoint_noIntersection() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 4.0), (x: 4.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 0.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 3.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPoint_secondSubsetOfFirstInterior() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 4.0), (x: 4.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.5)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPoint_secondTouchesFirstInteriorAndExterior() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 4.0), (x: 4.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 0.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 3.1, y: 1.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LinearRing LineString tests
    ///

    func testLinearRing_LineString_noIntersection() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -1.0), (x: 1.0, y: -5.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_interiorsIntersectAtOnePointLineStringFirstSegment() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -1.0), (x: 1.0, y: -5.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 0.0, y: 0.0), (x: 2.0, y: -2.0), (x: 2.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero , .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_interiorsIntersectAtOnePointSecondSegments() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -1.0), (x: 1.0, y: -5.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 2.0, y: -2.0), (x: 2.0, y: -3.0), (x: 6.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    /// TODO: Add more tests like this one, where the line string and linear ring touch at a point but do not cross.
    func testLinearRing_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -1.0), (x: 1.0, y: -5.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 0.0, y: -2.0), (x: 2.0, y: 0.0), (x: 6.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_interiorsIntersectAtTwoPointsBothSegments() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -1.0), (x: 1.0, y: -5.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 3.0, y: 0.0), (x: 3.0, y: -2.0), (x: 6.0, y: -2.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_firstInteriorIntersectsSecondInteriorAtMultipleSegmentEndpoints() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -1.0), (x: 1.0, y: -5.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 0.0, y: -2.0), (x: 3.0, y: 1.0), (x: 7.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_FirstBoundaryPoint() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -1.0), (x: 1.0, y: -5.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: -3.0), (x: -3.0, y: 4.0), (x: -7.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_SecondBoundaryPoint() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -1.0), (x: 1.0, y: -5.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -7.0, y: -3.0), (x: -3.0, y: 4.0), (x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_BothBoundaryPoints() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -1.0), (x: 1.0, y: -5.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 3.0, y: -3.0), (x: 10.0, y: -3.0), (x: 10.0, y: 3.0), (x: 3.0, y: 3.0), (x: 3.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing2() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 10.0, y: -6.0), (x: -5.0, y: -5.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing3() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 10.0, y: -6.0), (x: 2.0, y: 2.0), (x: -4.9, y: -4.9)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing4() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 2.0, y: 2.0), (x: 10.0, y: -6.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_geometriesShareSingleLineSegment_lineStringBoundaryDoesNotTouch() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -1.0), (x: 1.0, y: -5.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: -10.0), (x: 1.0, y: -5.0), (x: 5.0, y: -1.0), (x: 1.0, y: 5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LineString_geometriesShareSingleLineSegment_lineStringBoundaryTouchesAtPoint() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -1.0), (x: 1.0, y: -5.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: -10.0), (x: 1.0, y: -5.0), (x: 5.0, y: -1.0), (x: 3.0, y: 5.0), (x: 3.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }
    
    ///
    /// LinearRing LinearRing tests
    ///

    func testLinearRing_LinearRing_noIntersection() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: -1.0, y: -5.0), (x: -5.0, y: -1.0), (x: -1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LinearRing_noIntersection_firstInsideSecond() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -1.0, y: 10.0), (x: 20.0, y: 15.0), (x: 25.0, y: -30.0), (x: -1.0, y: -10.0), (x: -1.0, y: 10.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LinearRing_noIntersection_secondInsideFirst() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 15.0), (x: 15.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 2.0, y: 2.0), (x: 2.0, y: 4.0), (x: 4.0, y: 4.0), (x: 4.0, y: 2.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LinearRing_interiorsIntersectAtTwoPoints() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 2.0, y: 2.0), (x: -10.0, y: 2.0), (x: 2.0, y: 14.0), (x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LinearRing_interiorsIntersectAtTwoPoints_DoNotCross() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -10.0, y: 2.0), (x: 1.0, y: 2.0), (x: 0.0, y: 0.0), (x: 2.0, y: 1.0), (x: 2.0, y: -10.0), (x: -10.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LinearRing_firstInteriorIntersectsSecondInteriorAtThreeSegmentEndpoints() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 2.0, y: 0.0), (x: 0.0, y: 2.0), (x: 5.0, y: 17.0), (x: 5.0, y: 0.0), (x: 2.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LinearRing_linearRingsMatch_samePointOrder() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LinearRing_linearRingsMatch_differentPointOrder() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0), (x: 1.0, y: 5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_LinearRing_oneSegmentShared() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -5.0), (x: 1.0, y: 1.0), (x: 5.0, y: 1.0), (x: 5.0, y: -15.0), (x: 1.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LinearRing MultiLineString tests
    ///

    func testLinearRing_MultiLineString_noIntersection() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 2.0, y: 2.0), (x: 0.0, y: 2.0), (x: 0.0, y: 13.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: 2.0), (x: -3.0, y: 2.0), (x: -3.0, y: -3.0), (x: -5.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -4.0, y: -18.0), (x: -4.0, y: -2.5), (x: 10.0, y: -2.5), (x: -4.0, y: -18.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString() {

        let geometry1 = LineString<Coordinate2D>(elements: [(x: -12.0, y: -8.0), (x: -3.0, y: -8.0), (x: -3.0, y: 10.0), (x: -12.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    /// TODO: Add more tests like this one, where the linear ring and multiline string touch at a point but do not cross.
    func testLinearRing_MultiLineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -7.0, y: 8.0), (x: -3.0, y: 4.0), (x: 1.0, y: 8.0), (x: -7.0, y: 8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -2.0, y: 7.0), (x: -2.0, y: -2.5), (x: 5.0, y: -2.5), (x: -2.0, y: 7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString1() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: 4.0, y: -1.0), (x: 10.0, y: -6.0), (x: -1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString2() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 0.0, y: -10.0), (x: 0.0, y: -3.0), (x: 12.0, y: -3.0), (x: 0.0, y: -10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString1() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -2.0, y: 1.0), (x: -9.0, y: 1.0), (x: -9.0, y: -9.0), (x: -2.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString2() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -2.0, y: -10.0), (x: -2.0, y: 1.0), (x: 0.0, y: 1.0), (x: -2.0, y: -10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_FirstLineString() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 1.0, y: -5.0), (x: 1.0, y: 0.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_SecondLineString() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: -5.0, y: 1.0), (x: 0.0, y: 1.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_AllBoundaryPoints() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: 1.0), (x: 1.0, y: 1.0), (x: 1.0, y: -5.0), (x: -5.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_firstLineStringInteriorDoesNotIntersectLinearRingExterior() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_secondLineStringInteriorDoesNotIntersectLinearRingExterior() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0), (x: -4.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_neitherLineStringInteriorIntersectsLinearRingExterior() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 0.0, y: 0.0), (x: 2.0, y: -2.0), (x: 0.0, y: -4.0), (x: -4.0, y: -4.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 0.0), (x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_secondTouchesFirstInteriorAtLineSegmentAndPoint() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.5, y: -1.5), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0), (x: 1.5, y: -1.5)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)]), LineString<Coordinate2D>(elements: [(x: 6.0, y: -3.0), (x: 0.0, y: -3.0), (x: -3.0, y: 0.0), (x: -10.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_firstLineStringInsideLinearRing_secondLineStringBoundaryTouchesLinearRing() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -5.0), (x: 5.0, y: -9.0), (x: 1.0, y: -9.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 3.0, y: -3.0), (x: 5.0, y: -5.0), (x: 5.0, y: -7.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: -9.0), (x: 3.0, y: -11.0), (x: 5.0, y: -9.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_secondLineStringInsideLinearRing_firstLineStringBoundaryTouchesLinearRing() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -5.0), (x: 5.0, y: -9.0), (x: 1.0, y: -9.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 3.0, y: -3.0), (x: 3.0, y: 5.0), (x: 4.0, y: 5.0), (x: 4.0, y: -4.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: -7.0), (x: 1.0, y: -9.0), (x: 3.0, y: -9.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap_FirstLineString() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 0.0, y: 0.0), (x: 4.0, y: -4.0), (x: 0.0, y: -8.0), (x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap_SecondLineString() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -1.0, y: 9.0), (x: -1.0, y: -4.0), (x: -5.0, y: -8.0), (x: -1.0, y: 9.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_secondProperSubsetOfFirst() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -10.0, y: -10.0), (x: 2.0, y: 2.0), (x: 12.0, y: -8.0), (x: -10.0, y: -10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -9.0, y: -9.0), (x: -7.0, y: -7.0), (x: -3.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 1.0), (x: 4.0, y:0.0), (x: 5.0, y: -1.0), (x: 7.0, y: -3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiLineString_secondMostlyProperSubsetOfFirstButOneLineStringBoundaryPointNotIncluded() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -10.0, y: -10.0), (x: 2.0, y: 2.0), (x: 12.0, y: -8.0), (x: -10.0, y: -10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -9.0, y: -9.0), (x: -7.0, y: -7.0), (x: -3.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 1.0), (x: 4.0, y:0.0), (x: 5.0, y: -1.0), (x: 10.0, y: 10.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// LinearRing Polygon tests
    ///

    func testLinearRing_Polygon_noIntersection() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_withHole_noIntersection_linearRingOutsideMainPolygon() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_withHole_noIntersection_linearRingInsideHole() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -7.0, y: -5.0), (x: -5.0, y: -5.0), (x: -7.0, y: -7.0), (x: -5.0, y: -7.0), (x: -7.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_interiorsExteriorsIntersect1() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 4.0, y: -4.0), (x: 7.0, y: -1.0), (x: 8.0, y: -1.0), (x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_interiorsExteriorsIntersect2() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 4.0, y: -4.0), (x: 7.0, y: -7.0), (x: 12.0, y: -7.0), (x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    /// TODO: Add more tests like this one, where the linear ring and polygon touch at a point but do not cross.
    func testLinearRing_Polygon_interiorIntersectsBoundaryAtOnePoint_linearRingFirstSegment_doNotCross() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 5.5, y: 5.0), (x: 5.5, y: -2.5), (x: 10.0, y: -2.5), (x: 5.5, y: 5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_interiorIntersectsBoundaryAtOnePoint_linearRingInsideHole_doNotCross() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -7.0, y: -7.0), (x: -8.0, y: -6.0), (x: -7.0, y: -5.0), (x: -7.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingOutsideMainLinearRing() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 4.0, y: -1.0), (x: 12.0, y: -1.0), (x: 12.0, y: -7.0), (x: 4.0, y: -7.0), (x: 0.0, y: -7.0), (x: 0.0, y: -1.0), (x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingInsideHole() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -8.0, y: -6.0), (x: -4.0, y: -6.0), (x: -6.0, y: -5.0), (x: -8.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingOutsideMainLinearRing() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -20.0, y: -8.0), (x: -10.0, y: -8.0), (x: -10.0, y: -6.0), (x: -20.0, y: -6.0), (x: -20.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .one,   .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingInsideHole() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -7.0, y: -5.0), (x: -5.0, y: -5.0), (x: -5.0, y: -4.0), (x: -7.0, y: -4.0), (x: -7.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .one,   .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_intersectsPolygonBoundaryInteriorExterior() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 4.0, y: -4.0), (x: 0.0, y: 0.0), (x: 0.0, y: 10.0), (x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -9.0, y: -9.0), (x: -7.0, y: -7.0), (x: -7.0, y: -9.0), (x: -9.0, y: -9.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -4.0, y: -6.0), (x: 10.0, y: -6.0), (x: 10.0, y: -4.0), (x: 0.0, y: -4.0), (x: 0.0, y: -3.0), (x: 12.0, y: -3.0), (x: 12.0, y: 5.0), (x: -4.0, y: 5.0), (x: -4.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -7.0, y: -7.0), (x: 0.0, y: -14.0), (x: 0.0, y: -6.0), (x: -6.0, y: -6.0), (x: -7.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }
    
    ///
    /// LinearRing MultiPolygon tests
    ///

    func testLinearRing_MultiPolygon_noIntersection() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_withHoles_noIntersection_linearRingOutsideMainPolygon() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [[(x: -9.0, y: 12.0), (x: -9.0, y: 10.0), (x: -7.0, y: 10.0), (x: -7.0, y: 12.0), (x: -9.0, y: 12.0)], [(x: -3.0, y: 4.0), (x: -3.0, y: 8.0), (x: -6.0, y: 8.0), (x: -6.0, y: 4.0), (x: -3.0, y: 4.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 20.0, y: -2.0)], [[(x: 11.0, y: -12.0), (x: 5.0, y: -18.0), (x: 11.0, y: -18.0), (x: 11.0, y: -12.0)], [(x: 12.0, y: -11.0), (x: 12.0, y: -19.0), (x: 19.0, y: -19.0), (x: 19.0, y: -11.0), (x: 12.0, y: -11.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_withHoles_noIntersection_linearRingInsideHole() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 13.0, y: -12.0), (x: 18.0, y: -15.0), (x: 13.0, y: -18.0), (x: 13.0, y: -12.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [[(x: -9.0, y: 12.0), (x: -9.0, y: 10.0), (x: -7.0, y: 10.0), (x: -7.0, y: 12.0), (x: -9.0, y: 12.0)], [(x: -3.0, y: 4.0), (x: -3.0, y: 8.0), (x: -6.0, y: 8.0), (x: -6.0, y: 4.0), (x: -3.0, y: 4.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 20.0, y: -2.0)], [[(x: 11.0, y: -12.0), (x: 5.0, y: -18.0), (x: 11.0, y: -18.0), (x: 11.0, y: -12.0)], [(x: 12.0, y: -11.0), (x: 12.0, y: -19.0), (x: 19.0, y: -19.0), (x: 19.0, y: -11.0), (x: 12.0, y: -11.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_withHoles_noIntersection_multiPolygonInsideLinearRing() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 100.0, y: -100.0), (x: -100.0, y: -100.0), (x: -100.0, y: 100.0), (x: 100.0, y: 100.0), (x: 100.0, y: -100.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [[(x: -9.0, y: 12.0), (x: -9.0, y: 10.0), (x: -7.0, y: 10.0), (x: -7.0, y: 12.0), (x: -9.0, y: 12.0)], [(x: -3.0, y: 4.0), (x: -3.0, y: 8.0), (x: -6.0, y: 8.0), (x: -6.0, y: 4.0), (x: -3.0, y: 4.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 20.0, y: -2.0)], [[(x: 11.0, y: -12.0), (x: 5.0, y: -18.0), (x: 11.0, y: -18.0), (x: 11.0, y: -12.0)], [(x: 12.0, y: -11.0), (x: 12.0, y: -19.0), (x: 19.0, y: -19.0), (x: 19.0, y: -11.0), (x: 12.0, y: -11.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_interiorsIntersect_firstPolygon() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 4.0, y: 0.0), (x: 0.0, y: 7.0), (x: -5.0, y: 5.0), (x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_interiorsIntersect_firstPolygon_withHole() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -10.0, y: 10.0), (x: -10.0, y: 12.0), (x: -5.0, y: 10.0), (x: -10.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinear_MultiPolygon_interiorsIntersect_secondPolygon() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 0.0, y: 10.0), (x: 6.0, y: 0.0), (x: 6.0, y: -6.0), (x: 0.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_interiorsIntersect_secondPolygon_withHole() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 15.0, y: -15.0), (x: 14.0, y: -18.0), (x: 18.0, y: -18.0), (x: 15.0, y: -15.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_interiorsIntersect_bothPolygons_withHoles() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -3.0, y: 10.0), (x: 0.0, y: 12.0), (x: 10.0, y: -18.0), (x: -3.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: -20.0, y: 18.0), (x: -30.0, y: 30.0), (x: -50.0, y: 0.0), (x: -20.0, y: 18.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 0.0, y: -40.0), (x: 22.0, y: -30.0), (x: 15.0, y: -20.0), (x: 0.0, y: -40.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 20.0, y: -20.0), (x: 0.0, y: -50.0), (x: -100.0, y: 0.0), (x: -18.0, y: 3.0), (x: -18.0, y: -30.0), (x: 20.0, y: -20.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 21.0, y: -3.0), (x: 10.0, y: 8.0), (x: 5.0, y: 20.0), (x: -34.0, y: 20.0), (x: -34.0, y: 40.0), (x: 21.0, y: 40.0), (x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .one,   .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 21.0, y: -3.0), (x: 10.0, y: 8.0), (x: 5.0, y: 20.0), (x: -34.0, y: 20.0), (x: -12.0, y: 12.0), (x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .one,   .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsInteriorAndBoundary_withHoles() {

        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 21.0, y: -3.0), (x: 10.0, y: 8.0), (x: 5.0, y: 20.0), (x: -34.0, y: 20.0), (x: -8.0, y: 9.0), (x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .one,   .one],
            [.empty, .empty, .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiLineString Point tests
    ///

    func testMultiLineString_Point_noIntersection() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Point_secondSubsetOfFirstInterior() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Point_secondSubsetOfFirstBoundary() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 3.0, y: 3.0), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiLineString MutliPoint tests
    ///

    func testMultiLineString_MultiPoint_noIntersection() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 0.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 4.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPoint_secondSubsetOfFirstInterior() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 1.5, y: 1.5)), Point<Coordinate2D>(coordinate: (x: 2.5, y: 2.5))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPoint_secondProperSubsetOfFirstBoundary() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPoint_secondImproperSubsetOfFirstBoundary() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndBoundary() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.8, y: 1.8))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.zero,  .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndCoversBoundary() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.5, y: 1.5)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.zero,  .empty, .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndExterior() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstBoundaryAndExterior() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 4.0), (x: 2.0, y: 4.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 5.0, y: 5.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPoint_secondCoversFirstBoundaryAndTouchesExterior() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 10.0, y: 0.0), (x: 0.0, y: 10.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 3.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 10.0, y: 0.0)), Point<Coordinate2D>(coordinate: (x: 0.0, y: 10.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .empty],
            [.zero,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndBoundaryAndExterior() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 4.0), (x: 2.0, y: 4.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 5.0), (x: 3.0, y: 5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.5, y: 4.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 5.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero, .empty, .one],
            [.zero, .empty, .zero],
            [.zero, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndExteriorAndCoversBoundary() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 6.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 2.0), (x: 3.0, y: 7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint<CoordinateType>(elements: [Point<Coordinate2D>(coordinate: (x: 3.0, y: 2.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 6.0)), Point<Coordinate2D>(coordinate: (x: 3.0, y: 7.0)), Point<Coordinate2D>(coordinate: (x: 1.0, y: 1.5)), Point<Coordinate2D>(coordinate: (x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero, .empty, .one],
            [.zero, .empty, .empty],
            [.zero, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiLineString LineString tests
    ///

    func testMultiLineString_LineString_noIntersection() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -1.5), (x: 10.0, y: -1.5), (x: 10.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: 2.0), (x: -3.0, y: 2.0), (x: -3.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -4.0, y: -8.0), (x: -4.0, y: -2.5), (x: 10.0, y: -2.5)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -12.0, y: -8.0), (x: -3.0, y: -8.0), (x: -3.0, y: 10.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    /// TODO: Add more tests like this one, where the line strings touch at a point but do not cross.
    func testMultiLineString_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -7.0, y: 8.0), (x: -3.0, y: 4.0), (x: 1.0, y: 8.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -2.0, y: 7.0), (x: -2.0, y: -2.5), (x: 5.0, y: -2.5)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundaryFirstLineString1() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: 4.0, y: -1.0), (x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundaryFirstLineString2() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 0.0, y: -10.0), (x: 0.0, y: -3.0), (x: 12.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundarySecondLineString1() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -2.0, y: 1.0), (x: -9.0, y: 1.0), (x: -9.0, y: -9.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundarySecondLineString2() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -2.0, y: -10.0), (x: -2.0, y: 1.0), (x: 0.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 1.0, y: -5.0), (x: 1.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: -5.0, y: 1.0), (x: 0.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -5.0, y: 1.0), (x: 1.0, y: 1.0), (x: 1.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_FirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .one],
            [.empty, .zero,  .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_SecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .one],
            [.empty, .zero,  .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesFirstBoundaryPointOfSecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -2.0, y: 4.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .zero,  .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesSecondBoundaryPointOfFirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.5, y: -1.5), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .zero,  .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesNeitherBoundaryPoint_FirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 1.5, y: -1.5), (x: 2.0, y: -2.0), (x: 1.5, y: -2.5)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesNeitherBoundaryPoint_SecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -3.0, y: 4.0), (x: -2.0, y: 4.0), (x: -1.5, y: 4.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: 0.0, y: 0.0), (x: 4.0, y: -4.0), (x: 4.0, y: -8.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .one],
            [.zero, .empty, .zero],
            [.one,  .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -1.0, y: 9.0), (x: -1.0, y: -4.0), (x: -5.0, y: -8.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .one],
            [.zero, .empty, .zero],
            [.one,  .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LineString_firstProperSubsetOfSecond() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -9.0, y: -9.0), (x: -7.0, y: -7.0), (x: -3.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 1.0), (x: 4.0, y:0.0), (x: 5.0, y: -1.0), (x: 7.0, y: -3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -10.0, y: -10.0), (x: 2.0, y: 2.0), (x: 12.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        
        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .empty],
            [.zero, .empty, .empty],
            [.one,  .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiLineString LinearRing tests
    ///

    func testMultiLineString_LinearRing_noIntersection() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_interiorsIntersectAtOnePointFirstSegmentsFirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 2.0, y: 2.0), (x: 0.0, y: 2.0), (x: 0.0, y: 13.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 5.0), (x: 5.0, y: 1.0), (x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_interiorsIntersectAtOnePointFirstSegmentsSecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: 2.0), (x: -3.0, y: 2.0), (x: -3.0, y: -3.0), (x: -5.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_interiorsIntersectAtOnePointSecondSegmentsFirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -4.0, y: -18.0), (x: -4.0, y: -2.5), (x: 10.0, y: -2.5), (x: -4.0, y: -18.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_interiorsIntersectAtOnePointSecondSegmentsSecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString<Coordinate2D>(elements: [(x: -12.0, y: -8.0), (x: -3.0, y: -8.0), (x: -3.0, y: 10.0), (x: -12.0, y: -8.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    /// TODO: Add more tests like this one, where the linear ring and multiline string touch at a point but do not cross.
    func testMultiLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -7.0, y: 8.0), (x: -3.0, y: 4.0), (x: 1.0, y: 8.0), (x: -7.0, y: 8.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -2.0, y: 7.0), (x: -2.0, y: -2.5), (x: 5.0, y: -2.5), (x: -2.0, y: 7.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundaryFirstLineString1() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: 4.0, y: -1.0), (x: 10.0, y: -6.0), (x: -1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundaryFirstLineString2() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 0.0, y: -10.0), (x: 0.0, y: -3.0), (x: 12.0, y: -3.0), (x: 0.0, y: -10.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundarySecondLineString1() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -2.0, y: 1.0), (x: -9.0, y: 1.0), (x: -9.0, y: -9.0), (x: -2.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundarySecondLineString2() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -2.0, y: -10.0), (x: -2.0, y: 1.0), (x: 0.0, y: 1.0), (x: -2.0, y: -10.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 1.0, y: -5.0), (x: 1.0, y: 0.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: -5.0, y: 1.0), (x: 0.0, y: 1.0), (x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -5.0, y: 1.0), (x: 1.0, y: 1.0), (x: 1.0, y: -5.0), (x: -5.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .empty],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_firstLineStringInteriorDoesNotIntersectLinearRingExterior() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .one],
            [.zero, .empty, .zero],
            [.one,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_secondLineStringInteriorDoesNotIntersectLinearRingExterior() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0), (x: -4.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .one],
            [.zero, .empty, .zero],
            [.one,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_neitherLineStringInteriorIntersectsLinearRingExterior() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 0.0, y: 0.0), (x: 2.0, y: -2.0), (x: 0.0, y: -4.0), (x: -4.0, y: -4.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 0.0), (x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .empty],
            [.zero, .empty, .empty],
            [.one,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_firstTouchesSecondInteriorAtLineSegmentAndPoint() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)]), LineString<Coordinate2D>(elements: [(x: 6.0, y: -3.0), (x: 0.0, y: -3.0), (x: -3.0, y: 0.0), (x: -10.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.5, y: -1.5), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0), (x: 1.5, y: -1.5)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_firstLineStringInsideLinearRing_secondLineStringBoundaryTouchesLinearRing() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 3.0, y: -3.0), (x: 5.0, y: -5.0), (x: 5.0, y: -7.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: -9.0), (x: 3.0, y: -11.0), (x: 5.0, y: -9.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -5.0), (x: 5.0, y: -9.0), (x: 1.0, y: -9.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .one],
            [.zero, .empty, .empty],
            [.one,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_secondLineStringInsideLinearRing_firstLineStringBoundaryTouchesLinearRing() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 3.0, y: -3.0), (x: 3.0, y: 5.0), (x: 4.0, y: 5.0), (x: 4.0, y: -4.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: -7.0), (x: 1.0, y: -9.0), (x: 3.0, y: -9.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 5.0, y: -5.0), (x: 5.0, y: -9.0), (x: 1.0, y: -9.0), (x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .one],
            [.zero, .empty, .empty],
            [.one,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: 0.0, y: 0.0), (x: 4.0, y: -4.0), (x: 0.0, y: -8.0), (x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .one],
            [.zero, .empty, .zero],
            [.one,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -1.0, y: 9.0), (x: -1.0, y: -4.0), (x: -5.0, y: -8.0), (x: -1.0, y: 9.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .one],
            [.zero, .empty, .zero],
            [.one,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_firstProperSubsetOfSecond() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -9.0, y: -9.0), (x: -7.0, y: -7.0), (x: -3.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 1.0), (x: 4.0, y:0.0), (x: 5.0, y: -1.0), (x: 7.0, y: -3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -10.0, y: -10.0), (x: 2.0, y: 2.0), (x: 12.0, y: -8.0), (x: -10.0, y: -10.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .empty],
            [.zero, .empty, .empty],
            [.one,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_LinearRing_firstMostlyProperSubsetOfSecondButOneLineStringBoundaryPointNotIncluded() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -9.0, y: -9.0), (x: -7.0, y: -7.0), (x: -3.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: 3.0, y: 1.0), (x: 4.0, y:0.0), (x: 5.0, y: -1.0), (x: 10.0, y: 10.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing<Coordinate2D>(elements: [(x: -10.0, y: -10.0), (x: 2.0, y: 2.0), (x: 12.0, y: -8.0), (x: -10.0, y: -10.0)], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .one],
            [.zero, .empty, .zero],
            [.one,  .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiLineString MultiLineString tests
    ///

    func testMultiLineString_MultiLineString_noIntersection() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: -2.0, y: -2.0), (x: -1.0, y: -3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -5.0, y: -1.5), (x: 10.0, y: -1.5), (x: 10.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint1() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -5.0, y: 2.0), (x: -3.0, y: 2.0), (x: -3.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint2() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -4.0, y: -8.0), (x: -4.0, y: -2.5), (x: 10.0, y: -2.5)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint3() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -12.0, y: -8.0), (x: -3.0, y: -8.0), (x: -3.0, y: 10.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    /// TODO: Add more tests like this one, where the line strings touch at a point but do not cross.
    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint_DoNotCross_firstInteriorEndpointTouchesSecondInteriorPoint() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -7.0, y: 8.0), (x: -3.0, y: 4.0), (x: 1.0, y: 8.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint_DoNotCross_firstInteriorEndpointTouchesSecondInteriorEndpoint() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: 7.0, y: 8.0), (x: 2.0, y: -2.0), (x: 10.0, y: -10.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings_interiorPoints() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -2.0, y: 7.0), (x: -2.0, y: -2.5), (x: 5.0, y: -2.5)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings_endpoints() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 2.0, y: -10.0), (x: 2.0, y: -2.0), (x: 10.0, y: -2.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 7.0), (x: -4.0, y: 4.0), (x: -15.0, y: 4.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.zero,  .empty, .one],
            [.empty, .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundaryFirstLineString1() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -1.0, y: -1.0), (x: 4.0, y: -1.0), (x: 10.0, y: -6.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundaryFirstLineString2() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: 0.0, y: -10.0), (x: 0.0, y: -3.0), (x: 12.0, y: -3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundarySecondLineString1() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -2.0, y: 1.0), (x: -9.0, y: 1.0), (x: -9.0, y: -9.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundarySecondLineString2() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -2.0, y: -10.0), (x: -2.0, y: 1.0), (x: 0.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: 1.0, y: -5.0), (x: 1.0, y: 0.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -5.0, y: -5.0), (x: -5.0, y: 1.0), (x: 0.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .zero],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 11.0, y: 1.0), (x: 12.0, y: 2.0), (x: 11.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -5.0, y: 1.0), (x: 1.0, y: 1.0), (x: 1.0, y: -5.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.zero,  .empty, .empty],
            [.one,   .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_SameOrder() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.empty, .zero,  .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_DifferentOrder() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .empty, .empty],
            [.empty, .zero,  .empty],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_firstSubsetOfSecond() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.5, y: -1.5), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .empty],
            [.zero, .zero,  .empty],
            [.one,  .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_secondSubsetOfFirst() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 2.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .zero,  .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExteriorOrBoundary_firstSubsetOfSecond() {
    
        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.5, y: -1.5), (x: 2.0, y: -2.0), (x: 1.5, y: -2.5)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 2.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
    
        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
    
        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .empty],
            [.zero, .empty, .empty],
            [.one,  .zero,  .two]
            ])
    
        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExteriorOrBoundary_secondSubsetOfFirst() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.5, y: -1.5), (x: 2.0, y: -2.0), (x: 1.5, y: -2.5)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 2.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineStrings() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.5, y: -1.5), (x: 2.0, y: -2.0), (x: 2.0, y: -1.0), (x: 0.0, y: -1.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: -2.0), (x: -4.0, y: -4.0), (x: -1.0, y: -4.0), (x: -1.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.one,  .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineStrings() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: -1.0), (x: 2.0, y: -2.0), (x: 1.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 10.0, y: -1.5), (x: 12.0, y: -2.0), (x: 12.0, y: -1.0), (x: 10.0, y: -1.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 2.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 0.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.one,  .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_firstProperSubsetOfSecond() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -9.0, y: -9.0), (x: -7.0, y: -7.0), (x: -3.0, y: -3.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 1.0, y: 4.0), (x: 5.0, y: 4.0), (x: 5.0, y: -3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -30.0, y: -30.0), (x: -30.0, y: -2.0), (x: -20.0, y: -2.0), (x: -20.0, y: -20.0), (x: -2.0, y: -2.0)]), LineString<Coordinate2D>(elements: [(x: 1.0, y: 0.0), (x: 1.0, y: 4.0), (x: 5.0, y: 4.0), (x: 5.0, y: -30.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .empty, .empty],
            [.zero, .empty, .empty],
            [.one,  .zero,  .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiLineString_secondProperSubsetOfFirst() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 20.0, y: 10.0), (x: 0.0, y: 10.0), (x: 0.0, y: 0.0), (x: 20.0, y: 0.0)]), LineString<Coordinate2D>(elements: [(x: 0.0, y: -10.0), (x: 0.0, y: -40.0), (x: -40.0, y: -40.0), (x: -40.0, y: -10.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 10.0, y: 10.0), (x: 0.0, y: 10.0), (x: 0.0, y: 0.0), (x: 10.0, y: 0.0)]), LineString<Coordinate2D>(elements: [(x: 0.0, y: -20.0), (x: 0.0, y: -40.0), (x: -40.0, y: -40.0), (x: -40.0, y: -20.0)])], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.empty, .empty, .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiLineString Polygon tests
    ///

    func testMultiLineString_Polygon_noIntersection() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_withHole_noIntersection_multiLineStringOutsideMainPolygon() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_withHole_noIntersection_multiLineStringInsideHole() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -7.0, y: -5.0), (x: -6.0, y: -6.0), (x: -7.0, y: -7.0)]), LineString<Coordinate2D>(elements: [(x: -6.0, y: -5.0), (x: -5.0, y: -6.0), (x: -6.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_withHoles_noIntersection_multiLineStringInsideTwoHoles() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -30.0, y: -70.0), (x: -25.0, y: -75.0), (x: -30.0, y: -80.0)]), LineString<Coordinate2D>(elements: [(x: -80.0, y: -20.0), (x: -70.0, y: -30.0), (x: -60.0, y: -20.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 0.0, y: 0.0), (x: 0.0, y: -100.0), (x: -100.0, y: -100.0), (x: -100.0, y: 0.0), (x: 0.0, y: 0.0)], [[(x: -90.0, y: -10.0), (x: -90.0, y: -50.0), (x: -50.0, y: -50.0), (x: -50.0, y: -10.0), (x: -90.0, y: -10.0)], [(x: -40.0, y: -60.0), (x: -40.0, y: -90.0), (x: -10.0, y: -90.0), (x: -10.0, y: -60.0), (x: -40.0, y: -60.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideMainLinearRing() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -30.0, y: -70.0), (x: -25.0, y: -75.0), (x: -30.0, y: -80.0)]), LineString<Coordinate2D>(elements: [(x: -80.0, y: -20.0), (x: -70.0, y: -30.0), (x: -60.0, y: -20.0)]), LineString<Coordinate2D>(elements: [(x: 10.0, y: 10.0), (x: 20.0, y: 20.0), (x: 10.0, y: 30.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 0.0, y: 0.0), (x: 0.0, y: -100.0), (x: -100.0, y: -100.0), (x: -100.0, y: 0.0), (x: 0.0, y: 0.0)], [[(x: -90.0, y: -10.0), (x: -90.0, y: -50.0), (x: -50.0, y: -50.0), (x: -50.0, y: -10.0), (x: -90.0, y: -10.0)], [(x: -40.0, y: -60.0), (x: -40.0, y: -90.0), (x: -10.0, y: -90.0), (x: -10.0, y: -60.0), (x: -40.0, y: -60.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_interiorsIntersect_firstLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 4.0, y: 4.0), (x: 8.0, y: 0.0), (x: 4.0, y: -4.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_interiorsIntersect_secondLineString() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 4.0, y: 4.0), (x: 8.0, y: 8.0), (x: 4.0, y: 12.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: -4.0), (x: 4.0, y: -4.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    /// TODO: Add more tests like this one, where the multi line string and polygon touch at a point but do not cross.
    func testMultiLineString_Polygon_firstInteriorIntersectsSecondBoundaryAtOnePoint_firstLineString_doNotCross() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 5.5, y: 5.0), (x: 5.5, y: -2.5), (x: 10.0, y: -2.5)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: 1.0), (x: -4.0, y: 4.0), (x: -1.0, y: 4.0), (x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_firstInteriorIntersectsSecondBoundaryAtOnePoint_lineStringInsideHole_doNotCross() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -6.0, y: -7.0), (x: -7.0, y: -6.0), (x: -6.0, y: -5.0)]), LineString<Coordinate2D>(elements: [(x: -7.0, y: -7.0), (x: -8.0, y: -6.0), (x: -7.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .zero,  .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtOnePoint_doNotCross_multiLineStringOutsideMainLinearRing() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 5.5, y: 5.0), (x: 5.5, y: 0.0), (x: 10.0, y: 0.0)]), LineString<Coordinate2D>(elements: [(x: 12.0, y: 10.0), (x: 12.0, y: -7.0), (x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtTwoPoints_doNotCross_mulitLineStringOutsideMainLinearRing() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 5.5, y: 5.0), (x: 5.5, y: 0.0), (x: 10.0, y: 0.0)]), LineString<Coordinate2D>(elements: [(x: 4.0, y: -1.0), (x: 12.0, y: -1.0), (x: 12.0, y: -7.0), (x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtThreePoints_doNotCross_mulitLineStringOutsideMainLinearRing() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 2.5, y: 5.0), (x: -5.5, y: 5.0), (x: -5.5, y: -5.5), (x: 2.5, y: -5.5)]), LineString<Coordinate2D>(elements: [(x: 4.0, y: -1.0), (x: 12.0, y: -1.0), (x: 12.0, y: -7.0), (x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtFourPoints_doNotCross_mulitLineStringOutsideMainLinearRing() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 2.5, y: -2.5), (x: -5.5, y: -2.5), (x: -5.5, y: -5.5), (x: 2.5, y: -5.5)]), LineString<Coordinate2D>(elements: [(x: 4.0, y: -1.0), (x: 12.0, y: -1.0), (x: 12.0, y: -7.0), (x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_firstbBoundaryIntersectsSecondBoundaryAtOnePoint_doNotCross_multiLineStringInsideHole() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -5.0, y: -7.0), (x: -6.0, y: -6.0), (x: -6.0, y: -5.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: -7.0), (x: -5.0, y: -6.0), (x: -5.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_firstbBoundaryIntersectsSecondBoundaryAtTwoPoints_doNotCross_multiLineStringInsideHole() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -5.0, y: -7.0), (x: -6.0, y: -6.0), (x: -6.0, y: -5.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: -7.0), (x: -5.0, y: -6.0), (x: -4.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_firstbBoundaryIntersectsSecondBoundaryAtThreePoints_doNotCross_multiLineStringInsideHole() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -6.0, y: -8.0), (x: -7.0, y: -6.0), (x: -6.0, y: -5.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: -7.0), (x: -5.0, y: -6.0), (x: -4.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_firstbBoundaryIntersectsSecondBoundaryAtFourPoints_doNotCross_multiLineStringInsideHole() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -6.0, y: -8.0), (x: -7.0, y: -6.0), (x: -6.0, y: -4.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: -7.0), (x: -5.0, y: -6.0), (x: -4.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero , .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorExterior() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -6.0, y: -8.0), (x: -7.0, y: -6.0), (x: -6.0, y: -4.0)]), LineString<Coordinate2D>(elements: [(x: 4.0, y: -4.0), (x: 0.0, y: 0.0), (x: 0.0, y: 10.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -9.0, y: -9.0), (x: -7.0, y: -7.0), (x: -6.0, y: -6.0)]), LineString<Coordinate2D>(elements: [(x: -6.0, y: -7.0), (x: -6.0, y: -7.5), (x: -6.5, y: -7.5)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -9.0, y: -9.0), (x: -7.0, y: -7.0), (x: -9.0, y: -5.0)]), LineString<Coordinate2D>(elements: [(x: -4.0, y: -6.0), (x: 10.0, y: -6.0), (x: 10.0, y: -4.0), (x: 0.0, y: -4.0), (x: 0.0, y: -3.0), (x: 12.0, y: -3.0), (x: 12.0, y: 5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: 4.0, y: -1.0), (x: 7.0, y: -4.0), (x: 4.0, y: -7.0), (x: 1.0, y: -4.0), (x: 4.0, y: -1.0)], []), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -7.0, y: -7.0), (x: 0.0, y: -14.0), (x: 0.0, y: -6.0), (x: -6.0, y: -6.0)]), LineString<Coordinate2D>(elements: [(x: 8.0, y: 0.0), (x: 8.0, y: -12.0), (x: -10.0, y: 6.0), (x: 10.0, y: 26.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon<Coordinate2D>(rings: ([(x: -10.0, y: -2.0), (x: -2.0, y: -2.0), (x: -2.0, y: -10.0), (x: -10.0, y: -10.0), (x: -10.0, y: -2.0)], [[(x: -8.0, y: -4.0), (x: -8.0, y: -8.0), (x: -4.0, y: -8.0), (x: -4.0, y: -4.0), (x: -8.0, y: -4.0)]]), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,   .zero,  .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    ///
    /// MultiLineString MultiPolygon tests
    ///

    func testMultiLineString_MultiPolygon_noIntersection() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -10.0, y: -10.0), (x: -10.0, y: -20.0), (x: -20.0, y: -20.0), (x: -20.0, y: -10.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringOutsideMainPolygon() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 1.0), (x: 2.0, y: 2.0), (x: 1.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -10.0, y: -10.0), (x: -10.0, y: -20.0), (x: -20.0, y: -20.0), (x: -20.0, y: -10.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [[(x: -9.0, y: 12.0), (x: -9.0, y: 10.0), (x: -7.0, y: 10.0), (x: -7.0, y: 12.0), (x: -9.0, y: 12.0)], [(x: -3.0, y: 4.0), (x: -3.0, y: 8.0), (x: -6.0, y: 8.0), (x: -6.0, y: 4.0), (x: -3.0, y: 4.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 20.0, y: -2.0)], [[(x: 11.0, y: -12.0), (x: 5.0, y: -18.0), (x: 11.0, y: -18.0), (x: 11.0, y: -12.0)], [(x: 12.0, y: -11.0), (x: 12.0, y: -19.0), (x: 19.0, y: -19.0), (x: 19.0, y: -11.0), (x: 12.0, y: -11.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideOneHole() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 13.0, y: -12.0), (x: 15.0, y: -14.0), (x: 18.0, y: -12.0)]), LineString<Coordinate2D>(elements: [(x: 13.0, y: -18.0), (x: 15.0, y: -16.0), (x: 18.0, y: -18.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [[(x: -9.0, y: 12.0), (x: -9.0, y: 10.0), (x: -7.0, y: 10.0), (x: -7.0, y: 12.0), (x: -9.0, y: 12.0)], [(x: -3.0, y: 4.0), (x: -3.0, y: 8.0), (x: -6.0, y: 8.0), (x: -6.0, y: 4.0), (x: -3.0, y: 4.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 20.0, y: -2.0)], [[(x: 11.0, y: -12.0), (x: 5.0, y: -18.0), (x: 11.0, y: -18.0), (x: 11.0, y: -12.0)], [(x: 12.0, y: -11.0), (x: 12.0, y: -19.0), (x: 19.0, y: -19.0), (x: 19.0, y: -11.0), (x: 12.0, y: -11.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHoles() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 13.0, y: -12.0), (x: 15.0, y: -14.0), (x: 18.0, y: -12.0)]), LineString<Coordinate2D>(elements: [(x: 8.0, y: -17.0), (x: 8.0, y: -16.0), (x: 9.0, y: -16.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [[(x: -9.0, y: 12.0), (x: -9.0, y: 10.0), (x: -7.0, y: 10.0), (x: -7.0, y: 12.0), (x: -9.0, y: 12.0)], [(x: -3.0, y: 4.0), (x: -3.0, y: 8.0), (x: -6.0, y: 8.0), (x: -6.0, y: 4.0), (x: -3.0, y: 4.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 20.0, y: -2.0)], [[(x: 11.0, y: -12.0), (x: 5.0, y: -18.0), (x: 11.0, y: -18.0), (x: 11.0, y: -12.0)], [(x: 12.0, y: -11.0), (x: 12.0, y: -19.0), (x: 19.0, y: -19.0), (x: 19.0, y: -11.0), (x: 12.0, y: -11.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHolesInTwoDifferentPolygonsAndOutsideAllPolygons() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: -8.0, y: 10.5), (x: -7.5, y: 11.0), (x: -8.0, y: 11.5)]), LineString<Coordinate2D>(elements: [(x: 8.0, y: -17.0), (x: 8.0, y: -16.0), (x: 9.0, y: -16.0)]), LineString<Coordinate2D>(elements: [(x: 100.0, y: 20.0), (x: 150.0, y: 30.0), (x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [[(x: -9.0, y: 12.0), (x: -9.0, y: 10.0), (x: -7.0, y: 10.0), (x: -7.0, y: 12.0), (x: -9.0, y: 12.0)], [(x: -3.0, y: 4.0), (x: -3.0, y: 8.0), (x: -6.0, y: 8.0), (x: -6.0, y: 4.0), (x: -3.0, y: 4.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 20.0, y: -2.0)], [[(x: 11.0, y: -12.0), (x: 5.0, y: -18.0), (x: 11.0, y: -18.0), (x: 11.0, y: -12.0)], [(x: 12.0, y: -11.0), (x: 12.0, y: -19.0), (x: 19.0, y: -19.0), (x: 19.0, y: -11.0), (x: 12.0, y: -11.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideAllPolygons() {
        
        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 13.0, y: -12.0), (x: 15.0, y: -14.0), (x: 18.0, y: -12.0)]), LineString<Coordinate2D>(elements: [(x: 8.0, y: -17.0), (x: 8.0, y: -16.0), (x: 9.0, y: -16.0)]), LineString<Coordinate2D>(elements: [(x: 100.0, y: 20.0), (x: 150.0, y: 30.0), (x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [[(x: -9.0, y: 12.0), (x: -9.0, y: 10.0), (x: -7.0, y: 10.0), (x: -7.0, y: 12.0), (x: -9.0, y: 12.0)], [(x: -3.0, y: 4.0), (x: -3.0, y: 8.0), (x: -6.0, y: 8.0), (x: -6.0, y: 4.0), (x: -3.0, y: 4.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 20.0, y: -2.0)], [[(x: 11.0, y: -12.0), (x: 5.0, y: -18.0), (x: 11.0, y: -18.0), (x: 11.0, y: -12.0)], [(x: 12.0, y: -11.0), (x: 12.0, y: -19.0), (x: 19.0, y: -19.0), (x: 19.0, y: -11.0), (x: 12.0, y: -11.0)]]))], precision: precision, coordinateSystem: cs)
        
        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
        
        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .empty, .zero],
            [.two,   .one,   .two]
            ])
        
        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_firstPolygon() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 13.0, y: 12.0), (x: 15.0, y: 14.0), (x: 18.0, y: 12.0)]), LineString<Coordinate2D>(elements: [(x: 4.0, y: 0.0), (x: 0.0, y: 7.0), (x: -5.0, y: 5.0)]), LineString<Coordinate2D>(elements: [(x: 100.0, y: 20.0), (x: 150.0, y: 30.0), (x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_firstPolygon_withHole() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 100.0, y: 20.0), (x: 150.0, y: 30.0), (x: 200.0, y: 100.0)]), LineString<Coordinate2D>(elements: [(x: -10.0, y: 10.0), (x: -10.0, y: 12.0), (x: -5.0, y: 10.0)]), LineString<Coordinate2D>(elements: [(x: 10.0, y: 20.0), (x: 15.0, y: 30.0), (x: 10.0, y: 40.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_secondPolygon() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 0.0, y: 10.0), (x: 6.0, y: 0.0), (x: 6.0, y: -6.0)]), LineString<Coordinate2D>(elements: [(x: 100.0, y: 20.0), (x: 150.0, y: 30.0), (x: 200.0, y: 100.0)]), LineString<Coordinate2D>(elements: [(x: 10.0, y: 20.0), (x: 15.0, y: 30.0), (x: 10.0, y: 40.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 8.0, y: -2.0), (x: 8.0, y: -8.0), (x: 2.0, y: -8.0), (x: 8.0, y: -2.0)], []))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_secondPolygon_withHole() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 10.0, y: 20.0), (x: 15.0, y: 30.0), (x: 10.0, y: 40.0)]), LineString<Coordinate2D>(elements: [(x: 100.0, y: 20.0), (x: 150.0, y: 30.0), (x: 200.0, y: 100.0)]), LineString<Coordinate2D>(elements: [(x: 15.0, y: -15.0), (x: 14.0, y: -18.0), (x: 18.0, y: -18.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 10.0, y: 20.0), (x: 15.0, y: 30.0), (x: 10.0, y: 40.0)]), LineString<Coordinate2D>(elements: [(x: 100.0, y: 20.0), (x: 150.0, y: 30.0), (x: 200.0, y: 100.0)]), LineString<Coordinate2D>(elements: [(x: -3.0, y: 10.0), (x: 0.0, y: 12.0), (x: 10.0, y: -18.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles_differentLineStrings() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 1.0, y: 2.0), (x: 40.0, y: -40.0), (x: 1.0, y: -80.0)]), LineString<Coordinate2D>(elements: [(x: 100.0, y: 20.0), (x: 150.0, y: 30.0), (x: 200.0, y: 100.0)]), LineString<Coordinate2D>(elements: [(x: -3.0, y: 10.0), (x: 0.0, y: 12.0), (x: -3.0, y: 40.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .zero],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_boundariesIntersect_firstPolygon_withHoles() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 100.0, y: 20.0), (x: 150.0, y: 30.0), (x: 200.0, y: 100.0)]), LineString<Coordinate2D>(elements: [(x: -20.0, y: 18.0), (x: -30.0, y: 30.0), (x: -50.0, y: 0.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero,  .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_boundariesIntersect_secondPolygon_withHoles() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 0.0, y: -40.0), (x: 22.0, y: -30.0), (x: 15.0, y: -20.0)]), LineString<Coordinate2D>(elements: [(x: 100.0, y: 20.0), (x: 150.0, y: 30.0), (x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero,  .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_boundariesIntersect_bothPolygons_withHoles() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 20.0, y: -20.0), (x: 0.0, y: -50.0), (x: -100.0, y: 0.0), (x: -18.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: 100.0, y: 20.0), (x: 150.0, y: 30.0), (x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero,  .zero],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

    func testMultiLineString_MultiPolygon_boundariesIntersectAtAllFourBoundaryPoints_bothPolygons_withHoles() {

        let geometry1 = MultiLineString<Coordinate2D>(elements: [LineString<Coordinate2D>(elements: [(x: 20.0, y: -20.0), (x: 0.0, y: -50.0), (x: -100.0, y: 0.0), (x: -20.0, y: 3.0)]), LineString<Coordinate2D>(elements: [(x: -16.0, y: 20.0), (x: -16.0, y: 30.0), (x: 16.0, y: 30.0), (x: 16.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.empty, .empty, .one],
            [.empty, .zero,  .empty],
            [.two,   .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }

//    func testLineString_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = LineString<Coordinate2D>(elements: [(x: 21.0, y: -3.0), (x: 10.0, y: 8.0), (x: 5.0, y: 20.0), (x: -34.0, y: 20.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .one,   .one],
//            [.empty, .empty, .zero],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testLineString_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = LineString<Coordinate2D>(elements: [(x: 21.0, y: -3.0), (x: 10.0, y: 8.0), (x: 5.0, y: 20.0), (x: -34.0, y: 20.0), (x: -12.0, y: 12.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,   .one,   .one],
//            [.empty, .empty, .zero],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testLineString_MultiPolygon_interiorsIntersectAndBoundariesIntersect_withHoles() {
//
//        let geometry1 = LineString<Coordinate2D>(elements: [(x: 21.0, y: -3.0), (x: 10.0, y: 8.0), (x: 5.0, y: 20.0), (x: -34.0, y: 20.0), (x: -8.0, y: 9.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,   .one,  .one],
//            [.empty, .zero, .zero],
//            [.two,   .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testLineString_MultiPolygon_boundaryIntersectsInteriorAndBoundary_withHoles() {
//
//        let geometry1 = LineString<Coordinate2D>(elements: [(x: 20.0, y: -2.0), (x: 10.0, y: 8.0), (x: 5.0, y: 20.0), (x: -34.0, y: 20.0), (x: -7.0, y: 9.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0), (x: 20.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .one,  .one],
//            [.zero, .zero, .empty],
//            [.two,  .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
}
