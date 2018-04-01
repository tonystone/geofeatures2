///
/// BoundsTests.swift
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

class BoundsTests: XCTestCase {

    func testInit() {
        let input    = Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 90.0))
        let expected = ((x: 0.0, y: 0.0), (x: 90.0, y: 90.0))

        XCTAssertEqual(input.min.x, expected.0.x)
        XCTAssertEqual(input.min.y, expected.0.y)
        XCTAssertEqual(input.max.x, expected.1.x)
        XCTAssertEqual(input.max.y, expected.1.y)
    }

    func testMin() {
        let input    = Bounds(min: (x: 1.0, y: 1.0), max: (x: 90.0, y: 90.0))
        let expected = (x: 1.0, y: 1.0)

        XCTAssertEqual(input.min.x, expected.x)
        XCTAssertEqual(input.min.y, expected.y)
    }

    func testMax() {
        let input    = Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 90.0))
        let expected = (x: 90.0, y: 90.0)

        XCTAssertEqual(input.max.x, expected.x)
        XCTAssertEqual(input.max.y, expected.y)
    }

    func testMidWithOriginZero() {
        let input    = Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 90.0))
        let expected = (x: 45.0, y: 45.0)

        XCTAssertEqual(input.mid.x, expected.x)
        XCTAssertEqual(input.mid.y, expected.y)
    }

    func testMidWithOriginNegative() {
        let input    = Bounds(min: (x: -45.0, y: -45.0), max: (x: 45.0, y: 45.0))
        let expected = (x: 0.0, y: 0.0)

        XCTAssertEqual(input.mid.x, expected.x)
        XCTAssertEqual(input.mid.y, expected.y)
    }

    func testExpand() {
        let input    = (Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 90.0)), Bounds(min: (x: 0.0, y: 20.0), max: (x: 90.0, y: 200.0)))
        let expected = Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 200.0))

        XCTAssertEqual(input.0.expand(other: input.1),  expected)
    }

    func testEqualTrue() {
        let input    = (Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 90.0)), Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 90.0)))
        let expected = true

        XCTAssertEqual(input.0 == input.1,  expected)
    }

    func testEqualFalse() {
        let input    = (Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 90.0)), Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 200.0)))
        let expected = false

        XCTAssertEqual(input.0 == input.1,  expected)
    }

    func testDescription() {
        let input    = Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 90.0))
        let expected = "Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 90.0))"

        XCTAssertEqual(input.description,  expected)
    }

    func testDebugDescription() {
        let input    = Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 90.0))
        let expected = "Bounds(min: (x: 0.0, y: 0.0), max: (x: 90.0, y: 90.0))"

        XCTAssertEqual(input.debugDescription,  expected)
    }
}

