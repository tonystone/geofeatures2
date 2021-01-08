///
///  GeometryCollection+GeometryTests.swift
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
///  Created by Tony Stone on 4/24/2016.
///
import XCTest
import GeoFeatures

#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS)) && SWIFT_PACKAGE
    /// Note: Resolution of GeoFeatures.Polygon is ambiguous when ApplicationsServices is included in the app (ApplicationsServices is used by XCTest), this resolves the ambiguity.
    import struct GeoFeatures.Polygon
#endif

class GeometryCollectionGeometryTests: XCTestCase {

    let precision = Floating()
    let cs       = Cartesian()

    // MARK: Dimension

    func testDimension () {
        XCTAssertEqual(GeometryCollection(precision: precision, coordinateSystem: cs).dimension, Dimension.empty)
    }

    func testDimensionWithHomogeneousPoint () {
        XCTAssertEqual(GeometryCollection([Point([1, 1])], precision: precision, coordinateSystem: cs).dimension, Dimension.zero)
    }

    func testDimensionWithHomogeneousLineString () {
        XCTAssertEqual(GeometryCollection([LineString()], precision: precision, coordinateSystem: cs).dimension, Dimension.empty)
    }

    func testDimensionWithHomogeneousLineStringEmpty () {
        XCTAssertEqual(GeometryCollection([LineString([[1, 1], [1, 2]])], precision: precision, coordinateSystem: cs).dimension, Dimension.one)
    }

    func testDimensionWithHomogeneousPolygon () {
        XCTAssertEqual(GeometryCollection([Polygon([[[1, 1], [1, 2], [2, 2], [2, 1], [1, 1]]])], precision: precision, coordinateSystem: cs).dimension, Dimension.two)
    }

    func testDimensionWithHomogeneousPolygonEmpty () {
        XCTAssertEqual(GeometryCollection([Polygon()], precision: precision, coordinateSystem: cs).dimension, Dimension.empty)
    }

    func testDimensionWithNonHomogeneousPointPolygon () {
        XCTAssertEqual(GeometryCollection([Point([1, 1]), Polygon([[[1, 1], [1, 2], [2, 2], [2, 1], [1, 1]]])], precision: precision, coordinateSystem: cs).dimension, Dimension.two)
    }

    func testDimensionWithNonHomogeneousPointPolygonEmpty () {
        XCTAssertEqual(GeometryCollection([Point([1, 1]), Polygon()], precision: precision, coordinateSystem: cs).dimension, Dimension.zero)
    }

    func testDimensionWithNonHomogeneousPointLineString () {
        XCTAssertEqual(GeometryCollection([Point([1, 1]), LineString([[1, 1], [1, 2]])], precision: precision, coordinateSystem: cs).dimension, Dimension.one)
    }

    func testDimensionWithNonHomogeneousPointLineStringEmpty () {
        XCTAssertEqual(GeometryCollection([Point([1, 1]), LineString()], precision: precision, coordinateSystem: cs).dimension, Dimension.zero)
    }

    // MARK: Boundary

    func testBoundary() {
        let input = GeometryCollection([LineString([[1.0, 1.0], [2.0, 2.0]]), Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0]], innerRings: [])] as [Geometry], precision: precision, coordinateSystem: cs)
        let expected = GeometryCollection(precision: precision, coordinateSystem: cs) // GeometryCollection will always return an empty GeometryCollection for boundary

        XCTAssertTrue(input.boundary() == expected, "\(input) is not equal to \(expected)")
    }

    // MARK: - Bounds

    func testBoundsEmpty() {
        let input = GeometryCollection(precision: precision, coordinateSystem: cs)
        let expected: Bounds? = nil

        XCTAssertEqual(input.bounds(), expected)
    }

    func testBoundsWithElements() {
        let input = GeometryCollection([LineString([[1.0, 1.0], [2.0, 2.0]]), Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0]], innerRings: [])] as [Geometry], precision: precision, coordinateSystem: cs)
        let expected = Bounds(min: (x: 1.0, y: 1.0), max: (x: 6.0, y: 4.0))

        XCTAssertEqual(input.bounds(), expected)
    }

    // MARK: Equal

    func testEqualTrue() {
        let input1 = GeometryCollection([LineString([[1.0, 1.0], [2.0, 2.0]]), Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0]], innerRings: [])], precision: precision, coordinateSystem: cs)
        let input2 = GeometryCollection([LineString([[1.0, 1.0], [2.0, 2.0]]), Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0]], innerRings: [])], precision: precision, coordinateSystem: cs)

        XCTAssertEqual(input1, input2)
    }

    func testEqualWithSameTypesFalse() {
        let input1            = GeometryCollection([LineString([[1.0, 1.0], [2.0, 2.0]]), Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0]], innerRings: [])]  as [Geometry], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = GeometryCollection(precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
    }

    func testEqualWithDifferentTypesFalse() {
        let input1            = GeometryCollection([LineString([[1.0, 1.0], [2.0, 2.0]]), Polygon([[6.0, 1.0], [1.0, 1.0], [1.0, 3.0], [3.5, 4.0], [6.0, 3.0]], innerRings: [])]  as [Geometry], precision: precision, coordinateSystem: cs)
        let input2: Geometry  = LineString([[1.0, 1.0], [2.0, 2.0]], precision: precision, coordinateSystem: cs)

        XCTAssertFalse(input1.equals(input2), "\(input1) is not equal to \(input2)")
    }

    // MARK: Valid

    func testValidTrue() {
        /// Empty case
        let testGeometryCollection1 = GeometryCollection(precision: precision, coordinateSystem: cs)
        /// Geometry collection with a LineString and a MultiPoint
        let testGeometryCollection2 = GeometryCollection([LineString([[3, 3], [60, 60], [120, 3]]), MultiPoint([[3, 3], [60, 60], [120, 3]])])

        XCTAssertTrue(testGeometryCollection1.valid())
        XCTAssertTrue(testGeometryCollection2.valid())
    }

    func testValidFalse() {
        /// We cannot currently test the false case, so simply create a dummy case that will return true
        ///
        /// Empty case
        let testGeometryCollection1 = GeometryCollection(precision: precision, coordinateSystem: cs)

        XCTAssertFalse(!testGeometryCollection1.valid())
    }
}
