///
///  FixedTests.swift
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

class FixedTests: XCTestCase {

    let precision  = Fixed(scale: 10)

    func testConvertWithScale10Lower() {
        XCTAssertEqual(precision.convert(1.01), 1.0)
    }

    func testConvertWithScale10Middle() {
        XCTAssertEqual(precision.convert(1.05), 1.1)
    }

    func testConvertWithScale10Upper() {
        XCTAssertEqual(precision.convert(1.09), 1.1)
    }

    func testConvertWithScale10Lower2() {
        XCTAssertEqual(precision.convert(1.0111), 1.0)
    }

    func testConvertWithScale10Middle2() {
        XCTAssertEqual(precision.convert(1.0555), 1.1)
    }

    func testConvertWithScale10Upper2() {
        XCTAssertEqual(precision.convert(1.0999), 1.1)
    }

    func testConvertOptionalWithScale10Lower() {
        let input:    Double? = 1.01
        let expected: Double? = 1.0

        XCTAssertEqual(precision.convert(input), expected)
    }

    func testConvertOptionalWithNil() {
        let input:    Double? = nil
        let expected: Double? = nil

        XCTAssertEqual(precision.convert(input), expected)
    }

    // MARK: CustomStringConvertible & CustomDebugStringConvertible

    func testDescription() {
        XCTAssertEqual(precision.description, "Fixed(scale: 10.0)")
    }

    func testDebugDescription() {
        XCTAssertEqual(precision.debugDescription, "Fixed(scale: 10.0)")
    }

    func testEqualTrue() {
        let input1 = Fixed(scale: 10)
        let input2 = Fixed(scale: 10)

        XCTAssertEqual(input1, input2)
    }

    func testEqualFalse() {
        let input1 = Fixed(scale: 10)
        let input2 = Fixed(scale: 100)

        XCTAssertNotEqual(input1, input2)
    }

    func testEqualFalseWithDifferentType() {
        let input1 = Fixed(scale: 10)
        let input2 = Floating()

        XCTAssertFalse(input1 == input2)
    }
}
