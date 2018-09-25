///
///  GeoJSONReaderTests.swift
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
///  Created by Tony Stone on 11/16/2016.
///
import XCTest
@testable import GeoFeatures

#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS)) && SWIFT_PACKAGE
    /// Note: Resolution of GeoFeatures.Polygon is ambiguous when ApplicationsServices is included in the app (ApplicationsServices is used by XCTest), this resolves the ambiguity.
    import struct GeoFeatures.Polygon
#endif

// MARK: - Coordinate 2D, FloatingPrecision, Cartesian -

class GeoJSONReaderCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    private var reader = GeoJSONReader(precision: Floating(), coordinateSystem: Cartesian())

    // MARK: - Negative Tests

    func testReadWithInvalidJSON() {

        let input = ":&*** This is not JSON"
        let expected = "^The data couldn’t be read because it isn’t in the correct format.*"

        XCTAssertThrowsError(try reader.read(string: input)) { error in

            if case GeoJSONReader.Errors.invalidJSON(let message) = error {
                XCTAssert(message.range(of: expected, options: .regularExpression) != nil)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testReadWithInvalidRoot() {

        let input = "[]"
        let expected = "Root JSON must be an object type."

        XCTAssertThrowsError(try reader.read(string: input)) { error in

            if case GeoJSONReader.Errors.invalidJSON(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testReadWithMissingTypeAttribute() {

        let input = "{  \"coordinates\": [1.0, 1.0] }"
        let expected = "Missing required attribute \"type\"."

        XCTAssertThrowsError(try reader.read(string: input)) { error in

            if case GeoJSONReader.Errors.missingAttribute(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testReadWithUnsupportedType() {

        let input = "{ \"type\": \"Polywoggle\", \"coordinates\": [1.0, 1.0] }"
        let expected = "Unsupported type \"Polywoggle\"."

        XCTAssertThrowsError(try reader.read(string: input)) { error in

            if case GeoJSONReader.Errors.unsupportedType(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testReadWithMissingCoordinates() {

        let input = "{ \"type\": \"Point\" }"
        let expected = "Missing required attribute \"coordinates\"."

        XCTAssertThrowsError(try reader.read(string: input)) { error in

            if case GeoJSONReader.Errors.missingAttribute(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testReadWithInvalidCoordinateStructure() {

        let input = "{ \"type\": \"Point\", \"coordinates\": [[1.0, 1.0]] }"
        let expected = "Invalid structure for \"coordinates\" attribute."

        XCTAssertThrowsError(try reader.read(string: input)) { error in

            if case GeoJSONReader.Errors.invalidJSON(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testReadWithMissingGeometries() {

        let input = "{ \"type\": \"GeometryCollection\" }"
        let expected = "Missing required attribute \"geometries\"."

        XCTAssertThrowsError(try reader.read(string: input)) { error in

            if case GeoJSONReader.Errors.missingAttribute(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testReadWithInvalidGeometriesStructure() {

        let input = "{ \"type\": \"GeometryCollection\", \"geometries\": {} }"
        let expected = "Invalid structure for \"geometries\" attribute."

        XCTAssertThrowsError(try reader.read(string: input)) { error in

            if case GeoJSONReader.Errors.invalidJSON(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    // MARK: Positive Tests

    func testReadWithValidPoint() {

        let input = "{ \"type\": \"Point\", \"coordinates\": [1.0, 1.0] }"
        let expected = Point([1.0, 1.0])

        XCTAssertEqual(try reader.read(string: input) as? Point, expected)
    }

    func testReadWithValidLineString() {

        let input = "{ \"type\": \"LineString\", \"coordinates\": [ [1.0, 1.0], [2.0, 2.0] ] }"
        let expected = LineString([[1.0, 1.0], [2.0, 2.0]])

        XCTAssertEqual(try reader.read(string: input) as? LineString, expected)
    }

    func testReadWithValidPolygon() {

        let input = "{ \"type\": \"Polygon\"," +
                        "\"coordinates\": [" +
                        "[ [100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0] ]," +
                        "[ [100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8], [100.2, 0.2] ]" +
                        "]" +
                    "}"
        let expected = Polygon([[100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0]], innerRings: [[[100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8], [100.2, 0.2]]])

        XCTAssertEqual(try reader.read(string: input) as? Polygon, expected)
    }

    func testReadWithValidMultiPoint() {

        let input = "{ \"type\": \"MultiPoint\", \"coordinates\": [ [100.0, 0.0], [101.0, 1.0] ] }"
        let expected = MultiPoint([Point([100.0, 0.0]), Point([101.0, 1.0])])

        XCTAssertEqual(try reader.read(string: input) as? MultiPoint, expected)
    }

    func testReadWithValidMultiLineString() {

        let input = "{ \"type\": \"MultiLineString\"," +
                       "\"coordinates\": [" +
                            "[ [100.0, 0.0], [101.0, 1.0] ]," +
                            "[ [102.0, 2.0], [103.0, 3.0] ]" +
                        "]" +
                    "}"
        let expected = MultiLineString([LineString([[100.0, 0.0], [101.0, 1.0]]), LineString([[102.0, 2.0], [103.0, 3.0]])])

        XCTAssertEqual(try reader.read(string: input) as? MultiLineString, expected)
    }

    func testReadWithValidMultiPolygon() {

        let input = "{ \"type\": \"MultiPolygon\"," +
                        "\"coordinates\": [" +
                            "[[[102.0, 2.0], [103.0, 2.0], [103.0, 3.0], [102.0, 3.0], [102.0, 2.0]]]," +
                            "[[[100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0]]," +
                            " [[100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8], [100.2, 0.2]]]" +
                        "]" +
                    "}"
        let expected = MultiPolygon([
                Polygon([[102.0, 2.0], [103.0, 2.0], [103.0, 3.0], [102.0, 3.0], [102.0, 2.0]], innerRings: []),
                Polygon([[100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0]], innerRings: [[[100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8], [100.2, 0.2]]])
                ])

        XCTAssertEqual(try reader.read(string: input) as? MultiPolygon, expected)
    }

    func testReadWithValidGeometryCollection() {

        let input = "{ \"type\": \"GeometryCollection\"," +
                        "\"geometries\": [" +
                            "{ \"type\": \"Point\", \"coordinates\": [100.0, 0.0] }," +
                            "{ \"type\": \"LineString\", \"coordinates\": [ [101.0, 0.0], [102.0, 1.0] ] }" +
                        "]" +
                    "}"
        let expected = GeometryCollection([
                Point([100.0, 0.0]),
                LineString([[101.0, 0.0], [102.0, 1.0]])
                ] as [Geometry])

        XCTAssertEqual(try reader.read(string: input) as? GeometryCollection, expected)
    }
}

// MARK: - Coordinate 3DM, Fixed, Cartesian -

class GeoJSONReaderCoordinate3DMFixedCartesianTests: XCTestCase {

    private var reader = GeoJSONReader(precision: Fixed(scale: 100), coordinateSystem: Cartesian())

    // MARK: Positive Tests

    func testReadWithValidPoint() {

        let input = "{ \"type\": \"Point\", \"coordinates\": [1.001, 1.001, 1.001, 1.001] }"
        let expected = Point([1.0, 1.0, 1.0, 1.0])

        XCTAssertEqual(try reader.read(string: input) as? Point, expected)
    }

    func testReadWithValidLineString() {

        let input = "{ \"type\": \"LineString\", \"coordinates\": [ [1.0, 1.0, 1.0, 1.0], [2.0, 2.0, 2.0, 2.0] ] }"
        let expected = LineString([[1.0, 1.0, 1.0, 1.0], [2.0, 2.0, 2.0, 2.0]])

        XCTAssertEqual(try reader.read(string: input) as? LineString, expected)
    }

    func testReadWithValidPolygon() {

        let input = "{ \"type\": \"Polygon\"," +
                        "\"coordinates\": [" +
                        "[ [100.0, 0.0, 1.0, 1.0], [101.0, 0.0, 1.0, 1.0], [101.0, 1.001, 1.0, 1.0], [100.0, 1.001, 1.0, 1.0], [100.0, 0.0, 1.0, 1.0] ]," +
                        "[ [100.2, 0.2, 1.0, 1.0], [100.8, 0.2, 1.0, 1.0], [100.8, 0.8, 1.0, 1.0], [100.2, 0.8, 1.0, 1.0], [100.2, 0.2, 1.0, 1.0] ]" +
                        "]" +
                    "}"
        let expected = Polygon([[100.0, 0.0, 1.0, 1.0], [101.0, 0.0, 1.0, 1.0], [101.0, 1.0, 1.0, 1.0], [100.0, 1.0, 1.0, 1.0], [100.0, 0.0, 1.0, 1.0]], innerRings: [[[100.2, 0.2, 1.0, 1.0], [100.8, 0.2, 1.0, 1.0], [100.8, 0.8, 1.0, 1.0], [100.2, 0.8, 1.0, 1.0], [100.2, 0.2, 1.0, 1.0]]])

        XCTAssertEqual(try reader.read(string: input) as? Polygon, expected)
    }

    func testReadWithValidMultiPoint() {

        let input = "{ \"type\": \"MultiPoint\", \"coordinates\": [ [100.0, 0.0, 1.0, 1.0], [101.0, 1.0, 1.0, 1.0] ] }"
        let expected = MultiPoint([Point([100.0, 0.0, 1.0, 1.0]), Point([101.0, 1.0, 1.0, 1.0])])

        XCTAssertEqual(try reader.read(string: input) as? MultiPoint, expected)
    }

    func testReadWithValidMultiLineString() {

        let input = "{ \"type\": \"MultiLineString\"," +
                       "\"coordinates\": [" +
                            "[ [100.0, 0.0, 1.0, 1.0], [101.0, 1.0, 1.0, 1.0] ]," +
                            "[ [102.0, 2.0, 1.0, 1.0], [103.0, 3.0, 1.0, 1.0] ]" +
                        "]" +
                    "}"
        let expected = MultiLineString([LineString([[100.0, 0.0, 1.0, 1.0], [101.0, 1.0, 1.0, 1.0]]), LineString([[102.0, 2.0, 1.0, 1.0], [103.0, 3.0, 1.0, 1.0]])])

        XCTAssertEqual(try reader.read(string: input) as? MultiLineString, expected)
    }

    func testReadWithValidMultiPolygon() {

        let input = "{ \"type\": \"MultiPolygon\"," +
                        "\"coordinates\": [" +
                            "[[[102.0, 2.0, 1.0, 1.0], [103.0, 2.0, 1.0, 1.0], [103.0, 3.0, 1.0, 1.0], [102.0, 3.0, 1.0, 1.0], [102.0, 2.0, 1.0, 1.0]]]," +
                            "[[[100.0, 0.0, 1.0, 1.0], [101.0, 0.0, 1.0, 1.0], [101.0, 1.0, 1.0, 1.0], [100.0, 1.0, 1.0, 1.0], [100.0, 0.0, 1.0, 1.0]]," +
                            " [[100.2, 0.2, 1.0, 1.0], [100.8, 0.2, 1.0, 1.0], [100.8, 0.8, 1.0, 1.0], [100.2, 0.8, 1.0, 1.0], [100.2, 0.2, 1.0, 1.0]]]" +
                        "]" +
                    "}"
        let expected = MultiPolygon([
                Polygon([[102.0, 2.0, 1.0, 1.0], [103.0, 2.0, 1.0, 1.0], [103.0, 3.0, 1.0, 1.0], [102.0, 3.0, 1.0, 1.0], [102.0, 2.0, 1.0, 1.0]], innerRings: []),
                Polygon([[100.0, 0.0, 1.0, 1.0], [101.0, 0.0, 1.0, 1.0], [101.0, 1.0, 1.0, 1.0], [100.0, 1.0, 1.0, 1.0], [100.0, 0.0, 1.0, 1.0]], innerRings: [[[100.2, 0.2, 1.0, 1.0], [100.8, 0.2, 1.0, 1.0], [100.8, 0.8, 1.0, 1.0], [100.2, 0.8, 1.0, 1.0], [100.2, 0.2, 1.0, 1.0]]])
                ])

        XCTAssertEqual(try reader.read(string: input) as? MultiPolygon, expected)
    }

    func testReadWithValidGeometryCollection() {

        let input = "{ \"type\": \"GeometryCollection\"," +
                        "\"geometries\": [" +
                            "{ \"type\": \"Point\", \"coordinates\": [100.0, 0.0, 1.0, 1.0] }," +
                            "{ \"type\": \"LineString\", \"coordinates\": [ [101.0, 0.0, 1.0, 1.0], [102.0, 1.0, 1.0, 1.0] ] }" +
                        "]" +
                    "}"
        let expected = GeometryCollection([
                Point([100.0, 0.0, 1.0, 1.0]),
                LineString([[101.0, 0.0, 1.0, 1.0], [102.0, 1.0, 1.0, 1.0]])
                ] as [Geometry])

        XCTAssertEqual(try reader.read(string: input) as? GeometryCollection, expected)
    }
}

// MARK: - Test internal methods

class GeoJSONReaderInternal: XCTestCase {

    private var reader = GeoJSONReader(precision: Floating(), coordinateSystem: Cartesian())

    func testCoordinateWithInvalidString() {

        let input: [Any] = ["1.0.0.2.1"]
        let expected = "Invalid structure for \"coordinates\" attribute."

        XCTAssertThrowsError(try reader.coordinate(array: input)) { error in

            if case GeoJSONReader.Errors.invalidJSON(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testCoordinatesWithInvalidStructure() {

        let input = ["coordinates": [1.0, 1.0, 1.0, 1.0] ]
        let expected = "Invalid structure for \"coordinates\" attribute."

        XCTAssertThrowsError(try Coordinates<String>.coordinates(json: input)) { error in

            if case GeoJSONReader.Errors.invalidJSON(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }
}
