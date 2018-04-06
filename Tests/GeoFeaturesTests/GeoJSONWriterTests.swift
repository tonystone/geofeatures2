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
        let expected = "Unsupported type \"UnsupportedGeometry(precision: FloatingPrecision(), coordinateSystem: Cartesian(), dimension: GeoFeatures.Dimension.one)\"."

        XCTAssertThrowsError(try writer.write(input)) { error in

            if case GeoJSONWriterError.unsupportedType(let message) = error {
                XCTAssertEqual(message, expected)
            } else {
                XCTFail("Wrong error thrown: \(error) is not equal to \(expected)")
            }
        }
    }

    func testWritePoint() {

        let input = Point(Coordinate(x: 1.0, y: 1.0))
        let expected: [String: Any] = ["type": "Point", "coordinates": [1.0, 1.0] ]

        XCTAssertTrue(try writer.write(input).elementsEqual(expected, by: { (lhs, rhs) -> Bool in
            guard lhs.key == rhs.key else { return false }

            if let lhsValue = lhs.value as? String,
               let rhsValue = rhs.value as? String {

                return lhsValue == rhsValue

            } else if let lhsCoordinate = lhs.value as? [Double],
                      let rhsCoordinate = rhs.value as? [Double] {

                if lhsCoordinate[0] != rhsCoordinate[0] || lhsCoordinate[1] != rhsCoordinate[1] {
                    return false
                }
                return true
            }
            return false
        }))
    }

    func testWriteLineString() {

        let input = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)])
        let expected: [String: Any] =  ["type": "LineString", "coordinates": [ [1.0, 1.0], [2.0, 2.0] ] ]

        XCTAssertTrue(try writer.write(input).elementsEqual(expected, by: { (lhs, rhs) -> Bool in
            guard lhs.key == rhs.key else { return false }

            if let lhsValue = lhs.value as? String,
                let rhsValue = rhs.value as? String {

                return lhsValue == rhsValue

            } else if let lhsArray = lhs.value as? [[Double]],
                      let rhsArray = rhs.value as? [[Double]] {

                for coordinateIndex in 0..<lhsArray.count {
                    let lhsCoordinate = lhsArray[coordinateIndex]
                    let rhsCoordinate = rhsArray[coordinateIndex]

                    if lhsCoordinate[0] != rhsCoordinate[0] || lhsCoordinate[1] != rhsCoordinate[1] {
                        return false
                    }
                }
                return true
            }
            return false
        }))
    }

    func testWritePolygon() throws {
        let input = Polygon([Coordinate(x: 100.0, y: 0.0), Coordinate(x: 101.0, y: 0.0), Coordinate(x: 101.0, y: 1.0), Coordinate(x: 100.0, y: 1.0), Coordinate(x: 100.0, y: 0.0)], innerRings: [[Coordinate(x: 100.2, y: 0.2), Coordinate(x: 100.8, y: 0.2), Coordinate(x: 100.8, y: 0.8), Coordinate(x: 100.2, y: 0.8), Coordinate(x: 100.2, y: 0.2)]])

        let expected: [String: Any] = [ "type": "Polygon",
                                        "coordinates": [
                                            [ [100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0] ],
                                            [ [100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8], [100.2, 0.2] ]
                                            ]
                                    ]
        let value = try writer.write(input)
        XCTAssertTrue(value.elementsEqual(expected, by: { (lhs, rhs) -> Bool in
            guard lhs.key == rhs.key else { return false }

            if let lhsValue = lhs.value as? String,
               let rhsValue = rhs.value as? String {

                return lhsValue == rhsValue

            } else if let lhsArray = lhs.value as? [[[Double]]],
                      let rhsArray = rhs.value as? [[[Double]]] {

                for ringIndex in 0..<lhsArray.count {
                    let lhsRing = lhsArray[ringIndex]
                    let rhsRing = rhsArray[ringIndex]

                    for coordinateIndex in 0..<lhsRing.count {
                        let lhsCoordinate = lhsRing[coordinateIndex]
                        let rhsCoordinate = rhsRing[coordinateIndex]

                        if lhsCoordinate[0] != rhsCoordinate[0] || lhsCoordinate[1] != rhsCoordinate[1] {
                            return false
                        }
                    }
                }
                return true
            }
            return false
        }))
    }

    func testWriteMultiPoint() {

        let input = MultiPoint([Point(Coordinate(x: 100.0, y: 0.0)), Point(Coordinate(x: 101.0, y: 1.0))])
        let expected: [String: Any] = ["type": "MultiPoint", "coordinates": [ [100.0, 0.0], [101.0, 1.0] ] ]

        XCTAssertTrue(try writer.write(input).elementsEqual(expected, by: { (lhs, rhs) -> Bool in
            guard lhs.key == rhs.key else { return false }

            if let lhsValue = lhs.value as? String,
                let rhsValue = rhs.value as? String {

                return lhsValue == rhsValue

            } else if let lhsArray = lhs.value as? [[Double]],
                let rhsArray = rhs.value as? [[Double]] {

                for coordinateIndex in 0..<lhsArray.count {
                    let lhsCoordinate = lhsArray[coordinateIndex]
                    let rhsCoordinate = rhsArray[coordinateIndex]

                    if lhsCoordinate[0] != rhsCoordinate[0] || lhsCoordinate[1] != rhsCoordinate[1] {
                        return false
                    }
                }
                return true
            }
            return false
        }))
    }
}
