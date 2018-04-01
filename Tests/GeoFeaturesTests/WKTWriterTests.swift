///
///  WKTWriterTests.swift
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
///  Created by Paul Chang on 3/9/2016.
///
import XCTest
import GeoFeatures

#if (os(OSX) || os(iOS) || os(tvOS) || os(watchOS)) && SWIFT_PACKAGE
    /// Note: Resolution of GeoFeatures.Polygon is ambiguous when ApplicationsServices is included in the app (ApplicationsServices is used by XCTest), this resolves the ambiguity.
    import struct GeoFeatures.Polygon
#endif

private struct UnsupportedGeometry: Geometry {

    let precision: Precision = FloatingPrecision()

    let coordinateSystem: CoordinateSystem = Cartesian()

    let dimension: GeoFeatures.Dimension = .one

    func isEmpty() -> Bool {
        return true
    }

    func bounds() -> Bounds? {
        return nil
    }

    func boundary() -> Geometry {
        return GeometryCollection()
    }

    func equals(_ other: Geometry) -> Bool { return false }
}

// MARK: - Coordinate2D -

class WKTWriterCoordinate2DTests: XCTestCase {

    var writer = WKTWriter()

    // MARK: - General

    func testWriteUnsupportedGeometry() throws {

        XCTAssertEqual("", try writer.write(UnsupportedGeometry()))
    }

    func testWritePoint() throws {

        XCTAssertEqual("POINT (1.0 1.0)", try writer.write(Point(coordinate: Coordinate(x:1.0, y:1.0))))
    }

    func testWriteLineStringEmpty() throws {

        let emptyLineString = LineString()

        XCTAssertEqual("LINESTRING EMPTY", try writer.write(emptyLineString))
    }

    func testWriteLineStringsinglePoint() throws {

        XCTAssertEqual("LINESTRING (1.0 1.0)", try writer.write(LineString(coordinates: [Coordinate(x:1.0, y:1.0)])))
    }

    func testWriteLineStringmultiplePoints() throws {

        XCTAssertEqual("LINESTRING (1.0 1.0, 2.0 2.0, 3.0 3.0)", try writer.write(LineString(coordinates: [Coordinate(x:1.0, y:1.0), Coordinate(x:2.0, y:2.0), Coordinate(x:3.0, y:3.0)])))
    }

    func testWriteLinearRingEmpty() throws {

        let emptyLinearRing = LinearRing()

        XCTAssertEqual("LINEARRING EMPTY", try writer.write(emptyLinearRing))
    }

    func testWriteLinearRing() throws {

        XCTAssertEqual("LINEARRING (1.0 1.0, 2.0 2.0, 3.0 3.0, 1.0 1.0)", try writer.write(LinearRing(coordinates: [Coordinate(x:1.0, y:1.0), Coordinate(x:2.0, y:2.0), Coordinate(x:3.0, y:3.0), Coordinate(x:1.0, y:1.0)])))
    }

    func testWritePolygonEmpty() throws {

        XCTAssertEqual("POLYGON EMPTY", try writer.write(Polygon()))
    }

    func testWritePolygon() throws {

        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0), Coordinate(x:2.0, y:2.0), Coordinate(x:3.0, y:3.0), Coordinate(x:1.0, y:1.0)])
        let innerRing = LinearRing(coordinates: [Coordinate(x:4.0, y:4.0), Coordinate(x:5.0, y:5.0), Coordinate(x:6.0, y:6.0), Coordinate(x:4.0, y:4.0)])

        XCTAssertEqual("POLYGON ((1.0 1.0, 2.0 2.0, 3.0 3.0, 1.0 1.0), (4.0 4.0, 5.0 5.0, 6.0 6.0, 4.0 4.0))", try writer.write(Polygon(outerRing: outerRing, innerRings: [innerRing])))
    }

    func testWritePolygonZeroInnerRings() throws {

        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0), Coordinate(x:2.0, y:2.0), Coordinate(x:3.0, y:3.0), Coordinate(x:1.0, y:1.0)])

        XCTAssertEqual("POLYGON ((1.0 1.0, 2.0 2.0, 3.0 3.0, 1.0 1.0))", try writer.write(Polygon(outerRing: outerRing, innerRings: [])))
    }

    func testWriteMultiPointEmpty() throws {

        let emptyMultiPoint = MultiPoint(elements: [])

        XCTAssertEqual("MULTIPOINT EMPTY", try writer.write(emptyMultiPoint))
    }

    func testWriteMultiPointSinglePoint() throws {

        let multiPoint = MultiPoint(elements: [Point(coordinate: Coordinate(x:1.0, y:1.0))])

        XCTAssertEqual("MULTIPOINT ((1.0 1.0))", try writer.write(multiPoint))
    }

    func testWriteMultiPointTwoPoints() throws {

        let multiPoint = MultiPoint(elements: [Point(coordinate: Coordinate(x:1.0, y:1.0)), Point(coordinate: Coordinate(x:2.0, y:2.0))])

        XCTAssertEqual("MULTIPOINT ((1.0 1.0), (2.0 2.0))", try writer.write(multiPoint))
    }

    func testWriteMultiLineStringEmpty() throws {

        let multiLineString = MultiLineString(elements: [])

        XCTAssertEqual("MULTILINESTRING EMPTY", try writer.write(multiLineString))
    }

    func testWriteMultiLineStringSingleLineString() throws {

        let multiLineString = MultiLineString(elements: [LineString(coordinates: [Coordinate(x:1.0, y:1.0), Coordinate(x:2.0, y:2.0)])])

        XCTAssertEqual("MULTILINESTRING ((1.0 1.0, 2.0 2.0))", try writer.write(multiLineString))
    }

    func testWriteMultiLineStringMultipleLineString() throws {

        let multiLineString = MultiLineString(elements: [LineString(coordinates: [Coordinate(x:1.0, y:1.0), Coordinate(x:2.0, y:2.0)]), LineString(coordinates: [Coordinate(x:3.0, y:3.0), Coordinate(x:4.0, y:4.0)])])

        XCTAssertEqual("MULTILINESTRING ((1.0 1.0, 2.0 2.0), (3.0 3.0, 4.0 4.0))", try writer.write(multiLineString))
    }

    func testWriteMultiPolygonEmpty() throws {

        let emptyMultiPolygon = MultiPolygon()

        XCTAssertEqual("MULTIPOLYGON EMPTY", try writer.write(emptyMultiPolygon))
    }

    func testWriteMultiPolygon() throws {
        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0), Coordinate(x:2.0, y:2.0), Coordinate(x:3.0, y:3.0), Coordinate(x:1.0, y:1.0)])
        let innerRing = LinearRing(coordinates: [Coordinate(x:4.0, y:4.0), Coordinate(x:5.0, y:5.0), Coordinate(x:6.0, y:6.0), Coordinate(x:4.0, y:4.0)])

        XCTAssertEqual("MULTIPOLYGON (((1.0 1.0, 2.0 2.0, 3.0 3.0, 1.0 1.0), (4.0 4.0, 5.0 5.0, 6.0 6.0, 4.0 4.0)), ((1.0 1.0, 2.0 2.0, 3.0 3.0, 1.0 1.0), (4.0 4.0, 5.0 5.0, 6.0 6.0, 4.0 4.0)))", try writer.write(MultiPolygon(elements: [Polygon(outerRing: outerRing, innerRings: [innerRing]), Polygon(outerRing: outerRing, innerRings: [innerRing])])))
    }

    func testWriteGeometryCollection() throws {

        var geometryCollection = GeometryCollection()

        geometryCollection.append(Point(coordinate: Coordinate(x:1.0, y:2.0)))
        geometryCollection.append(Point(coordinate: Coordinate(x:10.0, y:20.0)))
        geometryCollection.append(LineString(coordinates: [Coordinate(x:3.0, y:4.0)]))
        geometryCollection.append(LinearRing(coordinates: [Coordinate(x:1.0, y:1.0), Coordinate(x:2.0, y:2.0), Coordinate(x:3.0, y:3.0), Coordinate(x:1.0, y:1.0)]))
        geometryCollection.append(Polygon(outerRing: LinearRing(coordinates: [Coordinate(x:1.0, y:1.0), Coordinate(x:2.0, y:2.0), Coordinate(x:3.0, y:3.0), Coordinate(x:1.0, y:1.0)]), innerRings: [LinearRing(coordinates: [Coordinate(x:4.0, y:4.0), Coordinate(x:5.0, y:5.0), Coordinate(x:6.0, y:6.0), Coordinate(x:4.0, y:4.0)])]))

        XCTAssertEqual("GEOMETRYCOLLECTION (POINT (1.0 2.0), POINT (10.0 20.0), LINESTRING (3.0 4.0), LINEARRING (1.0 1.0, 2.0 2.0, 3.0 3.0, 1.0 1.0), POLYGON ((1.0 1.0, 2.0 2.0, 3.0 3.0, 1.0 1.0), (4.0 4.0, 5.0 5.0, 6.0 6.0, 4.0 4.0)))", try writer.write(geometryCollection))
    }
}

// MARK: - Coordinate2DM -

class WKTWriterCoordinate2DMTests: XCTestCase {

    var writer = WKTWriter(axes: [.m])

    func testWritePoint() throws {

        XCTAssertEqual("POINT M (1.0 2.0 3.0)", try writer.write(Point(coordinate: Coordinate(x:1.0, y:2.0, m:3.0))))
    }

    func testWriteLineStringEmpty() throws {

        let emptyLineString = LineString()

        XCTAssertEqual("LINESTRING M EMPTY", try writer.write(emptyLineString))
    }

    func testWriteLineStringsinglePoint() throws {

        XCTAssertEqual("LINESTRING M (1.0 1.0 2.0)", try writer.write(LineString(coordinates: [Coordinate(x:1.0, y:1.0, m:2.0)])))
    }

    func testWriteLineStringmultiplePoints() throws {

        XCTAssertEqual("LINESTRING M (1.0 1.0 2.0, 2.0 2.0 4.0, 3.0 3.0 6.0)", try writer.write(LineString(coordinates: [Coordinate(x:1.0, y:1.0, m:2.0), Coordinate(x:2.0, y:2.0, m:4.0), Coordinate(x:3.0, y:3.0, m:6.0)])))
    }

    func testWriteLinearRingEmpty() throws {

        let emptyLinearRing = LinearRing()

        XCTAssertEqual("LINEARRING M EMPTY", try writer.write(emptyLinearRing))
    }

    func testWriteLinearRing() throws {

        XCTAssertEqual("LINEARRING M (1.0 1.0 2.0, 2.0 2.0 4.0, 3.0 3.0 6.0, 1.0 1.0 2.0)", try writer.write(LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, m: 2.0), Coordinate(x:2.0, y:2.0, m:4.0), Coordinate(x:3.0, y:3.0, m:6.0), Coordinate(x:1.0, y:1.0, m:2.0)])))
    }

    func testWritePolygonEmpty() throws {

        XCTAssertEqual("POLYGON M EMPTY", try writer.write(Polygon()))
    }

    func testWritePolygon() throws {

        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, m:2.0), Coordinate(x:2.0, y:2.0, m:4.0), Coordinate(x:3.0, y:3.0, m:6.0), Coordinate(x:1.0, y:1.0, m:2.0)])
        let innerRing = LinearRing(coordinates: [Coordinate(x:4.0, y:4.0, m:8.0), Coordinate(x:5.0, y:5.0, m:10.0), Coordinate(x:6.0, y:6.0, m:12.0), Coordinate(x:4.0, y:4.0, m:8.0)])

        XCTAssertEqual("POLYGON M ((1.0 1.0 2.0, 2.0 2.0 4.0, 3.0 3.0 6.0, 1.0 1.0 2.0), (4.0 4.0 8.0, 5.0 5.0 10.0, 6.0 6.0 12.0, 4.0 4.0 8.0))", try writer.write(Polygon(outerRing: outerRing, innerRings: [innerRing])))
    }

    func testWritePolygonZeroInnerRings() throws {

        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, m:2.0), Coordinate(x:2.0, y:2.0, m:4.0), Coordinate(x:3.0, y:3.0, m:6.0), Coordinate(x:1.0, y:1.0, m:2.0)])

        XCTAssertEqual("POLYGON M ((1.0 1.0 2.0, 2.0 2.0 4.0, 3.0 3.0 6.0, 1.0 1.0 2.0))", try writer.write(Polygon(outerRing: outerRing, innerRings: [])))
    }

    func testWriteMultiPointEmpty() throws {

        let multiPoint = MultiPoint(elements: [])

        XCTAssertEqual("MULTIPOINT M EMPTY", try writer.write(multiPoint))
    }

    func testWriteMultiPointSinglePoint() throws {

        let multiPoint = MultiPoint(elements: [Point(coordinate: Coordinate(x:1.0, y:1.0, m: 2.0))])

        XCTAssertEqual("MULTIPOINT M ((1.0 1.0 2.0))", try writer.write(multiPoint))
    }

    func testWriteMultiPointTwoPoints() throws {

        let multiPoint = MultiPoint(elements: [Point(coordinate: Coordinate(x:1.0, y:1.0, m:2.0)), Point(coordinate: Coordinate(x:2.0, y:2.0, m:4.0))])

        XCTAssertEqual("MULTIPOINT M ((1.0 1.0 2.0), (2.0 2.0 4.0))", try writer.write(multiPoint))
    }

    func testWriteMultiLineStringEmpty() throws {

        let multiLineString = MultiLineString(elements: [])

        XCTAssertEqual("MULTILINESTRING M EMPTY", try writer.write(multiLineString))
    }

    func testWriteMultiLineStringSingleLineString() throws {

        let multiLineString = MultiLineString(elements: [LineString(coordinates: [Coordinate(x:1.0, y:1.0, m: 2.0), Coordinate(x:2.0, y:2.0, m:4.0)])])

        XCTAssertEqual("MULTILINESTRING M ((1.0 1.0 2.0, 2.0 2.0 4.0))", try writer.write(multiLineString))
    }

    func testWriteMultiLineStringMultipleLineString() throws {

        let multiLineString = MultiLineString(elements: [LineString(coordinates: [Coordinate(x:1.0, y:1.0, m:2.0), Coordinate(x:2.0, y:2.0, m:4.0)]), LineString(coordinates: [Coordinate(x:3.0, y:3.0, m:6.0), Coordinate(x:4.0, y:4.0, m:8.0)])])

        XCTAssertEqual("MULTILINESTRING M ((1.0 1.0 2.0, 2.0 2.0 4.0), (3.0 3.0 6.0, 4.0 4.0 8.0))", try writer.write(multiLineString))
    }

    func testWriteMultiPolygonEmpty() throws {

        let emptyMultiPolygon = MultiPolygon()

        XCTAssertEqual("MULTIPOLYGON M EMPTY", try writer.write(emptyMultiPolygon))
    }

    func testWriteMultiPolygon() throws {
        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, m:2.0), Coordinate(x:2.0, y:2.0, m:4.0), Coordinate(x:3.0, y:3.0, m:6.0), Coordinate(x:1.0, y:1.0, m:2.0)])
        let innerRing = LinearRing(coordinates: [Coordinate(x:4.0, y:4.0, m:8.0), Coordinate(x:5.0, y:5.0, m:10.0), Coordinate(x:6.0, y:6.0, m:12.0), Coordinate(x:4.0, y:4.0, m:8.0)])

        XCTAssertEqual("MULTIPOLYGON M (((1.0 1.0 2.0, 2.0 2.0 4.0, 3.0 3.0 6.0, 1.0 1.0 2.0), (4.0 4.0 8.0, 5.0 5.0 10.0, 6.0 6.0 12.0, 4.0 4.0 8.0)), ((1.0 1.0 2.0, 2.0 2.0 4.0, 3.0 3.0 6.0, 1.0 1.0 2.0), (4.0 4.0 8.0, 5.0 5.0 10.0, 6.0 6.0 12.0, 4.0 4.0 8.0)))", try writer.write(MultiPolygon(elements: [Polygon(outerRing: outerRing, innerRings: [innerRing]), Polygon(outerRing: outerRing, innerRings: [innerRing])])))
    }
}

// MARK: - Coordinate3D -

class WKTWriterCoordinate3DTests: XCTestCase {

    var writer = WKTWriter(axes: [.z])

    func testWritePoint() throws {

        XCTAssertEqual("POINT Z (1.0 2.0 3.0)", try writer.write(Point(coordinate: Coordinate(x:1.0, y:2.0, z:3.0))))
    }

    func testWriteLineStringEmpty() throws {

        let emptyLineString = LineString()

        XCTAssertEqual("LINESTRING Z EMPTY", try writer.write(emptyLineString))
    }

    func testWriteLineStringsinglePoint() throws {

        XCTAssertEqual("LINESTRING Z (1.0 1.0 1.0)", try writer.write(LineString(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0)])))
    }

    func testWriteLineStringmultiplePoints() throws {

        XCTAssertEqual("LINESTRING Z (1.0 1.0 1.0, 2.0 2.0 2.0, 3.0 3.0 3.0)", try writer.write(LineString(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0), Coordinate(x:2.0, y:2.0, z:2.0), Coordinate(x:3.0, y:3.0, z:3.0)])))
    }

    func testWriteLinearRingEmpty() throws {

        let emptyLinearRing = LinearRing()

        XCTAssertEqual("LINEARRING Z EMPTY", try writer.write(emptyLinearRing))
    }

    func testWriteLinearRing() throws {

        XCTAssertEqual("LINEARRING Z (1.0 1.0 1.0, 2.0 2.0 2.0, 3.0 3.0 3.0, 1.0 1.0 1.0)", try writer.write(LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0), Coordinate(x:2.0, y:2.0, z:2.0), Coordinate(x:3.0, y:3.0, z:3.0), Coordinate(x:1.0, y:1.0, z:1.0)])))
    }

    func testWritePolygonEmpty() throws {

        XCTAssertEqual("POLYGON Z EMPTY", try writer.write(Polygon()))
    }

    func testWritePolygon() throws {

        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0), Coordinate(x:2.0, y:2.0, z:2.0), Coordinate(x:3.0, y:3.0, z:3.0), Coordinate(x:1.0, y:1.0, z:1.0)])
        let innerRing = LinearRing(coordinates: [Coordinate(x:4.0, y:4.0, z:4.0), Coordinate(x:5.0, y:5.0, z:5.0), Coordinate(x:6.0, y:6.0, z:6.0), Coordinate(x:4.0, y:4.0, z:4.0)])

        XCTAssertEqual("POLYGON Z ((1.0 1.0 1.0, 2.0 2.0 2.0, 3.0 3.0 3.0, 1.0 1.0 1.0), (4.0 4.0 4.0, 5.0 5.0 5.0, 6.0 6.0 6.0, 4.0 4.0 4.0))", try writer.write(Polygon(outerRing: outerRing, innerRings: [innerRing])))
    }

    func testWritePolygonZeroInnerRings() throws {

        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0), Coordinate(x:2.0, y:2.0, z:2.0), Coordinate(x:3.0, y:3.0, z:3.0), Coordinate(x:1.0, y:1.0, z:1.0)])

        XCTAssertEqual("POLYGON Z ((1.0 1.0 1.0, 2.0 2.0 2.0, 3.0 3.0 3.0, 1.0 1.0 1.0))", try writer.write(Polygon(outerRing: outerRing, innerRings: [])))
    }

    func testWriteMultiPointEmpty() throws {

        let multiPoint = MultiPoint(elements: [])

        XCTAssertEqual("MULTIPOINT Z EMPTY", try writer.write(multiPoint))
    }

    func testWriteMultiPointSinglePoint() throws {

        let multiPoint = MultiPoint(elements: [Point(coordinate: Coordinate(x:1.0, y:1.0, z: 2.0))])

        XCTAssertEqual("MULTIPOINT Z ((1.0 1.0 2.0))", try writer.write(multiPoint))
    }

    func testWriteMultiPointTwoPoints() throws {

        let multiPoint = MultiPoint(elements: [Point(coordinate: Coordinate(x:1.0, y:1.0, z:1.0)), Point(coordinate: Coordinate(x:2.0, y:2.0, z:2.0))])

        XCTAssertEqual("MULTIPOINT Z ((1.0 1.0 1.0), (2.0 2.0 2.0))", try writer.write(multiPoint))
    }

    func testWriteMultiLineStringEmpty() throws {

        let multiLineString = MultiLineString(elements: [])

        XCTAssertEqual("MULTILINESTRING Z EMPTY", try writer.write(multiLineString))
    }

    func testWriteMultiLineStringSingleLineString() throws {

        let multiLineString = MultiLineString(elements: [LineString(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0), Coordinate(x:2.0, y:2.0, z:2.0)])])

        XCTAssertEqual("MULTILINESTRING Z ((1.0 1.0 1.0, 2.0 2.0 2.0))", try writer.write(multiLineString))
    }

    func testWriteMultiLineStringMultipleLineString() throws {

        let multiLineString = MultiLineString(elements: [LineString(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0), Coordinate(x:2.0, y:2.0, z:2.0)]), LineString(coordinates: [Coordinate(x:3.0, y:3.0, z:3.0), Coordinate(x:4.0, y:4.0, z:4.0)])])

        XCTAssertEqual("MULTILINESTRING Z ((1.0 1.0 1.0, 2.0 2.0 2.0), (3.0 3.0 3.0, 4.0 4.0 4.0))", try writer.write(multiLineString))
    }

    func testWriteMultiPolygonEmpty() throws {

        let emptyMultiPolygon = MultiPolygon()

        XCTAssertEqual("MULTIPOLYGON Z EMPTY", try writer.write(emptyMultiPolygon))
    }

    func testWriteMultiPolygon() throws {
        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0), Coordinate(x:2.0, y:2.0, z:2.0), Coordinate(x:3.0, y:3.0, z:3.0), Coordinate(x:1.0, y:1.0, z:1.0)])
        let innerRing = LinearRing(coordinates: [Coordinate(x:4.0, y:4.0, z:4.0), Coordinate(x:5.0, y:5.0, z:5.0), Coordinate(x:6.0, y:6.0, z:6.0), Coordinate(x:4.0, y:4.0, z:4.0)])

        XCTAssertEqual("MULTIPOLYGON Z (((1.0 1.0 1.0, 2.0 2.0 2.0, 3.0 3.0 3.0, 1.0 1.0 1.0), (4.0 4.0 4.0, 5.0 5.0 5.0, 6.0 6.0 6.0, 4.0 4.0 4.0)), ((1.0 1.0 1.0, 2.0 2.0 2.0, 3.0 3.0 3.0, 1.0 1.0 1.0), (4.0 4.0 4.0, 5.0 5.0 5.0, 6.0 6.0 6.0, 4.0 4.0 4.0)))", try writer.write(MultiPolygon(elements: [Polygon(outerRing: outerRing, innerRings: [innerRing]), Polygon(outerRing: outerRing, innerRings: [innerRing])])))
    }
}

// MARK: - Coordinate3DM -

class WKTWriterCoordinate3DMTests: XCTestCase {

    var writer = WKTWriter(axes: [.z, .m])

    func testWritePoint() throws {

        XCTAssertEqual("POINT ZM (1.0 2.0 3.0 4.0)", try writer.write(Point(coordinate: Coordinate(x:1.0, y:2.0, z:3.0, m:4.0))))
    }

    func testWriteLineStringEmpty() throws {

        let emptyLineString = LineString()

        XCTAssertEqual("LINESTRING ZM EMPTY", try writer.write(emptyLineString))
    }

    func testWriteLineStringsinglePoint() throws {

        XCTAssertEqual("LINESTRING ZM (1.0 1.0 1.0 3.0)", try writer.write(LineString(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0, m:3.0)])))
    }

    func testWriteLineStringmultiplePoints() throws {

        XCTAssertEqual("LINESTRING ZM (1.0 1.0 1.0 3.0, 2.0 2.0 2.0 6.0, 3.0 3.0 3.0 9.0)", try writer.write(LineString(coordinates: [Coordinate(x:1.0, y:1.0, z: 1.0, m:3.0), Coordinate(x:2.0, y:2.0, z:2.0, m:6.0), Coordinate(x:3.0, y:3.0, z:3.0, m:9.0)])))
    }

    func testWriteLinearRingEmpty() throws {

        let emptyLinearRing = LinearRing()

        XCTAssertEqual("LINEARRING ZM EMPTY", try writer.write(emptyLinearRing))
    }

    func testWriteLinearRing() throws {

        XCTAssertEqual("LINEARRING ZM (1.0 1.0 1.0 3.0, 2.0 2.0 2.0 6.0, 3.0 3.0 3.0 9.0, 1.0 1.0 1.0 3.0)", try writer.write(LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0, m: 3.0), Coordinate(x:2.0, y:2.0, z:2.0, m:6.0), Coordinate(x:3.0, y:3.0, z:3.0, m:9.0), Coordinate(x:1.0, y:1.0, z:1.0, m:3.0)])))
    }

    func testWritePolygonEmpty() throws {

        XCTAssertEqual("POLYGON ZM EMPTY", try writer.write(Polygon()))
    }

    func testWritePolygon() throws {

        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0, m:3.0), Coordinate(x:2.0, y:2.0, z:2.0, m:6.0), Coordinate(x:3.0, y:3.0, z:3.0, m:9.0), Coordinate(x:1.0, y:1.0, z:1.0, m:3.0)])
        let innerRing = LinearRing(coordinates: [Coordinate(x:4.0, y:4.0, z:4.0, m:12.0), Coordinate(x:5.0, y:5.0, z:5.0, m:15.0), Coordinate(x:6.0, y:6.0, z:6.0, m:18.0), Coordinate(x:4.0, y:4.0, z:4.0, m:12.0)])

        XCTAssertEqual("POLYGON ZM ((1.0 1.0 1.0 3.0, 2.0 2.0 2.0 6.0, 3.0 3.0 3.0 9.0, 1.0 1.0 1.0 3.0), (4.0 4.0 4.0 12.0, 5.0 5.0 5.0 15.0, 6.0 6.0 6.0 18.0, 4.0 4.0 4.0 12.0))", try writer.write(Polygon(outerRing: outerRing, innerRings: [innerRing])))
    }

    func testWritePolygonZeroInnerRings() throws {

        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0, m:3.0), Coordinate(x:2.0, y:2.0, z:2.0, m:6.0), Coordinate(x:3.0, y:3.0, z:3.0, m:9.0), Coordinate(x:1.0, y:1.0, z:1.0, m:3.0)])

        XCTAssertEqual("POLYGON ZM ((1.0 1.0 1.0 3.0, 2.0 2.0 2.0 6.0, 3.0 3.0 3.0 9.0, 1.0 1.0 1.0 3.0))", try writer.write(Polygon(outerRing: outerRing, innerRings: [])))
    }

    func testWriteMultiPointEmpty() throws {

        let multiPoint = MultiPoint(elements: [])

        XCTAssertEqual("MULTIPOINT ZM EMPTY", try writer.write(multiPoint))
    }

    func testWriteMultiPointSinglePoint() throws {

        let multiPoint = MultiPoint(elements: [Point(coordinate: Coordinate(x:1.0, y:1.0, z: 1.0, m: 3.0))])

        XCTAssertEqual("MULTIPOINT ZM ((1.0 1.0 1.0 3.0))", try writer.write(multiPoint))
    }

    func testWriteMultiPointTwoPoints() throws {

        let multiPoint = MultiPoint(elements: [Point(coordinate: Coordinate(x:1.0, y:1.0, z:1.0, m:3.0)), Point(coordinate: Coordinate(x:2.0, y:2.0, z:2.0, m:6.0))])

        XCTAssertEqual("MULTIPOINT ZM ((1.0 1.0 1.0 3.0), (2.0 2.0 2.0 6.0))", try writer.write(multiPoint))
    }

    func testWriteMultiLineStringEmpty() throws {

        let multiLineString = MultiLineString(elements: [])

        XCTAssertEqual("MULTILINESTRING ZM EMPTY", try writer.write(multiLineString))
    }

    func testWriteMultiLineStringSingleLineString() throws {

        let multiLineString = MultiLineString(elements: [LineString(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0, m:3.0), Coordinate(x:2.0, y:2.0, z:2.0, m:6.0)])])

        XCTAssertEqual("MULTILINESTRING ZM ((1.0 1.0 1.0 3.0, 2.0 2.0 2.0 6.0))", try writer.write(multiLineString))
    }

    func testWriteMultiLineStringMultipleLineString() throws {

        let multiLineString = MultiLineString(elements: [LineString(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0, m:3.0), Coordinate(x:2.0, y:2.0, z:2.0, m:6.0)]), LineString(coordinates: [Coordinate(x:3.0, y:3.0, z:3.0, m:9.0), Coordinate(x:4.0, y:4.0, z:4.0, m:12.0)])])

        XCTAssertEqual("MULTILINESTRING ZM ((1.0 1.0 1.0 3.0, 2.0 2.0 2.0 6.0), (3.0 3.0 3.0 9.0, 4.0 4.0 4.0 12.0))", try writer.write(multiLineString))
    }

    func testWriteMultiPolygonEmpty() throws {

        let emptyMultiPolygon = MultiPolygon()

        XCTAssertEqual("MULTIPOLYGON ZM EMPTY", try writer.write(emptyMultiPolygon))
    }

    func testWriteMultiPolygon() throws {
        let outerRing = LinearRing(coordinates: [Coordinate(x:1.0, y:1.0, z:1.0, m:3.0), Coordinate(x:2.0, y:2.0, z:2.0, m:6.0), Coordinate(x:3.0, y:3.0, z:3.0, m:9.0), Coordinate(x:1.0, y:1.0, z:1.0, m:3.0)])
        let innerRing = LinearRing(coordinates: [Coordinate(x:4.0, y:4.0, z:4.0, m:12.0), Coordinate(x:5.0, y:5.0, z:5.0, m:15.0), Coordinate(x:6.0, y:6.0, z:6.0, m:18.0), Coordinate(x:4.0, y:4.0, z:4.0, m:12.0)])

        XCTAssertEqual("MULTIPOLYGON ZM (((1.0 1.0 1.0 3.0, 2.0 2.0 2.0 6.0, 3.0 3.0 3.0 9.0, 1.0 1.0 1.0 3.0), (4.0 4.0 4.0 12.0, 5.0 5.0 5.0 15.0, 6.0 6.0 6.0 18.0, 4.0 4.0 4.0 12.0)), ((1.0 1.0 1.0 3.0, 2.0 2.0 2.0 6.0, 3.0 3.0 3.0 9.0, 1.0 1.0 1.0 3.0), (4.0 4.0 4.0 12.0, 5.0 5.0 5.0 15.0, 6.0 6.0 6.0 18.0, 4.0 4.0 4.0 12.0)))", try writer.write(MultiPolygon(elements: [Polygon(outerRing: outerRing, innerRings: [innerRing]), Polygon(outerRing: outerRing, innerRings: [innerRing])])))
    }
}
