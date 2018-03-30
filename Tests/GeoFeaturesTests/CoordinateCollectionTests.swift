///
/// CoordinateCollectionTests.swift
///
/// Copyright (c) 2018 Tony Stone, All rights reserved.
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
/// Created by Tony Stone on 3/30/18.
///
import XCTest
@testable import GeoFeatures

class CoordinateCollectionTests: XCTestCase {

    func testInit() {
        let expected = 0

        XCTAssertEqual(CoordinateCollection().count, expected)
    }

    func testInitWithCoordinate() {
        let input = Coordinate(x: 1.0, y: 2.0)
        let expected = 1

        XCTAssertEqual(CoordinateCollection(coordinate: input).count, expected)
    }

    func testInitWithEmptyArrayOfCoordinates() {
        let input: [Coordinate] = []
        let expected = 0

        XCTAssertEqual(CoordinateCollection(coordinates: input).count, expected)
    }

    func testInitWithArrayOfCoordinates() {
        let input = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]
        let expected = 2

        XCTAssertEqual(CoordinateCollection(coordinates: input).count,expected)
    }

    func testInitWithCollectionOfCoordinates() {
        let input = CoordinateCollection(coordinates: [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)])
        let expected = 2

        XCTAssertEqual(CoordinateCollection(coordinates: input).count, expected)
    }

    func testInitWithArrayLiteral() {
        let expected = 2

        XCTAssertEqual(CoordinateCollection(arrayLiteral: Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)).count, expected)
    }

    func testCapacity() {
        var collection = CoordinateCollection()

        let input    = collection.capacity * 2
        let expected = collection.capacity * 2


        collection.reserveCapacity(input)

        XCTAssertEqual(collection.capacity, expected)
    }

    func testStartIndex() {
        let expected = 0

        XCTAssertEqual(CoordinateCollection().startIndex, expected)
    }

    func testEndIndex() {
        let input = CoordinateCollection(coordinates: [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)])
        let expected = 2

        XCTAssertEqual(CoordinateCollection(coordinates: input).endIndex, expected)
    }

    func testIndexAfter() {
        let input    = 0
        let expected = 1

        XCTAssertEqual(CoordinateCollection().index(after: input), expected)
    }

    func testSubscrptGet() {
        let input    = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]
        let expected = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]

        let collection = CoordinateCollection(coordinates: input)

        XCTAssertEqual(collection[0], expected[0])
        XCTAssertEqual(collection[1], expected[1])
    }

    func testSubscrptSet() {
        let input    = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]
        let expected = [Coordinate(x: 3.0, y: 4.0), Coordinate(x: 1.0, y: 2.0)]

        var collection = CoordinateCollection(coordinates: input)

        /// Swap them
        let first = collection[0]

        collection[0] = collection[1]
        collection[1] = first

        XCTAssertEqual(collection[0], expected[0])
        XCTAssertEqual(collection[1], expected[1])
    }

    func testAppend() {
        let input    = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]
        let expected = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]

        var collection = CoordinateCollection()

        collection.append(input[0])
        collection.append(input[1])

        XCTAssertEqual(collection[0], expected[0])
        XCTAssertEqual(collection[1], expected[1])
    }

    func testAppendContentsOf() {
        let input    = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]
        let expected = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]

        var collection = CoordinateCollection()

        collection.append(contentsOf: input)

        XCTAssertEqual(collection[0], expected[0])
        XCTAssertEqual(collection[1], expected[1])
    }

    func testInsert() {
        let input    = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]
        let expected = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]

        var collection = CoordinateCollection(coordinate: input[1])

        collection.insert(input[0], at: 0)

        XCTAssertEqual(collection[0], expected[0])
        XCTAssertEqual(collection[1], expected[1])
    }

    func testApplyPrecision() {
        let input    = [Coordinate(x: 1.001, y: 2.001), Coordinate(x: 3.003, y: 4.004)]
        let expected = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]

        var collection = CoordinateCollection(coordinates: input)

        collection.apply(precision: FixedPrecision(scale: 100))

        XCTAssertEqual(collection[0], expected[0])
        XCTAssertEqual(collection[1], expected[1])
    }

    func testAxesWithCoordinate2D() {
        let input    = [Coordinate(x: 1.0, y: 2.0), Coordinate(x: 3.0, y: 4.0)]
        let expected: [CoordinateCollection.Axis] = [.x, .y]

        XCTAssertEqual(CoordinateCollection(coordinates: input).axes(), expected)
    }

    func testAxesWithCoordinate2DM() {
        let input    = [Coordinate(x: 1.0, y: 2.0, m: 3.0), Coordinate(x: 3.0, y: 4.0, m: 5.0)]
        let expected: [CoordinateCollection.Axis] = [.x, .y, .m]

        XCTAssertEqual(CoordinateCollection(coordinates: input).axes(), expected)
    }

    func testAxesWithCoordinate3D() {
        let input    = [Coordinate(x: 1.0, y: 2.0, z: 3.0), Coordinate(x: 3.0, y: 4.0, z: 5.0)]
        let expected: [CoordinateCollection.Axis] = [.x, .y, .z]

        XCTAssertEqual(CoordinateCollection(coordinates: input).axes(), expected)
    }

    func testAxesWithCoordinate3DM() {
        let input    = [Coordinate(x: 1.0, y: 2.0, z: 3.0, m: 4.0), Coordinate(x: 3.0, y: 4.0, z: 5.0, m: 4.0)]
        let expected: [CoordinateCollection.Axis] = [.x, .y, .z, .m]

        XCTAssertEqual(CoordinateCollection(coordinates: input).axes(), expected)
    }

}
