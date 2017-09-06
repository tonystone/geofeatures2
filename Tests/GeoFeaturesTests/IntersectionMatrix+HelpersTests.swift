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

class IntersectionMatrixHelperTests: XCTestCase {

    /// This is a dummy for now.  It will be replaced soon.
    func testInit() {
        let matrix = IntersectionMatrix()

        XCTAssertEqual(matrix[.interior, .interior], Dimension.empty)
        XCTAssertEqual(matrix[.interior, .boundary], Dimension.empty)
        XCTAssertEqual(matrix[.interior, .exterior], Dimension.empty)

        XCTAssertEqual(matrix[.boundary, .interior], Dimension.empty)
        XCTAssertEqual(matrix[.boundary, .boundary], Dimension.empty)
        XCTAssertEqual(matrix[.boundary, .exterior], Dimension.empty)

        XCTAssertEqual(matrix[.exterior, .interior], Dimension.empty)
        XCTAssertEqual(matrix[.exterior, .boundary], Dimension.empty)
        XCTAssertEqual(matrix[.exterior, .exterior], Dimension.empty)
    }
}
