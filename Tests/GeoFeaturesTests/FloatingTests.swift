///
///  FloatingPrecisionTests.swift
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
///  Created by Tony Stone on 2/11/2016.
///
import XCTest
import GeoFeatures

class FloatingTests: XCTestCase {

    let precision  = Floating()

    func testConvertEqual() {
        XCTAssertEqual(precision.convert(100.003), 100.003)
    }

    func testConvertNotEqual1() {
        XCTAssertNotEqual(precision.convert(100.0), 100.003)
    }

    func testConvertNotEqual2() {
        XCTAssertNotEqual(precision.convert(100.003), 100.0003)
    }

    func testConvertOptionalEqual() {
        let input:    Double? = 100.003
        let expected: Double? = 100.003

        XCTAssertEqual(precision.convert(input), expected)
    }

    func testConvertOptionalNotEqual1() {
        let input:    Double? = 100.0
        let expected: Double? = 100.003

        XCTAssertNotEqual(precision.convert(input), expected)
    }

    func testConvertOptionalNotEqual2() {
        let input:    Double? = 100.003
        let expected: Double? = 100.0003

        XCTAssertNotEqual(precision.convert(input), expected)
    }

    func testConvertOptionalNilEqual() {
        let input:    Double? = nil
        let expected: Double? = nil

        XCTAssertEqual(precision.convert(input), expected)
    }

    func testConvertOptionalNilNotEqual() {
        let input:    Double? = nil
        let expected: Double? = 100.03

        XCTAssertNotEqual(precision.convert(input), expected)
    }

    // MARK: CustomStringConvertible & CustomDebugStringConvertible

    func testDescription() {
        XCTAssertEqual(precision.description, "Floating()")
    }

    func testDebugDescription() {
        XCTAssertEqual(precision.debugDescription, "Floating()")
    }

    func testEqualTrue() {
        let input1 = Floating()
        let input2 = Floating()

        XCTAssertEqual(input1, input2)
    }

    func testEqualFalseWithDifferentType() {
        let input1 = Fixed(scale: 10)
        let input2 = Floating()

        XCTAssertFalse(input1 == input2)
    }
}
