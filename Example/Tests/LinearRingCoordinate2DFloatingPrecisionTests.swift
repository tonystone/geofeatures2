/*
*   LinearRingCoordinate2DFloatingPrecisionTests.swift
 *
 *   Copyright 2016 Tony Stone
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 *   Created by Tony Stone on 2/10/16.
 */
import XCTest
@testable import GeoFeatures2

/*
    NOTE: This file was auto generated by gyb from file CoordinateCollectionTests.swift.gyb using the following command.

    ~/gyb --line-directive '' -DCoordinateType=Coordinate2D -D"TestTuple0=(x: 1.0, y: 1.0)" -D"TestTuple1=(x: 2.0, y: 2.0)" -D"ExpectedTuple0=(x: 1.0, y: 1.0)" -D"ExpectedTuple1=(x: 2.0, y: 2.0)" -D"Precision=FloatingPrecision()" -DGeometryType=LinearRing -o LinearRingCoordinate2DFloatingPrecisionTests.swift CoordinateCollectionTests.swift.gyb

    Do NOT edit this file directly as it will be regenerated automatically when needed.
*/

class LinearRingCoordinate2DFloatingPrecisionTests : XCTestCase {

    // MARK: Init
    
    func testInit_NoArg ()   {
        XCTAssertEqual(LinearRing<Coordinate2D>(precision: FloatingPrecision()).isEmpty, true)
    }
    
    func testInit_Tuple () {
    
        XCTAssertEqual(
            (LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0),(x: 2.0, y: 2.0)], precision: FloatingPrecision()).elementsEqual([Coordinate2D(tuple: (x: 1.0, y: 1.0)), Coordinate2D(tuple: (x: 2.0, y: 2.0))])
                { (lhs: Coordinate2D, rhs: Coordinate2D) -> Bool in
                    return lhs == rhs
            }
        ), true)
    }
    
    // MARK: CollectionType
    
    func testSubscript_Get () {
        let geometry = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0),(x: 2.0, y: 2.0)], precision: FloatingPrecision())
        
        XCTAssertEqual(geometry[1] == Coordinate2D(tuple: (x: 2.0, y: 2.0)), true)
    }
    
    func testSubscript_Set () {
        var geometry = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0),(x: 2.0, y: 2.0)], precision: FloatingPrecision())
        
        geometry[1] = Coordinate2D(tuple: (x: 1.0, y: 1.0))
        
        XCTAssertEqual(geometry[1] ==  Coordinate2D(tuple: (x: 1.0, y: 1.0)), true)
    }
    
    func testAppendContentsOf_LinearRing () {
        
        let geometry1 = LinearRing<Coordinate2D>(elements: [(x: 1.0, y: 1.0),(x: 2.0, y: 2.0)], precision: FloatingPrecision())
        var geometry2 = LinearRing<Coordinate2D>(precision: FloatingPrecision())
        
        geometry2.appendContentsOf(geometry1)
        
        XCTAssertEqual(geometry1 == geometry2, true)
    }
    
    func testAppendContentsOf_Array () {
        
        var geometry = LinearRing<Coordinate2D>(precision: FloatingPrecision())
        
        geometry.appendContentsOf([Coordinate2D(tuple: (x: 1.0, y: 1.0)), Coordinate2D(tuple: (x: 2.0, y: 2.0))])
        
        XCTAssertEqual(geometry.elementsEqual([Coordinate2D(tuple: (x: 1.0, y: 1.0)), Coordinate2D(tuple: (x: 2.0, y: 2.0))]) { (lhs: Coordinate2D, rhs: Coordinate2D) -> Bool in
            return lhs == rhs
        }, true)
    }
    
    // MARK: Equal
    
    func testEquals () {
        XCTAssertEqual(LinearRing<Coordinate2D>(elements: [Coordinate2D(tuple: (x: 1.0, y: 1.0)), Coordinate2D(tuple: (x: 2.0, y: 2.0))], precision: FloatingPrecision()).equals(LinearRing<Coordinate2D>(elements: [Coordinate2D(tuple: (x: 1.0, y: 1.0)), Coordinate2D(tuple: (x: 2.0, y: 2.0))], precision: FloatingPrecision())), true)
    }
    
    // MARK: isEmpty
    
    func testIsEmpty () {
        XCTAssertEqual(LinearRing<Coordinate2D>(precision: FloatingPrecision()).isEmpty(), true)
    }
    
    func testIsEmpty_False() {
        XCTAssertEqual(LinearRing<Coordinate2D>(elements: [Coordinate2D(tuple: (x: 1.0, y: 1.0)), Coordinate2D(tuple: (x: 2.0, y: 2.0))], precision: FloatingPrecision()).isEmpty(), false)
    }
    
    func testCount () {
        XCTAssertEqual(LinearRing<Coordinate2D>(elements: [Coordinate2D(tuple: (x: 1.0, y: 1.0)), Coordinate2D(tuple: (x: 2.0, y: 2.0))], precision: FloatingPrecision()).count, 2)
    }
    
    func testAppend () {
        var geometry = LinearRing<Coordinate2D>(precision: FloatingPrecision())
        
        geometry.append((x: 1.0, y: 1.0))
        
        XCTAssertEqual(geometry.elementsEqual([Coordinate2D(tuple: (x: 1.0, y: 1.0))])
            { (lhs: Coordinate2D, rhs: Coordinate2D) -> Bool in
                return lhs == rhs
        }, true)
    }

    func testInsert () {
        var geometry = LinearRing<Coordinate2D>(elements: [Coordinate2D(tuple: (x: 1.0, y: 1.0)), Coordinate2D(tuple: (x: 2.0, y: 2.0))], precision: FloatingPrecision())
        
        geometry.insert(Coordinate2D(tuple: (x: 2.0, y: 2.0)), atIndex: 0)

        XCTAssertEqual(geometry.elementsEqual([Coordinate2D(tuple: (x: 2.0, y: 2.0)), Coordinate2D(tuple: (x: 1.0, y: 1.0)), Coordinate2D(tuple: (x: 2.0, y: 2.0))])
            { (lhs: Coordinate2D, rhs: Coordinate2D) -> Bool in
                return lhs == rhs
            }, true)
        
    }

    func testRemoveAll () {
        var geometry = LinearRing<Coordinate2D>(elements: [Coordinate2D(tuple: (x: 1.0, y: 1.0)), Coordinate2D(tuple: (x: 2.0, y: 2.0))], precision: FloatingPrecision())

        geometry.removeAll()

        XCTAssertEqual(geometry.isEmpty(), true)
    }

}
