///
///  LinearRing+CurveTests.swift
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
///  Created by Tony Stone on 5/30/2016.
///
import XCTest
import GeoFeatures

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class LinearRingCurveCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testLengthTest1() {
        XCTAssertEqual(LinearRing([Coordinate(x: 0, y: 0), Coordinate(x: 1, y: 1), Coordinate(x: 1, y: 0), Coordinate(x: 0, y: 0)], precision: precision, coordinateSystem: cs).length(), 3.4142135623730951)
    }

    func testLengthTest2() {
        XCTAssertEqual(LinearRing([Coordinate(x: 0, y: 0), Coordinate(x: 0, y: 2), Coordinate(x: 2, y: 2), Coordinate(x: 2, y: 0), Coordinate(x: 0, y: 0)], precision: precision, coordinateSystem: cs).length(), 8.0)
    }

    func testLengthTest3() {
        XCTAssertEqual(LinearRing([Coordinate(x: 0, y: 0), Coordinate(x: 7, y: 0), Coordinate(x: 7, y: 7), Coordinate(x: 0, y: 7), Coordinate(x: 0, y: 0)], precision: precision, coordinateSystem: cs).length(), 28.0)
    }

    func testLengthTest4() {
        XCTAssertEqual(LinearRing([Coordinate(x: 0, y: 0), Coordinate(x: 0, y: 2), Coordinate(x: 0, y: 3), Coordinate(x: 0, y: 4), Coordinate(x: 0, y: 5), Coordinate(x: 5, y: 5), Coordinate(x: 5, y: 0), Coordinate(x: 0, y: 0)], precision: precision, coordinateSystem: cs).length(), 20.0)
    }

    func testLengthPerformance() {
        let lineString = LinearRing([Coordinate(x:0, y: 0), Coordinate(x: 0, y: 2), Coordinate(x: 0, y: 3), Coordinate(x: 0, y: 4), Coordinate(x: 0, y: 5), Coordinate(x: 5, y: 5), Coordinate(x: 5, y: 0), Coordinate(x: 0, y: 0)], precision: precision, coordinateSystem: cs)

        self.measure {

            for _ in 1...500000 {
                let _ = lineString.length()
            }
        }
    }

    func testIsClosedClosed() {
        XCTAssertTrue(LinearRing([Coordinate(x: 0, y: 0), Coordinate(x: 0, y: 2), Coordinate(x: 0, y: 3), Coordinate(x: 2, y: 0), Coordinate(x: 0, y: 0)], precision: precision, coordinateSystem: cs).isClosed())
    }

    func testIsClosedOpen() {
        XCTAssertFalse(LinearRing([Coordinate(x: 0, y: 0), Coordinate(x: 0, y: 2), Coordinate(x: 0, y: 3), Coordinate(x: 0, y: 4), Coordinate(x: 0, y: 5)], precision: precision, coordinateSystem: cs).isClosed())
    }

    func testIsClosedEmpty() {
        XCTAssertFalse(LinearRing(precision: precision, coordinateSystem: cs).isClosed())
    }
}
