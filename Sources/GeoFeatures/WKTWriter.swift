///
///  WKTWriter.swift
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
///  Created by Tony Stone on 3/8/2016.
///
import Swift

extension WKTWriter {

    public enum Axis {
        case z, m
    }

    public enum Errors: Error  {
        case invalidNumberOfCoordinates(String)
    }

    /// Translated from BNF
    private enum WKT: String {
        case SINGLE_SPACE                   = " "
        case NEW_LINE                       = "\\n"
        case COMMA                          = ","
        case LEFT_PAREN                     = "("
        case RIGHT_PAREN                    = ")"
        case LEFT_BRACKET                   = "["
        case RIGHT_BRACKET                  = "]"
        case THREEDIMENSIONAL               = "Z"
        case MEASURED                       = "M"
        case EMPTY                          = "EMPTY"
        case POINT                          = "POINT"
        case LINESTRING                     = "LINESTRING"
        case LINEARRING                     = "LINEARRING"
        case POLYGON                        = "POLYGON"
        case MULTIPOINT                     = "MULTIPOINT"
        case MULTILINESTRING                = "MULTILINESTRING"
        case MULTIPOLYGON                   = "MULTIPOLYGON"
        case GEOMETRYCOLLECTION             = "GEOMETRYCOLLECTION"
        case NAN                            = "NaN"
    }
}

///
/// WKTWriter
///
/// WKTWriter generates a WKT – Well-known Text – representation of a `Geometry` object.
///
public class WKTWriter {

    public init(axes: [Axis] = []) {
        self.output = (axes.contains(.z), axes.contains(.m))
    }

    ///
    /// Based on the geometry passed in, converts it into a string representation as specified by
    /// the OGC WKT standard.
    ///
    /// - parameter geometry: A geometry type to be converted to WKT
    /// - returns: WKT string for supported types. If unsupported, an empty string is returned.
    /// - note: This method does not check the validity of the geometry.
    ///
    public func write(_ geometry: Geometry) throws -> String {

        /// BNF: <geometry tagged text> ::= <point tagged text>
        ///                          | <linestring tagged text>
        ///                          | <polygon tagged text>
        ///                          | <triangle tagged text>
        ///                          | <polyhedralsurface tagged text>
        ///                          | <tin tagged text>
        ///                          | <multipoint tagged text>
        ///                          | <multilinestring tagged text>
        ///                          | <multipolygon tagged text>
        ///                          | <geometrycollection tagged text>
        ///
        switch geometry {

        case let point as Point:
            return try self.pointTaggedText(point)

        case let lineString as LineString:
            return try self.lineStringTaggedText(lineString)

        case let linearRing as LinearRing:
            return try self.linearRingTaggedText(linearRing)

        case let polygon as Polygon:
            return try self.polygonTaggedText(polygon)

        case let multiPoint as MultiPoint:
            return try self.multiPointTaggedText(multiPoint)

        case let multiPolygon as MultiPolygon:
            return try self.multiPolygonTaggedText(multiPolygon)

        case let multiLineString as MultiLineString:
            return try self.multiLineStringTaggedText(multiLineString)

        case let geometryCollection as GeometryCollection:
            return try self.geometryCollectionTaggedText(geometryCollection)

        default: return ""
        }
    }

    private let output: (z: Bool, m: Bool)
}

private extension WKTWriter {

    /// BNF: <point tagged text> ::= point <point text>
    private func pointTaggedText(_ point: Point) throws -> String {

        return WKT.POINT.rawValue + WKT.SINGLE_SPACE.rawValue + zmText() + (try pointText(point))
    }

    /// BNF: <point text> ::= <empty set> | <left paren> <point> <right paren>
    private func pointText(_ point: Point) throws -> String {

        return WKT.LEFT_PAREN.rawValue + (try self.coordinateText(point.coordinate)) + WKT.RIGHT_PAREN.rawValue
    }

    /// BNF: <linestring tagged text> ::= linestring <linestring text>
    private func lineStringTaggedText(_ lineString: LineString) throws -> String {

        return WKT.LINESTRING.rawValue + WKT.SINGLE_SPACE.rawValue + zmText() + (try lineStringText(lineString))
    }

    /// BNF: <linestring text> ::= <empty set> | <left paren> <point> {<comma> <point>}* <right paren>
    private func lineStringText(_ lineString: LineString) throws -> String {

        if lineString.isEmpty() {
            return WKT.EMPTY.rawValue
        }

        var lineStringText = WKT.LEFT_PAREN.rawValue

        for index in 0..<lineString.count {
            if index > 0 {
                lineStringText += WKT.COMMA.rawValue + WKT.SINGLE_SPACE.rawValue
            }
            lineStringText += try self.coordinateText(lineString[index])
        }

        lineStringText += WKT.RIGHT_PAREN.rawValue

        return lineStringText
    }

    /// BNF: None defined by OGC
    private func linearRingTaggedText(_ linearRing: LinearRing) throws -> String {

        return WKT.LINEARRING.rawValue + WKT.SINGLE_SPACE.rawValue + zmText() + (try linearRingText(linearRing))
    }

    /// BNF: None defined by OGC
    private func linearRingText(_ linearRing: LinearRing) throws -> String {

        if linearRing.isEmpty() {
            return WKT.EMPTY.rawValue
        }

        var linearRingText = WKT.LEFT_PAREN.rawValue

        for index in 0..<linearRing.count {
            if index > 0 {
                linearRingText += WKT.COMMA.rawValue + WKT.SINGLE_SPACE.rawValue
            }
            linearRingText += try self.coordinateText(linearRing[index])
        }

        linearRingText += WKT.RIGHT_PAREN.rawValue

        return linearRingText
    }

    /// BNF: <polygon tagged text> ::= polygon <polygon text>
    private func polygonTaggedText(_ polygon: Polygon) throws -> String {

        return WKT.POLYGON.rawValue + WKT.SINGLE_SPACE.rawValue + zmText() + (try polygonText(polygon))
    }

    /// BNF: <polygon text> ::= <empty set> | <left paren> <linestring text> {<comma> <linestring text>}* <right paren>
    private func polygonText(_ polygon: Polygon ) throws -> String {

        if polygon.isEmpty() {
            return WKT.EMPTY.rawValue
        }

        var polygonText = WKT.LEFT_PAREN.rawValue + (try linearRingText(polygon.outerRing))

        for index in 0..<polygon.innerRings.count {

            if index < polygon.innerRings.count {
                polygonText += WKT.COMMA.rawValue + WKT.SINGLE_SPACE.rawValue
            }
            polygonText += try linearRingText(polygon.innerRings[index])
        }

        polygonText += WKT.RIGHT_PAREN.rawValue

        return polygonText
    }

    /// BNF: <multipoint tagged text> ::= multipoint <multipoint text>
    private func multiPointTaggedText(_ multiPoint: MultiPoint) throws -> String {

        return WKT.MULTIPOINT.rawValue + WKT.SINGLE_SPACE.rawValue + zmText() + (try multiPointText(multiPoint))
    }

    /// BNF: <multipoint text> ::= <empty set> | <left paren> <point text> {<comma> <point text>}* <right paren>
    private func multiPointText(_ multiPoint: MultiPoint) throws -> String {

        if multiPoint.isEmpty() {
            return WKT.EMPTY.rawValue
        }

        var multiPointText = WKT.LEFT_PAREN.rawValue

        for index in 0..<multiPoint.count {
            if index > 0 {
                multiPointText += WKT.COMMA.rawValue + WKT.SINGLE_SPACE.rawValue
            }
            multiPointText += try pointText(multiPoint[index])
        }

        return multiPointText + WKT.RIGHT_PAREN.rawValue
    }

    /// BNF: <multilinestring tagged text> ::= multilinestring <multilinestring text>
    private func multiLineStringTaggedText(_ multiLineString: MultiLineString) throws -> String {

        return WKT.MULTILINESTRING.rawValue + WKT.SINGLE_SPACE.rawValue + zmText() + (try multiLineStringText(multiLineString))
    }

    /// BNF: <multilinestring text> ::= <empty set> | <left paren> <linestring text> {<comma> <linestring text>}* <right paren>
    private func multiLineStringText(_ multiLineString: MultiLineString) throws -> String {

        if multiLineString.isEmpty() {
            return WKT.EMPTY.rawValue
        }

        var multiLineStringText = WKT.LEFT_PAREN.rawValue

        for index in 0..<multiLineString.count {
            if index > 0 {
                multiLineStringText += WKT.COMMA.rawValue + WKT.SINGLE_SPACE.rawValue
            }
            multiLineStringText += try lineStringText(multiLineString[index])
        }

        return multiLineStringText + WKT.RIGHT_PAREN.rawValue
    }

    /// BNF: <multipolygon tagged text> ::= multipolygon <multipolygon text>
    private func multiPolygonTaggedText(_ multiPolygon: MultiPolygon) throws -> String {

        return WKT.MULTIPOLYGON.rawValue + WKT.SINGLE_SPACE.rawValue + zmText() + (try multiPolygonText(multiPolygon))
    }

    /// BNF: <multipolygon text> ::= <empty set> | <left paren> <polygon text> {<comma> <polygon text>}* <right paren>
    private func multiPolygonText(_ multiPolygon: MultiPolygon ) throws -> String {

        if multiPolygon.isEmpty() {
            return WKT.EMPTY.rawValue
        }

        var multiPolygonText = WKT.LEFT_PAREN.rawValue

        for index in 0..<multiPolygon.count {
            if index > 0 {
                multiPolygonText += WKT.COMMA.rawValue + WKT.SINGLE_SPACE.rawValue
            }
            multiPolygonText += try polygonText(multiPolygon[index])
        }

        return multiPolygonText + WKT.RIGHT_PAREN.rawValue
    }

    /// BNF: <geometrycollection tagged text> ::= geometrycollection <geometrycollection text>
    private func geometryCollectionTaggedText(_ geometryCollection: GeometryCollection) throws -> String {

        return WKT.GEOMETRYCOLLECTION.rawValue + WKT.SINGLE_SPACE.rawValue + zmText() + (try geometryCollectionText(geometryCollection))
    }

    /// BNF: <geometrycollection text> ::= <empty set> | <left paren> <geometry tagged text> {<comma> <geometry tagged text>}* <right paren>
    private func geometryCollectionText(_ geometryCollection: GeometryCollection) throws -> String {

        var geometryCollectionText = WKT.LEFT_PAREN.rawValue

        for index in 0..<geometryCollection.count {

            if index > 0 {
                geometryCollectionText += WKT.COMMA.rawValue + WKT.SINGLE_SPACE.rawValue
            }
            geometryCollectionText += try write(geometryCollection[index])
        }

        return geometryCollectionText + WKT.RIGHT_PAREN.rawValue
    }

    /// BNF: <point> ::= <x> <y>
    /// BNF: <point z> ::= <x> <y> <z>
    /// BNF: <point m> ::= <x> <y> <m>
    /// BNF: <point zm> ::= <x> <y> <z> <m>
    private func coordinateText(_ coordinate: Coordinate) throws -> String  {
        var text = "\(coordinate.x) \(coordinate.y)"

        if output.z {
            guard let z = coordinate.z
                else { throw Errors.invalidNumberOfCoordinates("Coordinate \(coordinate) is missing the Z axis.") }

            text += " \(z)"
        }
        if output.m {
            guard let m = coordinate.m
                else { throw Errors.invalidNumberOfCoordinates("Coordinate \(coordinate) is missing the M axis.") }

            text += " \(m)"
        }
        return text
    }

    private func zmText() -> String {

        var zmText = ""

        if output.z {
            zmText += WKT.THREEDIMENSIONAL.rawValue
        }

        if output.m {
            zmText += WKT.MEASURED.rawValue
        }

        if zmText != "" {
            zmText += WKT.SINGLE_SPACE.rawValue
        }
        return zmText
    }
}
