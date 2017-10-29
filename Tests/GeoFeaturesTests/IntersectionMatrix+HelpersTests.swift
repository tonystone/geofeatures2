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

// MARK: - All

private typealias CoordinateType = Coordinate2D

class IntersectionMatrixHelperTests: XCTestCase {

    let precision = FloatingPrecision()
    let cs        = Cartesian()

    ///
    /// Zero Zero tests
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
    /// Zero One tests
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
    /// Zero Two tests
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
}
