///
///  Geometry+PredicateTests.swift
///
///  Copyright (c) 2020 Tony Stone
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
///  Created by Tony Stone on 4/8/2020.
///
import XCTest
@testable import GeoFeatures

// MARK: - All

class GeometryPredicateTests: XCTestCase {

    func testEqualsWithLineStringAndLineStringTrue() {
        let lineString1 = LineString([[200, 100], [100, 100]])
        let lineString2 = LineString([[200, 100], [100, 100]])

        XCTAssertTrue(lineString1.equals(lineString2))
    }

    func testEqualsWithLineStringAndReversedLineStringTrue() {
        let lineString1 = LineString([[200, 100], [100, 100]])
        let lineString2 = LineString([[100, 100], [200, 100]])

        XCTAssertTrue(lineString1.equals(lineString2))
    }

}
