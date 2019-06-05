///
///  IntersectionTests.swift
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
///  Created by Ed Swiss on 10/29/18.
///
import XCTest
@testable import GeoFeatures

#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS)) && SWIFT_PACKAGE
/// TODO: Remove this after figuring out why there seems to be a symbol conflict (error: cannot specialize a non-generic definition) with another Polygon on Swift PM on Apple platforms only.
import struct GeoFeatures.Polygon
#endif

// MARK: - All

class IntersectionTests: XCTestCase {

    let precision = Floating()
    let cs        = Cartesian()

    ///
    /// Point Point tests
    ///

    func testPoint_Point_noIntersection() {

        let geometry1 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_Point_identicalPoints() {

        let geometry1 = Point(Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// Point MultiPoint tests
    ///

    func testPoint_MultiPoint_noIntersection() {

        let geometry1 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_MultiPoint_firstProperSubsetOfSecond() {

        let geometry1 = Point(Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_MultiPoint_firstImproperSubsetOfSecond() {

        let geometry1 = Point(Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// Point LineString tests
    ///

    func testPoint_LineString_noIntersection() {

        let geometry1 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_LineString_firstSubsetOfSecondInterior() {

        let geometry1 = Point(Coordinate(x: 1.0, y: 1.5), precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_LineString_firstSubsetOfSecondBoundary() {

        let geometry1 = Point(Coordinate(x: 1.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// Point LinearRing tests
    ///

    func testPoint_LinearRing_noIntersection() {

        let geometry1 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_LinearRing_firstSubsetOfSecondInterior() {

        let geometry1 = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// Point MultiLineString tests
    ///

    func testPoint_MultiLineString_noIntersection() {

        let geometry1 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_MultiLineString_firstSubsetOfSecondInterior() {

        let geometry1 = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_MultiLineString_firstSubsetOfSecondBoundary() {

        let geometry1 = Point(Coordinate(x: 3.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// Point Polygon tests
    ///

    func testPoint_Polygon_outerRingOnly_noIntersection() {

        let geometry1 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_Polygon_outerRingAndInnerRing_outsideMainRing_noIntersection() {

        let geometry1 = Point(Coordinate(x: -20.0, y: -20.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_Polygon_outerRingAndInnerRing_insideInnerRing_noIntersection() {

        let geometry1 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: -3.0, y: 0.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 3.0, y: 0.0), Coordinate(x: 0.0, y: 3.0), Coordinate(x: -3.0, y: 0.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_Polygon_outerRingOnly_intersectsBoundary() {

        let geometry1 = Point(Coordinate(x: 2.0, y: 2.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_Polygon_outerRingAndInnerRing_intersectsOuterBoundary() {

        let geometry1 = Point(Coordinate(x: -10.0, y: 5.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_Polygon_outerRingAndInnerRing_intersectsInnerBoundary() {

        let geometry1 = Point(Coordinate(x: 4.0, y: 4.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_Polygon_outerRingOnly_intersectsInterior() {

        let geometry1 = Point(Coordinate(x: 2.5, y: 2.5), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_Polygon_outerRingAndInnerRing_intersectsInterior() {

        let geometry1 = Point(Coordinate(x: -1.0, y: 4.0), precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// Point MultiPolygon tests
    ///

    func testPoint_MultiPolygon_outerRingsOnly_noIntersection() {

        let geometry1 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_MultiPolygon_outerRingAndInnerRings_outsideMainRings_noIntersection() {

        let geometry1 = Point(Coordinate(x: -20.0, y: -20.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_MultiPolygon_outerRingAndInnerRing_insideInnerRing_noIntersection() {

        let geometry1 = Point(Coordinate(x: 6.0, y: -4.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_MultiPolygon_outerRingOnly_intersectsBoundary() {

        let geometry1 = Point(Coordinate(x: -5.0, y: 4.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterBoundary() {

        let geometry1 = Point(Coordinate(x: 6.0, y: -2.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_MultiPolygon_outerRingAndInnerRing_intersectsInnerBoundary() {

        let geometry1 = Point(Coordinate(x: 5.0, y: -4.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_MultiPolygon_outerRingOnly_intersectsInterior() {

        let geometry1 = Point(Coordinate(x: -4.0, y: 3.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPoint_MultiPolygon_outerRingAndInnerRing_intersectsInterior() {

        let geometry1 = Point(Coordinate(x: 6.0, y: -9.0), precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry1

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// MultiPoint Point tests
    ///

    func testMultiPoint_Point_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiPoint_Point_secondProperSubsetOfFirst() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiPoint_Point_secondImproperSubsetOfFirst() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 1.0, y: 1.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// MultiPoint MultiPoint tests
    ///

    func testMultiPoint_MultiPoint_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected  = MultiPoint()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiPoint_MultiPoint_firstIntersectsSecondButNotSubset() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 3.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected  = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0))])

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiPoint_MultiPoint_firstProperSubsetOfSecond() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0)), Point(Coordinate(x: 5.0, y: 5.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0))])
        
        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPoint_secondProperSubsetOfFirst() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0)), Point(Coordinate(x: 5.0, y: 5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected  = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPoint_firstImproperSubsetOfSecond() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected  = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 4.0, y: 4.0))])

        compare(resultGeometry, expected)
    }

    ///
    /// MultiPoint LineString tests
    ///

    func testMultiPoint_LineString_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 3.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LineString_firstSubsetOfSecondInterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.5, y: 1.0)), Point(Coordinate(x: 2.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 3.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.5, y: 1.0)), Point(Coordinate(x: 2.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LineString_firstProperSubsetOfSecondBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LineString_firstImproperSubsetOfSecondBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondInteriorAndBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 2.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondInteriorAndCoversBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 2.5)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 2.5)), Point(Coordinate(x: 1.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondInteriorAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 2.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondBoundaryAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LineString_firstCoversSecondBoundaryAndTouchesExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondInteriorAndBoundaryAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 1.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 1.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LineString_firstTouchesSecondInteriorAndExteriorAndCoversBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 1.5)), Point(Coordinate(x: 1.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 1.5)), Point(Coordinate(x: 1.0, y: 3.0))])

        compare(resultGeometry, expected)
    }

    ///
    /// MultiPoint LinearRing tests
    ///

    func testMultiPoint_LinearRing_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 3.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LinearRing_firstSubsetOfSecondInterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.5, y: 1.0)), Point(Coordinate(x: 2.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.5, y: 1.0)), Point(Coordinate(x: 2.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LinearRing_firstTouchesSecondInteriorAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_LinearRing_firstTouchesSecondInteriorAndExterior_bothGeometriesNeedSimplification() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 2.5)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    ///
    /// MutliPoint MultiLineString tests
    ///

    func testMultiPoint_MultiLineString_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 4.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiLineString_firstSubsetOfSecondInterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 2.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 2.5, y: 2.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiLineString_firstProperSubsetOfSecondBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiLineString_firstImproperSubsetOfSecondBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.8, y: 1.8))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.8, y: 1.8))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndCoversBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 3.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 3.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondBoundaryAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 5.0, y: 5.0)), Point(Coordinate(x: 2.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 4.0), Coordinate(x: 2.0, y: 4.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 4.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiLineString_firstCoversSecondBoundaryAndTouchesExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 2.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 10.0, y: 0.0)), Point(Coordinate(x: 0.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 10.0, y: 0.0), Coordinate(x: 0.0, y: 10.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 10.0, y: 0.0)), Point(Coordinate(x: 0.0, y: 10.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndBoundaryAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.5, y: 4.0)), Point(Coordinate(x: 1.0, y: 5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 4.0), Coordinate(x: 2.0, y: 4.0)]), LineString([Coordinate(x: 1.0, y: 5.0), Coordinate(x: 3.0, y: 5.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.5, y: 4.0)), Point(Coordinate(x: 1.0, y: 5.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndExteriorAndCoversBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 6.0)), Point(Coordinate(x: 3.0, y: 7.0)), Point(Coordinate(x: 1.0, y: 1.5)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 6.0)]), LineString([Coordinate(x: 3.0, y: 2.0), Coordinate(x: 3.0, y: 7.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 6.0)), Point(Coordinate(x: 3.0, y: 7.0)), Point(Coordinate(x: 1.0, y: 1.5))])

        compare(resultGeometry, expected)
    }

    ///
    /// MultiPoint Polygon tests
    ///

    func testMultiPoint_Polygon_outerRingOnly_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 10.0, y: 2.0)), Point(Coordinate(x: 0.5, y: 4.0)), Point(Coordinate(x: 1.0, y: 5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_outsideMainRing_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 11.0, y: 2.0)), Point(Coordinate(x: 0.5, y: 14.0)), Point(Coordinate(x: -11.0, y: -5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_insideInnerRing_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: -0.5, y: 0.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: -3.0, y: 0.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 3.0, y: 0.0), Coordinate(x: 0.0, y: 3.0), Coordinate(x: -3.0, y: 0.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 11.0, y: 11.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -5.0, y: -3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }
        
        let expected = MultiPoint([])
        
        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsBoundaryOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 2.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 2.0, y: 4.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsOuterBoundaryOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -10.0, y: 3.4)), Point(Coordinate(x: 2.5, y: -10.0)), Point(Coordinate(x: 10.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -10.0, y: 3.4)), Point(Coordinate(x: 2.5, y: -10.0)), Point(Coordinate(x: 10.0, y: 10.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInnerBoundaryOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 4.0, y: 4.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 4.0, y: 4.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 4.0, y: -10.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 4.0, y: -10.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 10.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 10.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 4.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsInteriorOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 3.0)), Point(Coordinate(x: 3.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 2.2))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 3.0)), Point(Coordinate(x: 3.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 2.2))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 6.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 0.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 6.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 0.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -8.0, y: -8.0)), Point(Coordinate(x: 6.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 0.0)), Point(Coordinate(x: -0.5, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -8.0, y: -8.0)), Point(Coordinate(x: 6.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 0.0)), Point(Coordinate(x: -0.5, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 4.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 4.5, y: 2.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -10.0, y: 3.4)), Point(Coordinate(x: 2.5, y: 0.0)), Point(Coordinate(x: 5.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -10.0, y: 3.4)), Point(Coordinate(x: 2.5, y: 0.0)), Point(Coordinate(x: 5.0, y: 10.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -9.0, y: -9.0)), Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: -9.0)), Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 8.0, y: 7.0)), Point(Coordinate(x: 4.0, y: -10.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 8.0, y: 7.0)), Point(Coordinate(x: 4.0, y: -10.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 10.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 4.0)), Point(Coordinate(x: -1.0, y: -0.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 10.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 4.0)), Point(Coordinate(x: -1.0, y: -0.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -2.0, y: -2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.5, y: 2.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -9.0, y: 3.4)), Point(Coordinate(x: 12.5, y: 0.0)), Point(Coordinate(x: 5.0, y: -8.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: 3.4)), Point(Coordinate(x: 5.0, y: -8.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 2.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -4.0, y: -2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -5.0, y: -11.0)), Point(Coordinate(x: -1.0, y: -0.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -1.0, y: -0.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsBoundaryAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: 12.5, y: 0.0)), Point(Coordinate(x: 5.0, y: -10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: 5.0, y: -10.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 10.0, y: 9.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 10.0, y: 9.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -6.0, y: -2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -5.0, y: -3.0)), Point(Coordinate(x: 3.0, y: 5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -6.0, y: -2.0)), Point(Coordinate(x: 3.0, y: 5.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndBoundaryAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: 12.5, y: 0.0)), Point(Coordinate(x: -8.0, y: -8.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: -8.0, y: -8.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 10.0, y: 9.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 7.0, y: 4.3)), Point(Coordinate(x: 2.0, y: 12.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 10.0, y: 9.0)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 7.0, y: 4.3))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -6.0, y: -2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -5.0, y: -3.0)), Point(Coordinate(x: 3.0, y: 5.0)), Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 13.0, y: -5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -6.0, y: -2.0)), Point(Coordinate(x: 3.0, y: 5.0)), Point(Coordinate(x: 1.0, y: -1.0))])

        compare(resultGeometry, expected)
    }

    ///
    /// MultiPoint MultiPolygon tests
    ///

    func testMultiPoint_MultiPolygon_outerRingOnly_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 10.0, y: 2.0)), Point(Coordinate(x: 0.5, y: -4.0)), Point(Coordinate(x: -1.0, y: 5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_outsideMainRing_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 11.0, y: 2.0)), Point(Coordinate(x: 0.5, y: 14.0)), Point(Coordinate(x: -11.0, y: -5.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_insideInnerRing_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 5.5, y: -3.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 11.0, y: 11.0)), Point(Coordinate(x: 6.0, y: -3.5)), Point(Coordinate(x: 3.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsBoundaryOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: -3.0, y: 4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: -3.0, y: 4.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterBoundaryOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -10.0, y: 3.4)), Point(Coordinate(x: 4.0, y: -6.0)), Point(Coordinate(x: 10.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -10.0, y: 3.4)), Point(Coordinate(x: 4.0, y: -6.0)), Point(Coordinate(x: 10.0, y: 10.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInnerBoundaryOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 6.0, y: -3.0)), Point(Coordinate(x: 2.0, y: 4.0)), Point(Coordinate(x: 5.0, y: -4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 6.0, y: -3.0)), Point(Coordinate(x: 2.0, y: 4.0)), Point(Coordinate(x: 5.0, y: -4.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 6.0, y: -3.0)), Point(Coordinate(x: 5.0, y: -4.0)), Point(Coordinate(x: -9.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 6.0, y: -3.0)), Point(Coordinate(x: 5.0, y: -4.0)), Point(Coordinate(x: -9.0, y: 10.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -7.0, y: 3.0)), Point(Coordinate(x: 6.0, y: -10.0)), Point(Coordinate(x: 10.0, y: 9.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -7.0, y: 3.0)), Point(Coordinate(x: 6.0, y: -10.0)), Point(Coordinate(x: 10.0, y: 9.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -4.0, y: 3.0)), Point(Coordinate(x: -4.0, y: 2.5)), Point(Coordinate(x: 3.0, y: 2.2))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -4.0, y: 3.0)), Point(Coordinate(x: -4.0, y: 2.5)), Point(Coordinate(x: 3.0, y: 2.2))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 6.0, y: -9.0)), Point(Coordinate(x: 0.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 6.0, y: -9.0)), Point(Coordinate(x: 0.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorOnly() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 2.5, y: -3.5)), Point(Coordinate(x: 9.0, y: -19.0)), Point(Coordinate(x: 8.0, y: -8.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 2.5, y: -3.5)), Point(Coordinate(x: 9.0, y: -19.0)), Point(Coordinate(x: 8.0, y: -8.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -4.0, y: 3.0)), Point(Coordinate(x: -2.0, y: 2.0)), Point(Coordinate(x: -4.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -4.0, y: 3.0)), Point(Coordinate(x: -2.0, y: 2.0)), Point(Coordinate(x: -4.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 6.0, y: -2.4)), Point(Coordinate(x: 10.0, y: 4.0)), Point(Coordinate(x: 5.0, y: 10.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 6.0, y: -2.4)), Point(Coordinate(x: 10.0, y: 4.0)), Point(Coordinate(x: 5.0, y: 10.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -9.0, y: 7.0)), Point(Coordinate(x: 6.0, y: -10.0)), Point(Coordinate(x: 5.0, y: -4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: 7.0)), Point(Coordinate(x: 6.0, y: -10.0)), Point(Coordinate(x: 5.0, y: -4.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 9.1, y: -2.8)), Point(Coordinate(x: 6.0, y: -10.0)), Point(Coordinate(x: 2.0, y: -18.0)), Point(Coordinate(x: 2.5, y: -2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 9.1, y: -2.8)), Point(Coordinate(x: 6.0, y: -10.0)), Point(Coordinate(x: 2.0, y: -18.0)), Point(Coordinate(x: 2.5, y: -2.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -2.0, y: -2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -4.0, y: 3.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -4.0, y: 3.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -9.0, y: 3.4)), Point(Coordinate(x: 6.0, y: -2.5)), Point(Coordinate(x: 15.0, y: -8.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: 3.4)), Point(Coordinate(x: 6.0, y: -2.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 6.0, y: -4.0)), Point(Coordinate(x: 6.5, y: -4.8))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 5.0, y: -11.0)), Point(Coordinate(x: 6.0, y: -4.0)), Point(Coordinate(x: -25.0, y: -11.0)), Point(Coordinate(x: 9.5, y: 9.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 9.5, y: 9.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsBoundaryAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: -4.0, y: 6.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: -4.0, y: 6.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: 12.5, y: 0.0)), Point(Coordinate(x:7.0, y: -4.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x:7.0, y: -4.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 6.0, y: -4.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 4.0, y: -6.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 4.0, y: -6.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 4.0, y: -12.0)), Point(Coordinate(x: 6.0, y: -4.0)), Point(Coordinate(x: 11.0, y: -21.0)), Point(Coordinate(x: 3.0, y: -11.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: -11.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndBoundaryAndExterior() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -4.0, y: 2.0)), Point(Coordinate(x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -4.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: 12.5, y: 0.0)), Point(Coordinate(x: 5.0, y: -2.5))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: 5.0, y: -2.5))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 9.0, y: 9.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 6.0, y: -11.0)), Point(Coordinate(x: 7.0, y: -4.3)), Point(Coordinate(x: 9.0, y: -2.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 9.0, y: 9.0)), Point(Coordinate(x: 7.0, y: -4.3)), Point(Coordinate(x: 9.0, y: -2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = MultiPoint([Point(Coordinate(x: 9.0, y: -19.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 6.0, y: -4.0)), Point(Coordinate(x: 13.0, y: 5.0)), Point(Coordinate(x: 3.0, y: -11.0)), Point(Coordinate(x: 10.0, y: -18.0)), Point(Coordinate(x: -9.0, y: 1.0))], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 9.0, y: -19.0)), Point(Coordinate(x: 3.0, y: -11.0)), Point(Coordinate(x: 10.0, y: -18.0)), Point(Coordinate(x: -9.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    ///
    /// LineString Point tests
    ///

    func testLineString_Point_noIntersection() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Point_firstSubsetOfSecondInterior() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 1.0, y: 1.5), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Point_firstSubsetOfSecondBoundary() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 1.0, y: 3.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// LineString MultiPoint tests
    ///

    func testLineString_MultiPoint_noIntersection() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 3.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testLineString_MultiPoint_secondSubsetOfFirstInterior() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 3.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 1.5, y: 1.0)), Point(Coordinate(x: 2.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.5, y: 1.0)), Point(Coordinate(x: 2.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testLineString_MultiPoint_secondProperSubsetOfFirstBoundary() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0))])

        compare(resultGeometry, expected)
    }

    func testLineString_MultiPoint_secondImproperSubsetOfFirstBoundary() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testLineString_MultiPoint_secondTouchesFirstInteriorAndBoundary() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 2.5))])

        compare(resultGeometry, expected)
    }

    func testLineString_MultiPoint_secondTouchesFirstInteriorAndCoversBoundary() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 2.5)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 2.5)), Point(Coordinate(x: 1.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testLineString_MultiPoint_secondTouchesFirstInteriorAndExterior() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 2.5))])

        compare(resultGeometry, expected)
    }

    func testLineString_MultiPoint_secondTouchesFirstBoundaryAndExterior() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testLineString_MultiPoint_secondCoversFirstBoundaryAndTouchesExterior() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testLineString_MultiPoint_secondTouchesFirstInteriorAndBoundaryAndExterior() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 1.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 1.5))])

        compare(resultGeometry, expected)
    }

    func testLineString_MultiPoint_secondTouchesFirstInteriorAndExteriorAndCoversBoundary() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 1.5)), Point(Coordinate(x: 1.0, y: 3.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 1.5)), Point(Coordinate(x: 1.0, y: 3.0))])

        compare(resultGeometry, expected)
    }

    ///
    /// LineString LineString tests
    ///

    func testLineString_LineString_noIntersection() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_interiorsIntersectAtOnePointFirstSegments() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -2.0, y: 0.0), Coordinate(x: 0.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -1.0, y: -1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_interiorsIntersectAtOnePointSecondSegments() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: 6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 4.0, y: 0.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    /// TODO: Add more tests like this one, where the line strings touch at a point but do not cross.
    func testLineString_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -2.0, y: 0.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -5.0, y: -2.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -2.0, y: -2.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_interiorsIntersectAtTwoPointsBothSegments() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -2.0, y: 2.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: 6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 4.0, y: 0.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_firstInteriorIntersectsSecondBoundary() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 0.0, y: -12.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 4.0, y: 0.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_firstInteriorIntersectsSecondBoundary_FirstBoundaryPoint() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -3.0, y: -3.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 2.0, y: -10.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_firstInteriorIntersectsSecondBoundary_SecondBoundaryPoint() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 0.0, y: -12.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 4.0, y: 0.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -3.0, y: -3.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: -3.0)), Point(Coordinate(x: 4.0, y: 0.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesFirstBoundaryPoint() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 6.0, y: -2.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 6.0, y: -2.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesSecondBoundaryPoint() {

        let geometry1 = LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint() {

        let geometry1 = LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 6.0, y: -2.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 6.0, y: -2.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap() {

        let geometry1 = LineString([Coordinate(x: -7.0, y: -7.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 6.0, y: -2.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 6.0, y: -2.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap() {

        let geometry1 = LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 12.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_secondProperSubsetOfFirst() {

        let geometry1 = LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 12.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_secondOverlapsFirstAndTouchesFirstAtTwoPoints() {

        let geometry1 = LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 12.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -50.0, y: -50.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 4.0, y: 0.0), Coordinate(x: 6.0, y: 6.0), Coordinate(x: 6.0, y: -2.0), Coordinate(x: 8.0, y: 8.0), Coordinate(x: 8.0, y: -4.0), Coordinate(x: 10.0, y: 10.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 6.0, y: -2.0)), Point(Coordinate(x: 8.0, y: -4.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 4.0, y: 0.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LineString_secondOverlapsFirstAndTouchesFirstAtTwoPoints2() {

        let geometry1 = LineString([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 4.0), Coordinate(x: 4.0, y: 4.0), Coordinate(x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 2.0, y: -2.0), Coordinate(x: 8.0, y: 4.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: 2.0, y: -2.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 4.0, y: 0.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 0.0, y: 4.0), Coordinate(x: 4.0, y: 4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// LineString LinearRing tests
    ///

    func testLineString_LinearRing_noIntersection() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -2.0, y: 0.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -5.0, y: -2.0), Coordinate(x: -2.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -2.0, y: -2.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_interiorsIntersectAtOnePointSecondSegments() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: 6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 4.0, y: 0.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    /// TODO: Add more tests like this one, where the line string and linear ring touch at a point but do not cross.
    func testLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 4.0, y: -8.0), Coordinate(x: -3.0, y: -3.0), Coordinate(x: 10.0, y: -3.0), Coordinate(x: 4.0, y: -8.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_interiorsIntersectAtTwoPointsBothSegments() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -2.0, y: 2.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: 6.0), Coordinate(x: -2.0, y: 6.0), Coordinate(x: -2.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 4.0, y: 0.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_firstInteriorIntersectsSecondInteriorAtSegmentEndpoint() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 0.0, y: -12.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 4.0, y: 0.0), Coordinate(x: 4.0, y: -8.0), Coordinate(x: 0.0, y: -12.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 4.0, y: 0.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_FirstBoundaryPoint() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: -5.0), Coordinate(x: 2.0, y: -10.0), Coordinate(x: -5.0, y: -10.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -5.0, y: -5.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_SecondBoundaryPoint() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: -6.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: 1.0, y: -10.0), Coordinate(x: 1.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 10.0, y: -6.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_BothBoundaryPoints() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -8.0, y: -5.0), Coordinate(x: -1.0, y: -5.0), Coordinate(x: -1.0, y: -6.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 10.0, y: -8.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -8.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -5.0, y: -5.0)), Point(Coordinate(x: 10.0, y: -6.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing2() {

        let geometry1 = LineString([Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing3() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: -4.9, y: -4.9)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: -4.9, y: -4.9)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing4() {

        let geometry1 = LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 0.0, y: 0.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_secondProperSubsetOfFirst() {

        let geometry1 = LineString([Coordinate(x: -10.0, y: 0.0), Coordinate(x: 20.0, y: 0.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 0.0, y: 20.0), Coordinate(x: 0.0, y: -10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 20.0, y: 0.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 0.0, y: 20.0), Coordinate(x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 20.0, y: 0.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 0.0, y: 20.0), Coordinate(x: 0.0, y: 0.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_secondOverlapsFirstAndTouchesFirstAtTwoPoints() {

        let geometry1 = LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 12.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -50.0, y: -50.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 4.0, y: 0.0), Coordinate(x: 6.0, y: 6.0), Coordinate(x: 6.0, y: -2.0), Coordinate(x: 8.0, y: 8.0), Coordinate(x: 8.0, y: -4.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 10.0), Coordinate(x: 20.0, y: -50.0), Coordinate(x: -50.0, y: -50.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 6.0, y: -2.0)), Point(Coordinate(x: 8.0, y: -4.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 4.0, y: 0.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_LinearRing_secondOverlapsFirstAndTouchesFirstAtTwoPoints2() {

        let geometry1 = LineString([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 4.0), Coordinate(x: 4.0, y: 4.0), Coordinate(x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 2.0, y: -2.0), Coordinate(x: 8.0, y: 4.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: 2.0, y: -2.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 4.0, y: 0.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 0.0, y: 4.0), Coordinate(x: 4.0, y: 4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// LineString MultiLineString tests
    ///

    func testLineString_MultiLineString_noIntersection() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -1.5), Coordinate(x: 10.0, y: -1.5), Coordinate(x: 10.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.5, y: -1.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: 2.0), Coordinate(x: -3.0, y: 2.0), Coordinate(x: -3.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 2.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString() {

        let geometry1 = LineString([Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -2.5), Coordinate(x: 10.0, y: -2.5)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString() {

        let geometry1 = LineString([Coordinate(x: -12.0, y: -8.0), Coordinate(x: -3.0, y: -8.0), Coordinate(x: -3.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    /// TODO: Add more tests like this one, where the line strings touch at a point but do not cross.
    func testLineString_MultiLineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = LineString([Coordinate(x: -7.0, y: 8.0), Coordinate(x: -3.0, y: 4.0), Coordinate(x: 1.0, y: 8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings() {

        let geometry1 = LineString([Coordinate(x: -2.0, y: 7.0), Coordinate(x: -2.0, y: -2.5), Coordinate(x: 5.0, y: -2.5)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -2.0, y: 4.0)), Point(Coordinate(x: 1.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString1() {

        let geometry1 = LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 4.0, y: -1.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString2() {

        let geometry1 = LineString([Coordinate(x: 0.0, y: -10.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 12.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString1() {

        let geometry1 = LineString([Coordinate(x: -2.0, y: 1.0), Coordinate(x: -9.0, y: 1.0), Coordinate(x: -9.0, y: -9.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString2() {

        let geometry1 = LineString([Coordinate(x: -2.0, y: -10.0), Coordinate(x: -2.0, y: 1.0), Coordinate(x: 0.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -1.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_FirstLineString() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_SecondLineString() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: -5.0, y: 1.0), Coordinate(x: 0.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0)), Point(Coordinate(x: -1.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_AllBoundaryPoints() {

        let geometry1 = LineString([Coordinate(x: -5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0)), Point(Coordinate(x: -1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings_FirstLineString() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings_SecondLineString() {

        let geometry1 = LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesFirstBoundaryPointOfSecondLineString() {

        let geometry1 = LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -2.0, y: 4.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -2.0, y: 4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesSecondBoundaryPointOfFirstLineString() {

        let geometry1 = LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint_FirstLineString() {

        let geometry1 = LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.5, y: -2.5)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.5, y: -2.5)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint_SecondLineString() {

        let geometry1 = LineString([Coordinate(x: -3.0, y: 4.0), Coordinate(x: -2.0, y: 4.0), Coordinate(x: -1.5, y: 4.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -3.0, y: 4.0), Coordinate(x: -1.5, y: 4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap_FirstLineString() {

        let geometry1 = LineString([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 4.0, y: -4.0), Coordinate(x: 4.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap_SecondLineString() {

        let geometry1 = LineString([Coordinate(x: -1.0, y: 9.0), Coordinate(x: -1.0, y: -4.0), Coordinate(x: -5.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_secondProperSubsetOfFirst() {

        let geometry1 = LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 12.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 4.0, y:0.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 7.0, y: -3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 7.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstProperSubsetOfSimplifiedSecond() {

        let geometry1 = LineString([Coordinate(x: -10.0, y: 5.0), Coordinate(x: -5.0, y: 5.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 10.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -1.0, y: 1.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 50.0, y: -5.0)]), LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: -5.0, y: 5.0), Coordinate(x: -50.0, y: 5.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -10.0, y: 5.0), Coordinate(x: -5.0, y: 5.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 10.0, y: -5.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_secondTouchesFirstAtTwoSegmentsAndTwoPoints() {

        let geometry1 = LineString([Coordinate(x: 30.0, y: 0.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: -10.0, y: 0.0), Coordinate(x: -30.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 50.0, y: -10.0), Coordinate(x: 50.0, y: 0.0), Coordinate(x: 20.0, y: 0.0), Coordinate(x: 0.0, y: 20.0)]), LineString([Coordinate(x: -50.0, y: -10.0), Coordinate(x: -50.0, y: 0.0), Coordinate(x: -20.0, y: 0.0), Coordinate(x: 0.0, y: 20.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 10.0, y: 10.0)), Point(Coordinate(x: -10.0, y: 10.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 30.0, y: 0.0), Coordinate(x: 20.0, y: 0.0)]), LineString([Coordinate(x: -30.0, y: 0.0), Coordinate(x: -20.0, y: 0.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstRectangleTouchesSecondSquaresAtMultipleSegments() {

        let geometry1 = LineString([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 20.0), Coordinate(x: 60.0, y: 20.0), Coordinate(x: 60.0, y: 0.0), Coordinate(x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 20.0, y: 0.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 20.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 20.0, y: 0.0)]), LineString([Coordinate(x: 40.0, y: 20.0), Coordinate(x: 40.0, y: 0.0), Coordinate(x: 60.0, y: 0.0), Coordinate(x: 60.0, y: 20.0), Coordinate(x: 40.0, y: 20.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 20.0, y: 20.0), Coordinate(x: 0.0, y: 20.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 20.0, y: 0.0)]), LineString([Coordinate(x: 40.0, y: 20.0), Coordinate(x: 60.0, y: 20.0), Coordinate(x: 60.0, y: 0.0), Coordinate(x: 40.0, y: 0.0)])]))

        XCTAssertEqual(resultGeometry.count, 1, "There should not be any points, only line strings.")
        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiLineString_firstTouchesSecondAtTwoSegmentsAndTwoPoints() {

        let geometry1 = LineString([Coordinate(x: -20.0, y: 0.0), Coordinate(x: 40.0, y: 0.0), Coordinate(x: 0.0, y: 40.0), Coordinate(x: 0.0, y: 20.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 20.0, y: 0.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 40.0)]), LineString([Coordinate(x: 20.0, y: 20.0), Coordinate(x: 40.0, y: 20.0), Coordinate(x: 40.0, y: -20.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 40.0, y: 0.0)), Point(Coordinate(x: 20.0, y: 20.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 20.0, y: 0.0), Coordinate(x: 0.0, y: 0.0)]), LineString([Coordinate(x: 0.0, y: 40.0), Coordinate(x: 0.0, y: 20.0)])]))

        XCTAssertEqual(resultGeometry.count, 2, "There should be two points and two line strings.")
        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// LineString Polygon tests
    ///

    func testLineString_Polygon_noIntersection() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_withHole_noIntersection_lineStringOutsideMainPolygon() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_withHole_noIntersection_lineStringInsideHole() {

        let geometry1 = LineString([Coordinate(x: -7.0, y: -5.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -5.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_interiorsIntersect_lineStringFirstSegment() {

        let geometry1 = LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -1.0), Coordinate(x: 12.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 5.5, y: -2.5)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_interiorsIntersect_lineStringSecondSegment() {

        let geometry1 = LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -7.0), Coordinate(x: 12.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 5.5, y: -5.5)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    /// TODO: Add more tests like this one, where the line string and polygon touch at a point but do not cross.
    func testLineString_Polygon_interiorIntersectsBoundaryAtOnePoint_lineStringFirstSegment_doNotCross() {

        let geometry1 = LineString([Coordinate(x: 5.5, y: 5.0), Coordinate(x: 5.5, y: -2.5), Coordinate(x: 10.0, y: -2.5)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 5.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_interiorIntersectsBoundaryAtOnePoint_lineStringInsideHole_doNotCross() {

        let geometry1 = LineString([Coordinate(x: -7.0, y: -7.0), Coordinate(x: -8.0, y: -6.0), Coordinate(x: -7.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -8.0, y: -6.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringOutsideMainLinearRing() {

        let geometry1 = LineString([Coordinate(x: 12.0, y: 10.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 4.0, y: -7.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringOutsideMainLinearRing() {

        let geometry1 = LineString([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 4.0, y: -1.0)), Point(Coordinate(x: 4.0, y: -7.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringInsideHole() {

        let geometry1 = LineString([Coordinate(x: -7.0, y: -7.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -4.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: -6.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringInsideHole() {

        let geometry1 = LineString([Coordinate(x: -7.0, y: -8.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -4.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -7.0, y: -8.0)), Point(Coordinate(x: -4.0, y: -6.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_intersectsPolygonBoundaryInteriorExterior() {

        let geometry1 = LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 2.5, y: -2.5)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole() {

        let geometry1 = LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -6.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -8.0, y: -8.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes() {

        let geometry1 = LineString([Coordinate(x: -4.0, y: -6.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 10.0, y: -4.0), Coordinate(x: 0.0, y: -4.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 12.0, y: -3.0), Coordinate(x: 12.0, y: 5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 5.0, y: -6.0), Coordinate(x: 3.0, y: -6.0)]), LineString([Coordinate(x: 7.0, y: -4.0), Coordinate(x: 1.0, y: -4.0)]), LineString([Coordinate(x: 6.0, y: -3.0), Coordinate(x: 2.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole() {

        let geometry1 = LineString([Coordinate(x: -7.0, y: -7.0), Coordinate(x: 0.0, y: -14.0), Coordinate(x: 0.0, y: -6.0), Coordinate(x: -6.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -6.0, y: -8.0), Coordinate(x: -4.0, y: -10.0)]), LineString([Coordinate(x: -2.0, y: -6.0), Coordinate(x: -4.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_intersectsPolygonBoundaryAtPointsOnly() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: -7.0), Coordinate(x: 7.0, y: -7.0), Coordinate(x: 7.0, y: -1.0), Coordinate(x: 1.0, y: -1.0), Coordinate(x: 1.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 4.0, y: -7.0)), Point(Coordinate(x: 7.0, y: -4.0)), Point(Coordinate(x: 4.0, y: -1.0)), Point(Coordinate(x: 1.0, y: -4.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_intersectsPolygonBoundaryInteriorAndExteriorAtPointsAndSegments() {

        let geometry1 = LineString([Coordinate(x: -4.0, y: -4.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 6.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: -6.0, y: -10.0), Coordinate(x: -6.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -2.0, y: -2.0)), Point(Coordinate(x: -4.0, y: -4.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -8.0, y: -8.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)]), LineString([Coordinate(x: -2.0, y: -10.0), Coordinate(x: -6.0, y: -10.0), Coordinate(x: -6.0, y: -8.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_Polygon_intersectsPolygonBoundaryInteriorAndExteriorAtPointsAndSegments_multipleHoles() {

        let geometry1 = LineString([Coordinate(x: 0.0, y: 80.0), Coordinate(x: 200.0, y: 80.0), Coordinate(x: 200.0, y: 30.0), Coordinate(x: 50.0, y: 30.0), Coordinate(x: 90.0, y: -10.0), Coordinate(x: 110.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 100.0, y: 0.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 100.0), Coordinate(x: 100.0, y: 100.0), Coordinate(x: 100.0, y: 0.0)], innerRings: [[Coordinate(x: 20.0, y: 20.0), Coordinate(x: 10.0, y: 20.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 10.0), Coordinate(x: 20.0, y: 20.0)], [Coordinate(x: 60.0, y: 40.0), Coordinate(x: 60.0, y: 20.0), Coordinate(x: 80.0, y: 20.0), Coordinate(x: 80.0, y: 40.0), Coordinate(x: 60.0, y: 40.0)], [Coordinate(x: 40.0, y: 60.0), Coordinate(x: 60.0, y: 60.0), Coordinate(x: 60.0, y: 80.0), Coordinate(x: 40.0, y: 80.0), Coordinate(x: 40.0, y: 60.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 100.0, y: 0.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 0.0, y: 80.0), Coordinate(x: 100.0, y: 80.0)]), LineString([Coordinate(x: 100.0, y: 30.0), Coordinate(x: 80.0, y: 30.0)]), LineString([Coordinate(x: 60.0, y: 30.0), Coordinate(x: 50.0, y: 30.0), Coordinate(x: 80.0, y: 0.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// LineString MultiPolygon tests
    ///

    func testLineString_MultiPolygon_noIntersection() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_withHoles_noIntersection_lineStringOutsideMainPolygon() {

        let geometry1 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_withHoles_noIntersection_lineStringInsideHole() {

        let geometry1 = LineString([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 18.0, y: -15.0), Coordinate(x: 13.0, y: -18.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersect_firstPolygon() {

        let geometry1 = LineString([Coordinate(x: 4.0, y: 0.0), Coordinate(x: 0.0, y: 7.0), Coordinate(x: -10.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 2.0), Coordinate(x: -10.0, y: 2.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 2.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -5.0, y: 2.0), Coordinate(x: -2.0, y: 5.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersect_firstPolygon_withHole() {

        let geometry1 = LineString([Coordinate(x: -10.0, y: 10.0), Coordinate(x: -10.0, y: 12.0), Coordinate(x: -5.0, y: 7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -8.0, y: 10.0), Coordinate(x: -5.0, y: 7.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersect_secondPolygon() {

        let geometry1 = LineString([Coordinate(x: 0.0, y: 10.0), Coordinate(x: 6.0, y: 0.0), Coordinate(x: 6.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 6.0, y: -4.0), Coordinate(x: 6.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersect_secondPolygon_withHole() {

        let geometry1 = LineString([Coordinate(x: 15.0, y: -15.0), Coordinate(x: 13.0, y: -17.0), Coordinate(x: 13.0, y: -18.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 14.0, y: -16.0), Coordinate(x: 13.0, y: -17.0), Coordinate(x: 13.0, y: -18.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles() {

        let geometry1 = LineString([Coordinate(x: -3.0, y: 10.0), Coordinate(x: 0.0, y: 13.0), Coordinate(x: 18.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -3.0, y: 10.0), Coordinate(x: -2.0, y: 11.0)]), LineString([Coordinate(x: 15.0, y: -2.0), Coordinate(x: 18.0, y: -5.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_boundariesIntersect_firstPolygon_withHoles() {

        let geometry1 = LineString([Coordinate(x: -20.0, y: 18.0), Coordinate(x: -30.0, y: 30.0), Coordinate(x: -50.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -20.0, y: 18.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_boundariesIntersect_secondPolygon_withHoles() {

        let geometry1 = LineString([Coordinate(x: 0.0, y: -40.0), Coordinate(x: 22.0, y: -30.0), Coordinate(x: 15.0, y: -20.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 15.0, y: -20.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_boundariesIntersect_bothPolygons_withHoles() {

        let geometry1 = LineString([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 0.0, y: -50.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: -18.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -18.0, y: 3.0)), Point(Coordinate(x: 20.0, y: -20.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles() {

        let geometry1 = LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 20.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles() {

        let geometry1 = LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 12.0), Coordinate(x: -12.0, y: 12.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 20.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)]), LineString([Coordinate(x: -20.0, y: 12.0), Coordinate(x: -16.0, y: 12.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_interiorsIntersectAndBoundariesIntersect_withHoles() {

        let geometry1 = LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 9.0), Coordinate(x: -8.0, y: 9.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 20.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)]), LineString([Coordinate(x: -20.0, y: 9.0), Coordinate(x: -8.0, y: 9.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLineString_MultiPolygon_boundaryIntersectsInteriorAndBoundary_withHoles() {

        let geometry1 = LineString([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 10.0), Coordinate(x: -7.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 20.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)]), LineString([Coordinate(x: -20.0, y: 10.0), Coordinate(x: -16.0, y: 10.0)]), LineString([Coordinate(x: -8.0, y: 10.0), Coordinate(x: -7.0, y: 10.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// LinearRing Point tests
    ///

    func testLinearRing_Point_noIntersection() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 4.0), Coordinate(x: 4.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Point_secondSubsetOfFirstInterior_firstSegment() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 4.0), Coordinate(x: 4.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 1.0, y: 1.5), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Point_secondSubsetOfFirstInterior_lastSegment() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 4.0), Coordinate(x: 4.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 3.0, y: 1.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// LinearRing MultiPoint tests
    ///

    func testLinearRing_MultiPoint_noIntersection() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 4.0), Coordinate(x: 4.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 3.0, y: 3.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testLinearRing_MultiPoint_secondSubsetOfFirstInterior() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 4.0), Coordinate(x: 4.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.5)), Point(Coordinate(x: 2.5, y: 2.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.0, y: 1.5)), Point(Coordinate(x: 2.5, y: 2.5))])

        compare(resultGeometry, expected)
    }

    func testLinearRing_MultiPoint_secondTouchesFirstInteriorAndExterior() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 4.0), Coordinate(x: 4.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 3.1, y: 1.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.1, y: 1.0))])

        compare(resultGeometry, expected)
    }

    ///
    /// LinearRing LineString tests
    ///

    func testLinearRing_LineString_noIntersection() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_interiorsIntersectAtOnePointLineStringFirstSegment() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 2.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_interiorsIntersectAtOnePointSecondSegments() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 2.0, y: -2.0), Coordinate(x: 2.0, y: -3.0), Coordinate(x: 6.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 3.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    /// TODO: Add more tests like this one, where the line string and linear ring touch at a point but do not cross.
    func testLinearRing_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 0.0, y: -2.0), Coordinate(x: 2.0, y: 0.0), Coordinate(x: 6.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_interiorsIntersectAtTwoPointsBothSegments() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 3.0, y: 0.0), Coordinate(x: 3.0, y: -2.0), Coordinate(x: 6.0, y: -2.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 3.0, y: -1.0)), Point(Coordinate(x: 4.0, y: -2.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_firstInteriorIntersectsSecondInteriorAtMultipleSegmentEndpoints() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 0.0, y: -2.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 7.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 5.0, y: -1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_FirstBoundaryPoint() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: -3.0), Coordinate(x: -3.0, y: 4.0), Coordinate(x: -7.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_SecondBoundaryPoint() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -7.0, y: -3.0), Coordinate(x: -3.0, y: 4.0), Coordinate(x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_BothBoundaryPoints() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 3.0, y: -3.0), Coordinate(x: 10.0, y: -3.0), Coordinate(x: 10.0, y: 3.0), Coordinate(x: 3.0, y: 3.0), Coordinate(x: 3.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 3.0, y: -3.0)), Point(Coordinate(x: 3.0, y: -1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing() {

        let geometry1 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing2() {

        let geometry1 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing3() {

        let geometry1 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: -4.9, y: -4.9)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: -4.9, y: -4.9)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing4() {

        let geometry1 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 0.0, y: 0.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_geometriesShareSingleLineSegment_lineStringBoundaryDoesNotTouch() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: -10.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: 5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -5.0), Coordinate(x: 5.0, y: -1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_geometriesShareSingleLineSegment_lineStringBoundaryTouchesAtPoint() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: -10.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 3.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 3.0, y: -1.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -5.0), Coordinate(x: 5.0, y: -1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_firstProperSubsetOfSecond() {

        let geometry1 = LinearRing([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 20.0, y: 0.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 0.0, y: 20.0), Coordinate(x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -10.0, y: 0.0), Coordinate(x: 20.0, y: 0.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 0.0, y: 20.0), Coordinate(x: 0.0, y: -10.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 20.0, y: 0.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 0.0, y: 20.0), Coordinate(x: 0.0, y: 0.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_firstOverlapsSecondAndTouchesSecondAtTwoPoints() {

        let geometry1 = LinearRing([Coordinate(x: -50.0, y: -50.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 4.0, y: 0.0), Coordinate(x: 6.0, y: 6.0), Coordinate(x: 6.0, y: -2.0), Coordinate(x: 8.0, y: 8.0), Coordinate(x: 8.0, y: -4.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 10.0), Coordinate(x: 20.0, y: -50.0), Coordinate(x: -50.0, y: -50.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 12.0, y: -8.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 6.0, y: -2.0)), Point(Coordinate(x: 8.0, y: -4.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 4.0, y: 0.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LineString_firstOverlapsSecondAndTouchesSecondAtTwoPoints2() {

        let geometry1 = LinearRing([Coordinate(x: 2.0, y: -2.0), Coordinate(x: 8.0, y: 4.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: 2.0, y: -2.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 4.0), Coordinate(x: 4.0, y: 4.0), Coordinate(x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 4.0, y: 0.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 0.0, y: 4.0), Coordinate(x: 4.0, y: 4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// LinearRing LinearRing tests
    ///

    func testLinearRing_LinearRing_noIntersection() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -1.0, y: -1.0), Coordinate(x: -1.0, y: -5.0), Coordinate(x: -5.0, y: -1.0), Coordinate(x: -1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LinearRing_noIntersection_firstInsideSecond() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -1.0, y: 10.0), Coordinate(x: 20.0, y: 15.0), Coordinate(x: 25.0, y: -30.0), Coordinate(x: -1.0, y: -10.0), Coordinate(x: -1.0, y: 10.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LinearRing_noIntersection_secondInsideFirst() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 15.0), Coordinate(x: 15.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 4.0), Coordinate(x: 4.0, y: 4.0), Coordinate(x: 4.0, y: 2.0), Coordinate(x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LinearRing_interiorsIntersectAtTwoPoints() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 2.0, y: 2.0), Coordinate(x: -10.0, y: 2.0), Coordinate(x: 2.0, y: 14.0), Coordinate(x: 2.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: 2.0)), Point(Coordinate(x: 2.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LinearRing_interiorsIntersectAtTwoPoints_DoNotCross() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -10.0, y: 2.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: -10.0), Coordinate(x: -10.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: 2.0)), Point(Coordinate(x: 2.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LinearRing_firstInteriorIntersectsSecondInteriorAtThreeSegmentEndpoints() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 2.0, y: 0.0), Coordinate(x: 0.0, y: 2.0), Coordinate(x: 5.0, y: 17.0), Coordinate(x: 5.0, y: 0.0), Coordinate(x: 2.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 5.0)), Point(Coordinate(x: 5.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LinearRing_linearRingsMatch_samePointOrder() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
         expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LinearRing_linearRingsMatch_differentPointOrder() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LinearRing_oneSegmentShared() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 5.0, y: -15.0), Coordinate(x: 1.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LinearRing_twoSegmentsShared() {

        let geometry1 = LinearRing([Coordinate(x: 0.0, y: 20.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 20.0, y: 0.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 20.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 20.0, y: 4.0), Coordinate(x: 0.0, y: 4.0), Coordinate(x: 0.0, y: -20.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 20.0, y: 4.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 20.0, y: 0.0), Coordinate(x: 20.0, y: 4.0)]), LineString([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_LinearRing_oneSegmentAndOnePointShared() {

        let geometry1 = LinearRing([Coordinate(x: 20.0, y: 0.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 20.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 20.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 20.0, y: -20.0), Coordinate(x: -20.0, y: -20.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 20.0, y: -20.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 0.0, y: 0.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 20.0, y: 20.0), Coordinate(x: 20.0, y: 0.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// LinearRing MultiLineString tests
    ///

    func testLinearRing_MultiLineString_noIntersection() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 2.0, y: 2.0), Coordinate(x: 0.0, y: 2.0), Coordinate(x: 0.0, y: 13.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: 2.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString() {

        let geometry1 = LinearRing([Coordinate(x: -5.0, y: 2.0), Coordinate(x: -3.0, y: 2.0), Coordinate(x: -3.0, y: -3.0), Coordinate(x: -5.0, y: 2.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 2.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString() {

        let geometry1 = LinearRing([Coordinate(x: -4.0, y: -18.0), Coordinate(x: -4.0, y: -2.5), Coordinate(x: 10.0, y: -2.5), Coordinate(x: -4.0, y: -18.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString() {

        let geometry1 = LineString([Coordinate(x: -12.0, y: -8.0), Coordinate(x: -3.0, y: -8.0), Coordinate(x: -3.0, y: 10.0), Coordinate(x: -12.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    /// TODO: Add more tests like this one, where the linear ring and multiline string touch at a point but do not cross.
    func testLinearRing_MultiLineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = LinearRing([Coordinate(x: -7.0, y: 8.0), Coordinate(x: -3.0, y: 4.0), Coordinate(x: 1.0, y: 8.0), Coordinate(x: -7.0, y: 8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_interiorsIntersectAtTwoPointsDifferentSegmentsDifferentLineStrings() {

        let geometry1 = LinearRing([Coordinate(x: -2.0, y: 7.0), Coordinate(x: -2.0, y: -2.5), Coordinate(x: 5.0, y: -2.5), Coordinate(x: -2.0, y: 7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -2.0, y: 4.0)), Point(Coordinate(x: 1.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString1() {

        let geometry1 = LinearRing([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 4.0, y: -1.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: -1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString2() {

        let geometry1 = LinearRing([Coordinate(x: 0.0, y: -10.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 12.0, y: -3.0), Coordinate(x: 0.0, y: -10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString1() {

        let geometry1 = LinearRing([Coordinate(x: -2.0, y: 1.0), Coordinate(x: -9.0, y: 1.0), Coordinate(x: -9.0, y: -9.0), Coordinate(x: -2.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString2() {

        let geometry1 = LinearRing([Coordinate(x: -2.0, y: -10.0), Coordinate(x: -2.0, y: 1.0), Coordinate(x: 0.0, y: 1.0), Coordinate(x: -2.0, y: -10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -1.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_FirstLineString() {

        let geometry1 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: 0.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_SecondLineString() {

        let geometry1 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: -5.0, y: 1.0), Coordinate(x: 0.0, y: 1.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0)), Point(Coordinate(x: -1.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_AllBoundaryPoints() {

        let geometry1 = LinearRing([Coordinate(x: -5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: -5.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0)), Point(Coordinate(x: -1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_firstLineStringInteriorDoesNotIntersectLinearRingExterior() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_secondLineStringInteriorDoesNotIntersectLinearRingExterior() {

        let geometry1 = LinearRing([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0), Coordinate(x: -4.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_neitherLineStringInteriorIntersectsLinearRingExterior() {

        let geometry1 = LinearRing([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 0.0, y: -4.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 0.0), Coordinate(x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_secondTouchesFirstInteriorAtLineSegmentAndPoint() {

        let geometry1 = LinearRing([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0), Coordinate(x: 1.5, y: -1.5)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)]), LineString([Coordinate(x: 6.0, y: -3.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: -3.0, y: 0.0), Coordinate(x: -10.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -3.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_firstLineStringInsideLinearRing_secondLineStringBoundaryTouchesLinearRing() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 5.0, y: -9.0), Coordinate(x: 1.0, y: -9.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 3.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 5.0, y: -7.0)]), LineString([Coordinate(x: 1.0, y: -9.0), Coordinate(x: 3.0, y: -11.0), Coordinate(x: 5.0, y: -9.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 5.0, y: -9.0)), Point(Coordinate(x: 1.0, y: -9.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 3.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 5.0, y: -7.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_secondLineStringInsideLinearRing_firstLineStringBoundaryTouchesLinearRing() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 5.0, y: -9.0), Coordinate(x: 1.0, y: -9.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 3.0, y: -3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 4.0, y: 5.0), Coordinate(x: 4.0, y: -4.0)]), LineString([Coordinate(x: 1.0, y: -7.0), Coordinate(x: 1.0, y: -9.0), Coordinate(x: 3.0, y: -9.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 3.0, y: -3.0)), Point(Coordinate(x: 4.0, y: -4.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 3.0, y: -9.0), Coordinate(x: 1.0, y: -9.0), Coordinate(x: 1.0, y: -7.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap_FirstLineString() {

        let geometry1 = LinearRing([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 4.0, y: -4.0), Coordinate(x: 0.0, y: -8.0), Coordinate(x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap_SecondLineString() {

        let geometry1 = LinearRing([Coordinate(x: -1.0, y: 9.0), Coordinate(x: -1.0, y: -4.0), Coordinate(x: -5.0, y: -8.0), Coordinate(x: -1.0, y: 9.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: 4.0, y: 1.0), Coordinate(x: 4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_secondProperSubsetOfFirst() {

        let geometry1 = LinearRing([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 12.0, y: -8.0), Coordinate(x: -10.0, y: -10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 4.0, y:0.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 7.0, y: -3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 7.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_secondMostlyProperSubsetOfFirstButOneLineStringBoundaryPointNotIncluded() {

        let geometry1 = LinearRing([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 12.0, y: -8.0), Coordinate(x: -10.0, y: -10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 4.0, y:0.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 10.0, y: 10.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: -1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiLineString_secondTouchesFirstAtThreePointsAndTwoLineSegments() {

        let geometry1 = LinearRing([Coordinate(x: 20.0, y: 20.0), Coordinate(x: 20.0, y: 0.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 20.0), Coordinate(x: 20.0, y: 20.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 10.0, y: 30.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: 30.0, y: 10.0)]), LineString([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y:20.0), Coordinate(x: 14.0, y: 20.0), Coordinate(x: 14.0, y: 10.0), Coordinate(x: 20.0, y: 10.0), Coordinate(x: 20.0, y: 8.0), Coordinate(x: 10.0, y: 8.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 20.0, y: 0.0)), Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 0.0, y: 20.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 20.0, y: 10.0), Coordinate(x: 20.0, y: 8.0)]), LineString([Coordinate(x: 10.0, y: 20.0), Coordinate(x: 14.0, y: 20.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// LinearRing Polygon tests
    ///

    func testLinearRing_Polygon_noIntersection() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_withHole_noIntersection_linearRingOutsideMainPolygon() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_withHole_noIntersection_linearRingInsideHole() {

        let geometry1 = LinearRing([Coordinate(x: -7.0, y: -5.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -5.0, y: -7.0), Coordinate(x: -7.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_interiorsExteriorsIntersect1() {

        let geometry1 = LinearRing([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -1.0), Coordinate(x: 10.0, y: -4.0), Coordinate(x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 5.5, y: -2.5), Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_interiorsExteriorsIntersect2() {

        let geometry1 = LinearRing([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -7.0), Coordinate(x: 4.0, y: -10.0), Coordinate(x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 5.5, y: -5.5), Coordinate(x: 4.0, y: -4.0), Coordinate(x: 4.0, y: -7.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    /// TODO: Add more tests like this one, where the linear ring and polygon touch at a point but do not cross.
    func testLinearRing_Polygon_interiorIntersectsBoundaryAtOnePoint_linearRingFirstSegment_doNotCross() {

        let geometry1 = LinearRing([Coordinate(x: 5.5, y: 5.0), Coordinate(x: 5.5, y: -2.5), Coordinate(x: 10.0, y: -2.5), Coordinate(x: 5.5, y: 5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 5.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_interiorIntersectsBoundaryAtOnePoint_linearRingInsideHole_doNotCross() {

        let geometry1 = LinearRing([Coordinate(x: -7.0, y: -7.0), Coordinate(x: -8.0, y: -6.0), Coordinate(x: -7.0, y: -5.0), Coordinate(x: -7.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -8.0, y: -6.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingOutsideMainLinearRing() {

        let geometry1 = LinearRing([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 0.0, y: -7.0), Coordinate(x: 0.0, y: -1.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 4.0, y: -1.0)), Point(Coordinate(x: 4.0, y: -7.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingInsideHole() {

        let geometry1 = LinearRing([Coordinate(x: -8.0, y: -6.0), Coordinate(x: -4.0, y: -6.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -8.0, y: -6.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -8.0, y: -6.0)), Point(Coordinate(x: -4.0, y: -6.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingOutsideMainLinearRing() {

        let geometry1 = LinearRing([Coordinate(x: -20.0, y: -8.0), Coordinate(x: -10.0, y: -8.0), Coordinate(x: -10.0, y: -6.0), Coordinate(x: -20.0, y: -6.0), Coordinate(x: -20.0, y: -8.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -10.0, y: -8.0), Coordinate(x: -10.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingInsideHole() {

        let geometry1 = LinearRing([Coordinate(x: -7.0, y: -5.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: -5.0, y: -4.0), Coordinate(x: -7.0, y: -4.0), Coordinate(x: -7.0, y: -5.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -5.0, y: -4.0), Coordinate(x: -7.0, y: -4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_intersectsPolygonBoundaryInteriorExterior() {

        let geometry1 = LinearRing([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 10.0), Coordinate(x: 4.0, y: 10.0), Coordinate(x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 2.5, y: -2.5), Coordinate(x: 4.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole() {

        let geometry1 = LinearRing([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -7.0, y: -9.0), Coordinate(x: -9.0, y: -9.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -8.0, y: -8.0), Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -9.0), Coordinate(x: -7.0, y: -8.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes() {

        let geometry1 = LinearRing([Coordinate(x: 0.0, y: -7.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 4.0, y: 10.0), Coordinate(x: 7.0, y: 10.0), Coordinate(x: 7.0, y: -7.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 7.0, y: -4.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 4.0, y: -7.0), Coordinate(x: 4.0, y: -1.0)]), LineString([Coordinate(x: 5.5, y: -5.5), Coordinate(x: 2.5, y: -2.5)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole() {

        let geometry1 = LinearRing([Coordinate(x: -7.0, y: -7.0), Coordinate(x: 0.0, y: -14.0), Coordinate(x: 0.0, y: -6.0), Coordinate(x: -6.0, y: -6.0), Coordinate(x: -7.0, y: -7.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -6.0, y: -8.0), Coordinate(x: -4.0, y: -10.0)]), LineString([Coordinate(x: -2.0, y: -6.0), Coordinate(x: -4.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// LinearRing MultiPolygon tests
    ///

    func testLinearRing_MultiPolygon_noIntersection() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_withHoles_noIntersection_linearRingOutsideMainPolygon() {

        let geometry1 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_withHoles_noIntersection_linearRingInsideHole() {

        let geometry1 = LinearRing([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 18.0, y: -15.0), Coordinate(x: 13.0, y: -18.0), Coordinate(x: 13.0, y: -12.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_withHoles_noIntersection_multiPolygonInsideLinearRing() {

        let geometry1 = LinearRing([Coordinate(x: 100.0, y: -100.0), Coordinate(x: -100.0, y: -100.0), Coordinate(x: -100.0, y: 100.0), Coordinate(x: 100.0, y: 100.0), Coordinate(x: 100.0, y: -100.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_interiorsIntersect_firstPolygon() {

        let geometry1 = LinearRing([Coordinate(x: 4.0, y: 0.0), Coordinate(x: 0.0, y: 7.0), Coordinate(x: -7.0, y: 7.0), Coordinate(x: -7.0, y: -4.0), Coordinate(x: 0.0, y: -4.0), Coordinate(x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -2.0, y: 7.0), Coordinate(x: -7.0, y: 7.0), Coordinate(x: -7.0, y: 3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_interiorsIntersect_firstPolygon_withHole() {

        let geometry1 = LinearRing([Coordinate(x: -10.0, y: 10.0), Coordinate(x: -10.0, y: 15.0), Coordinate(x: -5.0, y: 10.0), Coordinate(x: -10.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -8.0, y: 13.0), Coordinate(x: -5.0, y: 10.0), Coordinate(x: -8.0, y: 10.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_interiorsIntersect_secondPolygon() {

        let geometry1 = LinearRing([Coordinate(x: 0.0, y: 10.0), Coordinate(x: 6.0, y: 0.0), Coordinate(x: 6.0, y: -6.0), Coordinate(x: 0.0, y: -6.0), Coordinate(x: 0.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 6.0, y: -4.0), Coordinate(x: 6.0, y: -6.0), Coordinate(x: 4.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_interiorsIntersect_secondPolygon_withHole() {

        let geometry1 = LinearRing([Coordinate(x: 15.0, y: -15.0), Coordinate(x: 12.0, y: -18.0), Coordinate(x: 18.0, y: -18.0), Coordinate(x: 15.0, y: -15.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 14.0, y: -16.0), Coordinate(x: 12.0, y: -18.0), Coordinate(x: 18.0, y: -18.0), Coordinate(x: 16.0, y: -16.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_interiorsIntersect_bothPolygons_withHoles() {

        let geometry1 = LinearRing([Coordinate(x: -3.0, y: 10.0), Coordinate(x: 0.0, y: 13.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 18.0, y: -18.0), Coordinate(x: -3.0, y: -18.0), Coordinate(x: -3.0, y: 10.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -2.0, y: 11.0), Coordinate(x: -3.0, y: 10.0), Coordinate(x: -3.0, y: 3.0)]), LineString([Coordinate(x: 2.0, y: -2.0), Coordinate(x: 12.0, y: -12.0)]), LineString([Coordinate(x: 16.0, y: -16.0), Coordinate(x: 18.0, y: -18.0), Coordinate(x: 2.0, y: -18.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles() {

        let geometry1 = LinearRing([Coordinate(x: -20.0, y: 18.0), Coordinate(x: -30.0, y: 30.0), Coordinate(x: -50.0, y: 0.0), Coordinate(x: -20.0, y: 18.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -20.0, y: 18.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles() {

        let geometry1 = LinearRing([Coordinate(x: 0.0, y: -40.0), Coordinate(x: 22.0, y: -30.0), Coordinate(x: 15.0, y: -20.0), Coordinate(x: 0.0, y: -40.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 15.0, y: -20.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles() {

        let geometry1 = LinearRing([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 0.0, y: -50.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: -18.0, y: 3.0), Coordinate(x: -18.0, y: -30.0), Coordinate(x: 20.0, y: -20.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -18.0, y: 3.0)), Point(Coordinate(x: 20.0, y: -20.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles() {

        let geometry1 = LinearRing([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 40.0), Coordinate(x: 21.0, y: 40.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 20.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles() {

        let geometry1 = LinearRing([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 12.0), Coordinate(x: -12.0, y: 12.0), Coordinate(x: -12.0, y: -6.0), Coordinate(x: 3.0, y: -21.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 20.0, y: -2.0)), Point(Coordinate(x: 2.0, y: -20.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)]), LineString([Coordinate(x: -20.0, y: 12.0), Coordinate(x: -16.0, y: 12.0)]), LineString([Coordinate(x: -12.0, y: 9.0), Coordinate(x: -12.0, y: 3.0)]), LineString([Coordinate(x: 20.0, y: -4.0), Coordinate(x: 4.0, y: -20.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testLinearRing_MultiPolygon_interiorIntersectsInteriorAndBoundary_withHoles() {

        let geometry1 = LinearRing([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 12.0), Coordinate(x: -12.0, y: 12.0), Coordinate(x: -8.0, y: 9.0), Coordinate(x: 0.0, y: 1.0), Coordinate(x: 19.0, y: -1.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 20.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)]), LineString([Coordinate(x: -20.0, y: 12.0), Coordinate(x: -16.0, y: 12.0)]), LineString([Coordinate(x: -8.0, y: 9.0), Coordinate(x: -2.0, y: 3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// MultiLineString Point tests
    ///

    func testMultiLineString_Point_noIntersection() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Point_secondSubsetOfFirstInterior() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 1.5, y: 1.5), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Point_secondSubsetOfFirstBoundary() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 3.0, y: 3.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// MultiLineString MultiPoint tests
    ///

    func testMultiLineString_MultiPoint_noIntersection() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 4.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testMultiLineString_MultiPoint_secondSubsetOfFirstInterior() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 2.5, y: 2.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 2.5, y: 2.5))])

        compare(resultGeometry, expected)
    }

    func testMultiLineString_MultiPoint_secondProperSubsetOfFirstBoundary() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testMultiLineString_MultiPoint_secondImproperSubsetOfFirstBoundary() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndBoundary() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.8, y: 1.8))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.8, y: 1.8))])

        compare(resultGeometry, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndCoversBoundary() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 3.0, y: 1.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.5, y: 1.5)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 3.0, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndExterior() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 2.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstBoundaryAndExterior() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 4.0), Coordinate(x: 2.0, y: 4.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 5.0, y: 5.0)), Point(Coordinate(x: 2.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 4.0))])

        compare(resultGeometry, expected)
    }

    func testMultiLineString_MultiPoint_secondCoversFirstBoundaryAndTouchesExterior() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 10.0, y: 0.0), Coordinate(x: 0.0, y: 10.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 3.0, y: 3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 2.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 10.0, y: 0.0)), Point(Coordinate(x: 0.0, y: 10.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 3.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 10.0, y: 0.0)), Point(Coordinate(x: 0.0, y: 10.0))])

        compare(resultGeometry, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndBoundaryAndExterior() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 4.0), Coordinate(x: 2.0, y: 4.0)]), LineString([Coordinate(x: 1.0, y: 5.0), Coordinate(x: 3.0, y: 5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 1.5, y: 4.0)), Point(Coordinate(x: 1.0, y: 5.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 1.5, y: 4.0)), Point(Coordinate(x: 1.0, y: 5.0))])

        compare(resultGeometry, expected)
    }

    func testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndExteriorAndCoversBoundary() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 6.0)]), LineString([Coordinate(x: 3.0, y: 2.0), Coordinate(x: 3.0, y: 7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 6.0)), Point(Coordinate(x: 3.0, y: 7.0)), Point(Coordinate(x: 1.0, y: 1.5)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: 6.0)), Point(Coordinate(x: 3.0, y: 7.0)), Point(Coordinate(x: 1.0, y: 1.5))])

        compare(resultGeometry, expected)
    }

    ///
    /// MultiLineString LineString tests
    ///

    func testMultiLineString_LineString_noIntersection() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -1.5), Coordinate(x: 10.0, y: -1.5), Coordinate(x: 10.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.5, y: -1.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: 2.0), Coordinate(x: -3.0, y: 2.0), Coordinate(x: -3.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 2.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -2.5), Coordinate(x: 10.0, y: -2.5)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -12.0, y: -8.0), Coordinate(x: -3.0, y: -8.0), Coordinate(x: -3.0, y: 10.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    /// TODO: Add more tests like this one, where the line strings touch at a point but do not cross.
    func testMultiLineString_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -7.0, y: 8.0), Coordinate(x: -3.0, y: 4.0), Coordinate(x: 1.0, y: 8.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -2.0, y: 7.0), Coordinate(x: -2.0, y: -2.5), Coordinate(x: 5.0, y: -2.5)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -2.0, y: 4.0)), Point(Coordinate(x: 1.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundaryFirstLineString1() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 4.0, y: -1.0), Coordinate(x: 10.0, y: -6.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundaryFirstLineString2() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 0.0, y: -10.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 12.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundarySecondLineString1() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -2.0, y: 1.0), Coordinate(x: -9.0, y: 1.0), Coordinate(x: -9.0, y: -9.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundarySecondLineString2() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -2.0, y: -10.0), Coordinate(x: -2.0, y: 1.0), Coordinate(x: 0.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -1.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: -5.0, y: 1.0), Coordinate(x: 0.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0)), Point(Coordinate(x: -1.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0)), Point(Coordinate(x: -1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_FirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_SecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesFirstBoundaryPointOfSecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -2.0, y: 4.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -2.0, y: 4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesSecondBoundaryPointOfFirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesNeitherBoundaryPoint_FirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.5, y: -2.5)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.5, y: -2.5)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesNeitherBoundaryPoint_SecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -3.0, y: 4.0), Coordinate(x: -2.0, y: 4.0), Coordinate(x: -1.5, y: 4.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -3.0, y: 4.0), Coordinate(x: -1.5, y: 4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 4.0, y: -4.0), Coordinate(x: 4.0, y: -8.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -1.0, y: 9.0), Coordinate(x: -1.0, y: -4.0), Coordinate(x: -5.0, y: -8.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LineString_firstProperSubsetOfSecond() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 4.0, y:0.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 7.0, y: -3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 12.0, y: -8.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 7.0, y: -3.0)])], precision: precision, coordinateSystem: cs))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// MultiLineString LinearRing tests
    ///

    func testMultiLineString_LinearRing_noIntersection() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected, "For \(resultGeometry) and \(expected) expected no intersection")
    }

    func testMultiLineString_LinearRing_interiorsIntersectAtOnePointFirstSegmentsFirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 2.0, y: 2.0), Coordinate(x: 0.0, y: 2.0), Coordinate(x: 0.0, y: 13.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 5.0), Coordinate(x: 5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: 2.0))]))

        XCTAssertEqual(resultGeometry, expected)

//        compareTopo(geometry1, geometry2, resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_interiorsIntersectAtOnePointFirstSegmentsSecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -5.0, y: 2.0), Coordinate(x: -3.0, y: 2.0), Coordinate(x: -3.0, y: -3.0), Coordinate(x: -5.0, y: 2.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 2.0))]))

        XCTAssertEqual(resultGeometry, expected)

//        compareTopo(resultGeometry, expected, "Coordinate(x: -4.0, y: 2.0)")
    }

    func testMultiLineString_LinearRing_interiorsIntersectAtOnePointSecondSegmentsFirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -4.0, y: -18.0), Coordinate(x: -4.0, y: -2.5), Coordinate(x: 10.0, y: -2.5), Coordinate(x: -4.0, y: -18.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected)

//        compareTopo(resultGeometry, expected, "Coordinate(x: 1.5, y: -2.5)")
    }

    func testMultiLineString_LinearRing_interiorsIntersectAtOnePointSecondSegmentsSecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -12.0, y: -8.0), Coordinate(x: -3.0, y: -8.0), Coordinate(x: -3.0, y: 10.0), Coordinate(x: -12.0, y: -8.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    /// TODO: Add more tests like this one, where the linear ring and multiline string touch at a point but do not cross.
    func testMultiLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -7.0, y: 8.0), Coordinate(x: -3.0, y: 4.0), Coordinate(x: 1.0, y: 8.0), Coordinate(x: -7.0, y: 8.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_interiorsIntersectAtTwoPointsDifferentSegmentsDifferentLineStrings() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -2.0, y: 7.0), Coordinate(x: -2.0, y: -2.5), Coordinate(x: 5.0, y: -2.5), Coordinate(x: -2.0, y: 7.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -2.0, y: 4.0)), Point(Coordinate(x: 1.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundaryFirstLineString1() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 4.0, y: -1.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: -1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundaryFirstLineString2() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 0.0, y: -10.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 12.0, y: -3.0), Coordinate(x: 0.0, y: -10.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundarySecondLineString1() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -2.0, y: 1.0), Coordinate(x: -9.0, y: 1.0), Coordinate(x: -9.0, y: -9.0), Coordinate(x: -2.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundarySecondLineString2() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -2.0, y: -10.0), Coordinate(x: -2.0, y: 1.0), Coordinate(x: 0.0, y: 1.0), Coordinate(x: -2.0, y: -10.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -1.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: 0.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -5.0, y: -5.0), Coordinate(x: -5.0, y: 1.0), Coordinate(x: 0.0, y: 1.0), Coordinate(x: -5.0, y: -5.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0)), Point(Coordinate(x: -1.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: -5.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0)), Point(Coordinate(x: -1.0, y: 1.0)), Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_firstLineStringInteriorDoesNotIntersectLinearRingExterior() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_secondLineStringInteriorDoesNotIntersectLinearRingExterior() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0), Coordinate(x: -4.0, y: 1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_neitherLineStringInteriorIntersectsLinearRingExterior() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 0.0, y: -4.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 0.0), Coordinate(x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_firstTouchesSecondInteriorAtLineSegmentAndPoint() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)]), LineString([Coordinate(x: 6.0, y: -3.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: -3.0, y: 0.0), Coordinate(x: -10.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0), Coordinate(x: 1.5, y: -1.5)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -3.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_firstLineStringInsideLinearRing_secondLineStringBoundaryTouchesLinearRing() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 3.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 5.0, y: -7.0)]), LineString([Coordinate(x: 1.0, y: -9.0), Coordinate(x: 3.0, y: -11.0), Coordinate(x: 5.0, y: -9.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 5.0, y: -9.0), Coordinate(x: 1.0, y: -9.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 5.0, y: -9.0)), Point(Coordinate(x: 1.0, y: -9.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 3.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 5.0, y: -7.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_secondLineStringInsideLinearRing_firstLineStringBoundaryTouchesLinearRing() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 3.0, y: -3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 4.0, y: 5.0), Coordinate(x: 4.0, y: -4.0)]), LineString([Coordinate(x: 1.0, y: -7.0), Coordinate(x: 1.0, y: -9.0), Coordinate(x: 3.0, y: -9.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 5.0, y: -9.0), Coordinate(x: 1.0, y: -9.0), Coordinate(x: 1.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 3.0, y: -3.0)), Point(Coordinate(x: 4.0, y: -4.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 3.0, y: -9.0), Coordinate(x: 1.0, y: -9.0), Coordinate(x: 1.0, y: -7.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 4.0, y: -4.0), Coordinate(x: 0.0, y: -8.0), Coordinate(x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -1.0, y: 9.0), Coordinate(x: -1.0, y: -4.0), Coordinate(x: -7.0, y: -1.0), Coordinate(x: -1.0, y: 9.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 4.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_firstProperSubsetOfSecond() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 4.0, y:0.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 7.0, y: -3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 12.0, y: -8.0), Coordinate(x: -10.0, y: -10.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 7.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_LinearRing_firstMostlyProperSubsetOfSecondButOneLineStringBoundaryPointNotIncluded() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 4.0, y:0.0), Coordinate(x: 5.0, y: -1.0), Coordinate(x: 10.0, y: 10.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = LinearRing([Coordinate(x: -10.0, y: -10.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 12.0, y: -8.0), Coordinate(x: -10.0, y: -10.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: -1.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// MultiLineString MultiLineString tests
    ///

    func testMultiLineString_MultiLineString_noIntersection() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -1.0, y: -3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been no intersection but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -5.0, y: -1.5), Coordinate(x: 10.0, y: -1.5), Coordinate(x: 10.0, y: -3.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.5, y: -1.5))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint1() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -5.0, y: 2.0), Coordinate(x: -3.0, y: 2.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 2.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint2() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -2.5), Coordinate(x: 10.0, y: -2.5)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint3() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -12.0, y: -8.0), Coordinate(x: -3.0, y: -8.0), Coordinate(x: -3.0, y: 10.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    /// TODO: Add more tests like this one, where the line strings touch at a point but do not cross.
    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint_DoNotCross_firstInteriorEndpointTouchesSecondInteriorPoint() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -7.0, y: 8.0), Coordinate(x: -3.0, y: 4.0), Coordinate(x: 1.0, y: 8.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -3.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint_DoNotCross_firstInteriorEndpointTouchesSecondInteriorEndpoint() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: 7.0, y: 8.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -10.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 2.0, y: -2.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings_interiorPoints() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -2.0, y: 7.0), Coordinate(x: -2.0, y: -2.5), Coordinate(x: 5.0, y: -2.5)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.5, y: -2.5)), Point(Coordinate(x: -2.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings_endpoints() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 2.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)]), LineString([Coordinate(x: -4.0, y: 7.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -15.0, y: 4.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 2.0, y: -2.0)), Point(Coordinate(x: -4.0, y: 4.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundaryFirstLineString1() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -1.0, y: -1.0), Coordinate(x: 4.0, y: -1.0), Coordinate(x: 10.0, y: -6.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundaryFirstLineString2() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: 0.0, y: -10.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 12.0, y: -3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundarySecondLineString1() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -2.0, y: 1.0), Coordinate(x: -9.0, y: 1.0), Coordinate(x: -9.0, y: -9.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundarySecondLineString2() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -2.0, y: -10.0), Coordinate(x: -2.0, y: 1.0), Coordinate(x: 0.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -1.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: 1.0, y: -5.0), Coordinate(x: 1.0, y: 0.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 1.0, y: -3.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -5.0, y: -5.0), Coordinate(x: -5.0, y: 1.0), Coordinate(x: 0.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: 1.0)), Point(Coordinate(x: -1.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 11.0, y: 1.0), Coordinate(x: 12.0, y: 2.0), Coordinate(x: 11.0, y: 3.0)]), LineString([Coordinate(x: -5.0, y: 1.0), Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: -5.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 1.0, y: -3.0)), Point(Coordinate(x: -4.0, y: 1.0)), Point(Coordinate(x: -1.0, y: 1.0))]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_SameOrder() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_DifferentOrder() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)]), LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_firstSubsetOfSecond() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_secondSubsetOfFirst() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 2.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 2.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 2.0)])]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExteriorOrBoundary_firstSubsetOfSecond() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.5, y: -2.5)]), LineString([Coordinate(x: -4.0, y: 2.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.5, y: -2.5)]), LineString([Coordinate(x: -4.0, y: 2.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 2.0)])]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExteriorOrBoundary_secondSubsetOfFirst() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.5, y: -2.5)]), LineString([Coordinate(x: -4.0, y: 2.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.5, y: -2.5)]), LineString([Coordinate(x: -4.0, y: 2.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 2.0)])]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineStrings() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 2.0, y: -1.0), Coordinate(x: 0.0, y: -1.0)]), LineString([Coordinate(x: -4.0, y: -2.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -1.0, y: -4.0), Coordinate(x: -1.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 1.0, y: -1.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: 1.5, y: -1.5), Coordinate(x: 2.0, y: -2.0)])]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineStrings() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 1.0, y: -3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 10.0, y: -1.5), Coordinate(x: 12.0, y: -2.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 10.0, y: -1.0)]), LineString([Coordinate(x: -4.0, y: 2.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 0.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -4.0, y: 2.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_firstProperSubsetOfSecond() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 4.0), Coordinate(x: 5.0, y: 4.0), Coordinate(x: 5.0, y: -3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: -30.0, y: -30.0), Coordinate(x: -30.0, y: -2.0), Coordinate(x: -20.0, y: -2.0), Coordinate(x: -20.0, y: -20.0), Coordinate(x: -2.0, y: -2.0)]), LineString([Coordinate(x: 1.0, y: 0.0), Coordinate(x: 1.0, y: 4.0), Coordinate(x: 5.0, y: 4.0), Coordinate(x: 5.0, y: -30.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -3.0, y: -3.0)]), LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 1.0, y: 4.0), Coordinate(x: 5.0, y: 4.0), Coordinate(x: 5.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    func testMultiLineString_MultiLineString_secondProperSubsetOfFirst() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 20.0, y: 10.0), Coordinate(x: 0.0, y: 10.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 20.0, y: 0.0)]), LineString([Coordinate(x: 0.0, y: -10.0), Coordinate(x: 0.0, y: -40.0), Coordinate(x: -40.0, y: -40.0), Coordinate(x: -40.0, y: -10.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiLineString([LineString([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 0.0, y: 10.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 10.0, y: 0.0)]), LineString([Coordinate(x: 0.0, y: -20.0), Coordinate(x: 0.0, y: -40.0), Coordinate(x: -40.0, y: -40.0), Coordinate(x: -40.0, y: -20.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 0.0, y: 10.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 10.0, y: 0.0)]), LineString([Coordinate(x: 0.0, y: -20.0), Coordinate(x: 0.0, y: -40.0), Coordinate(x: -40.0, y: -40.0), Coordinate(x: -40.0, y: -20.0)])], precision: precision, coordinateSystem: cs))

        XCTAssertEqual(resultGeometry, expected, "The intersection of \(geometry1) and \(geometry2) should have been \(expected) but instead returned \(resultGeometry).")
    }

    ///
    /// MultiLineString Polygon tests
    ///

    func testMultiLineString_Polygon_noIntersection() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_withHole_noIntersection_multiLineStringOutsideMainPolygon() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_withHole_noIntersection_multiLineStringInsideHole() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -7.0, y: -5.0), Coordinate(x: -6.0, y: -6.0), Coordinate(x: -7.0, y: -7.0)]), LineString([Coordinate(x: -6.0, y: -5.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -6.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_withHoles_noIntersection_multiLineStringInsideTwoHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -30.0, y: -70.0), Coordinate(x: -25.0, y: -75.0), Coordinate(x: -30.0, y: -80.0)]), LineString([Coordinate(x: -80.0, y: -20.0), Coordinate(x: -70.0, y: -30.0), Coordinate(x: -60.0, y: -20.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: -100.0), Coordinate(x: -100.0, y: -100.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: 0.0, y: 0.0)], innerRings: [[Coordinate(x: -90.0, y: -10.0), Coordinate(x: -90.0, y: -50.0), Coordinate(x: -50.0, y: -50.0), Coordinate(x: -50.0, y: -10.0), Coordinate(x: -90.0, y: -10.0)], [Coordinate(x: -40.0, y: -60.0), Coordinate(x: -40.0, y: -90.0), Coordinate(x: -10.0, y: -90.0), Coordinate(x: -10.0, y: -60.0), Coordinate(x: -40.0, y: -60.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideMainLinearRing() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -30.0, y: -70.0), Coordinate(x: -25.0, y: -75.0), Coordinate(x: -30.0, y: -80.0)]), LineString([Coordinate(x: -80.0, y: -20.0), Coordinate(x: -70.0, y: -30.0), Coordinate(x: -60.0, y: -20.0)]), LineString([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 10.0, y: 30.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: -100.0), Coordinate(x: -100.0, y: -100.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: 0.0, y: 0.0)], innerRings: [[Coordinate(x: -90.0, y: -10.0), Coordinate(x: -90.0, y: -50.0), Coordinate(x: -50.0, y: -50.0), Coordinate(x: -50.0, y: -10.0), Coordinate(x: -90.0, y: -10.0)], [Coordinate(x: -40.0, y: -60.0), Coordinate(x: -40.0, y: -90.0), Coordinate(x: -10.0, y: -90.0), Coordinate(x: -10.0, y: -60.0), Coordinate(x: -40.0, y: -60.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_interiorsIntersect_firstLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 4.0, y: 4.0), Coordinate(x: 8.0, y: 0.0), Coordinate(x: 4.0, y: -4.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 5.5, y: -2.5), Coordinate(x: 4.0, y: -4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_interiorsIntersect_secondLineString() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 4.0, y: 4.0), Coordinate(x: 8.0, y: 8.0), Coordinate(x: 4.0, y: 12.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: -4.0), Coordinate(x: 4.0, y: -4.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -4.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    /// TODO: Add more tests like this one, where the multi line string and polygon touch at a point but do not cross.
    func testMultiLineString_Polygon_firstInteriorIntersectsSecondBoundaryAtOnePoint_firstLineString_doNotCross() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 5.5, y: 5.0), Coordinate(x: 5.5, y: -2.5), Coordinate(x: 10.0, y: -2.5)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 5.5, y: -2.5))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_firstInteriorIntersectsSecondBoundaryAtOnePoint_lineStringInsideHole_doNotCross() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -6.0, y: -7.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -6.0, y: -5.0)]), LineString([Coordinate(x: -7.0, y: -7.0), Coordinate(x: -8.0, y: -6.0), Coordinate(x: -7.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -8.0, y: -6.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtOnePoint_doNotCross_multiLineStringOutsideMainLinearRing() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 5.5, y: 5.0), Coordinate(x: 5.5, y: 0.0), Coordinate(x: 10.0, y: 0.0)]), LineString([Coordinate(x: 12.0, y: 10.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 4.0, y: -7.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtTwoPoints_doNotCross_multiLineStringOutsideMainLinearRing() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 5.5, y: 5.0), Coordinate(x: 5.5, y: 0.0), Coordinate(x: 10.0, y: 0.0)]), LineString([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 4.0, y: -1.0)), Point(Coordinate(x: 4.0, y: -7.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtThreePoints_doNotCross_multiLineStringOutsideMainLinearRing() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 2.5, y: 5.0), Coordinate(x: -5.5, y: 5.0), Coordinate(x: -5.5, y: -5.5), Coordinate(x: 2.5, y: -5.5)]), LineString([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 2.5, y: -5.5)), Point(Coordinate(x: 4.0, y: -1.0)), Point(Coordinate(x: 4.0, y: -7.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtFourPoints_doNotCross_multiLineStringOutsideMainLinearRing() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 2.5, y: -2.5), Coordinate(x: -5.5, y: -2.5), Coordinate(x: -5.5, y: -5.5), Coordinate(x: 2.5, y: -5.5)]), LineString([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 2.5, y: -2.5)), Point(Coordinate(x: 2.5, y: -5.5)), Point(Coordinate(x: 4.0, y: -1.0)), Point(Coordinate(x: 4.0, y: -7.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtOnePoint_doNotCross_multiLineStringInsideHole() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -5.0, y: -7.0), Coordinate(x: -6.0, y: -6.0), Coordinate(x: -6.0, y: -5.0)]), LineString([Coordinate(x: -4.0, y: -7.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -5.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: -7.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtTwoPoints_doNotCross_multiLineStringInsideHole() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -5.0, y: -7.0), Coordinate(x: -6.0, y: -6.0), Coordinate(x: -6.0, y: -5.0)]), LineString([Coordinate(x: -4.0, y: -7.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -4.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -4.0, y: -7.0)), Point(Coordinate(x: -4.0, y: -5.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtThreePoints_doNotCross_multiLineStringInsideHole() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -6.0, y: -8.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -6.0, y: -5.0)]), LineString([Coordinate(x: -4.0, y: -7.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -4.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -6.0, y: -8.0)), Point(Coordinate(x: -4.0, y: -7.0)), Point(Coordinate(x: -4.0, y: -5.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtFourPoints_doNotCross_multiLineStringInsideHole() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -6.0, y: -8.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -6.0, y: -4.0)]), LineString([Coordinate(x: -4.0, y: -7.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -4.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -6.0, y: -8.0)), Point(Coordinate(x: -6.0, y: -4.0)), Point(Coordinate(x: -4.0, y: -7.0)), Point(Coordinate(x: -4.0, y: -5.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorExterior() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -6.0, y: -8.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -6.0, y: -4.0)]), LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 10.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 2.5, y: -2.5)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -6.0, y: -6.0)]), LineString([Coordinate(x: -6.0, y: -7.0), Coordinate(x: -6.0, y: -7.5), Coordinate(x: -6.5, y: -7.5)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -8.0, y: -8.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -9.0, y: -5.0)]), LineString([Coordinate(x: -4.0, y: -6.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 10.0, y: -4.0), Coordinate(x: 0.0, y: -4.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 12.0, y: -3.0), Coordinate(x: 12.0, y: 5.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 5.0, y: -6.0), Coordinate(x: 3.0, y: -6.0)]), LineString([Coordinate(x: 7.0, y: -4.0), Coordinate(x: 1.0, y: -4.0)]), LineString([Coordinate(x: 6.0, y: -3.0), Coordinate(x: 2.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -7.0, y: -7.0), Coordinate(x: 0.0, y: -14.0), Coordinate(x: 0.0, y: -6.0), Coordinate(x: -6.0, y: -6.0)]), LineString([Coordinate(x: 8.0, y: 0.0), Coordinate(x: 8.0, y: -12.0), Coordinate(x: -10.0, y: 6.0), Coordinate(x: 10.0, y: 26.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -2.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -6.0, y: -8.0), Coordinate(x: -4.0, y: -10.0)]), LineString([Coordinate(x: -2.0, y: -6.0), Coordinate(x: -4.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// MultiLineString MultiPolygon tests
    ///

    func testMultiLineString_MultiPolygon_noIntersection() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -20.0), Coordinate(x: -20.0, y: -20.0), Coordinate(x: -20.0, y: -10.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringOutsideMainPolygon() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -20.0), Coordinate(x: -20.0, y: -20.0), Coordinate(x: -20.0, y: -10.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideOneHole() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 15.0, y: -14.0), Coordinate(x: 18.0, y: -12.0)]), LineString([Coordinate(x: 13.0, y: -18.0), Coordinate(x: 15.0, y: -16.0), Coordinate(x: 18.0, y: -18.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 15.0, y: -14.0), Coordinate(x: 18.0, y: -12.0)]), LineString([Coordinate(x: 8.0, y: -17.0), Coordinate(x: 8.0, y: -16.0), Coordinate(x: 9.0, y: -16.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHolesInTwoDifferentPolygonsAndOutsideAllPolygons() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -8.0, y: 10.5), Coordinate(x: -7.5, y: 11.0), Coordinate(x: -8.0, y: 11.5)]), LineString([Coordinate(x: 8.0, y: -17.0), Coordinate(x: 8.0, y: -16.0), Coordinate(x: 9.0, y: -16.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideAllPolygons() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 15.0, y: -14.0), Coordinate(x: 18.0, y: -12.0)]), LineString([Coordinate(x: 8.0, y: -17.0), Coordinate(x: 8.0, y: -16.0), Coordinate(x: 9.0, y: -16.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_firstPolygon() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 13.0, y: 12.0), Coordinate(x: 15.0, y: 14.0), Coordinate(x: 18.0, y: 12.0)]), LineString([Coordinate(x: 4.0, y: 0.0), Coordinate(x: 0.0, y: 7.0), Coordinate(x: -5.0, y: 2.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -4.0, y: 3.0), Coordinate(x: -2.0, y: 5.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_firstPolygon_withHole() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: -10.0, y: 10.0), Coordinate(x: -10.0, y: 12.0), Coordinate(x: -5.0, y: 7.0)]), LineString([Coordinate(x: 10.0, y: 20.0), Coordinate(x: 15.0, y: 30.0), Coordinate(x: 10.0, y: 40.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -8.0, y: 10.0), Coordinate(x: -5.0, y: 7.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_secondPolygon() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 0.0, y: 10.0), Coordinate(x: 6.0, y: 0.0), Coordinate(x: 6.0, y: -6.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: 10.0, y: 20.0), Coordinate(x: 15.0, y: 30.0), Coordinate(x: 10.0, y: 40.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 6.0, y: -4.0), Coordinate(x: 6.0, y: -6.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_secondPolygon_withHole() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 10.0, y: 20.0), Coordinate(x: 15.0, y: 30.0), Coordinate(x: 10.0, y: 40.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: 14.0, y: -15.0), Coordinate(x: 14.0, y: -18.0), Coordinate(x: 18.0, y: -18.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 14.0, y: -16.0), Coordinate(x: 14.0, y: -18.0), Coordinate(x: 18.0, y: -18.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 10.0, y: 20.0), Coordinate(x: 15.0, y: 30.0), Coordinate(x: 10.0, y: 40.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: -3.0, y: 10.0), Coordinate(x: 0.0, y: 13.0), Coordinate(x: 16.0, y: -3.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: -3.0, y: 10.0), Coordinate(x: -2.0, y: 11.0)]), LineString([Coordinate(x: 15.0, y: -2.0), Coordinate(x: 16.0, y: -3.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles_differentLineStrings() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 40.0, y: -40.0), Coordinate(x: 1.0, y: -79.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: -3.0, y: 10.0), Coordinate(x: 0.0, y: 13.0), Coordinate(x: -3.0, y: 16.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiLineString([LineString([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 16.0, y: -16.0)]), LineString([Coordinate(x: 12.0, y: -12.0), Coordinate(x: 2.0, y: -2.0)]), LineString([Coordinate(x: -3.0, y: 10.0), Coordinate(x: -2.0, y: 11.0)]), LineString([Coordinate(x: -2.0, y: 15.0), Coordinate(x: -3.0, y: 16.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_boundariesIntersect_firstPolygon_withHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: -20.0, y: 18.0), Coordinate(x: -30.0, y: 30.0), Coordinate(x: -50.0, y: 0.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -20.0, y: 18.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_boundariesIntersect_secondPolygon_withHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 0.0, y: -40.0), Coordinate(x: 22.0, y: -30.0), Coordinate(x: 15.0, y: -20.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 15.0, y: -20.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_boundariesIntersect_bothPolygons_withHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 0.0, y: -50.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: -18.0, y: 3.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -18.0, y: 3.0)), Point(Coordinate(x: 20.0, y: -20.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_boundariesIntersectAtAllFourBoundaryPoints_bothPolygons_withHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 0.0, y: -50.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: -20.0, y: 3.0)]), LineString([Coordinate(x: -16.0, y: 20.0), Coordinate(x: -16.0, y: 30.0), Coordinate(x: 16.0, y: 30.0), Coordinate(x: 16.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -20.0, y: 3.0)), Point(Coordinate(x: 20.0, y: -20.0)), Point(Coordinate(x: -16.0, y: 20.0)), Point(Coordinate(x: 16.0, y: -2.0))]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 13.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 20.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 12.0), Coordinate(x: -12.0, y: 12.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 20.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)]), LineString([Coordinate(x: -20.0, y: 12.0), Coordinate(x: -16.0, y: 12.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_interiorsIntersectAndBoundariesIntersect_withHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 12.0), Coordinate(x: -11.0, y: 12.0), Coordinate(x: -8.0, y: 9.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -8.0, y: 9.0)), Point(Coordinate(x: 20.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)]), LineString([Coordinate(x: -20.0, y: 12.0), Coordinate(x: -16.0, y: 12.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_boundaryIntersectsInteriorAndBoundary_withHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 12.0), Coordinate(x: -10.0, y: 12.0), Coordinate(x: -7.0, y: 9.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: 20.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)]), LineString([Coordinate(x: -20.0, y: 12.0), Coordinate(x: -16.0, y: 12.0)]), LineString([Coordinate(x: -8.0, y: 10.0), Coordinate(x: -7.0, y: 9.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    func testMultiLineString_MultiPolygon_boundaryIntersectsInteriorAndBoundaryAtAllFourBoundaryPoints_withHoles() {

        let geometry1 = MultiLineString([LineString([Coordinate(x: -20.0, y: 4.0), Coordinate(x: -40.0, y: 4.0), Coordinate(x: -40.0, y: -50.0), Coordinate(x: 6.0, y: -50.0), Coordinate(x: 6.0, y: -20.0)]), LineString([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 12.0), Coordinate(x: -11.0, y: 12.0), Coordinate(x: -8.0, y: 9.0)])], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        var expected  = GeometryCollection()
        expected.append(MultiPoint([Point(Coordinate(x: -20.0, y: 4.0)), Point(Coordinate(x: 6.0, y: -20.0)), Point(Coordinate(x: -8.0, y: 9.0)), Point(Coordinate(x: 20.0, y: -2.0))]))
        expected.append(MultiLineString([LineString([Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0)]), LineString([Coordinate(x: -20.0, y: 12.0), Coordinate(x: -16.0, y: 12.0)])]))

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// Polygon Point tests
    ///

    func testPolygon_Point_outerRingOnly_noIntersection() {

        let geometry1 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPolygon_Point_outerRingAndInnerRing_outsideMainRing_noIntersection() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: -20.0, y: -20.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPolygon_Point_outerRingAndInnerRing_insideInnerRing_noIntersection() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: -3.0, y: 0.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 3.0, y: 0.0), Coordinate(x: 0.0, y: 3.0), Coordinate(x: -3.0, y: 0.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? GeometryCollection else {
            return XCTFail()
        }

        let expected  = GeometryCollection()

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPolygon_Point_outerRingOnly_intersectsBoundary() {

        let geometry1 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 2.0, y: 2.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPolygon_Point_outerRingAndInnerRing_intersectsOuterBoundary() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: -10.0, y: 5.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPolygon_Point_outerRingAndInnerRing_intersectsInnerBoundary() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 4.0, y: 4.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPolygon_Point_outerRingOnly_intersectsInterior() {

        let geometry1 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: 2.5, y: 2.5), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    func testPolygon_Point_outerRingAndInnerRing_intersectsInterior() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = Point(Coordinate(x: -1.0, y: 4.0), precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? Point else {
            return XCTFail()
        }

        let expected  = geometry2

        XCTAssertEqual(resultGeometry, expected)
    }

    ///
    /// Polygon MultiPoint tests
    ///

    func testPolygon_MultiPoint_outerRingOnly_noIntersection() {

        let geometry1 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 10.0, y: 2.0)), Point(Coordinate(x: 0.5, y: 4.0)), Point(Coordinate(x: 1.0, y: 5.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_outsideMainRing_noIntersection() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 11.0, y: 2.0)), Point(Coordinate(x: 0.5, y: 14.0)), Point(Coordinate(x: -11.0, y: -5.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_insideInnerRing_noIntersection() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: -3.0, y: 0.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 3.0, y: 0.0), Coordinate(x: 0.0, y: 3.0), Coordinate(x: -3.0, y: 0.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 1.0, y: 1.0)), Point(Coordinate(x: -0.5, y: 0.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 11.0, y: 11.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -5.0, y: -3.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingOnly_intersectsBoundaryOnly() {

        let geometry1 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 2.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 2.0, y: 4.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterBoundaryOnly() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -10.0, y: 3.4)), Point(Coordinate(x: 2.5, y: -10.0)), Point(Coordinate(x: 10.0, y: 10.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -10.0, y: 3.4)), Point(Coordinate(x: 2.5, y: -10.0)), Point(Coordinate(x: 10.0, y: 10.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInnerBoundaryOnly() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 4.0, y: 4.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 4.0, y: 4.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 4.0, y: -10.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: 4.0, y: -10.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 10.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 4.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 10.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 4.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingOnly_intersectsInteriorOnly() {

        let geometry1 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 3.0)), Point(Coordinate(x: 3.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 2.2))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 3.0)), Point(Coordinate(x: 3.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 2.2))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorOnly() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 6.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 0.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 6.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 0.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorOnly() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -8.0, y: -8.0)), Point(Coordinate(x: 6.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 0.0)), Point(Coordinate(x: -0.5, y: 1.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -8.0, y: -8.0)), Point(Coordinate(x: 6.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 0.0)), Point(Coordinate(x: -0.5, y: 1.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundary() {

        let geometry1 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 4.5, y: 2.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 4.5, y: 2.5))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -10.0, y: 3.4)), Point(Coordinate(x: 2.5, y: 0.0)), Point(Coordinate(x: 5.0, y: 10.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -10.0, y: 3.4)), Point(Coordinate(x: 2.5, y: 0.0)), Point(Coordinate(x: 5.0, y: 10.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -9.0, y: -9.0)), Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: -9.0)), Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 8.0, y: 7.0)), Point(Coordinate(x: 4.0, y: -10.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 8.0, y: 7.0)), Point(Coordinate(x: 4.0, y: -10.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 10.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 4.0)), Point(Coordinate(x: -1.0, y: -0.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -2.0, y: -3.0)), Point(Coordinate(x: 10.0, y: 2.5)), Point(Coordinate(x: 4.0, y: 4.0)), Point(Coordinate(x: -1.0, y: -0.5))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndExterior() {

        let geometry1 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -2.0, y: -2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.5, y: 2.5))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -9.0, y: 3.4)), Point(Coordinate(x: 12.5, y: 0.0)), Point(Coordinate(x: 5.0, y: -8.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: 3.4)), Point(Coordinate(x: 5.0, y: -8.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 2.5, y: 2.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -4.0, y: -2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -5.0, y: -11.0)), Point(Coordinate(x: -1.0, y: -0.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -1.0, y: -0.5))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingOnly_intersectsBoundaryAndExterior() {

        let geometry1 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: 12.5, y: 0.0)), Point(Coordinate(x: 5.0, y: -10.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: 5.0, y: -10.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 10.0, y: 9.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 10.0, y: 9.0)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -6.0, y: -2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -5.0, y: -3.0)), Point(Coordinate(x: 3.0, y: 5.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -6.0, y: -2.0)), Point(Coordinate(x: 3.0, y: 5.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundaryAndExterior() {

        let geometry1 = Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 2.0, y: 2.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: 12.5, y: 0.0)), Point(Coordinate(x: -8.0, y: -8.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: -8.0, y: -8.0))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: 10.0, y: 9.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 7.0, y: 4.3)), Point(Coordinate(x: 2.0, y: 12.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: 10.0, y: 9.0)), Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 7.0, y: 4.3))])

        compare(resultGeometry, expected)
    }

    func testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings() {

        let geometry1 = Polygon([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -10.0, y: -10.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -6.0, y: -1.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -2.0, y: -5.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -6.0, y: -1.0)]], precision: precision, coordinateSystem: cs)
        let geometry2 = MultiPoint([Point(Coordinate(x: -6.0, y: -2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -5.0, y: -3.0)), Point(Coordinate(x: 3.0, y: 5.0)), Point(Coordinate(x: 1.0, y: -1.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 13.0, y: -5.0))], precision: precision, coordinateSystem: cs)

        guard let resultGeometry = intersection(geometry1, geometry2) as? MultiPoint else {
            return XCTFail()
        }

        let expected = MultiPoint([Point(Coordinate(x: -6.0, y: -2.0)), Point(Coordinate(x: 3.0, y: 5.0)), Point(Coordinate(x: 1.0, y: -1.0))])

        compare(resultGeometry, expected)
    }

//    ///
//    /// Polygon LineString tests
//    ///
//
//    func testPolygon_LineString_noIntersection() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_withHole_noIntersection_lineStringOutsideMainPolygon() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_withHole_noIntersection_lineStringInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: -7.0, y: -5.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -5.0, y: -7.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_interiorsIntersect_lineStringFirstSegment() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -1.0), Coordinate(x: 12.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_interiorsIntersect_lineStringSecondSegment() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -7.0), Coordinate(x: 12.0, y: -7.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    /// TODO: Add more tests like this one, where the line string and polygon touch at a point but do not cross.
//    func testPolygon_LineString_interiorIntersectsBoundaryAtOnePoint_lineStringFirstSegment_doNotCross() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 5.5, y: 5.0), Coordinate(x: 5.5, y: -2.5), Coordinate(x: 10.0, y: -2.5)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_interiorIntersectsBoundaryAtOnePoint_lineStringInsideHole_doNotCross() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: -7.0, y: -7.0), Coordinate(x: -8.0, y: -6.0), Coordinate(x: -7.0, y: -5.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringOutsideMainLinearRing() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 12.0, y: 10.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringOutsideMainLinearRing() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: -7.0, y: -7.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -4.0, y: -6.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: -7.0, y: -8.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -4.0, y: -6.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_intersectsPolygonBoundaryInteriorExterior() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 10.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_intersectsPolygonBoundaryInteriorAndExteriorInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -6.0, y: -6.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_intersectsPolygonBoundaryInteriorExterior_multipleTimes() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: -4.0, y: -6.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 10.0, y: -4.0), Coordinate(x: 0.0, y: -4.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 12.0, y: -3.0), Coordinate(x: 12.0, y: 5.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LineString_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: -7.0, y: -7.0), Coordinate(x: 0.0, y: -14.0), Coordinate(x: 0.0, y: -6.0), Coordinate(x: -6.0, y: -6.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    ///
//    /// Polygon LinearRing tests
//    ///
//
//    func testPolygon_LinearRing_noIntersection() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_withHole_noIntersection_linearRingOutsideMainPolygon() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_withHole_noIntersection_linearRingInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: -7.0, y: -5.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -5.0, y: -7.0), Coordinate(x: -7.0, y: -5.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_interiorsExteriorsIntersect1() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -1.0), Coordinate(x: 8.0, y: -1.0), Coordinate(x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_interiorsExteriorsIntersect2() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -7.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    /// TODO: Add more tests like this one, where the linear ring and polygon touch at a point but do not cross.
//    func testPolygon_LinearRing_interiorIntersectsBoundaryAtOnePoint_linearRingFirstSegment_doNotCross() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 5.5, y: 5.0), Coordinate(x: 5.5, y: -2.5), Coordinate(x: 10.0, y: -2.5), Coordinate(x: 5.5, y: 5.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_interiorIntersectsBoundaryAtOnePoint_linearRingInsideHole_doNotCross() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: -7.0, y: -7.0), Coordinate(x: -8.0, y: -6.0), Coordinate(x: -7.0, y: -5.0), Coordinate(x: -7.0, y: -7.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingOutsideMainLinearRing() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 0.0, y: -7.0), Coordinate(x: 0.0, y: -1.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: -8.0, y: -6.0), Coordinate(x: -4.0, y: -6.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -8.0, y: -6.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingOutsideMainLinearRing() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: -20.0, y: -8.0), Coordinate(x: -10.0, y: -8.0), Coordinate(x: -10.0, y: -6.0), Coordinate(x: -20.0, y: -6.0), Coordinate(x: -20.0, y: -8.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.one,   .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: -7.0, y: -5.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: -5.0, y: -4.0), Coordinate(x: -7.0, y: -4.0), Coordinate(x: -7.0, y: -5.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.one,   .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_intersectsPolygonBoundaryInteriorExterior() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 10.0), Coordinate(x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_intersectsPolygonBoundaryInteriorAndExteriorInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -7.0, y: -9.0), Coordinate(x: -9.0, y: -9.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_intersectsPolygonBoundaryInteriorExterior_multipleTimes() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: -4.0, y: -6.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 10.0, y: -4.0), Coordinate(x: 0.0, y: -4.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 12.0, y: -3.0), Coordinate(x: 12.0, y: 5.0), Coordinate(x: -4.0, y: 5.0), Coordinate(x: -4.0, y: -6.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_LinearRing_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: -7.0, y: -7.0), Coordinate(x: 0.0, y: -14.0), Coordinate(x: 0.0, y: -6.0), Coordinate(x: -6.0, y: -6.0), Coordinate(x: -7.0, y: -7.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    ///
//    /// Polygon MultiLineString tests
//    ///
//
//    func testPolygon_MultiLineString_noIntersection() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_withHole_noIntersection_multiLineStringOutsideMainPolygon() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_withHole_noIntersection_multiLineStringInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -7.0, y: -5.0), Coordinate(x: -6.0, y: -6.0), Coordinate(x: -7.0, y: -7.0)]), LineString([Coordinate(x: -6.0, y: -5.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -6.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHoles() {
//
//        let geometry1 = Polygon([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: -100.0), Coordinate(x: -100.0, y: -100.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: 0.0, y: 0.0)], innerRings: [[Coordinate(x: -90.0, y: -10.0), Coordinate(x: -90.0, y: -50.0), Coordinate(x: -50.0, y: -50.0), Coordinate(x: -50.0, y: -10.0), Coordinate(x: -90.0, y: -10.0)], [Coordinate(x: -40.0, y: -60.0), Coordinate(x: -40.0, y: -90.0), Coordinate(x: -10.0, y: -90.0), Coordinate(x: -10.0, y: -60.0), Coordinate(x: -40.0, y: -60.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -30.0, y: -70.0), Coordinate(x: -25.0, y: -75.0), Coordinate(x: -30.0, y: -80.0)]), LineString([Coordinate(x: -80.0, y: -20.0), Coordinate(x: -70.0, y: -30.0), Coordinate(x: -60.0, y: -20.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideMainLinearRing() {
//
//        let geometry1 = Polygon([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: -100.0), Coordinate(x: -100.0, y: -100.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: 0.0, y: 0.0)], innerRings: [[Coordinate(x: -90.0, y: -10.0), Coordinate(x: -90.0, y: -50.0), Coordinate(x: -50.0, y: -50.0), Coordinate(x: -50.0, y: -10.0), Coordinate(x: -90.0, y: -10.0)], [Coordinate(x: -40.0, y: -60.0), Coordinate(x: -40.0, y: -90.0), Coordinate(x: -10.0, y: -90.0), Coordinate(x: -10.0, y: -60.0), Coordinate(x: -40.0, y: -60.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -30.0, y: -70.0), Coordinate(x: -25.0, y: -75.0), Coordinate(x: -30.0, y: -80.0)]), LineString([Coordinate(x: -80.0, y: -20.0), Coordinate(x: -70.0, y: -30.0), Coordinate(x: -60.0, y: -20.0)]), LineString([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 10.0, y: 30.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_interiorsIntersect_firstLineString() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 4.0, y: 4.0), Coordinate(x: 8.0, y: 0.0), Coordinate(x: 4.0, y: -4.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_interiorsIntersect_secondLineString() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 4.0, y: 4.0), Coordinate(x: 8.0, y: 8.0), Coordinate(x: 4.0, y: 12.0)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: -4.0), Coordinate(x: 4.0, y: -4.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    /// TODO: Add more tests like this one, where the multi line string and polygon touch at a point but do not cross.
//    func testPolygon_MultiLineString_secondInteriorIntersectsFirstBoundaryAtOnePoint_firstLineString_doNotCross() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 5.5, y: 5.0), Coordinate(x: 5.5, y: -2.5), Coordinate(x: 10.0, y: -2.5)]), LineString([Coordinate(x: -4.0, y: 1.0), Coordinate(x: -4.0, y: 4.0), Coordinate(x: -1.0, y: 4.0), Coordinate(x: -1.0, y: 1.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_secondInteriorIntersectsFirstBoundaryAtOnePoint_lineStringInsideHole_doNotCross() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -6.0, y: -7.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -6.0, y: -5.0)]), LineString([Coordinate(x: -7.0, y: -7.0), Coordinate(x: -8.0, y: -6.0), Coordinate(x: -7.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtOnePoint_doNotCross_multiLineStringOutsideMainLinearRing() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 5.5, y: 5.0), Coordinate(x: 5.5, y: 0.0), Coordinate(x: 10.0, y: 0.0)]), LineString([Coordinate(x: 12.0, y: 10.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtTwoPoints_doNotCross_multiLineStringOutsideMainLinearRing() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 5.5, y: 5.0), Coordinate(x: 5.5, y: 0.0), Coordinate(x: 10.0, y: 0.0)]), LineString([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtThreePoints_doNotCross_multiLineStringOutsideMainLinearRing() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 2.5, y: 5.0), Coordinate(x: -5.5, y: 5.0), Coordinate(x: -5.5, y: -5.5), Coordinate(x: 2.5, y: -5.5)]), LineString([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtFourPoints_doNotCross_mulitLineStringOutsideMainLinearRing() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 2.5, y: -2.5), Coordinate(x: -5.5, y: -2.5), Coordinate(x: -5.5, y: -5.5), Coordinate(x: 2.5, y: -5.5)]), LineString([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtOnePoint_doNotCross_multiLineStringInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -5.0, y: -7.0), Coordinate(x: -6.0, y: -6.0), Coordinate(x: -6.0, y: -5.0)]), LineString([Coordinate(x: -4.0, y: -7.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -5.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtTwoPoints_doNotCross_multiLineStringInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -5.0, y: -7.0), Coordinate(x: -6.0, y: -6.0), Coordinate(x: -6.0, y: -5.0)]), LineString([Coordinate(x: -4.0, y: -7.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -4.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtThreePoints_doNotCross_multiLineStringInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -6.0, y: -8.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -6.0, y: -5.0)]), LineString([Coordinate(x: -4.0, y: -7.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -4.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtFourPoints_doNotCross_multiLineStringInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -6.0, y: -8.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -6.0, y: -4.0)]), LineString([Coordinate(x: -4.0, y: -7.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -4.0, y: -5.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorExterior() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -6.0, y: -8.0), Coordinate(x: -7.0, y: -6.0), Coordinate(x: -6.0, y: -4.0)]), LineString([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 10.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorAndExteriorInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -6.0, y: -6.0)]), LineString([Coordinate(x: -6.0, y: -7.0), Coordinate(x: -6.0, y: -7.5), Coordinate(x: -6.5, y: -7.5)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorExterior_multipleTimes() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -9.0, y: -5.0)]), LineString([Coordinate(x: -4.0, y: -6.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 10.0, y: -4.0), Coordinate(x: 0.0, y: -4.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 12.0, y: -3.0), Coordinate(x: 12.0, y: 5.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -7.0, y: -7.0), Coordinate(x: 0.0, y: -14.0), Coordinate(x: 0.0, y: -6.0), Coordinate(x: -6.0, y: -6.0)]), LineString([Coordinate(x: 8.0, y: 0.0), Coordinate(x: 8.0, y: -12.0), Coordinate(x: -10.0, y: 6.0), Coordinate(x: 10.0, y: 26.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    ///
//    /// Polygon Polygon tests
//    ///
//
//    func testPolygon_Polgyon_noIntersection() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_firstWithHole_noIntersection_polygonsOutsideOfEachOther() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_firstWithHole_noIntersection_secondPolygonInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -7.0, y: -5.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -5.0, y: -7.0), Coordinate(x: -7.0, y: -5.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_bothWithHoles_noIntersection_firstPolygonInsideSecondHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -100.0, y: -100.0), Coordinate(x: -100.0, y: 100.0), Coordinate(x: 100.0, y: 100.0), Coordinate(x: 100.0, y: -100.0), Coordinate(x: -100.0, y: -100.0)], innerRings: [[Coordinate(x: -80.0, y: -80.0), Coordinate(x: 80.0, y: -80.0), Coordinate(x: 80.0, y: 80.0), Coordinate(x: -80.0, y: 8.0), Coordinate(x: -80.0, y: -80.0)]], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_secondInsideFirst() {
//
//        let geometry1 = Polygon([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: 0.0, y: -10.0), Coordinate(x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -1.0), Coordinate(x: 8.0, y: -1.0), Coordinate(x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two,   .one,   .two],
//            [.empty, .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_firstInsideSecond() {
//
//        let geometry1 = Polygon([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: 0.0, y: -10.0), Coordinate(x: 0.0, y: 0.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -4.0, y: 4.0), Coordinate(x: 24.0, y: 4.0), Coordinate(x: 24.0, y: -24.0), Coordinate(x: -4.0, y: -24.0), Coordinate(x: -4.0, y: 4.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .empty, .empty],
//            [.one, .empty, .empty],
//            [.two, .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_interiorsExteriorsIntersect1() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -1.0), Coordinate(x: 8.0, y: -1.0), Coordinate(x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_interiorsExteriorsIntersect2() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 7.0, y: -7.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    /// TODO: Add more tests like this one, where the two polygons touch at a point but do not cross.
//    func testPolygon_Polygon_interiorIntersectsBoundaryAtOnePoint_firstPolygonFirstSegment_doNotCross() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 5.5, y: 5.0), Coordinate(x: 5.5, y: -2.5), Coordinate(x: 10.0, y: -2.5), Coordinate(x: 5.5, y: 5.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_secondPolygonIntersectsFirstBoundaryAtOnePointInsideHole_doNotCross() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -7.0, y: -7.0), Coordinate(x: -8.0, y: -6.0), Coordinate(x: -7.0, y: -5.0), Coordinate(x: -7.0, y: -7.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_firstPolygonIntersectsSecondBoundaryAtTwoPoints_doNotCross() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 12.0, y: -1.0), Coordinate(x: 12.0, y: -7.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 0.0, y: -7.0), Coordinate(x: 0.0, y: -10.0), Coordinate(x: 20.0, y: -10.0), Coordinate(x: 20.0, y: 10.0), Coordinate(x: 4.0, y: 10.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_secondPolygonIntersectsFirstBoundaryAtTwoPoints_doNotCross_secondPolygonInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -8.0, y: -6.0), Coordinate(x: -4.0, y: -6.0), Coordinate(x: -6.0, y: -5.0), Coordinate(x: -8.0, y: -6.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_boundariesIntersectAtLineSegment_doNotCross() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -20.0, y: -8.0), Coordinate(x: -10.0, y: -8.0), Coordinate(x: -10.0, y: -6.0), Coordinate(x: -20.0, y: -6.0), Coordinate(x: -20.0, y: -8.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .one,   .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_boundariesIntersectsAtLineSegment_doNotCross_secondPolygonInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -7.0, y: -5.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: -5.0, y: -4.0), Coordinate(x: -7.0, y: -4.0), Coordinate(x: -7.0, y: -5.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .one,   .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_intersectsBoundaryInteriorExterior() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 4.0, y: -4.0), Coordinate(x: 0.0, y: 0.0), Coordinate(x: 0.0, y: 10.0), Coordinate(x: 4.0, y: -4.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_intersectsBoundaryInteriorAndExteriorInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -9.0, y: -9.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -7.0, y: -9.0), Coordinate(x: -9.0, y: -9.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_intersectsBoundaryInteriorExterior_multipleTimes() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -4.0, y: -6.0), Coordinate(x: 10.0, y: -6.0), Coordinate(x: 10.0, y: -4.0), Coordinate(x: 0.0, y: -4.0), Coordinate(x: 0.0, y: -3.0), Coordinate(x: 12.0, y: -3.0), Coordinate(x: 12.0, y: 5.0), Coordinate(x: -4.0, y: 5.0), Coordinate(x: -4.0, y: -6.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_intersectsBoundaryInteriorAndExterior_bothInsideAndOutsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -7.0, y: -7.0), Coordinate(x: 0.0, y: -14.0), Coordinate(x: 0.0, y: -6.0), Coordinate(x: -6.0, y: -6.0), Coordinate(x: -7.0, y: -7.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_identicalPolygons() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two,   .empty, .empty],
//            [.empty, .one,   .empty],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_identicalPolygons_differentPointOrder() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 4.0, y: -7.0), Coordinate(x: 1.0, y: -4.0), Coordinate(x: 4.0, y: -1.0), Coordinate(x: 7.0, y: -4.0), Coordinate(x: 4.0, y: -7.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two,   .empty, .empty],
//            [.empty, .one,   .empty],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_identicalPolygons_withHoles() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two,   .empty, .empty],
//            [.empty, .one,   .empty],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_identicalPolygons_withHoles_differentPointOrder() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0)], innerRings: [[Coordinate(x: -4.0, y: -8.0), Coordinate(x: -4.0, y: -4.0), Coordinate(x: -8.0, y: -4.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -4.0, y: -8.0)]], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two,   .empty, .empty],
//            [.empty, .one,   .empty],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_withHoles_secondSameAsFirstButWithOneExtraHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -7.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -7.0, y: -8.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -8.0, y: -7.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -7.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -7.0, y: -8.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -8.0, y: -7.0)], [Coordinate(x: -6.0, y: -5.0), Coordinate(x: -6.0, y: -6.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: -6.0, y: -5.0)]], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two,   .one,   .two],
//            [.empty, .one,   .empty],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_Polygon_withHoles_firstSameAsSecondButWithOneExtraHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -7.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -7.0, y: -8.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -8.0, y: -7.0)], [Coordinate(x: -6.0, y: -5.0), Coordinate(x: -6.0, y: -6.0), Coordinate(x: -5.0, y: -6.0), Coordinate(x: -5.0, y: -5.0), Coordinate(x: -6.0, y: -5.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -10.0, y: -2.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -2.0, y: -10.0), Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -2.0)], innerRings: [[Coordinate(x: -8.0, y: -7.0), Coordinate(x: -8.0, y: -8.0), Coordinate(x: -7.0, y: -8.0), Coordinate(x: -7.0, y: -7.0), Coordinate(x: -8.0, y: -7.0)]], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .empty, .empty],
//            [.one, .one,   .empty],
//            [.two, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    ///
//    /// Polygon MultiPolygon tests
//    ///
//
//    func testPolygon_MultiPolygon_noIntersection() {
//
//        let geometry1 = Polygon([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_withHoles_noIntersection_PolygonOutsideMultiPolygon() {
//
//        let geometry1 = Polygon([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_withHoles_noIntersection_polygonInsideHole() {
//
//        let geometry1 = Polygon([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 18.0, y: -15.0), Coordinate(x: 13.0, y: -18.0), Coordinate(x: 13.0, y: -12.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_withHoles_noIntersection_multiPolygonInsidePolygonHole() {
//
//        let geometry1 = Polygon([Coordinate(x: 100.0, y: -100.0), Coordinate(x: -100.0, y: -100.0), Coordinate(x: -100.0, y: 100.0), Coordinate(x: 100.0, y: 100.0), Coordinate(x: 100.0, y: -100.0)], innerRings: [[Coordinate(x: 80.0, y: -80.0), Coordinate(x: 80.0, y: 80.0), Coordinate(x: -80.0, y: 80.0), Coordinate(x: -80.0, y: -80.0), Coordinate(x: 80.0, y: -80.0)]], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_interiorsIntersect_firstPolygon() {
//
//        let geometry1 = Polygon([Coordinate(x: 4.0, y: 0.0), Coordinate(x: 0.0, y: 7.0), Coordinate(x: -5.0, y: 5.0), Coordinate(x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_interiorsIntersect_firstPolygon_withHole() {
//
//        let geometry1 = Polygon([Coordinate(x: -10.0, y: 10.0), Coordinate(x: -10.0, y: 12.0), Coordinate(x: -5.0, y: 10.0), Coordinate(x: -10.0, y: 10.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_interiorsIntersect_secondPolygon() {
//
//        let geometry1 = Polygon([Coordinate(x: 0.0, y: 10.0), Coordinate(x: 6.0, y: 0.0), Coordinate(x: 6.0, y: -6.0), Coordinate(x: 0.0, y: 10.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_interiorsIntersect_secondPolygon_withHole() {
//
//        let geometry1 = Polygon([Coordinate(x: 15.0, y: -15.0), Coordinate(x: 14.0, y: -18.0), Coordinate(x: 18.0, y: -18.0), Coordinate(x: 15.0, y: -15.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_interiorsIntersect_bothPolygons_withHoles() {
//
//        let geometry1 = Polygon([Coordinate(x: -3.0, y: 10.0), Coordinate(x: 0.0, y: 12.0), Coordinate(x: 10.0, y: -18.0), Coordinate(x: -3.0, y: 10.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles() {
//
//        let geometry1 = Polygon([Coordinate(x: -20.0, y: 18.0), Coordinate(x: -30.0, y: 30.0), Coordinate(x: -50.0, y: 0.0), Coordinate(x: -20.0, y: 18.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles() {
//
//        let geometry1 = Polygon([Coordinate(x: 0.0, y: -40.0), Coordinate(x: 22.0, y: -30.0), Coordinate(x: 15.0, y: -20.0), Coordinate(x: 0.0, y: -40.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles() {
//
//        let geometry1 = Polygon([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 0.0, y: -50.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: -18.0, y: 3.0), Coordinate(x: -18.0, y: -30.0), Coordinate(x: 20.0, y: -20.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = Polygon([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 40.0), Coordinate(x: 21.0, y: 40.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .one,   .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_polygonIntersectsMultiPolygonInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = Polygon([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -12.0, y: 12.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one, .two],
//            [.one, .one, .one],
//            [.two, .one, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testPolygon_MultiPolygon_polygonIntersectsMultiPolygonInteriorAndBoundary_withHoles() {
//
//        let geometry1 = Polygon([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -8.0, y: 9.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one, .two],
//            [.one, .one, .one],
//            [.two, .one, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    ///
//    /// MultiPolygon Point tests
//    ///
//
//    func testMultiPolygon_Point_outerRingsOnly_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Point(Coordinate(x: 0.0, y: 0.0), precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Point_outerRingAndInnerRings_outsideMainRings_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Point(Coordinate(x: -20.0, y: -20.0), precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Point_outerRingAndInnerRing_insideInnerRing_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Point(Coordinate(x: 6.0, y: -4.0), precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Point_outerRingOnly_intersectsBoundary() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Point(Coordinate(x: -5.0, y: 4.0), precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Point_outerRingAndInnerRing_intersectsOuterBoundary() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Point(Coordinate(x: 6.0, y: -2.0), precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Point_outerRingAndInnerRing_intersectsInnerBoundary() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Point(Coordinate(x: 5.0, y: -4.0), precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Point_outerRingOnly_intersectsInterior() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Point(Coordinate(x: -4.0, y: 3.0), precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.empty, .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Point_outerRingAndInnerRing_intersectsInterior() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Point(Coordinate(x: 6.0, y: -9.0), precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.empty, .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    ///
//    /// MultiPolygon MultiPoint tests
//    ///
//
//    func testMultiPolygon_MultiPoint_outerRingOnly_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 10.0, y: 2.0)), Point(Coordinate(x: 0.5, y: -4.0)), Point(Coordinate(x: -1.0, y: 5.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_outsideMainRing_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 11.0, y: 2.0)), Point(Coordinate(x: 0.5, y: 14.0)), Point(Coordinate(x: -11.0, y: -5.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_insideInnerRing_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 5.5, y: -3.5))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 11.0, y: 11.0)), Point(Coordinate(x: 6.0, y: -3.5)), Point(Coordinate(x: 3.0, y: 2.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingOnly_intersectsBoundaryOnly() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 4.0, y: 2.0)), Point(Coordinate(x: -3.0, y: 4.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterBoundaryOnly() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: -10.0, y: 3.4)), Point(Coordinate(x: 4.0, y: -6.0)), Point(Coordinate(x: 10.0, y: 10.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInnerBoundaryOnly() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 6.0, y: -3.0)), Point(Coordinate(x: 2.0, y: 4.0)), Point(Coordinate(x: 5.0, y: -4.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 6.0, y: -3.0)), Point(Coordinate(x: 5.0, y: -4.0)), Point(Coordinate(x: -9.0, y: 10.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: -7.0, y: 3.0)), Point(Coordinate(x: 6.0, y: -10.0)), Point(Coordinate(x: 10.0, y: 9.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorOnly() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: -4.0, y: 3.0)), Point(Coordinate(x: -4.0, y: 2.5)), Point(Coordinate(x: 3.0, y: 2.2))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.empty, .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorOnly() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 6.0, y: -9.0)), Point(Coordinate(x: 0.0, y: 1.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.empty, .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorOnly() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 2.5, y: -3.5)), Point(Coordinate(x: 9.0, y: -19.0)), Point(Coordinate(x: 8.0, y: -8.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.empty, .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundary() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: -4.0, y: 3.0)), Point(Coordinate(x: -2.0, y: 2.0)), Point(Coordinate(x: -4.0, y: 2.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 6.0, y: -2.4)), Point(Coordinate(x: 10.0, y: 4.0)), Point(Coordinate(x: 5.0, y: 10.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 1.0, y: 3.0)), Point(Coordinate(x: 2.0, y: 2.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: -9.0, y: 7.0)), Point(Coordinate(x: 6.0, y: -10.0)), Point(Coordinate(x: 5.0, y: -4.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 9.1, y: -2.8)), Point(Coordinate(x: 6.0, y: -10.0)), Point(Coordinate(x: 2.0, y: -18.0)), Point(Coordinate(x: 2.5, y: -2.5))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.zero,  .empty, .one],
//            [.empty, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndExterior() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: -2.0, y: -2.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -4.0, y: 3.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.empty, .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: -9.0, y: 3.4)), Point(Coordinate(x: 6.0, y: -2.5)), Point(Coordinate(x: 15.0, y: -8.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.empty, .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: -9.0, y: 9.0)), Point(Coordinate(x: 6.0, y: -4.0)), Point(Coordinate(x: 6.5, y: -4.8))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.empty, .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 5.0, y: -11.0)), Point(Coordinate(x: 6.0, y: -4.0)), Point(Coordinate(x: -25.0, y: -11.0)), Point(Coordinate(x: 9.5, y: 9.5))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero,  .empty, .two],
//            [.empty, .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingOnly_intersectsBoundaryAndExterior() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 2.0, y: 2.0)), Point(Coordinate(x: 0.0, y: 0.0)), Point(Coordinate(x: -4.0, y: 6.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: 12.5, y: 0.0)), Point(Coordinate(x:7.0, y: -4.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 6.0, y: -4.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 4.0, y: -6.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 4.0, y: -12.0)), Point(Coordinate(x: 6.0, y: -4.0)), Point(Coordinate(x: 11.0, y: -21.0)), Point(Coordinate(x: 3.0, y: -11.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.zero,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundaryAndExterior() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 1.0, y: 3.0)]), Polygon([Coordinate(x: -6.0, y: 2.0), Coordinate(x: -4.0, y: 6.0), Coordinate(x: -2.0, y: 2.0), Coordinate(x: -6.0, y: 2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: -4.0, y: 2.0)), Point(Coordinate(x: 8.5, y: 2.5))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero, .empty, .two],
//            [.zero, .empty, .one],
//            [.zero, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 10.0, y: 8.6)), Point(Coordinate(x: 12.5, y: 0.0)), Point(Coordinate(x: 5.0, y: -2.5))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero, .empty, .two],
//            [.zero, .empty, .one],
//            [.zero, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 6.0, y: -10.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 9.0, y: 9.0)), Point(Coordinate(x: 3.0, y: 2.0)), Point(Coordinate(x: 6.0, y: -11.0)), Point(Coordinate(x: 7.0, y: -4.3)), Point(Coordinate(x: 9.0, y: -2.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero, .empty, .two],
//            [.zero, .empty, .one],
//            [.zero, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 0.0), Coordinate(x: -10.0, y: 10.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: -10.0, y: 0.0)], innerRings: [[Coordinate(x: 1.0, y: 3.0), Coordinate(x: 3.0, y: 1.0), Coordinate(x: 5.0, y: 3.0), Coordinate(x: 3.0, y: 5.0), Coordinate(x: 1.0, y: 3.0)], [Coordinate(x: -8.0, y: 3.0), Coordinate(x: -2.0, y: 3.0), Coordinate(x: -5.0, y: 9.0), Coordinate(x: -8.0, y: 3.0)]]), Polygon([Coordinate(x: 10.0, y: -2.0), Coordinate(x: 10.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 10.0, y: -2.0)], innerRings: [[Coordinate(x: 5.0, y: -3.0), Coordinate(x: 5.0, y: -5.0), Coordinate(x: 7.0, y: -5.0), Coordinate(x: 7.0, y: -3.0), Coordinate(x: 5.0, y: -3.0)], [Coordinate(x: 3.0, y: -10.0), Coordinate(x: 3.0, y: -15.0), Coordinate(x: 7.0, y: -15.0), Coordinate(x: 7.0, y: -10.0), Coordinate(x: 3.0, y: -10.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPoint([Point(Coordinate(x: 9.0, y: -19.0)), Point(Coordinate(x: 2.5, y: 2.5)), Point(Coordinate(x: 6.0, y: -4.0)), Point(Coordinate(x: 13.0, y: 5.0)), Point(Coordinate(x: 3.0, y: -11.0)), Point(Coordinate(x: 10.0, y: -18.0)), Point(Coordinate(x: -9.0, y: 1.0))], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.zero, .empty, .two],
//            [.zero, .empty, .one],
//            [.zero, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    ///
//    /// MultiPolygon LineString tests
//    ///
//
//    func testMultiPolygon_LineString_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_withHoles_noIntersection_lineStringOutsideMainPolygon() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_withHoles_noIntersection_lineStringInsideHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 18.0, y: -15.0), Coordinate(x: 13.0, y: -18.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_interiorsIntersect_firstPolygon() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 4.0, y: 0.0), Coordinate(x: 0.0, y: 7.0), Coordinate(x: -5.0, y: 5.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_interiorsIntersect_firstPolygon_withHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: -10.0, y: 10.0), Coordinate(x: -10.0, y: 12.0), Coordinate(x: -5.0, y: 10.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_interiorsIntersect_secondPolygon() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 0.0, y: 10.0), Coordinate(x: 6.0, y: 0.0), Coordinate(x: 6.0, y: -6.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_interiorsIntersect_secondPolygon_withHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 15.0, y: -15.0), Coordinate(x: 14.0, y: -18.0), Coordinate(x: 18.0, y: -18.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_interiorsIntersect_bothPolygons_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: -3.0, y: 10.0), Coordinate(x: 0.0, y: 12.0), Coordinate(x: 10.0, y: -18.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_boundariesIntersect_firstPolygon_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: -20.0, y: 18.0), Coordinate(x: -30.0, y: 30.0), Coordinate(x: -50.0, y: 0.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_boundariesIntersect_secondPolygon_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 0.0, y: -40.0), Coordinate(x: 22.0, y: -30.0), Coordinate(x: 15.0, y: -20.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_boundariesIntersect_bothPolygons_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 0.0, y: -50.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: -18.0, y: 3.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.one,   .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -12.0, y: 12.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one, .empty, .two],
//            [.one, .empty, .one],
//            [.one, .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_interiorsIntersectAndBoundariesIntersect_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -8.0, y: 9.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one, .empty, .two],
//            [.one, .zero,  .one],
//            [.one, .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LineString_boundaryIntersectsInteriorAndBoundary_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LineString([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -7.0, y: 9.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one, .zero,  .two],
//            [.one, .zero,  .one],
//            [.one, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    ///
//    /// MultiPolygon LinearRing tests
//    ///
//
//    func testMultiPolygon_LinearRing_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_withHoles_noIntersection_linearRingOutsideMainPolygon() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_withHoles_noIntersection_linearRingInsideHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 18.0, y: -15.0), Coordinate(x: 13.0, y: -18.0), Coordinate(x: 13.0, y: -12.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_withHoles_noIntersection_multiPolygonInsideLinearRing() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 100.0, y: -100.0), Coordinate(x: -100.0, y: -100.0), Coordinate(x: -100.0, y: 100.0), Coordinate(x: 100.0, y: 100.0), Coordinate(x: 100.0, y: -100.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_interiorsIntersect_firstPolygon() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 4.0, y: 0.0), Coordinate(x: 0.0, y: 7.0), Coordinate(x: -5.0, y: 5.0), Coordinate(x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_interiorsIntersect_firstPolygon_withHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: -10.0, y: 10.0), Coordinate(x: -10.0, y: 12.0), Coordinate(x: -5.0, y: 10.0), Coordinate(x: -10.0, y: 10.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_interiorsIntersect_secondPolygon() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 0.0, y: 10.0), Coordinate(x: 6.0, y: 0.0), Coordinate(x: 6.0, y: -6.0), Coordinate(x: 0.0, y: 10.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_interiorsIntersect_secondPolygon_withHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 15.0, y: -15.0), Coordinate(x: 14.0, y: -18.0), Coordinate(x: 18.0, y: -18.0), Coordinate(x: 15.0, y: -15.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_interiorsIntersect_bothPolygons_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: -3.0, y: 10.0), Coordinate(x: 0.0, y: 12.0), Coordinate(x: 10.0, y: -18.0), Coordinate(x: -3.0, y: 10.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .empty, .two],
//            [.zero, .empty, .one],
//            [.one,  .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: -20.0, y: 18.0), Coordinate(x: -30.0, y: 30.0), Coordinate(x: -50.0, y: 0.0), Coordinate(x: -20.0, y: 18.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 0.0, y: -40.0), Coordinate(x: 22.0, y: -30.0), Coordinate(x: 15.0, y: -20.0), Coordinate(x: 0.0, y: -40.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 0.0, y: -50.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: -18.0, y: 3.0), Coordinate(x: -18.0, y: -30.0), Coordinate(x: 20.0, y: -20.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.zero,  .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 40.0), Coordinate(x: 21.0, y: 40.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.one,   .empty, .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -12.0, y: 12.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one, .empty, .two],
//            [.one, .empty, .one],
//            [.one, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonInteriorAndBoundary_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = LinearRing([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -8.0, y: 9.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one, .empty, .two],
//            [.one, .empty, .one],
//            [.one, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    ///
//    /// MultiPolygon MultiLineString tests
//    ///
//
//    func testMultiPolygon_MultiLineString_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -20.0), Coordinate(x: -20.0, y: -20.0), Coordinate(x: -20.0, y: -10.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringOutsidePolygons() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0)]), LineString([Coordinate(x: -10.0, y: -10.0), Coordinate(x: -10.0, y: -20.0), Coordinate(x: -20.0, y: -20.0), Coordinate(x: -20.0, y: -10.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideOneHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 15.0, y: -14.0), Coordinate(x: 18.0, y: -12.0)]), LineString([Coordinate(x: 13.0, y: -18.0), Coordinate(x: 15.0, y: -16.0), Coordinate(x: 18.0, y: -18.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 15.0, y: -14.0), Coordinate(x: 18.0, y: -12.0)]), LineString([Coordinate(x: 8.0, y: -17.0), Coordinate(x: 8.0, y: -16.0), Coordinate(x: 9.0, y: -16.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHolesInTwoDifferentPolygonsAndOutsideAllPolygons() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -8.0, y: 10.5), Coordinate(x: -7.5, y: 11.0), Coordinate(x: -8.0, y: 11.5)]), LineString([Coordinate(x: 8.0, y: -17.0), Coordinate(x: 8.0, y: -16.0), Coordinate(x: 9.0, y: -16.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideAllPolygons() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 15.0, y: -14.0), Coordinate(x: 18.0, y: -12.0)]), LineString([Coordinate(x: 8.0, y: -17.0), Coordinate(x: 8.0, y: -16.0), Coordinate(x: 9.0, y: -16.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_interiorsIntersect_firstPolygon() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 13.0, y: 12.0), Coordinate(x: 15.0, y: 14.0), Coordinate(x: 18.0, y: 12.0)]), LineString([Coordinate(x: 4.0, y: 0.0), Coordinate(x: 0.0, y: 7.0), Coordinate(x: -5.0, y: 5.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_interiorsIntersect_firstPolygon_withHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: -10.0, y: 10.0), Coordinate(x: -10.0, y: 12.0), Coordinate(x: -5.0, y: 10.0)]), LineString([Coordinate(x: 10.0, y: 20.0), Coordinate(x: 15.0, y: 30.0), Coordinate(x: 10.0, y: 40.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_interiorsIntersect_secondPolygon() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 0.0, y: 10.0), Coordinate(x: 6.0, y: 0.0), Coordinate(x: 6.0, y: -6.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: 10.0, y: 20.0), Coordinate(x: 15.0, y: 30.0), Coordinate(x: 10.0, y: 40.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_interiorsIntersect_secondPolygon_withHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 10.0, y: 20.0), Coordinate(x: 15.0, y: 30.0), Coordinate(x: 10.0, y: 40.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: 15.0, y: -15.0), Coordinate(x: 14.0, y: -18.0), Coordinate(x: 18.0, y: -18.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_interiorsIntersect_bothPolygons_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 10.0, y: 20.0), Coordinate(x: 15.0, y: 30.0), Coordinate(x: 10.0, y: 40.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: -3.0, y: 10.0), Coordinate(x: 0.0, y: 12.0), Coordinate(x: 10.0, y: -18.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_interiorsIntersect_bothPolygons_withHoles_differentLineStrings() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 1.0, y: 2.0), Coordinate(x: 40.0, y: -40.0), Coordinate(x: 1.0, y: -80.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: -3.0, y: 10.0), Coordinate(x: 0.0, y: 12.0), Coordinate(x: -3.0, y: 40.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one,  .zero,  .two],
//            [.zero, .empty, .one],
//            [.one,  .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_boundariesIntersect_firstPolygon_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: -20.0, y: 18.0), Coordinate(x: -30.0, y: 30.0), Coordinate(x: -50.0, y: 0.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_boundariesIntersect_secondPolygon_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 0.0, y: -40.0), Coordinate(x: 22.0, y: -30.0), Coordinate(x: 15.0, y: -20.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_boundariesIntersect_bothPolygons_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 0.0, y: -50.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: -18.0, y: 3.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_boundariesIntersectAtAllFourBoundaryPoints_bothPolygons_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 0.0, y: -50.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: -20.0, y: 3.0)]), LineString([Coordinate(x: -16.0, y: 20.0), Coordinate(x: -16.0, y: 30.0), Coordinate(x: 16.0, y: 30.0), Coordinate(x: 16.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.one,   .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.one,   .empty, .one],
//            [.one,   .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)]), LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -12.0, y: 12.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one, .empty, .two],
//            [.one, .empty, .one],
//            [.one, .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_interiorsIntersectAndBoundariesIntersect_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -8.0, y: 9.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one, .empty, .two],
//            [.one, .zero,  .one],
//            [.one, .zero,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_boundaryIntersectsInteriorAndBoundary_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -7.0, y: 9.0)]), LineString([Coordinate(x: 100.0, y: 20.0), Coordinate(x: 150.0, y: 30.0), Coordinate(x: 200.0, y: 100.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one, .zero, .two],
//            [.one, .zero, .one],
//            [.one, .zero, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiLineString_boundaryIntersectsInteriorAndBoundaryAtAllFourBoundaryPoints_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiLineString([LineString([Coordinate(x: -20.0, y: 4.0), Coordinate(x: -40.0, y: 4.0), Coordinate(x: -40.0, y: -50.0), Coordinate(x: 6.0, y: -50.0), Coordinate(x: 6.0, y: -20.0)]), LineString([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -7.0, y: 9.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.one, .zero,  .two],
//            [.one, .zero,  .one],
//            [.one, .empty, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    ///
//    /// MultiPolygon Polygon tests
//    ///
//
//    func testMultiPolygon_Polygon_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_withHoles_noIntersection_PolygonOutsideMultiPolygon() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_withHoles_noIntersection_polygonInsideHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 18.0, y: -15.0), Coordinate(x: 13.0, y: -18.0), Coordinate(x: 13.0, y: -12.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_withHoles_noIntersection_multiPolygonInsidePolygonHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 100.0, y: -100.0), Coordinate(x: -100.0, y: -100.0), Coordinate(x: -100.0, y: 100.0), Coordinate(x: 100.0, y: 100.0), Coordinate(x: 100.0, y: -100.0)], innerRings: [[Coordinate(x: 80.0, y: -80.0), Coordinate(x: 80.0, y: 80.0), Coordinate(x: -80.0, y: 80.0), Coordinate(x: -80.0, y: -80.0), Coordinate(x: 80.0, y: -80.0)]], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_interiorsIntersect_firstPolygon() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 4.0, y: 0.0), Coordinate(x: 0.0, y: 7.0), Coordinate(x: -5.0, y: 5.0), Coordinate(x: 4.0, y: 0.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_interiorsIntersect_firstPolygon_withHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -10.0, y: 10.0), Coordinate(x: -10.0, y: 12.0), Coordinate(x: -5.0, y: 10.0), Coordinate(x: -10.0, y: 10.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_interiorsIntersect_secondPolygon() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 0.0, y: 10.0), Coordinate(x: 6.0, y: 0.0), Coordinate(x: 6.0, y: -6.0), Coordinate(x: 0.0, y: 10.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_interiorsIntersect_secondPolygon_withHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 15.0, y: -15.0), Coordinate(x: 14.0, y: -18.0), Coordinate(x: 18.0, y: -18.0), Coordinate(x: 15.0, y: -15.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_interiorsIntersect_bothPolygons_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -3.0, y: 10.0), Coordinate(x: 0.0, y: 12.0), Coordinate(x: 10.0, y: -18.0), Coordinate(x: -3.0, y: 10.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: -20.0, y: 18.0), Coordinate(x: -30.0, y: 30.0), Coordinate(x: -50.0, y: 0.0), Coordinate(x: -20.0, y: 18.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 0.0, y: -40.0), Coordinate(x: 22.0, y: -30.0), Coordinate(x: 15.0, y: -20.0), Coordinate(x: 0.0, y: -40.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 0.0, y: -50.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: -18.0, y: 3.0), Coordinate(x: -18.0, y: -30.0), Coordinate(x: 20.0, y: -20.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 40.0), Coordinate(x: 21.0, y: 40.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .one,   .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_polygonIntersectsMultiPolygonInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -12.0, y: 12.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one, .two],
//            [.one, .one, .one],
//            [.two, .one, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_Polygon_polygonIntersectsMultiPolygonInteriorAndBoundary_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = Polygon([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -8.0, y: 9.0), Coordinate(x: 21.0, y: -3.0)], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one, .two],
//            [.one, .one, .one],
//            [.two, .one, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    ///
//    /// MultiPolygon MultiPolygon tests
//    ///
//
//    func testMultiPolygon_MultiPolygon_noIntersection() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 3.0), Coordinate(x: 1.0, y: 1.0)]), Polygon([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 10.0, y: 30.0), Coordinate(x: 10.0, y: 10.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_withHoles_noIntersection_MultiPolygonsOutsideEachOther() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 2.0, y: 2.0), Coordinate(x: 2.0, y: 12.0), Coordinate(x: 12.0, y: 12.0), Coordinate(x: 12.0, y: 2.0), Coordinate(x: 2.0, y: 2.0)], innerRings: [[Coordinate(x: 4.0, y: 4.0), Coordinate(x: 10.0, y: 4.0), Coordinate(x: 10.0, y: 10.0), Coordinate(x: 4.0, y: 10.0), Coordinate(x: 4.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: 2.0), Coordinate(x: 20.0, y: 12.0), Coordinate(x: 30.0, y: 12.0), Coordinate(x: 30.0, y: 2.0), Coordinate(x: 20.0, y: 2.0)], innerRings: [[Coordinate(x: 22.0, y: 4.0), Coordinate(x: 28.0, y: 4.0), Coordinate(x: 28.0, y: 10.0), Coordinate(x: 22.0, y: 10.0), Coordinate(x: 22.0, y: 4.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_withHoles_noIntersection_polygonInsideHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 13.0, y: -12.0), Coordinate(x: 18.0, y: -15.0), Coordinate(x: 13.0, y: -18.0), Coordinate(x: 13.0, y: -12.0)]), Polygon([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 10.0, y: 30.0), Coordinate(x: 10.0, y: 10.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_withHoles_noIntersection_multiPolygonInsideOnePolygonHole() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -9.0, y: 12.0), Coordinate(x: -9.0, y: 10.0), Coordinate(x: -7.0, y: 10.0), Coordinate(x: -7.0, y: 12.0), Coordinate(x: -9.0, y: 12.0)], [Coordinate(x: -3.0, y: 4.0), Coordinate(x: -3.0, y: 8.0), Coordinate(x: -6.0, y: 8.0), Coordinate(x: -6.0, y: 4.0), Coordinate(x: -3.0, y: 4.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 11.0, y: -12.0), Coordinate(x: 5.0, y: -18.0), Coordinate(x: 11.0, y: -18.0), Coordinate(x: 11.0, y: -12.0)], [Coordinate(x: 12.0, y: -11.0), Coordinate(x: 12.0, y: -19.0), Coordinate(x: 19.0, y: -19.0), Coordinate(x: 19.0, y: -11.0), Coordinate(x: 12.0, y: -11.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 100.0, y: -100.0), Coordinate(x: -100.0, y: -100.0), Coordinate(x: -100.0, y: 100.0), Coordinate(x: 100.0, y: 100.0), Coordinate(x: 100.0, y: -100.0)], innerRings: [[Coordinate(x: 80.0, y: -80.0), Coordinate(x: 80.0, y: 80.0), Coordinate(x: -80.0, y: 80.0), Coordinate(x: -80.0, y: -80.0), Coordinate(x: 80.0, y: -80.0)]]), Polygon([Coordinate(x: 200.0, y: 10.0), Coordinate(x: 210.0, y: 20.0), Coordinate(x: 200.0, y: 30.0), Coordinate(x: 200.0, y: 10.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_withHoles_noIntersection_multiPolygonInsideTwoPolygonHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -12.0, y: 13.0), Coordinate(x: -20.0, y: 13.0), Coordinate(x: -20.0, y: 23.0), Coordinate(x: -12.0, y: 23.0), Coordinate(x: -12.0, y: 13.0)], innerRings: [[Coordinate(x: -19.0, y: 22.0), Coordinate(x: -19.0, y: 20.0), Coordinate(x: -17.0, y: 20.0), Coordinate(x: -17.0, y: 22.0), Coordinate(x: -19.0, y: 22.0)], [Coordinate(x: -13.0, y: 14.0), Coordinate(x: -13.0, y: 18.0), Coordinate(x: -16.0, y: 18.0), Coordinate(x: -16.0, y: 14.0), Coordinate(x: -13.0, y: 14.0)]]), Polygon([Coordinate(x: 30.0, y: -12.0), Coordinate(x: 30.0, y: -30.0), Coordinate(x: 12.0, y: -30.0), Coordinate(x: 30.0, y: -12.0)], innerRings: [[Coordinate(x: 21.0, y: -22.0), Coordinate(x: 15.0, y: -28.0), Coordinate(x: 21.0, y: -28.0), Coordinate(x: 21.0, y: -22.0)], [Coordinate(x: 22.0, y: -21.0), Coordinate(x: 22.0, y: -29.0), Coordinate(x: 29.0, y: -29.0), Coordinate(x: 29.0, y: -21.0), Coordinate(x: 22.0, y: -21.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -1.0, y: 1.0), Coordinate(x: -1.0, y: 100.0), Coordinate(x: -100.0, y: 100.0), Coordinate(x: -100.0, y: 1.0), Coordinate(x: -1.0, y: 1.0)], innerRings: [[Coordinate(x: -2.0, y: 2.0), Coordinate(x: -2.0, y: 80.0), Coordinate(x: -80.0, y: 80.0), Coordinate(x: -80.0, y: 2.0), Coordinate(x: -2.0, y: 2.0)]]), Polygon([Coordinate(x: 1.0, y: -1.0), Coordinate(x: 1.0, y: -100.0), Coordinate(x: 100.0, y: -100.0), Coordinate(x: 100.0, y: -1.0), Coordinate(x: 1.0, y: -1.0)], innerRings: [[Coordinate(x: 2.0, y: -2.0), Coordinate(x: 2.0, y: -80.0), Coordinate(x: 80.0, y: -80.0), Coordinate(x: 80.0, y: -2.0), Coordinate(x: 2.0, y: -2.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .empty, .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_interiorsIntersect_firstPolygons() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 4.0, y: 0.0), Coordinate(x: 0.0, y: 7.0), Coordinate(x: -5.0, y: 5.0), Coordinate(x: 4.0, y: 0.0)]), Polygon([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 10.0, y: 30.0), Coordinate(x: 10.0, y: 10.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_interiorsIntersect_firstPolygons_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: -10.0, y: 10.0), Coordinate(x: -10.0, y: 12.0), Coordinate(x: -5.0, y: 12.0), Coordinate(x: -5.0, y: 10.0), Coordinate(x: -10.0, y: 10.0)], innerRings: [[Coordinate(x: -9.5, y: 10.5), Coordinate(x: -5.5, y: 10.5), Coordinate(x: -5.5, y: 11.5), Coordinate(x: -9.5, y: 10.5)]]), Polygon([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 10.0, y: 30.0), Coordinate(x: 10.0, y: 10.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_interiorsIntersect_secondPolygons() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 8.0, y: -2.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -2.0)])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 10.0, y: 30.0), Coordinate(x: 10.0, y: 10.0)]), Polygon([Coordinate(x: 0.0, y: 10.0), Coordinate(x: 6.0, y: 0.0), Coordinate(x: 6.0, y: -6.0), Coordinate(x: 0.0, y: 10.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one,  .two],
//            [.one, .zero, .one],
//            [.two, .one,  .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_interiorsIntersect_secondPolygons_withHoles_boundariesOverlapOnLineSegment() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -10.0, y: 3.0), Coordinate(x: -10.0, y: 13.0), Coordinate(x: -2.0, y: 13.0), Coordinate(x: -2.0, y: 3.0)]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        //        let geometry2 = Polygon([Coordinate(x: 15.0, y: -15.0), Coordinate(x: 14.0, y: -18.0), Coordinate(x: 18.0, y: -18.0), Coordinate(x: 15.0, y: -15.0)], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 10.0, y: 30.0), Coordinate(x: 10.0, y: 10.0)]), Polygon([Coordinate(x: 0.0, y: 0.0), Coordinate(x: 10.0, y: 0.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: 0.0, y: -10.0), Coordinate(x: 0.0, y: 0.0)], innerRings: [[Coordinate(x: 2.0, y: -2.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 8.0, y: -2.0), Coordinate(x: 2.0, y: -2.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one, .two],
//            [.one, .one, .one],
//            [.two, .one, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_interiorsIntersect_bothPolygons_withHoles_boundariesShareSegment() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 10.0, y: 30.0), Coordinate(x: 10.0, y: 10.0)]), Polygon([Coordinate(x: -5.0, y: 5.0), Coordinate(x: 10.0, y: 5.0), Coordinate(x: 10.0, y: -10.0), Coordinate(x: -5.0, y: -10.0), Coordinate(x: -5.0, y: 5.0)], innerRings: [[Coordinate(x: 2.0, y: -2.0), Coordinate(x: 2.0, y: -8.0), Coordinate(x: 8.0, y: -8.0), Coordinate(x: 8.0, y: -2.0), Coordinate(x: 2.0, y: -2.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one, .two],
//            [.one, .one, .one],
//            [.two, .one, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_boundariesIntersectAtOnePoint_doNotCross_firstPolygon_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 10.0, y: 30.0), Coordinate(x: 10.0, y: 10.0)]), Polygon([Coordinate(x: -20.0, y: 18.0), Coordinate(x: -30.0, y: 30.0), Coordinate(x: -50.0, y: 0.0), Coordinate(x: -24.0, y: 0.0), Coordinate(x: -20.0, y: 18.0)], innerRings: [[Coordinate(x: -25.0, y: 2.0), Coordinate(x: -25.0, y: 4.0), Coordinate(x: -28.0, y: 4.0), Coordinate(x: -28.0, y: 2.0), Coordinate(x: -25.0, y: 2.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_boundariesIntersectAtOnePoint_doNotCross_secondPolygon_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 20.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 20.0, y: 10.0), Coordinate(x: 10.0, y: 10.0)], innerRings: [[Coordinate(x: 18.0, y: 12.0), Coordinate(x: 18.0, y: 18.0), Coordinate(x: 12.0, y: 18.0), Coordinate(x: 12.0, y: 12.0), Coordinate(x: 18.0, y: 12.0)]]), Polygon([Coordinate(x: 0.0, y: -40.0), Coordinate(x: 22.0, y: -30.0), Coordinate(x: 15.0, y: -20.0), Coordinate(x: 0.0, y: -40.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_boundariesIntersectAtTwoPoints_doNotCross_bothPolygonsOfFirstMultiPolygonTouched_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 10.0, y: 10.0), Coordinate(x: 10.0, y: 20.0), Coordinate(x: 20.0, y: 20.0), Coordinate(x: 20.0, y: 10.0), Coordinate(x: 10.0, y: 10.0)], innerRings: [[Coordinate(x: 18.0, y: 12.0), Coordinate(x: 18.0, y: 18.0), Coordinate(x: 12.0, y: 18.0), Coordinate(x: 12.0, y: 12.0), Coordinate(x: 18.0, y: 12.0)]]), Polygon([Coordinate(x: 20.0, y: -20.0), Coordinate(x: 0.0, y: -50.0), Coordinate(x: -100.0, y: 0.0), Coordinate(x: -18.0, y: 3.0), Coordinate(x: -18.0, y: -30.0), Coordinate(x: 20.0, y: -20.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .zero,  .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 110.0, y: 10.0), Coordinate(x: 110.0, y: 20.0), Coordinate(x: 120.0, y: 20.0), Coordinate(x: 120.0, y: 10.0), Coordinate(x: 110.0, y: 10.0)], innerRings: [[Coordinate(x: 118.0, y: 12.0), Coordinate(x: 118.0, y: 18.0), Coordinate(x: 112.0, y: 18.0), Coordinate(x: 112.0, y: 12.0), Coordinate(x: 118.0, y: 12.0)]]), Polygon([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -34.0, y: 40.0), Coordinate(x: 21.0, y: 40.0), Coordinate(x: 21.0, y: -3.0)])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.empty, .empty, .two],
//            [.empty, .one,   .one],
//            [.two,   .one,   .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_boundariesIntersectAtInteriorAndBoundary_bothPolygonsOfFirstPolygon_atPointAndLineSegment_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -12.0, y: 12.0), Coordinate(x: -12.0, y: -3.0), Coordinate(x: 21.0, y: -3.0)], innerRings: [[Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 1.0)], [Coordinate(x: -1.0, y: -1.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -1.0, y: -2.0), Coordinate(x: -1.0, y: -1.0)]]), Polygon([Coordinate(x: 110.0, y: 10.0), Coordinate(x: 110.0, y: 20.0), Coordinate(x: 120.0, y: 20.0), Coordinate(x: 120.0, y: 10.0), Coordinate(x: 110.0, y: 10.0)], innerRings: [[Coordinate(x: 118.0, y: 12.0), Coordinate(x: 118.0, y: 18.0), Coordinate(x: 112.0, y: 18.0), Coordinate(x: 112.0, y: 12.0), Coordinate(x: 118.0, y: 12.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one, .two],
//            [.one, .one, .one],
//            [.two, .one, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
//
//    func testMultiPolygon_MultiPolygon_boundariesIntersectAtInteriorAndBoundary_withHoles() {
//
//        let geometry1 = MultiPolygon([Polygon([Coordinate(x: -2.0, y: 3.0), Coordinate(x: -20.0, y: 3.0), Coordinate(x: -20.0, y: 20.0), Coordinate(x: -2.0, y: 20.0), Coordinate(x: -2.0, y: 3.0)], innerRings: [[Coordinate(x: -8.0, y: 9.0), Coordinate(x: -16.0, y: 9.0), Coordinate(x: -16.0, y: 16.0), Coordinate(x: -8.0, y: 16.0), Coordinate(x: -8.0, y: 9.0)]]), Polygon([Coordinate(x: 20.0, y: -2.0), Coordinate(x: 20.0, y: -20.0), Coordinate(x: 2.0, y: -20.0), Coordinate(x: 2.0, y: -2.0), Coordinate(x: 20.0, y: -2.0)], innerRings: [[Coordinate(x: 16.0, y: -16.0), Coordinate(x: 16.0, y: -12.0), Coordinate(x: 12.0, y: -12.0), Coordinate(x: 12.0, y: -16.0), Coordinate(x: 16.0, y: -16.0)]])], precision: precision, coordinateSystem: cs)
//        let geometry2 = MultiPolygon([Polygon([Coordinate(x: 21.0, y: -3.0), Coordinate(x: 10.0, y: 8.0), Coordinate(x: 5.0, y: 20.0), Coordinate(x: -34.0, y: 20.0), Coordinate(x: -8.0, y: 9.0), Coordinate(x: -8.0, y: -3.0), Coordinate(x: 21.0, y: -3.0)], innerRings: [[Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 1.0), Coordinate(x: 2.0, y: 2.0), Coordinate(x: 1.0, y: 2.0), Coordinate(x: 1.0, y: 1.0)], [Coordinate(x: -1.0, y: -1.0), Coordinate(x: -2.0, y: -1.0), Coordinate(x: -2.0, y: -2.0), Coordinate(x: -1.0, y: -2.0), Coordinate(x: -1.0, y: -1.0)]]), Polygon([Coordinate(x: 110.0, y: 10.0), Coordinate(x: 110.0, y: 20.0), Coordinate(x: 120.0, y: 20.0), Coordinate(x: 120.0, y: 10.0), Coordinate(x: 110.0, y: 10.0)], innerRings: [[Coordinate(x: 118.0, y: 12.0), Coordinate(x: 118.0, y: 18.0), Coordinate(x: 112.0, y: 18.0), Coordinate(x: 112.0, y: 12.0), Coordinate(x: 118.0, y: 12.0)]])], precision: precision, coordinateSystem: cs)
//
//        let matrix = IntersectionMatrix.generateMatrix(geometry1, geometry2)
//
//        let expected  = IntersectionMatrix(arrayLiteral: [
//            [.two, .one, .two],
//            [.one, .one, .one],
//            [.two, .one, .two]
//            ])
//
//        XCTAssertEqual(matrix, expected)
//    }
    
    /// This is a temporary function used to compare two MultiPoint objects.
    /// It will fail only if a point from one of the collections is not in the other.
    func compare(_ points1: MultiPoint, _ points2: MultiPoint) {
        
        for tempPoint1 in points1 {
            if !points2.contains(tempPoint1) {
                XCTFail()
            }
        }
        
        for tempPoint2 in points2 {
            if !points1.contains(tempPoint2) {
                XCTFail()
            }
        }
    }
    
    ///
    /// From a geometry collection, return either a geometry of dimension zero, a MultiPoint,
    /// a geometry of dimension one, a MultiLineString, or a geometry of dimension two, a MultiLineString.
    ///
    /// - Parameters:
    ///     - geometryCollection: an intersection geometry collection containing no more than one MultiPoint,
    ///                             one MultiLineString, and one MultiLineString, for a maximum three objects.
    ///     - dimension: the dimension of the object in the geometryCollection to be returned.
    ///
    /// - Returns: The object in the geometryCollection with the given dimension or nil, if does not exist.
    ///
    func geometry(_ geometryCollection: GeometryCollection, _ dimension: GeoFeatures.Dimension) -> Geometry? {
        
        guard geometryCollection.count > 0 else { return nil }
        
        for geometry in geometryCollection {
            if let collection = geometry as? MultiPoint, dimension == .zero {
                return collection
            } else if let collection = geometry as? MultiLineString, dimension == .one {
                return collection
            } else if let collection = geometry as? MultiPolygon, dimension == .two {
                return collection
            }
        }

        return nil
    }
    
    ///
    /// This is a function used to compare two geometry collections.  This function is TBD.
    ///
    /// - Parameters:
    ///     - geometry1: The first of two geometries for which an intersection is to be found.
    ///     - geometry2: The second of two geometries for which an intersection is to be found.
    ///     - resultGeometry: The resulting geometry collection.
    ///     - expected: The expected geometry collection.
    ///
    /// - Returns: Nothing
    ///
    func compareTopo(_ geometry1: Geometry, _ geometry2: Geometry, _ resultGeometry: GeometryCollection, expected: GeometryCollection) {
        
//        let errorMessage = "For \(geometry1) and \(geometry2) got an intersection of \(resultGeometry) but expected an intersection of \(expected)."
//
//        if let dimension = geometry1.dimension { }
//
//        if !geometry1.equalsTopo(geometry2) {
//            XCTFail()
//        }
    }
}
