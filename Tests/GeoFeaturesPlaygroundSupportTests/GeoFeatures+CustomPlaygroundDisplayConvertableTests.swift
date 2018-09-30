///
///  GeoFeatures+CustomPlaygroundDisplayConvertableTests.swift
///
///  Copyright (c) Tony Stone, All rights reserved.
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
///  Created by Tony Stone on 8/20/18.
///
import XCTest

#if os(OSX) || os(iOS)

import GeoFeatures
@testable import GeoFeaturesPlaygroundSupport

class GeoFeaturesCustomPlaygroundDisplayConvertableTests: XCTestCase {
    
    // MARK: - Point

    func testPointPlaygroundDescriptionCartesion() {
        let input = Point([64.0, 64.0], coordinateSystem: Cartesian())

        XCTAssertTrue(input.playgroundDescription is CartesianGeometryVisualizationView)
    }

    func testPointPlaygroundDescriptionGeographic() {
        let input = Point([64.0, 64.0], coordinateSystem: Geographic())

        XCTAssertTrue(input.playgroundDescription is String)
    }

    // MARK: - LineString

    func testLineStringPlaygroundDescriptionCartesion() {
        let input = LineString([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]], coordinateSystem: Cartesian())

        XCTAssertTrue(input.playgroundDescription is CartesianGeometryVisualizationView)
    }

    func testLineStringPlaygroundDescriptionGeographic() {
        let input = LineString([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]], coordinateSystem: Geographic())

        XCTAssertTrue(input.playgroundDescription is String)
    }

    // MARK: - LinearRing

    func testLinearRingPlaygroundDescriptionCartesion() {
        let input = LinearRing([[1, 1], [1, 127], [127, 127], [127, 1], [1, 1]], coordinateSystem: Cartesian())

        XCTAssertTrue(input.playgroundDescription is CartesianGeometryVisualizationView)
    }

    func testLinearRingPlaygroundDescriptionGeographic() {
        let input = LinearRing([[1, 1], [1, 127], [127, 127], [127, 1], [1, 1]], coordinateSystem: Geographic())

        XCTAssertTrue(input.playgroundDescription is String)
    }

    // MARK: - Polygon

    func testPolygonPlaygroundDescriptionCartesion() {
        let input = Polygon([[[1, 1], [64, 128], [128, 1], [1, 1]], [[32, 20], [96, 20], [64, 86], [32, 20]]], coordinateSystem: Cartesian())

        XCTAssertTrue(input.playgroundDescription is CartesianGeometryVisualizationView)
    }

    func testPolygonPlaygroundDescriptionGeographic() {
        let input = Polygon([[[1, 1], [64, 128], [128, 1], [1, 1]], [[32, 20], [96, 20], [64, 86], [32, 20]]], coordinateSystem: Geographic())

        XCTAssertTrue(input.playgroundDescription is String)
    }

    // MARK: - MultiPoint

    func testMultiPointPlaygroundDescriptionCartesion() {
        let input = MultiPoint([[60.0, 60.0], [68.0, 60.0]], coordinateSystem: Cartesian())

        XCTAssertTrue(input.playgroundDescription is CartesianGeometryVisualizationView)
    }

    func testMultiPointPlaygroundDescriptionGeographic() {
        let input = MultiPoint([[60.0, 60.0], [68.0, 60.0]], coordinateSystem: Geographic())

        XCTAssertTrue(input.playgroundDescription is String)
    }

    // MARK: - MultiLineString

    func testMultiLineStringPlaygroundDescriptionCartesion() {
        let input = MultiLineString([[[100.00, 200.00], [150.00, 100.00], [125.00, 100.00]], [[200.00, 200.00], [250.00, 100.00], [225.00, 100.00]]], coordinateSystem: Cartesian())

        XCTAssertTrue(input.playgroundDescription is CartesianGeometryVisualizationView)
    }

    func testMultiLineStringPlaygroundDescriptionGeographic() {
        let input = MultiLineString([[[100.00, 200.00], [150.00, 100.00], [125.00, 100.00]], [[200.00, 200.00], [250.00, 100.00], [225.00, 100.00]]], coordinateSystem: Geographic())

        XCTAssertTrue(input.playgroundDescription is String)
    }

    // MARK: - MultiPolygon

    func testMultiPolygonPlaygroundDescriptionCartesion() {
        let input = MultiPolygon([Polygon([[[1, 1], [60, 128], [60, 1], [1, 1]]]), Polygon([[[64, 1], [64, 128], [128, 1], [64, 1]]])], coordinateSystem: Cartesian())

        XCTAssertTrue(input.playgroundDescription is CartesianGeometryVisualizationView)
    }

    func testMultiPolygonPlaygroundDescriptionGeographic() {
        let input = MultiPolygon([Polygon([[[1, 1], [60, 128], [60, 1], [1, 1]]]), Polygon([[[64, 1], [64, 128], [128, 1], [64, 1]]])], coordinateSystem: Geographic())

        XCTAssertTrue(input.playgroundDescription is String)
    }

    // MARK: - GeometryCollection

    func testGeometryCollectionPlaygroundDescriptionCartesion() {
        let input = GeometryCollection([LineString([[3, 3], [60, 60], [120, 3]]), MultiPoint([[3, 3], [60, 60], [120, 3]])], coordinateSystem: Cartesian())

        XCTAssertTrue(input.playgroundDescription is CartesianGeometryVisualizationView)
    }

    func testGeometryCollectionPlaygroundDescriptionGeographic() {
        let input = GeometryCollection([LineString([[3, 3], [60, 60], [120, 3]]), MultiPoint([[3, 3], [60, 60], [120, 3]])], coordinateSystem: Geographic())

        XCTAssertTrue(input.playgroundDescription is String)
    }

}

#endif
