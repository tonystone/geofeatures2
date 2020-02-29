///
///  CartesianTests.swift
///
///  Copyright (c) 2018 Tony Stone
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
///  Created by Tony Stone on 02/26/2018.
///
import XCTest
import GeoFeatures

private struct DummyCoordinateReferenceSystem: CoordinateSystem, Equatable, Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(String(reflecting: self))
    }
}

class CoordinateSystemCartesianTests: XCTestCase {

    func testEqualTrue() {
        XCTAssertTrue(Cartesian() == Cartesian())
    }

    func testEqualFalse() {
        XCTAssertFalse(Cartesian() == DummyCoordinateReferenceSystem())
    }

    func testDescription() {
        XCTAssertEqual(Cartesian().description, "Cartesian()")
    }

    func testDebugDescription() {
        XCTAssertEqual(Cartesian().debugDescription, "Cartesian()")
    }
}
