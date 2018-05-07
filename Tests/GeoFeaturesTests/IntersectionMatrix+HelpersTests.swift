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
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -10.0, y: 3.0), (x: -10.0, y: 13.0), (x: -2.0, y: 13.0), (x: -2.0, y: 3.0)], [])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

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
        let geometry2 = MultiPolygon<Coordinate2D>(elements: [Polygon<Coordinate2D>(rings: ([(x: -2.0, y: 3.0), (x: -20.0, y: 3.0), (x: -20.0, y: 20.0), (x: -2.0, y: 20.0), (x: -2.0, y: 3.0)], [[(x: -8.0, y: 9.0), (x: -16.0, y: 9.0), (x: -16.0, y: 16.0), (x: -8.0, y: 16.0), (x: -8.0, y: 9.0)]])), Polygon<Coordinate2D>(rings: ([(x: 20.0, y: -2.0), (x: 20.0, y: -20.0), (x: 2.0, y: -20.0), (x: 2.0, y: -2.0)], [[(x: 16.0, y: -16.0), (x: 16.0, y: -12.0), (x: 12.0, y: -12.0), (x: 12.0, y: -16.0), (x: 16.0, y: -16.0)]]))], precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        let expected  = IntersectionMatrix(arrayLiteral: [
            [.one,  .zero,  .one],
            [.zero, .empty, .empty],
            [.two,  .one,   .two]
            ])

        XCTAssertEqual(matrix, expected)
    }
}
