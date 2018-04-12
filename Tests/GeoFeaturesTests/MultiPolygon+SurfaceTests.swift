///
///  MultiPolygon+SurfaceTests.swift
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
///  Created by Tony Stone on 3/29/2016.
///
import XCTest
import GeoFeatures

#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS)) && SWIFT_PACKAGE
    /// Note: Resolution of GeoFeatures.Polygon is ambiguous when ApplicationsServices is included in the app (ApplicationsServices is used by XCTest), this resolves the ambiguity.
    import struct GeoFeatures.Polygon
#endif

// MARK: - Coordinate2D, Fixed, Cartesian -

class MultiPolygonSurfaceCoordinate2DFixedCartesianTests: XCTestCase {

    let precision = Fixed(scale: 100000)
    let cs       = Cartesian()

    func testAreaEmpty() {
        let input    = MultiPolygon(precision: precision, coordinateSystem: cs)
        let expected = 0.0

        XCTAssertEqual(input.area(), expected)
    }

    func testAreaWith2SamePolygons() {

        let input    = MultiPolygon([Polygon([Coordinate(x: 0, y: 0), Coordinate(x: 0, y: 6), Coordinate(x: 6, y: 6), Coordinate(x: 6, y: 0), Coordinate(x: 0, y: 0)], innerRings: [[Coordinate(x: 1, y: 1), Coordinate(x: 4, y: 1), Coordinate(x: 4, y: 2), Coordinate(x: 1, y: 2), Coordinate(x: 1, y: 1)]]), Polygon([Coordinate(x: 0, y: 0), Coordinate(x: 0, y: 6), Coordinate(x: 6, y: 6), Coordinate(x: 6, y: 0), Coordinate(x: 0, y: 0)], innerRings: [[Coordinate(x: 1, y: 1), Coordinate(x: 4, y: 1), Coordinate(x: 4, y: 2), Coordinate(x: 1, y: 2), Coordinate(x: 1, y: 1)]])], precision: precision, coordinateSystem: cs)
        let expected = 66.0

        XCTAssertEqual(input.area(), expected)
    }

    func testAreaWith2DifferentPolygons() {

        let input    = MultiPolygon([Polygon([Coordinate(x: 0, y: 0), Coordinate(x: 0, y: 6), Coordinate(x: 6, y: 6), Coordinate(x: 6, y: 0), Coordinate(x: 0, y: 0)], innerRings: [[Coordinate(x: 1, y: 1), Coordinate(x: 4, y: 1), Coordinate(x: 4, y: 2), Coordinate(x: 1, y: 2), Coordinate(x: 1, y: 1)]]), Polygon([Coordinate(x: 0, y: 0), Coordinate(x: 0, y: 6), Coordinate(x: 6, y: 6), Coordinate(x: 6, y: 0), Coordinate(x: 0, y: 0)], innerRings: [])], precision: precision, coordinateSystem: cs)
        let expected = 69.0

        XCTAssertEqual(input.area(), expected)
    }
}
