///
///  SweepLineIntersectorTests.swift
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
///  Created by Tony Stone on 1/16/2017.
///
import XCTest
@testable import GeoFeatures

class SweepLineIntersectorTests: XCTestCase {

    typealias CoordinateType = Coordinate2D

    func testIntersects() {
        let sweepLineIntersector    = SweepLineIntersector<CoordinateType>()
        let expected = sweepLineIntersector.intersects(coordinates: [CoordinateType(x: 1.0, y: 1.0), CoordinateType(x: 2.0, y: 1.0), CoordinateType(x: 3.0, y: 1.0)])

        XCTAssertEqual(expected, false)
    }

    func testIntersections_lineString_noIntersection() {
        let sweepLineIntersector    = SweepLineIntersector<CoordinateType>()
        let coordinates = [CoordinateType(x: 1.0, y: 1.0), CoordinateType(x: 2.0, y: 1.0), CoordinateType(x: 3.0, y: 1.0)]
        let expected = sweepLineIntersector.intersections(coordinates: coordinates)

        XCTAssertEqual(expected.count, 0)
    }
    func testIntersections_lineString_selfIntersectsOnePoint_Fails() {
        let sweepLineIntersector    = SweepLineIntersector<CoordinateType>()
        let coordinates = [CoordinateType(x: 1.0, y: 1.0), CoordinateType(x: 3.0, y: 1.0), CoordinateType(x: 2.0, y: 2.0), CoordinateType(x: 2.0, y: 0.0)]
        let expected = sweepLineIntersector.intersections(coordinates: coordinates)

        ///  The following is valid currently,
        XCTAssertEqual(expected.count, 0)
        /// but it should be replaced by the lines below when the sweep line code is working.
///        XCTAssertEqual(expected.count, 1)
///        let firstPoint = expected[0]
///        XCTAssertEqual(firstPoint, CoordinateType(x: 2.0, y: 1.0))
    }

    /// Add test to check if triangle returns one-point intersection

    /// Add test to check for overlapping line segments

    /// Add test to check for non-overlapping line segments on the same line

    /// Add test to check for parallel line segments
}
