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

    func testPointPoint_noIntersection() {

        let emptyMatrix = IntersectionMatrix()

        let geometry1 = Point<CoordinateType>(coordinate: (x: 0.00, y: 0.00), precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 1.00, y: 1.00), precision: precision, coordinateSystem: cs)

        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)

        XCTAssertEqual(matrix[.interior, .interior], Dimension.empty)
        XCTAssertEqual(matrix[.interior, .boundary], Dimension.empty)
        XCTAssertEqual(matrix[.interior, .exterior], Dimension.zero)

        XCTAssertEqual(matrix[.boundary, .interior], Dimension.empty)
        XCTAssertEqual(matrix[.boundary, .boundary], Dimension.empty)
        XCTAssertEqual(matrix[.boundary, .exterior], Dimension.empty)

        XCTAssertEqual(matrix[.exterior, .interior], Dimension.zero)
        XCTAssertEqual(matrix[.exterior, .boundary], Dimension.empty)
        XCTAssertEqual(matrix[.exterior, .exterior], Dimension.two)
    }
    
    func testPointPoint_identicalPoints() {
        
        let emptyMatrix = IntersectionMatrix()
        
        let geometry1 = Point<CoordinateType>(coordinate: (x: 1.00, y: 1.00), precision: precision, coordinateSystem: cs)
        let geometry2 = Point<CoordinateType>(coordinate: (x: 1.00, y: 1.00), precision: precision, coordinateSystem: cs)
        
        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
        
        XCTAssertEqual(matrix[.interior, .interior], Dimension.zero)
        XCTAssertEqual(matrix[.interior, .boundary], Dimension.empty)
        XCTAssertEqual(matrix[.interior, .exterior], Dimension.empty)
        
        XCTAssertEqual(matrix[.boundary, .interior], Dimension.empty)
        XCTAssertEqual(matrix[.boundary, .boundary], Dimension.empty)
        XCTAssertEqual(matrix[.boundary, .exterior], Dimension.empty)
        
        XCTAssertEqual(matrix[.exterior, .interior], Dimension.empty)
        XCTAssertEqual(matrix[.exterior, .boundary], Dimension.empty)
        XCTAssertEqual(matrix[.exterior, .exterior], Dimension.two)
    }
}
