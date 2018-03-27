///
///  Polygon+SurfaceTests.swift
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
///  Created by Tony Stone on 3/28/2016.
///
import XCTest
import GeoFeatures

#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS)) && SWIFT_PACKAGE
    /// Note: Resolution of GeoFeatures.Polygon is ambiguous when ApplicationsServices is included in the app (ApplicationsServices is used by XCTest), this resolves the ambiguity.
    import struct GeoFeatures.Polygon
#endif

// MARK: - Coordinate2D, FixedPrecision, Cartesian -

class PolygonSurfaceCoordinate2DFixedPrecisionCartesianTests: XCTestCase {

    let precision = FixedPrecision(scale: 100000)
    let cs       = Cartesian()

    func testAreaEmpty() {
        XCTAssertEqual(Polygon(precision: precision, coordinateSystem: cs).area(), 0.0)
    }

    func testAreaWithTriangle() {
        XCTAssertEqual(Polygon(outerRing: [Coordinate(x: 8.29, y: 0.88), Coordinate(x: 2.96, y: 5.15), Coordinate(x: 9.33, y: 7.62), Coordinate(x: 8.29, y: 0.88)], innerRings: [], precision: precision, coordinateSystem: cs).area(), 20.1825)
    }

    func testAreaWithRegularQuadrilateral() {
        XCTAssertEqual(Polygon(outerRing: [Coordinate(x: 8.29, y: 0.88), Coordinate(x: 3.18, y: 3.12), Coordinate(x: 5.43, y: 8.22), Coordinate(x: 10.53, y: 5.98), Coordinate(x: 8.29, y: 0.88)], innerRings: [], precision: precision, coordinateSystem: cs).area(), 31.0643)
    }

    func testAreaWithSimplePolygon1() {
        XCTAssertEqual(Polygon(outerRing: [Coordinate(x: 0.72, y: 2.28), Coordinate(x: 2.66, y: 4.71), Coordinate(x: 5.0, y: 3.5), Coordinate(x: 3.63, y: 2.52), Coordinate(x: 4.0, y: 1.6), Coordinate(x: 1.9, y: 1.0), Coordinate(x: 0.72, y: 2.28)], innerRings: [], precision: precision, coordinateSystem: cs).area(), 8.3593)
    }

    func testAreaWithSimplePolygon2() {
        XCTAssertEqual(Polygon(outerRing: [Coordinate(x: 0, y: 0), Coordinate(x: 0, y: 7), Coordinate(x: 4, y: 2), Coordinate(x: 2, y: 0), Coordinate(x: 0, y: 0)], innerRings: [], precision: precision, coordinateSystem: cs).area(), 16.0)
    }

    func testAreaWithSimplePolygon3() {
        XCTAssertEqual(Polygon(outerRing: [Coordinate(x: 0, y: 0), Coordinate(x: 0, y: 6), Coordinate(x: 6, y: 6), Coordinate(x: 6, y: 0), Coordinate(x: 0, y: 0)], innerRings: [], precision: precision, coordinateSystem: cs).area(), 36.0)
    }

    func testAreaWithSimplePolygonWithHole() {
        XCTAssertEqual(Polygon(outerRing: [Coordinate(x: 0, y: 0), Coordinate(x: 0, y: 6), Coordinate(x: 6, y: 6), Coordinate(x: 6, y: 0), Coordinate(x: 0, y: 0)], innerRings: [[Coordinate(x: 1, y: 1), Coordinate(x: 4, y: 1), Coordinate(x: 4, y: 2), Coordinate(x: 1, y: 2), Coordinate(x: 1, y: 1)]], precision: precision, coordinateSystem: cs).area(), 33.0)
    }

    func testAreaWithPentagon() {
        XCTAssertEqual(Polygon(outerRing: [Coordinate(x: 8.29, y: 0.88), Coordinate(x: 7.61, y: 4.86), Coordinate(x: 1.53, y: 3.60), Coordinate(x: 7.86, y: 8.36), Coordinate(x: 10.79, y: 4.77), Coordinate(x: 8.29, y: 0.88)], innerRings: [], precision: precision, coordinateSystem: cs).area(), 22.35635)
    }

    func testAreaWithRegularPentagon() {
        XCTAssertEqual(Polygon(outerRing: [Coordinate(x: 8.29, y: 0.88), Coordinate(x: 3.81, y: 2.06), Coordinate(x: 3.54, y: 6.68), Coordinate(x: 7.86, y: 8.36), Coordinate(x: 10.79, y: 4.77), Coordinate(x: 8.29, y: 0.88)], innerRings: [], precision: precision, coordinateSystem: cs).area(), 36.89385)
    }

    func testAreaWithRegularDecagon() {
        XCTAssertEqual(Polygon(outerRing: [Coordinate(x: 8.29, y: 0.88), Coordinate(x: 5.85, y: 0.74), Coordinate(x: 3.81, y: 2.06), Coordinate(x: 2.92, y: 4.33), Coordinate(x: 3.54, y: 6.68), Coordinate(x: 5.43, y: 8.22), Coordinate(x: 7.86, y: 8.36), Coordinate(x: 9.91, y: 7.04), Coordinate(x: 10.79, y: 4.77), Coordinate(x: 10.17, y: 2.42), Coordinate(x: 8.29, y: 0.88)], innerRings: [], precision: precision, coordinateSystem: cs).area(), 45.61285)
    }

    func testAreaWithTetrakaidecagon() {
        XCTAssertEqual(Polygon(outerRing: [Coordinate(x: 8.32, y: 1.66), Coordinate(x: 6.55, y: 0.62), Coordinate(x: 4.88, y: 1.14), Coordinate(x: 8.32, y: 2.95), Coordinate(x: 2.96, y: 3.98), Coordinate(x: 7.04, y: 6.15), Coordinate(x: 7.24, y: 7.20), Coordinate(x: 5.43, y: 8.22), Coordinate(x: 7.17, y: 8.48), Coordinate(x: 8.84, y: 7.96), Coordinate(x: 6.65, y: 4.32), Coordinate(x: 10.76, y: 5.12), Coordinate(x: 8.87, y: 4.06), Coordinate(x: 9.74, y: 1.86), Coordinate(x: 8.32, y: 1.66)], innerRings: [], precision: precision, coordinateSystem: cs).area(), 18.63)
    }

    func testAreaWithRegularQuadrilateralCrossingOrigin () {
        XCTAssertEqual(Polygon(outerRing: [Coordinate(x: 1.00, y: -1.00), Coordinate(x: -1.00, y: -1.00), Coordinate(x: -1.00, y: 1.00), Coordinate(x: 1.00, y: 1.00), Coordinate(x: 1.00, y: -1.00)], innerRings: [], precision: precision, coordinateSystem: cs).area(), 4.0)
    }

    func testPerformanceAreaQuadrilateral() {
        let geometry = Polygon(outerRing: [Coordinate(x: 8.29, y: 0.88), Coordinate(x: 3.18, y: 3.12), Coordinate(x: 5.43, y: 8.22), Coordinate(x: 10.53, y: 5.98), Coordinate(x: 8.29, y: 0.88)], innerRings: [], precision: precision, coordinateSystem: cs)

        self.measure {

            for _ in 1...500000 {
                let _ = geometry.area()
            }
        }
    }
}
