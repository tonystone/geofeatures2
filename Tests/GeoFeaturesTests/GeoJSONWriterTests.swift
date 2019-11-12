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

    let writer = GeoJSONWriter()

    // MARK: - General

    func testWriteUnsupportedGeometry() {

        let input = UnsupportedGeometry()
        let expected = "Unsupported type \"UnsupportedGeometry(precision: Floating(), coordinateSystem: Cartesian(), dimension: GeoFeatures.Dimension.one)\"."

        XCTAssertThrowsError(try writer.write(input)) { error in

            if case GeoJSONWriter.Errors.unsupportedType(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testWritePoint() throws {

        let input = Point(Coordinate(x: 1.0, y: 1.0))
        let expected: [String: Any] = ["type": "Point", "coordinates": [1.0, 1.0] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteLineString() throws {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)])
        let expected: [String: Any] =  ["type": "LineString", "coordinates": [ [1.0, 1.0], [2.0, 2.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteLinearRing() throws {

        let input = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)])
        let expected: [String: Any] =  ["type": "LineString", "coordinates": [ [1.0, 1.0], [2.0, 2.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWritePolygon() throws {
        let input = Polygon([Coordinate(x: 100.0, y: 0.0), Coordinate(x: 101.0, y: 0.0), Coordinate(x: 101.0, y: 1.0), Coordinate(x: 100.0, y: 1.0), Coordinate(x: 100.0, y: 0.0)], innerRings: [[Coordinate(x: 100.2, y: 0.2), Coordinate(x: 100.8, y: 0.2), Coordinate(x: 100.8, y: 0.8), Coordinate(x: 100.2, y: 0.8), Coordinate(x: 100.2, y: 0.2)]])

        let expected: [String: Any] = [ "type": "Polygon",
                                        "coordinates": [
                                            [ [100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0] ],
                                            [ [100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8], [100.2, 0.2] ]
                                            ]
                                    ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiPoint() throws {

        let input = MultiPoint([Point(Coordinate(x: 100.0, y: 0.0)), Point(Coordinate(x: 101.0, y: 1.0))])
        let expected: [String: Any] = ["type": "MultiPoint", "coordinates": [ [100.0, 0.0], [101.0, 1.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiLineString() throws {

        let input = MultiLineString([LineString([[100.0, 100.0], [100.0, 200.0], [200.0, 200.0]]), LineString([[200.0, 200.0], [200.0, 300.0], [300.0, 300.0]])])
        let expected: [String: Any] = ["type": "MultiLineString", "coordinates": [ [[100.0, 100.0], [100.0, 200.0], [200.0, 200.0]], [[200.0, 200.0], [200.0, 300.0], [300.0, 300.0]] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiPolygon() throws {

        let input = MultiPolygon([Polygon([[[0, 0], [60, 144], [120, 0], [0, 0]], [[40, 25], [80, 25], [60, 80], [40, 25]]]), Polygon([[0, 0], [100, 107], [140, 102], [102, 0], [102, 50], [0, 0]])])
        let expected: [String: Any] = ["type": "MultiPolygon", "coordinates": [ [[[0.0, 0.0], [60.0, 144.0], [120.0, 0.0], [0.0, 0.0]], [[40.0, 25.0], [80.0, 25.0], [60.0, 80.0], [40.0, 25.0]]], [[[0.0, 0.0], [100.0, 107.0], [140.0, 102.0], [102.0, 0.0], [102.0, 50.0], [0.0, 0.0]]] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteGeometryCollection() throws {

        let input = GeometryCollection([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), MultiPoint([Point(Coordinate(x: 100.0, y: 0.0)), Point(Coordinate(x: 101.0, y: 1.0))])])
        let expected: [String: Any] = ["type": "GeometryCollection", "geometries": [ ["type": "LineString", "coordinates": [ [1.0, 1.0], [2.0, 2.0] ] ], ["type": "MultiPoint", "coordinates": [ [100.0, 0.0], [101.0, 1.0] ] ]] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }
}

// MARK: - Coordinate2DM -

class GeoJSONWriterCoordinate2DMTests: XCTestCase {

    let writer = GeoJSONWriter(axes: [.m])

    // MARK: - General

    func testWriteUnsupportedGeometry() {

        let input = UnsupportedGeometry()
        let expected = "Unsupported type \"UnsupportedGeometry(precision: Floating(), coordinateSystem: Cartesian(), dimension: GeoFeatures.Dimension.one)\"."

        XCTAssertThrowsError(try writer.write(input)) { error in

            if case GeoJSONWriter.Errors.unsupportedType(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testWriteInvalidNumberOfCoordinates() throws {

        let input = Point(Coordinate(x: 1.0, y: 1.0))
        let expected = "Coordinate (x: 1.0, y: 1.0) is missing the M axis."

        XCTAssertThrowsError(try writer.write(input)) { error in

            if case GeoJSONWriter.Errors.invalidNumberOfCoordinates(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testWritePoint() throws {

        let input = Point(Coordinate(x: 1.0, y: 1.0, m: 1.0))
        let expected: [String: Any] = ["type": "Point", "coordinates": [1.0, 1.0, 1.0] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteLineString() throws {

        let input = LineString([Coordinate(x: 1.0, y: 1.0, m: 1.0), Coordinate(x: 2.0, y: 2.0, m: 2.0)])
        let expected: [String: Any] =  ["type": "LineString", "coordinates": [ [1.0, 1.0, 1.0], [2.0, 2.0, 2.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteLinearRing() throws {

        let input = LinearRing([Coordinate(x: 1.0, y: 1.0, m: 1.0), Coordinate(x: 2.0, y: 2.0, m: 2.0)])
        let expected: [String: Any] =  ["type": "LineString", "coordinates": [ [1.0, 1.0, 1.0], [2.0, 2.0, 2.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWritePolygon() throws {
        let input = Polygon([Coordinate(x: 100.0, y: 0.0, m: 0.0), Coordinate(x: 101.0, y: 0.0, m: 0.0), Coordinate(x: 101.0, y: 1.0, m: 0.0), Coordinate(x: 100.0, y: 1.0, m: 0.0), Coordinate(x: 100.0, y: 0.0, m: 0.0)], innerRings: [[Coordinate(x: 100.2, y: 0.2, m: 0.0), Coordinate(x: 100.8, y: 0.2, m: 0.0), Coordinate(x: 100.8, y: 0.8, m: 0.0), Coordinate(x: 100.2, y: 0.8, m: 0.0), Coordinate(x: 100.2, y: 0.2, m: 0.0)]])

        let expected: [String: Any] = [ "type": "Polygon",
                                        "coordinates": [
                                            [ [100.0, 0.0, 0.0], [101.0, 0.0, 0.0], [101.0, 1.0, 0.0], [100.0, 1.0, 0.0], [100.0, 0.0, 0.0] ],
                                            [ [100.2, 0.2, 0.0], [100.8, 0.2, 0.0], [100.8, 0.8, 0.0], [100.2, 0.8, 0.0], [100.2, 0.2, 0.0] ]
            ]
        ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiPoint() throws {

        let input = MultiPoint([Point(Coordinate(x: 100.0, y: 0.0, m: 0.0)), Point(Coordinate(x: 101.0, y: 1.0, m: 0.0))])
        let expected: [String: Any] = ["type": "MultiPoint", "coordinates": [ [100.0, 0.0, 0.0], [101.0, 1.0, 0.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiLineString() throws {

        let input = MultiLineString([LineString([Coordinate(x: 100.0, y: 100.0, m: 0.0), Coordinate(x: 100.0, y: 200.0, m: 0.0), Coordinate(x: 200.0, y: 200.0, m: 0.0)]), LineString([Coordinate(x: 200.0, y: 200.0, m: 0.0), Coordinate(x: 200.0, y: 300.0, m: 0.0), Coordinate(x: 300.0, y: 300.0, m: 0.0)])])
        let expected: [String: Any] = ["type": "MultiLineString", "coordinates": [ [[100.0, 100.0, 0.0], [100.0, 200.0, 0.0], [200.0, 200.0, 0.0]], [[200.0, 200.0, 0.0], [200.0, 300.0, 0.0], [300.0, 300.0, 0.0]] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiPolygon() throws {

        let input = MultiPolygon([Polygon([[Coordinate(x: 0.0, y: 0.0, m: 0.0), Coordinate(x: 60, y: 144, m: 0.0), Coordinate(x: 120, y: 0.0, m: 0.0), Coordinate(x: 0.0, y: 0.0, m: 0.0)], [Coordinate(x: 40, y: 25, m: 0.0), Coordinate(x: 80, y: 25, m: 0.0), Coordinate(x: 60, y: 80, m: 0.0), Coordinate(x: 40, y: 25, m: 0.0)]]), Polygon([Coordinate(x: 0.0, y: 0.0, m: 0.0), Coordinate(x: 100, y: 107, m: 0.0), Coordinate(x: 140, y: 102, m: 0.0), Coordinate(x: 102, y: 0.0, m: 0.0), Coordinate(x: 102, y: 50, m: 0.0), Coordinate(x: 0.0, y: 0.0, m: 0.0)])])
        let expected: [String: Any] = ["type": "MultiPolygon", "coordinates": [ [[[0.0, 0.0, 0.0], [60.0, 144.0, 0.0], [120.0, 0.0, 0.0], [0.0, 0.0, 0.0]], [[40.0, 25.0, 0.0], [80.0, 25.0, 0.0], [60.0, 80.0, 0.0], [40.0, 25.0, 0.0]]], [[[0.0, 0.0, 0.0], [100.0, 107.0, 0.0], [140.0, 102.0, 0.0], [102.0, 0.0, 0.0], [102.0, 50.0, 0.0], [0.0, 0.0, 0.0]]] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteGeometryCollection() throws {

        let input = GeometryCollection([LineString([Coordinate(x: 1.0, y: 1.0, m: 0.0), Coordinate(x: 2.0, y: 2.0, m: 0.0)]), MultiPoint([Point(Coordinate(x: 100.0, y: 0.0, m: 0.0)), Point(Coordinate(x: 101.0, y: 1.0, m: 0.0))])])
        let expected: [String: Any] = ["type": "GeometryCollection", "geometries": [ ["type": "LineString", "coordinates": [ [1.0, 1.0, 0.0], [2.0, 2.0, 0.0] ] ], ["type": "MultiPoint", "coordinates": [ [100.0, 0.0, 0.0], [101.0, 1.0, 0.0] ] ]] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }
}

// MARK: - Coordinate3D -

class GeoJSONWriterCoordinate3DTests: XCTestCase {

    let writer = GeoJSONWriter(axes: [.z])

    // MARK: - General

    func testWriteUnsupportedGeometry() {

        let input = UnsupportedGeometry()
        let expected = "Unsupported type \"UnsupportedGeometry(precision: Floating(), coordinateSystem: Cartesian(), dimension: GeoFeatures.Dimension.one)\"."

        XCTAssertThrowsError(try writer.write(input)) { error in

            if case GeoJSONWriter.Errors.unsupportedType(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testWriteInvalidNumberOfCoordinates() throws {

        let input = Point(Coordinate(x: 1.0, y: 1.0))
        let expected = "Coordinate (x: 1.0, y: 1.0) is missing the Z axis."

        XCTAssertThrowsError(try writer.write(input)) { error in

            if case GeoJSONWriter.Errors.invalidNumberOfCoordinates(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testWritePoint() throws {

        let input = Point(Coordinate(x: 1.0, y: 1.0, z: 1.0))
        let expected: [String: Any] = ["type": "Point", "coordinates": [1.0, 1.0, 1.0] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteLineString() throws {

        let input = LineString([Coordinate(x: 1.0, y: 1.0, z: 1.0), Coordinate(x: 2.0, y: 2.0, z: 2.0)])
        let expected: [String: Any] =  ["type": "LineString", "coordinates": [ [1.0, 1.0, 1.0], [2.0, 2.0, 2.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteLinearRing() throws {

        let input = LinearRing([Coordinate(x: 1.0, y: 1.0, z: 1.0), Coordinate(x: 2.0, y: 2.0, z: 2.0)])
        let expected: [String: Any] =  ["type": "LineString", "coordinates": [ [1.0, 1.0, 1.0], [2.0, 2.0, 2.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWritePolygon() throws {
        let input = Polygon([Coordinate(x: 100.0, y: 0.0, z: 0.0), Coordinate(x: 101.0, y: 0.0, z: 0.0), Coordinate(x: 101.0, y: 1.0, z: 0.0), Coordinate(x: 100.0, y: 1.0, z: 0.0), Coordinate(x: 100.0, y: 0.0, z: 0.0)], innerRings: [[Coordinate(x: 100.2, y: 0.2, z: 0.0), Coordinate(x: 100.8, y: 0.2, z: 0.0), Coordinate(x: 100.8, y: 0.8, z: 0.0), Coordinate(x: 100.2, y: 0.8, z: 0.0), Coordinate(x: 100.2, y: 0.2, z: 0.0)]])

        let expected: [String: Any] = [ "type": "Polygon",
                                        "coordinates": [
                                            [ [100.0, 0.0, 0.0], [101.0, 0.0, 0.0], [101.0, 1.0, 0.0], [100.0, 1.0, 0.0], [100.0, 0.0, 0.0] ],
                                            [ [100.2, 0.2, 0.0], [100.8, 0.2, 0.0], [100.8, 0.8, 0.0], [100.2, 0.8, 0.0], [100.2, 0.2, 0.0] ]
                                        ]
        ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiPoint() throws {

        let input = MultiPoint([Point(Coordinate(x: 100.0, y: 0.0, z: 0.0)), Point(Coordinate(x: 101.0, y: 1.0, z: 0.0))])
        let expected: [String: Any] = ["type": "MultiPoint", "coordinates": [ [100.0, 0.0, 0.0], [101.0, 1.0, 0.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiLineString() throws {

        let input = MultiLineString([LineString([Coordinate(x: 100.0, y: 100.0, z: 0.0), Coordinate(x: 100.0, y: 200.0, z: 0.0), Coordinate(x: 200.0, y: 200.0, z: 0.0)]), LineString([Coordinate(x: 200.0, y: 200.0, z: 0.0), Coordinate(x: 200.0, y: 300.0, z: 0.0), Coordinate(x: 300.0, y: 300.0, z: 0.0)])])
        let expected: [String: Any] = ["type": "MultiLineString", "coordinates": [ [[100.0, 100.0, 0.0], [100.0, 200.0, 0.0], [200.0, 200.0, 0.0]], [[200.0, 200.0, 0.0], [200.0, 300.0, 0.0], [300.0, 300.0, 0.0]] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiPolygon() throws {

        let input = MultiPolygon([Polygon([[Coordinate(x: 0.0, y: 0.0, z: 0.0), Coordinate(x: 60, y: 144, z: 0.0), Coordinate(x: 120, y: 0.0, z: 0.0), Coordinate(x: 0.0, y: 0.0, z: 0.0)], [Coordinate(x: 40, y: 25, z: 0.0), Coordinate(x: 80, y: 25, z: 0.0), Coordinate(x: 60, y: 80, z: 0.0), Coordinate(x: 40, y: 25, z: 0.0)]]), Polygon([Coordinate(x: 0.0, y: 0.0, z: 0.0), Coordinate(x: 100, y: 107, z: 0.0), Coordinate(x: 140, y: 102, z: 0.0), Coordinate(x: 102, y: 0.0, z: 0.0), Coordinate(x: 102, y: 50, z: 0.0), Coordinate(x: 0.0, y: 0.0, z: 0.0)])])
        let expected: [String: Any] = ["type": "MultiPolygon", "coordinates": [ [[[0.0, 0.0, 0.0], [60.0, 144.0, 0.0], [120.0, 0.0, 0.0], [0.0, 0.0, 0.0]], [[40.0, 25.0, 0.0], [80.0, 25.0, 0.0], [60.0, 80.0, 0.0], [40.0, 25.0, 0.0]]], [[[0.0, 0.0, 0.0], [100.0, 107.0, 0.0], [140.0, 102.0, 0.0], [102.0, 0.0, 0.0], [102.0, 50.0, 0.0], [0.0, 0.0, 0.0]]] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteGeometryCollection() throws {

        let input = GeometryCollection([LineString([Coordinate(x: 1.0, y: 1.0, z: 0.0), Coordinate(x: 2.0, y: 2.0, z: 0.0)]), MultiPoint([Point(Coordinate(x: 100.0, y: 0.0, z: 0.0)), Point(Coordinate(x: 101.0, y: 1.0, z: 0.0))])])
        let expected: [String: Any] = ["type": "GeometryCollection", "geometries": [ ["type": "LineString", "coordinates": [ [1.0, 1.0, 0.0], [2.0, 2.0, 0.0] ] ], ["type": "MultiPoint", "coordinates": [ [100.0, 0.0, 0.0], [101.0, 1.0, 0.0] ] ]] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }
}

// MARK: - Coordinate3DM -

class GeoJSONWriterCoordinate3DMTests: XCTestCase {

    let writer = GeoJSONWriter(axes: [.z, .m])

    // MARK: - General

    func testWriteUnsupportedGeometry() {

        let input = UnsupportedGeometry()
        let expected = "Unsupported type \"UnsupportedGeometry(precision: Floating(), coordinateSystem: Cartesian(), dimension: GeoFeatures.Dimension.one)\"."

        XCTAssertThrowsError(try writer.write(input)) { error in

            if case GeoJSONWriter.Errors.unsupportedType(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testWriteInvalidNumberOfCoordinates() throws {

        let input = Point(Coordinate(x: 1.0, y: 1.0, z: 1.0))
        let expected = "Coordinate (x: 1.0, y: 1.0, z: 1.0) is missing the M axis."

        XCTAssertThrowsError(try writer.write(input)) { error in

            if case GeoJSONWriter.Errors.invalidNumberOfCoordinates(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testWritePoint() throws {

        let input = Point(Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 0.0))
        let expected: [String: Any] = ["type": "Point", "coordinates": [1.0, 1.0, 1.0, 0.0] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteLineString() throws {

        let input = LineString([Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 0.0), Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 0.0)])
        let expected: [String: Any] =  ["type": "LineString", "coordinates": [ [1.0, 1.0, 1.0, 0.0], [2.0, 2.0, 2.0, 0.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteLinearRing() throws {

        let input = LinearRing([Coordinate(x: 1.0, y: 1.0, z: 1.0, m: 0.0), Coordinate(x: 2.0, y: 2.0, z: 2.0, m: 0.0)])
        let expected: [String: Any] =  ["type": "LineString", "coordinates": [ [1.0, 1.0, 1.0, 0.0], [2.0, 2.0, 2.0, 0.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWritePolygon() throws {
        let input = Polygon([Coordinate(x: 100.0, y: 0.0, z: 0.0, m: 0.0), Coordinate(x: 101.0, y: 0.0, z: 0.0, m: 0.0), Coordinate(x: 101.0, y: 1.0, z: 0.0, m: 0.0), Coordinate(x: 100.0, y: 1.0, z: 0.0, m: 0.0), Coordinate(x: 100.0, y: 0.0, z: 0.0, m: 0.0)], innerRings: [[Coordinate(x: 100.2, y: 0.2, z: 0.0, m: 0.0), Coordinate(x: 100.8, y: 0.2, z: 0.0, m: 0.0), Coordinate(x: 100.8, y: 0.8, z: 0.0, m: 0.0), Coordinate(x: 100.2, y: 0.8, z: 0.0, m: 0.0), Coordinate(x: 100.2, y: 0.2, z: 0.0, m: 0.0)]])

        let expected: [String: Any] = [ "type": "Polygon",
                                        "coordinates": [
                                            [ [100.0, 0.0, 0.0, 0.0], [101.0, 0.0, 0.0, 0.0], [101.0, 1.0, 0.0, 0.0], [100.0, 1.0, 0.0, 0.0], [100.0, 0.0, 0.0, 0.0] ],
                                            [ [100.2, 0.2, 0.0, 0.0], [100.8, 0.2, 0.0, 0.0], [100.8, 0.8, 0.0, 0.0], [100.2, 0.8, 0.0, 0.0], [100.2, 0.2, 0.0, 0.0] ]
                                        ]
        ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiPoint() throws {

        let input = MultiPoint([Point(Coordinate(x: 100.0, y: 0.0, z: 0.0, m: 0.0)), Point(Coordinate(x: 101.0, y: 1.0, z: 0.0, m: 0.0))])
        let expected: [String: Any] = ["type": "MultiPoint", "coordinates": [ [100.0, 0.0, 0.0, 0.0], [101.0, 1.0, 0.0, 0.0] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiLineString() throws {

        let input = MultiLineString([LineString([Coordinate(x: 100.0, y: 100.0, z: 0.0, m: 0.0), Coordinate(x: 100.0, y: 200.0, z: 0.0, m: 0.0), Coordinate(x: 200.0, y: 200.0, z: 0.0, m: 0.0)]), LineString([Coordinate(x: 200.0, y: 200.0, z: 0.0, m: 0.0), Coordinate(x: 200.0, y: 300.0, z: 0.0, m: 0.0), Coordinate(x: 300.0, y: 300.0, z: 0.0, m: 0.0)])])
        let expected: [String: Any] = ["type": "MultiLineString", "coordinates": [ [[100.0, 100.0, 0.0, 0.0], [100.0, 200.0, 0.0, 0.0], [200.0, 200.0, 0.0, 0.0]], [[200.0, 200.0, 0.0, 0.0], [200.0, 300.0, 0.0, 0.0], [300.0, 300.0, 0.0, 0.0]] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteMultiPolygon() throws {

        let input = MultiPolygon([Polygon([[Coordinate(x: 0.0, y: 0.0, z: 0.0, m: 0.0), Coordinate(x: 60, y: 144, z: 0.0, m: 0.0), Coordinate(x: 120, y: 0.0, z: 0.0, m: 0.0), Coordinate(x: 0.0, y: 0.0, z: 0.0, m: 0.0)], [Coordinate(x: 40, y: 25, z: 0.0, m: 0.0), Coordinate(x: 80, y: 25, z: 0.0, m: 0.0), Coordinate(x: 60, y: 80, z: 0.0, m: 0.0), Coordinate(x: 40, y: 25, z: 0.0, m: 0.0)]]), Polygon([Coordinate(x: 0.0, y: 0.0, z: 0.0, m: 0.0), Coordinate(x: 100, y: 107, z: 0.0, m: 0.0), Coordinate(x: 140, y: 102, z: 0.0, m: 0.0), Coordinate(x: 102, y: 0.0, z: 0.0, m: 0.0), Coordinate(x: 102, y: 50, z: 0.0, m: 0.0), Coordinate(x: 0.0, y: 0.0, z: 0.0, m: 0.0)])])
        let expected: [String: Any] = ["type": "MultiPolygon", "coordinates": [ [[[0.0, 0.0, 0.0, 0.0], [60.0, 144.0, 0.0, 0.0], [120.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]], [[40.0, 25.0, 0.0, 0.0], [80.0, 25.0, 0.0, 0.0], [60.0, 80.0, 0.0, 0.0], [40.0, 25.0, 0.0, 0.0]]], [[[0.0, 0.0, 0.0, 0.0], [100.0, 107.0, 0.0, 0.0], [140.0, 102.0, 0.0, 0.0], [102.0, 0.0, 0.0, 0.0], [102.0, 50.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0]]] ] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }

    func testWriteGeometryCollection() throws {

        let input = GeometryCollection([LineString([Coordinate(x: 1.0, y: 1.0, z: 0.0, m: 0.0), Coordinate(x: 2.0, y: 2.0, z: 0.0, m: 0.0)]), MultiPoint([Point(Coordinate(x: 100.0, y: 0.0, z: 0.0, m: 0.0)), Point(Coordinate(x: 101.0, y: 1.0, z: 0.0, m: 0.0))])])
        let expected: [String: Any] = ["type": "GeometryCollection", "geometries": [ ["type": "LineString", "coordinates": [ [1.0, 1.0, 0.0, 0.0], [2.0, 2.0, 0.0, 0.0] ] ], ["type": "MultiPoint", "coordinates": [ [100.0, 0.0, 0.0, 0.0], [101.0, 1.0, 0.0, 0.0] ] ]] ]

        let result = try writer.write(input)

        XCTAssertTrue(result.egaul(jsonObject: expected), "\"\(result)\" does not equal \"\(expected)\"")
    }
}


private  extension Array where Element == Any {

    func egaul(jsonObject other: [Element]) -> Bool {
        for i in self.indices {
            /// Does other contain the same indice?
            guard other.indices.contains(i)
                else { return false }

            guard jsonObjectEqual(self[i], other[i])
                else { return false }
        }
        return true
    }
}

private extension Dictionary where Key == String, Value == Any {

    func egaul(jsonObject other: [Key: Value]) -> Bool {

        /// The dictionaries should be the same size.
        guard self.count == other.count
            else { return false }

        for i in self.indices {

            /// Does the key at the current index exist in the other dictionary?
            let theKey = self[i].key
            guard let theOtherValue = other[theKey]
                else { return false }

            /// Is the value at the current index the same type and value?
            guard jsonObjectEqual(self[i].value, theOtherValue)
                else { return false }
        }
        return true
    }
}

private func jsonObjectEqual(_ lhAny: Any, _ rhAny: Any) -> Bool {

    switch (lhAny, rhAny) {

    case let (lhs, rhs) as (Bool, Bool):
        guard lhs == rhs
            else { return false }

    case let (lhs, rhs) as (Int, Int):
        guard lhs == rhs
            else { return false }

    case let (lhs, rhs) as (Float, Float):
        guard lhs == rhs
            else { return false }

    case let (lhs, rhs) as (Double, Double):
        guard lhs == rhs
            else { return false }

    case let (lhs, rhs) as (String, String):
        guard lhs == rhs
            else { return false }

    case let (lhs, rhs) as (Array<AnyHashable>, Array<AnyHashable>):
        guard lhs == rhs
            else { return false }

    case let (lhs, rhs) as (Dictionary<AnyHashable, AnyHashable>, Dictionary<AnyHashable, AnyHashable>):
        guard lhs == rhs
            else { return false }

    case let (lhs, rhs) as (Array<Any>, Array<Any>):
        guard lhs.egaul(jsonObject: rhs)
            else { return false }

    case let (lhs, rhs) as (Dictionary<String, Any>, Dictionary<String, Any>):
        guard lhs.egaul(jsonObject: rhs)
            else { return false }

    default:
        return false
    }
    return true
}
