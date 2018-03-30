///
/// RectangleTests.swift
///
/// Copyright (c) 2018 Tony Stone, All rights reserved.
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
/// Created by Tony Stone on 3/30/18.
///
import XCTest
@testable import GeoFeatures

class RectangleTests: XCTestCase {

    func testInit() {
        let input    = Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0))
        let expected = (Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0))

        XCTAssertEqual(input.lowerLeft,  expected.0)
        XCTAssertEqual(input.upperRight, expected.1)
    }

    func testLowerLeft() {
        let input    = Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0))
        let expected = Coordinate(x: 0.0, y: 0.0)

        XCTAssertEqual(input.lowerLeft,  expected)
    }

    func testUpperLeft() {
        let input    = Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0))
        let expected = Coordinate(x: 0.0, y: 90.0)

        XCTAssertEqual(input.upperLeft,  expected)
    }

    func testUpperRight() {
        let input    = Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0))
        let expected = Coordinate(x: 90.0, y: 90.0)

        XCTAssertEqual(input.upperRight,  expected)
    }

    func testLowerRight() {
        let input    = Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0))
        let expected = Coordinate(x: 90.0, y: 0.0)

        XCTAssertEqual(input.lowerRight,  expected)
    }

    func testCoordinatest() {
        let input    = Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0)).coordinates
        let expected = (Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 90.0), Coordinate(x: 90.0, y: 90.0), Coordinate(x: 90.0, y: 0.0), Coordinate(x: 0.0, y: 0.0))

        XCTAssertEqual(input[0],  expected.0)
        XCTAssertEqual(input[1],  expected.1)
        XCTAssertEqual(input[2],  expected.2)
        XCTAssertEqual(input[3],  expected.3)
        XCTAssertEqual(input[4],  expected.4)
    }

    func testUnion() {
        let input    = (Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0)), Rectangle(Coordinate(x: 0.0, y: 20.0), Coordinate(x: 90.0, y: 200.0)))
        let expected = Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 200.0))

        XCTAssertEqual(input.0.union(other: input.1),  expected)
    }

    func testEqualTrue() {
        let input    = (Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0)), Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0)))
        let expected = true

        XCTAssertEqual(input.0 == input.1,  expected)
    }

    func testEqualFalse() {
        let input    = (Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0)), Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 200.0)))
        let expected = false

        XCTAssertEqual(input.0 == input.1,  expected)
    }

    func testDescription() {
        let input    = Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0))
        let expected = "Rectangle((x: 0.0, y: 0.0), (x: 90.0, y: 90.0))"

        XCTAssertEqual(input.description,  expected)
    }

    func testDebugDescription() {
        let input    = Rectangle(Coordinate(x: 0.0, y: 0.0), Coordinate(x: 90.0, y: 90.0))
        let expected = "Rectangle((x: 0.0, y: 0.0), (x: 90.0, y: 90.0))"

        XCTAssertEqual(input.debugDescription,  expected)
    }
}

