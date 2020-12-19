///
///  SegmentTests.swift
///
///  Copyright (c) 2020 Ed Swiss
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
///  Created by Ed Swiss on 12/19/2020.
///
import XCTest
@testable import GeoFeatures

class SegmentTests: XCTestCase {

    func testValidLineStringWithTwoCoordinates() {
        let input: LineString = [Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]
        let output = Segment(other: input)

        XCTAssertEqual(input[0], output.leftCoordinate)
        XCTAssertEqual(input[1], output.rightCoordinate)
    }

    func testInvalidLineStringWithNoCoordinates() {
        let input: LineString = []
        let output = Segment(other: input)

        XCTAssertEqual(output.leftCoordinate, Coordinate(x: 0.0, y: 0.0))
        XCTAssertEqual(output.rightCoordinate, Coordinate(x: 0.0, y: 0.0))
    }

    func testInvalidLineStringWithOneCoordinate() {
        let input: LineString = [Coordinate(x: 1.0, y: 1.0)]
        let output = Segment(other: input)

        XCTAssertEqual(output.leftCoordinate, Coordinate(x: 0.0, y: 0.0))
        XCTAssertEqual(output.rightCoordinate, Coordinate(x: 0.0, y: 0.0))
    }

    func testInvalidLineStringWithThreeCoordinates() {
        let input: LineString = [Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 5.0)]
        let output = Segment(other: input)

        XCTAssertEqual(output.leftCoordinate, Coordinate(x: 0.0, y: 0.0))
        XCTAssertEqual(output.rightCoordinate, Coordinate(x: 0.0, y: 0.0))
    }
}
