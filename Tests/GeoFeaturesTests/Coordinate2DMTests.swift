///
///  Coordinate2DMTests.swift
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
///  Created by Tony Stone on 2/10/2016.
///
import XCTest
import GeoFeatures

class Coordinate2DMTests: XCTestCase {

    // MARK: Coordinate2DM

    func testInit () {
        let coordinate = Coordinate(x: 2.0, y: 3.0, m: 5.0)

        XCTAssertEqual(coordinate.x, 2.0)
        XCTAssertEqual(coordinate.y, 3.0)
        XCTAssertEqual(coordinate.z, nil)
        XCTAssertEqual(coordinate.m, 5.0)
    }

    func testInitWithArrayLiteral () {
        /// Note: 2DM is not possible with Array Literals since it is positional and the Z will always come before the M.
    }

    func testInitWithDictionaryLiteral () {
        let coordinate: Coordinate = ["x": 2.0, "y": 3.0, "m": 5.0]

        XCTAssertEqual(coordinate.x, 2.0)
        XCTAssertEqual(coordinate.y, 3.0)
        XCTAssertEqual(coordinate.z, nil)
        XCTAssertEqual(coordinate.m, 5.0)
    }

    func testX () {
        XCTAssertEqual(Coordinate(x: 1001.0, y: 1002.0, m: 1003.0).x, 1001.0)
    }

    func testY () {
        XCTAssertEqual(Coordinate(x: 1001.0, y: 1002.0, m: 1003.0).y, 1002.0)
    }

    func testZ () {
        XCTAssertEqual(Coordinate(x: 1001.0, y: 1002.0, m: 1003.0).z, nil)
    }

    func testM () {
        XCTAssertEqual(Coordinate(x: 1001.0, y: 1002.0, m: 1003.0).m, 1003.0)
    }

    // MARK: CopyConstructable

    func testInitCopy () {
        let coordinate = Coordinate(other: Coordinate(x: 2.0, y: 3.0, m: 4.0))

        XCTAssertEqual(coordinate.x, 2.0)
        XCTAssertEqual(coordinate.y, 3.0)
        XCTAssertEqual(coordinate.m, 4.0)
    }

    // MARK: CustomStringConvertible & CustomDebugStringConvertible

    func testDescription() {
        let coordinate = Coordinate(x: 2.0, y: 3.0, m: 4.0)

        XCTAssertEqual(coordinate.description, "(x: 2.0, y: 3.0, m: 4.0)")
    }

    func testDebugDescription() {
        let coordinate = Coordinate(x: 2.0, y: 3.0, m: 4.0)

        XCTAssertEqual(coordinate.debugDescription, "(x: 2.0, y: 3.0, m: 4.0)")
    }

    // MARK: Equal

    func testEqual () {
        XCTAssertEqual(Coordinate(x: 1.0, y: 1.0, m: 4.0), Coordinate(x: 1.0, y: 1.0, m: 4.0))
    }

    func testNotEqual () {
        XCTAssertNotEqual(Coordinate(x: 1.0, y: 1.0, m: 4.0), Coordinate(x: 2.0, y: 2.0, m: 4.0))
    }

    // MARK: Hashable

    func testHashValueWithZero () {
        let zero = Coordinate(x: 0.0, y: 0.0, m: 0.0)
        let negativeZero = Coordinate(x: -0.0, y: -0.0, m: -0.0)

        XCTAssertEqual(zero.hashValue, negativeZero.hashValue)
    }

    func testHashValueWithPositiveValue () {
        let zero = Coordinate(x: 0.0, y: 0.0, m: 0.0)
        var last = zero
        let limit = 10000

        for n in -limit...limit {

            let input    = Coordinate(x: Double(n), y: Double(n), m: Double(n))
            let expected = Coordinate(x: Double(n), y: Double(n), m: Double(n))

            XCTAssertEqual   (input.hashValue, expected.hashValue)
            XCTAssertNotEqual(input.hashValue, last.hashValue, "\(input.hashValue) is equal to \(zero.hashValue) for input \(input.description)")

            if n != 0 {
                XCTAssertNotEqual(input.hashValue, zero.hashValue, "\(input.hashValue) is equal to \(zero.hashValue) for input \(input.description)")
            }
            last = input
        }
    }
}
