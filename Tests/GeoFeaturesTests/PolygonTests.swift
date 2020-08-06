///
///  PolygonTests.swift
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
///  Created by Tony Stone on 11/14/2016.
///
import XCTest
@testable import GeoFeatures

#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS)) && SWIFT_PACKAGE
    /// Note: Resolution of GeoFeatures.Polygon is ambiguous when ApplicationsServices is included in the app (ApplicationsServices is used by XCTest), this resolves the ambiguity.
    import struct GeoFeatures.Polygon
#endif

// MARK: - Coordinate2D, FloatingPrecision, Cartesian -

class PolygonCoordinate2DFloatingPrecisionCartesianTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    func testInitNoArg() {

        let input = Polygon()

        XCTAssertEqual(input.isEmpty(), true)
    }

    func testInitWithNoArgDefaults() {
        let input    = Polygon()

        /// FIXME: Currently Precision and CoordinateRefereceSystem can not be Equitable and be used for anything otherthan Generic constraints because it's a protocol, this limits testing of the defaultPrecision and defaultCoordinateSystem
        /// XCTAssertEqual(input.precision as? FloatingPrecision, GeoFeatures.defaultPrecision)
        XCTAssertEqual(input.coordinateSystem as? Cartesian, GeoFeatures.defaultCoordinateSystem)
    }

    func testInitWithPrecisionAndCRS() {
        let input = Polygon(precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.precision as? Floating, precision)
        XCTAssertEqual(input.coordinateSystem as? Cartesian, cs)
    }

    func testInitWithPrecision() {
        let input    = Polygon(precision: precision)
        let expected = precision

        XCTAssertEqual(input.precision as? Floating, expected)
    }

    func testInitWithCRS() {
        let input = Polygon(coordinateSystem: cs)
        let expected = cs

        XCTAssertEqual(input.coordinateSystem as? Cartesian, expected)
    }

    func testInitWithRings() {

        let input    = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)
        let expected = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.outerRing.count, 6)
        XCTAssertEqual(input.innerRings.count, 1)
        XCTAssertEqual(input, expected)
    }

    func testInitWithTuple() {

        let input    = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)
        let expected = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input, expected)
     }

    func testDoubleEqualsTrue() {

       let input    = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)
       let expected = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)

       XCTAssertEqual(input, expected)
    }

    func testDoubleEqualsFalse() {

       let input    = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)
       let expected = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5)]], precision: precision, coordinateSystem: cs)

       XCTAssertNotEqual(input, expected)
    }

    // MARK: MutableCollection Conformance

    func testStartIndex() {
        let input    = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)
        let expected = 0

        XCTAssertEqual(input.startIndex, expected)
    }

    func testEndIndex() {
        let input    = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)
        let expected = 2

        XCTAssertEqual(input.endIndex, expected)
    }

    func testIndexAfter() {
        let input    = 0
        let expected = 1

        XCTAssertEqual(Polygon(precision: precision, coordinateSystem: cs).index(after: input), expected)
    }

    func testSubscriptGet() {
        let input    = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)
        let expected = LinearRing([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input[0], expected)
    }

    func testSubscriptSet() {
        var input    = (geometry: Polygon([Coordinate(x: 6.0, y: 1.0)], precision: precision, coordinateSystem: cs), newElement: LinearRing([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], precision: precision, coordinateSystem: cs))
        let expected = LinearRing([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        input.geometry[0] = input.newElement

        XCTAssertEqual(input.geometry[0], expected)
    }

    // MARK: RangeReplaceableCollection Conformance

    func testReplaceSubrangeAppend() {

        var input = (geometry: Polygon(precision: precision, coordinateSystem: cs), newElements: [LinearRing([Coordinate(x: 1.0, y: 1.0)])])
        let expected = [LinearRing([Coordinate(x: 1.0, y: 1.0)])]

        input.geometry.replaceSubrange(0..<0, with: input.newElements)

        XCTAssertTrue(input.geometry.elementsEqual(expected) { (lhs: LinearRing, rhs: LinearRing) -> Bool in
                return lhs == rhs
            }, "\(input) is not equal to \(expected)")
    }

    func testReplaceSubrangeInsert() {

        var input = (geometry: Polygon([LinearRing([Coordinate(x: 1.0, y: 1.0)]), LinearRing([Coordinate(x: 2.0, y: 2.0)])], precision: precision, coordinateSystem: cs), newElements: [LinearRing([Coordinate(x: 3.0, y: 3.0)])])
        let expected = [LinearRing([Coordinate(x: 3.0, y: 3.0)]), LinearRing([Coordinate(x: 1.0, y: 1.0)]), LinearRing([Coordinate(x: 2.0, y: 2.0)])]

        input.geometry.replaceSubrange(0..<0, with: input.newElements)

        XCTAssertTrue(input.geometry.elementsEqual(expected) { (lhs: LinearRing, rhs: LinearRing) -> Bool in
                return lhs == rhs
            }, "\(input) is not equal to \(expected)")
    }

    func testReplaceSubrangeReplace() {

        var input = (geometry: Polygon([LinearRing([Coordinate(x: 1.0, y: 1.0)]), LinearRing([Coordinate(x: 2.0, y: 2.0)])], precision: precision, coordinateSystem: cs), newElements: [LinearRing([Coordinate(x: 3.0, y: 3.0)])])
        let expected = [LinearRing([Coordinate(x: 3.0, y: 3.0)]), LinearRing([Coordinate(x: 2.0, y: 2.0)])]

        input.geometry.replaceSubrange(0..<1, with: input.newElements)

        XCTAssertTrue(input.geometry.elementsEqual(expected) { (lhs: LinearRing, rhs: LinearRing) -> Bool in
                return lhs == rhs
            }, "\(input) is not equal to \(expected)")
    }

    // MARK: CustomStringConvertible & CustomDebugStringConvertible

    func testDescription() {

        let input    = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)
        let expected = "Polygon([LinearRing([(x: 6.0, y: 1.0), (x: 1.0, y: 1.0), (x: 1.0, y: 3.0), (x: 3.5, y: 4.0), (x: 6.0, y: 3.0), (x: 6.0, y: 1.0)]), LinearRing([(x: 5.0, y: 2.0), (x: 3.0, y: 1.5), (x: 3.0, y: 3.0), (x: 4.0, y: 3.5), (x: 5.0, y: 3.0), (x: 5.0, y: 2.0)])])"

        XCTAssertEqual(input.description, expected)
    }

    func testDebugDescription() {

        let input    = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)
        let expected = "Polygon([LinearRing([(x: 6.0, y: 1.0), (x: 1.0, y: 1.0), (x: 1.0, y: 3.0), (x: 3.5, y: 4.0), (x: 6.0, y: 3.0), (x: 6.0, y: 1.0)]), LinearRing([(x: 5.0, y: 2.0), (x: 3.0, y: 1.5), (x: 3.0, y: 3.0), (x: 4.0, y: 3.5), (x: 5.0, y: 3.0), (x: 5.0, y: 2.0)])])"

        XCTAssertEqual(input.debugDescription, expected)
    }

    func testDescriptionEmpty() {

        let input    = Polygon(precision: precision, coordinateSystem: cs)
        let expected = "Polygon([])"

        XCTAssertEqual(input.description, expected)
    }

    func testOperatorEqualGeometryPolygon() {
        let input: Geometry                 = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)
        let expected: Polygon = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected)
    }

    func testOperatorEqualPolygonGeometry() {
        let input: Polygon = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)
        let expected: Geometry           = Polygon([Coordinate(x: 6.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.0, y: 3.0), Coordinate(x: 6.0, y: 1.0)], innerRings: [[Coordinate(x: 5.0, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 5.0, y: 2.0)]], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected)
    }
}

// MARK: - Coordinate2D, Fixed, Cartesian -

class PolygonCoordinate2DFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100)
    let cs       = Cartesian()

    func testInitNoArg() {

        let input = Polygon()

        XCTAssertEqual(input.isEmpty(), true)
    }

    func testInitWithNoArgDefaults() {
        let input    = Polygon()

        /// FIXME: Currently Precision and CoordinateRefereceSystem can not be Equitable and be used for anything otherthan Generic constraints because it's a protocol, this limits testing of the defaultPrecision and defaultCoordinateSystem
        /// XCTAssertEqual(input.precision as? FloatingPrecision, GeoFeatures.defaultPrecision)
        XCTAssertEqual(input.coordinateSystem as? Cartesian, GeoFeatures.defaultCoordinateSystem)
    }

    func testInitWithPrecisionAndCRS() {
        let input = Polygon(precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.precision as? Fixed, precision)
        XCTAssertEqual(input.coordinateSystem as? Cartesian, cs)
    }

    func testInitWithPrecision() {
        let input    = Polygon(precision: precision)
        let expected = precision

        XCTAssertEqual(input.precision as? Fixed, expected)
    }

    func testInitWithCRS() {
        let input = Polygon(coordinateSystem: cs)
        let expected = cs

        XCTAssertEqual(input.coordinateSystem as? Cartesian, expected)
    }

    func testInitWithRings() {

        let input    = Polygon([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], innerRings: [[Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]], precision: precision, coordinateSystem: cs)
        let expected = Polygon([Coordinate(x: 6.01, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.01, y: 3.0), Coordinate(x: 6.01, y: 1.0)], innerRings: [[Coordinate(x: 5.01, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.01, y: 3.0), Coordinate(x: 5.01, y: 2.0)]], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input.outerRing.count, 6)
        XCTAssertEqual(input.innerRings.count, 1)
        XCTAssertEqual(input, expected)
    }

    func testInitArrayLiteral() {

        let input: Polygon   = [[Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], [Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]]
        let expected = Polygon([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], innerRings: [[Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]])

        XCTAssertEqual(input, expected)
     }

    func testDoubleEqualsTrue() {

       let input    = Polygon([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], innerRings: [[Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]], precision: precision, coordinateSystem: cs)
       let expected = Polygon([Coordinate(x: 6.01, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.01, y: 3.0), Coordinate(x: 6.01, y: 1.0)], innerRings: [[Coordinate(x: 5.01, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.01, y: 3.0), Coordinate(x: 5.01, y: 2.0)]], precision: precision, coordinateSystem: cs)

       XCTAssertEqual(input, expected)
    }

    func testDoubleEqualsFalse() {

       let input    = Polygon([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], innerRings: [[Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]], precision: precision, coordinateSystem: cs)
       let expected = Polygon([Coordinate(x: 6.01, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.01, y: 3.0), Coordinate(x: 6.01, y: 1.0)], innerRings: [[Coordinate(x: 5.01, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.02, y: 3.0), Coordinate(x: 5.01, y: 2.0)]], precision: precision, coordinateSystem: cs)

       XCTAssertNotEqual(input, expected)
    }

    // MARK: MutableCollection Conformance

    func testStartIndex() {
        let input    = Polygon([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], innerRings: [[Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]], precision: precision, coordinateSystem: cs)
        let expected = 0

        XCTAssertEqual(input.startIndex, expected)
    }

    func testEndIndex() {
        let input    = Polygon([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], innerRings: [[Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]], precision: precision, coordinateSystem: cs)
        let expected = 2

        XCTAssertEqual(input.endIndex, expected)
    }

    func testIndexAfter() {
        let input    = 0
        let expected = 1

        XCTAssertEqual(Polygon(precision: precision, coordinateSystem: cs).index(after: input), expected)
    }

    func testSubscriptGet() {
        let input    = Polygon([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], innerRings: [[Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]], precision: precision, coordinateSystem: cs)
        let expected = LinearRing([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input[0] == expected)
    }

    func testSubscriptSet() {
        var input    = (geometry: Polygon([Coordinate(x: 6.006, y: 1.001)], precision: precision, coordinateSystem: cs), newElement: LinearRing([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], precision: precision, coordinateSystem: cs))
        let expected = LinearRing([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], precision: precision, coordinateSystem: cs)

        input.geometry[0] = input.newElement

        XCTAssertEqual(input.geometry[0], expected)
    }

    // MARK: RangeReplaceableCollection Conformance

    func testReplaceSubrangeAppend() {

        var input = (geometry: Polygon(precision: precision, coordinateSystem: cs), newElements: [LinearRing([Coordinate(x: 1.0, y: 1.0)])])
        let expected = [LinearRing([Coordinate(x: 1.0, y: 1.0)])]

        input.geometry.replaceSubrange(0..<0, with: input.newElements)

        XCTAssertTrue(input.geometry.elementsEqual(expected) { (lhs: LinearRing, rhs: LinearRing) -> Bool in
                return lhs == rhs
            }, "\(input) is not equal to \(expected)")
    }

    func testReplaceSubrangeInsert() {

        var input = (geometry: Polygon([LinearRing([Coordinate(x: 1.0, y: 1.0)]), LinearRing([Coordinate(x: 2.0, y: 2.0)])], precision: precision, coordinateSystem: cs), newElements: [LinearRing([Coordinate(x: 3.0, y: 3.0)])])
        let expected = [LinearRing([Coordinate(x: 3.0, y: 3.0)]), LinearRing([Coordinate(x: 1.0, y: 1.0)]), LinearRing([Coordinate(x: 2.0, y: 2.0)])]

        input.geometry.replaceSubrange(0..<0, with: input.newElements)

        XCTAssertTrue(input.geometry.elementsEqual(expected) { (lhs: LinearRing, rhs: LinearRing) -> Bool in
                return lhs == rhs
            }, "\(input) is not equal to \(expected)")
    }

    func testReplaceSubrangeReplace() {

        var input = (geometry: Polygon([LinearRing([Coordinate(x: 1.0, y: 1.0)]), LinearRing([Coordinate(x: 2.0, y: 2.0)])], precision: precision, coordinateSystem: cs), newElements: [LinearRing([Coordinate(x: 3.0, y: 3.0)])])
        let expected = [LinearRing([Coordinate(x: 3.0, y: 3.0)]), LinearRing([Coordinate(x: 2.0, y: 2.0)])]

        input.geometry.replaceSubrange(0..<1, with: input.newElements)

        XCTAssertTrue(input.geometry.elementsEqual(expected) { (lhs: LinearRing, rhs: LinearRing) -> Bool in
                return lhs == rhs
            }, "\(input) is not equal to \(expected)")
    }

    // MARK: CustomStringConvertible & CustomDebugStringConvertible

    func testDescription() {

        let input    = Polygon([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], innerRings: [[Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]], precision: precision, coordinateSystem: cs)
        let expected = "Polygon([LinearRing([(x: 6.01, y: 1.0), (x: 1.0, y: 1.0), (x: 1.0, y: 3.0), (x: 3.5, y: 4.0), (x: 6.01, y: 3.0), (x: 6.01, y: 1.0)]), LinearRing([(x: 5.01, y: 2.0), (x: 3.0, y: 1.5), (x: 3.0, y: 3.0), (x: 4.0, y: 3.5), (x: 5.01, y: 3.0), (x: 5.01, y: 2.0)])])"

        XCTAssertEqual(input.description, expected)
    }

    func testDebugDescription() {

        let input    = Polygon([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], innerRings: [[Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]], precision: precision, coordinateSystem: cs)
        let expected = "Polygon([LinearRing([(x: 6.01, y: 1.0), (x: 1.0, y: 1.0), (x: 1.0, y: 3.0), (x: 3.5, y: 4.0), (x: 6.01, y: 3.0), (x: 6.01, y: 1.0)]), LinearRing([(x: 5.01, y: 2.0), (x: 3.0, y: 1.5), (x: 3.0, y: 3.0), (x: 4.0, y: 3.5), (x: 5.01, y: 3.0), (x: 5.01, y: 2.0)])])"

        XCTAssertEqual(input.debugDescription, expected)
    }

    func testOperatorEqualWithGeometryAndPolygon() {
        let input: Geometry                 = Polygon([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], innerRings: [[Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]], precision: precision, coordinateSystem: cs)
        let expected: Polygon = Polygon([Coordinate(x: 6.01, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.01, y: 3.0), Coordinate(x: 6.01, y: 1.0)], innerRings: [[Coordinate(x: 5.01, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.01, y: 3.0), Coordinate(x: 5.01, y: 2.0)]], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected)
    }

    func testOperatorEqualWithPolygonAndGeometry() {
        let input: Polygon = Polygon([Coordinate(x: 6.006, y: 1.001), Coordinate(x: 1.001, y: 1.001), Coordinate(x: 1.001, y: 3.003), Coordinate(x: 3.501, y: 4.001), Coordinate(x: 6.006, y: 3.003), Coordinate(x: 6.006, y: 1.001)], innerRings: [[Coordinate(x: 5.005, y: 2.002), Coordinate(x: 3.003, y: 1.501), Coordinate(x: 3.003, y: 3.003), Coordinate(x: 4.004, y: 3.503), Coordinate(x: 5.005, y: 3.003), Coordinate(x: 5.005, y: 2.002)]], precision: precision, coordinateSystem: cs)
        let expected: Geometry           = Polygon([Coordinate(x: 6.01, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.5, y: 4.0), Coordinate(x: 6.01, y: 3.0), Coordinate(x: 6.01, y: 1.0)], innerRings: [[Coordinate(x: 5.01, y: 2.0), Coordinate(x: 3.0, y: 1.5), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 4.0, y: 3.5), Coordinate(x: 5.01, y: 3.0), Coordinate(x: 5.01, y: 2.0)]], precision: precision, coordinateSystem: cs)

        XCTAssertTrue(input == expected)
    }
}
