/*
*   LinearRingCoordinate2DMFixedPrecisionTests.swift
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

    ~/gyb --line-directive '' -DCoordinateType=Coordinate2DM -D"TestTuple0=(x: 1.001, y: 1.001, m: 1.001)" -D"TestTuple1=(x: 2.002, y: 2.002, m: 2.002)" -D"ExpectedTuple0=(x: 1.0, y: 1.0, m: 1.0)" -D"ExpectedTuple1=(x: 2.0, y: 2.0, m: 2.0)" -D"Precision=FixedPrecision(scale: 100)" -DGeometryType=LinearRing -o LinearRingCoordinate2DMFixedPrecisionTests.swift CoordinateCollectionTests.swift.gyb

    Do NOT edit this file directly as it will be regenerated automatically when needed.
*/

class LinearRingCoordinate2DMFixedPrecisionTests : XCTestCase {

    // MARK: Init
    
    func testInit_NoArg ()   {
        XCTAssertEqual(LinearRing<Coordinate2DM>(precision: FixedPrecision(scale: 100)).isEmpty, true)
    }
    
    func testInit_Tuple () {
    
        XCTAssertEqual(
            (LinearRing<Coordinate2DM>(elements: [(x: 1.001, y: 1.001, m: 1.001),(x: 2.002, y: 2.002, m: 2.002)], precision: FixedPrecision(scale: 100)).elementsEqual([Coordinate2DM(tuple: (x: 1.0, y: 1.0, m: 1.0)), Coordinate2DM(tuple: (x: 2.0, y: 2.0, m: 2.0))])
                { (lhs: Coordinate2DM, rhs: Coordinate2DM) -> Bool in
                    return lhs == rhs
            }
        ), true)
    }
    
    // MARK: CollectionType
    
    func testSubscript_Get () {
        let geometry = LinearRing<Coordinate2DM>(elements: [(x: 1.001, y: 1.001, m: 1.001),(x: 2.002, y: 2.002, m: 2.002)], precision: FixedPrecision(scale: 100))
        
        XCTAssertEqual(geometry[1] == Coordinate2DM(tuple: (x: 2.0, y: 2.0, m: 2.0)), true)
    }
    
    func testSubscript_Set () {
        var geometry = LinearRing<Coordinate2DM>(elements: [(x: 1.001, y: 1.001, m: 1.001),(x: 2.002, y: 2.002, m: 2.002)], precision: FixedPrecision(scale: 100))
        
        geometry[1] = Coordinate2DM(tuple: (x: 1.001, y: 1.001, m: 1.001))
        
        XCTAssertEqual(geometry[1] ==  Coordinate2DM(tuple: (x: 1.0, y: 1.0, m: 1.0)), true)
    }
    
    func testAppendContentsOf_LinearRing () {
        
        let geometry1 = LinearRing<Coordinate2DM>(elements: [(x: 1.001, y: 1.001, m: 1.001),(x: 2.002, y: 2.002, m: 2.002)], precision: FixedPrecision(scale: 100))
        var geometry2 = LinearRing<Coordinate2DM>(precision: FixedPrecision(scale: 100))
        
        geometry2.append(contentsOf: geometry1)
        
        XCTAssertEqual(geometry1 == geometry2, true)
    }
    
    func testAppendContentsOf_Array () {
        
        var geometry = LinearRing<Coordinate2DM>(precision: FixedPrecision(scale: 100))
        
        geometry.append(contentsOf: [Coordinate2DM(tuple: (x: 1.001, y: 1.001, m: 1.001)), Coordinate2DM(tuple: (x: 2.002, y: 2.002, m: 2.002))])
        
        XCTAssertEqual(geometry.elementsEqual([Coordinate2DM(tuple: (x: 1.0, y: 1.0, m: 1.0)), Coordinate2DM(tuple: (x: 2.0, y: 2.0, m: 2.0))]) { (lhs: Coordinate2DM, rhs: Coordinate2DM) -> Bool in
            return lhs == rhs
        }, true)
    }
    
    // MARK: Equal
    
    func testEquals () {
        XCTAssertEqual(LinearRing<Coordinate2DM>(elements: [Coordinate2DM(tuple: (x: 1.001, y: 1.001, m: 1.001)), Coordinate2DM(tuple: (x: 2.002, y: 2.002, m: 2.002))], precision: FixedPrecision(scale: 100)).equals(LinearRing<Coordinate2DM>(elements: [Coordinate2DM(tuple: (x: 1.0, y: 1.0, m: 1.0)), Coordinate2DM(tuple: (x: 2.0, y: 2.0, m: 2.0))], precision: FixedPrecision(scale: 100))), true)
    }
    
    // MARK: isEmpty
    
    func testIsEmpty () {
        XCTAssertEqual(LinearRing<Coordinate2DM>(precision: FixedPrecision(scale: 100)).isEmpty(), true)
    }
    
    func testIsEmpty_False() {
        XCTAssertEqual(LinearRing<Coordinate2DM>(elements: [Coordinate2DM(tuple: (x: 1.001, y: 1.001, m: 1.001)), Coordinate2DM(tuple: (x: 2.002, y: 2.002, m: 2.002))], precision: FixedPrecision(scale: 100)).isEmpty(), false)
    }
    
    func testCount () {
        XCTAssertEqual(LinearRing<Coordinate2DM>(elements: [Coordinate2DM(tuple: (x: 1.001, y: 1.001, m: 1.001)), Coordinate2DM(tuple: (x: 2.002, y: 2.002, m: 2.002))], precision: FixedPrecision(scale: 100)).count, 2)
    }
    
    func testAppend () {
        var geometry = LinearRing<Coordinate2DM>(precision: FixedPrecision(scale: 100))
        
        geometry.append((x: 1.001, y: 1.001, m: 1.001))
        
        XCTAssertEqual(geometry.elementsEqual([Coordinate2DM(tuple: (x: 1.0, y: 1.0, m: 1.0))])
            { (lhs: Coordinate2DM, rhs: Coordinate2DM) -> Bool in
                return lhs == rhs
        }, true)
    }

    func testInsert () {
        var geometry = LinearRing<Coordinate2DM>(elements: [Coordinate2DM(tuple: (x: 1.001, y: 1.001, m: 1.001)), Coordinate2DM(tuple: (x: 2.002, y: 2.002, m: 2.002))], precision: FixedPrecision(scale: 100))
        
        geometry.insert(Coordinate2DM(tuple: (x: 2.002, y: 2.002, m: 2.002)), atIndex: 0)

        XCTAssertEqual(geometry.elementsEqual([Coordinate2DM(tuple: (x: 2.002, y: 2.002, m: 2.002)), Coordinate2DM(tuple: (x: 1.001, y: 1.001, m: 1.001)), Coordinate2DM(tuple: (x: 2.002, y: 2.002, m: 2.002))])
            { (lhs: Coordinate2DM, rhs: Coordinate2DM) -> Bool in
                return lhs == rhs
            }, true)
        
    }

    func testRemoveAll () {
        var geometry = LinearRing<Coordinate2DM>(elements: [Coordinate2DM(tuple: (x: 1.001, y: 1.001, m: 1.001)), Coordinate2DM(tuple: (x: 2.002, y: 2.002, m: 2.002))], precision: FixedPrecision(scale: 100))

        geometry.removeAll()

        XCTAssertEqual(geometry.isEmpty(), true)
    }

}
