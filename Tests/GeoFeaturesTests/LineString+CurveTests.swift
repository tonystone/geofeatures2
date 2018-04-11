///
///  LineString+CurveTests.swift
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
///  Created by Tony Stone on 2/16/2016.
///
import XCTest
import GeoFeatures

// MARK: - Coordinate 2D, FloatingPrecision, Cartesian -

class LineStringCurveCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testLengthTest1() {
        XCTAssertEqual(LineString([[0, 0], [1, 1]], precision: precision, coordinateSystem: cs).length(), 1.4142135623730951)
    }

    func testLengthTest2() {
        XCTAssertEqual(LineString([[0, 0], [0, 2]], precision: precision, coordinateSystem: cs).length(), 2.0)
    }

    func testLengthTest3() {
        XCTAssertEqual(LineString([[0, 0], [7, 0]], precision: precision, coordinateSystem: cs).length(), 7.0)
    }

    func testLengthTest4() {
        XCTAssertEqual(LineString([[0, 0], [0, 2], [0, 3], [0, 4], [0, 5]], precision: precision, coordinateSystem: cs).length(), 5.0)
    }

    func testLengthPerformance() {
        let lineString = LineString([[0, 0], [0, 2], [0, 3], [0, 4], [0, 5]], precision: precision, coordinateSystem: cs)

        self.measure {

            for _ in 1...500000 {
                let _ = lineString.length()
            }
        }
    }

    func testIsClosedClosed() {
        XCTAssertTrue(LineString([[0, 0], [0, 2], [0, 3], [2, 0], [0, 0]], precision: precision, coordinateSystem: cs).isClosed())
    }

    func testIsClosedOpen() {
        XCTAssertFalse(LineString([[0, 0], [0, 2], [0, 3], [0, 4], [0, 5]], precision: precision, coordinateSystem: cs).isClosed())
    }

    func testIsClosedEmpty() {
        XCTAssertFalse(LineString(precision: precision, coordinateSystem: cs).isClosed())
    }
}

// MARK: - Coordinate 3D, FloatingPrecision, Cartesian -

class LineStringCurveCoordinate3DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testPerformanceLength() {
        let lineString = LineString([[0, 0, 0], [0, 2, 0], [0, 3, 0], [0, 4, 0], [0, 5, 0]], precision: precision, coordinateSystem: cs)

        self.measure {

            for _ in 1...500000 {
                let _ = lineString.length()
            }
        }
    }
}
