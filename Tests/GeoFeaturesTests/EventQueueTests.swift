///
///  EventQueueTests.swift
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
///  Created by Tony Stone on 12/18/2016.
///
import XCTest
@testable import GeoFeatures

class EventQueueTests: XCTestCase {

    typealias CoordinateType = Coordinate2D

    func testInit() {
        let input    = EventQueue(coordinates: [CoordinateType(x: 1.0, y: 1.0), CoordinateType(x: 2.0, y: 1.0), CoordinateType(x: 3.0, y: 1.0)])
        var expected = [LeftEvent(coordinate: CoordinateType(x: 1.0, y: 1.0), rightEvent: RightEvent(coordinate: CoordinateType(x: 2.0, y: 1.0))), RightEvent(coordinate: CoordinateType(x: 2.0, y: 1.0)),
                        LeftEvent(coordinate: CoordinateType(x: 2.0, y: 1.0), rightEvent: RightEvent(coordinate: CoordinateType(x: 3.0, y: 1.0))), RightEvent(coordinate: CoordinateType(x: 3.0, y: 1.0))].makeIterator()

        while let input = input.next(), let expected = expected.next() {

            XCTAssertEqual(input.self, expected.self)               /// Must be same type LeftEvent, RightEvent, or IntersectionEvent
            XCTAssertEqual(input.coordinate, expected.coordinate)   /// and have the same values in the coordinate
        }

        ///
        /// If the outputs of either the input or expected are not equal, next will return an extra value if called after the loop above
        ///
        XCTAssertTrue(input.next()    == nil, "There were more elements than expected.")
        XCTAssertTrue(expected.next() == nil, "Expected elements not found in input.")
    }

    func testInsertToEmptyQueue() {
        let input    = [LeftEvent(coordinate: CoordinateType(x: 1.0, y: 1.0), rightEvent: RightEvent(coordinate: CoordinateType(x: 2.0, y: 1.0))), RightEvent(coordinate: CoordinateType(x: 2.0, y: 1.0)),
                        LeftEvent(coordinate: CoordinateType(x: 2.0, y: 1.0), rightEvent: RightEvent(coordinate: CoordinateType(x: 3.0, y: 1.0))), RightEvent(coordinate: CoordinateType(x: 3.0, y: 1.0))]
        var expected = input.makeIterator()

        /// Perform inserts
        let eventQueue = EventQueue<CoordinateType>(coordinates: [])
        for event in input {
            eventQueue.insert(event: event)
        }

        /// Now make sure everything has been inserted correctly
        while let input = eventQueue.next(), let expected = expected.next() {

            XCTAssertEqual(input.self, expected.self)               /// Must be same type LeftEvent, RightEvent, or IntersectionEvent
            XCTAssertEqual(input.coordinate, expected.coordinate)   /// and have the same values in the coordinate
        }

        ///
        /// If the outputs of either the input or expected are not equal, next will return an extra value if called after the loop above
        ///
        XCTAssertTrue(eventQueue.next() == nil, "There were more elements than expected.")
        XCTAssertTrue(expected.next()   == nil, "Expected elements not found in input.")
    }

    func testInsertToEmptyQueueReverseInsert() {
        let input    = [ RightEvent(coordinate: CoordinateType(x: 3.0, y: 1.0)), LeftEvent(coordinate: CoordinateType(x: 2.0, y: 1.0), rightEvent: RightEvent(coordinate: CoordinateType(x: 3.0, y: 1.0))),
                         RightEvent(coordinate: CoordinateType(x: 2.0, y: 1.0)), LeftEvent(coordinate: CoordinateType(x: 1.0, y: 1.0), rightEvent: RightEvent(coordinate: CoordinateType(x: 2.0, y: 1.0)))]
        var expected = [LeftEvent(coordinate: CoordinateType(x: 1.0, y: 1.0), rightEvent: RightEvent(coordinate: CoordinateType(x: 2.0, y: 1.0))), RightEvent(coordinate: CoordinateType(x: 2.0, y: 1.0)),
                        LeftEvent(coordinate: CoordinateType(x: 2.0, y: 1.0), rightEvent: RightEvent(coordinate: CoordinateType(x: 3.0, y: 1.0))), RightEvent(coordinate: CoordinateType(x: 3.0, y: 1.0))].makeIterator()

        /// Perform inserts
        let eventQueue = EventQueue<CoordinateType>(coordinates: [])
        for event in input {
            eventQueue.insert(event: event)
        }

        /// Now make sure everything has been inserted correctly
        while let input = eventQueue.next(), let expected = expected.next() {

            XCTAssertEqual(input.self, expected.self)               /// Must be same type LeftEvent, RightEvent, or IntersectionEvent
            XCTAssertEqual(input.coordinate, expected.coordinate)   /// and have the same values in the coordinate
        }

        ///
        /// If the outputs of either the input or expected are not equal, next will return an extra value if called after the loop above
        ///
        XCTAssertTrue(eventQueue.next() == nil, "There were more elements than expected.")
        XCTAssertTrue(expected.next()   == nil, "Expected elements not found in input.")
    }
}
