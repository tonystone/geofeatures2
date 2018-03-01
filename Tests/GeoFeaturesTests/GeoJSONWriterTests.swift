///
///  GeoJSONWriterTests.swift
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
///  Created by Tony Stone on 12/17/2016.
///
import XCTest
import GeoFeatures

#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS)) && SWIFT_PACKAGE
/// TODO: Remove this after figuring out why there seems to be a symbol conflict (error: cannot specialize a non-generic definition) with another Polygon on Swift PM on Apple platforms only.
import struct GeoFeatures.Polygon
#endif

// MARK: - Coordinate2D -

class GeoJSONWriterCoordinate2DTests: XCTestCase {

    var writer = GeoJSONWriter<Coordinate2D>()

    // MARK: - General

    func testWriteUnsupportedGeometry() {

        let input = UnsupportedGeometry()
        let expected = "Unsupported type \"UnsupportedGeometry(precision: FloatingPrecision, coordinateSystem: Cartesian(), dimension: GeoFeatures.Dimension.one)\"."

        XCTAssertThrowsError(try writer.write(input)) { error in

            if case GeoJSONWriterError.unsupportedType(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }
}
