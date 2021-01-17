///
///  GeoJSONReader.swift
///
///  Copyright 2016 Tony Stone
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
///  Created by Tony Stone on 2/10/16.
///
import Swift
import Foundation

///
/// GeoJSON reader for GeoFeatures based on the Internet Engineering Task Force (IETF) proposed standard "The GeoJSON Format"
///
/// For more information see [Internet Engineering Task Force (IETF) - The GeoJSON Format](https://tools.ietf.org/html/rfc7946#section-4)
///
public class GeoJSONReader {

    public enum Errors: Error {
        case invalidJSON(String)
        case invalidEncoding(String)
        case invalidNumberOfCoordinates(String)
        case unsupportedType(String)
        case missingAttribute(String)
    }

    fileprivate let expectedStringEncoding = String.Encoding.utf8

    fileprivate let cs: CoordinateSystem
    fileprivate let precision: Precision

    ///
    /// Initialize this reader
    ///
    /// - Parameters:
    ///     - precision: The `Precision` model that should used for all coordinates.
    ///     - coordinateSystem: The 'CoordinateSystem` the result Geometries should use in calculations on their coordinates.
    ///
    public init(precision: Precision = defaultPrecision, coordinateSystem: CoordinateSystem = defaultCoordinateSystem) {
        self.cs = coordinateSystem
        self.precision = precision
    }

    ///
    /// Read a GeoJSON string into Geometry objects.
    ///
    /// - Parameters:
    ///     - string: The GeoJSON string to read
    ///
    /// - Returns: A Geometry object representing the GeoJSON
    ///
    public func read(string: String) throws -> Geometry {
        return try self.read(data: Data(Array(string.utf8)))
    }

    ///
    /// Read a json Data object into Geometry objects.
    ///
    /// - Parameters:
    ///     - data: The GeoJSON Data object to read
    ///
    /// - Returns: A Geometry object representing the GeoJSON
    ///
    public func read(data: Data) throws -> Geometry {

        var parsedJSON: Any = ""

        do {
            parsedJSON = try JSONSerialization.jsonObject(with: data)

        } catch let error as NSError {
            throw GeoJSONReader.Errors.invalidJSON("The data couldn’t be read because it isn’t in the correct format: "  + error.localizedDescription)
        }

        guard let jsonObject = parsedJSON as? [String: Any] else {
            throw GeoJSONReader.Errors.invalidJSON("Root JSON must be an object type.")
        }

        return try read(jsonObject: jsonObject)
    }

    ///
    /// Read a (Geo)JSON Object into Geometry objects.
    ///
    /// - Parameters:
    ///     - jsonObject: The GeoJSON object to read
    ///
    /// - Returns: A Geometry object representing the GeoJSON
    ///
    public func read(jsonObject: [String: Any]) throws -> Geometry {

        guard let type = jsonObject["type"] as? String else {
            throw GeoJSONReader.Errors.missingAttribute("Missing required attribute \"type\".")
        }

        switch type {

        case "Point":
            return try point(jsonObject: jsonObject)

        case "LineString":
            return try lineString(jsonObject: jsonObject)

        case "Polygon":
            return try polygon(jsonObject: jsonObject)

        case "MultiPoint":
            return try multiPoint(jsonObject: jsonObject)

        case "MultiLineString":
            return try multiLineString(jsonObject: jsonObject)

        case "MultiPolygon":
            return try multiPolygon(jsonObject: jsonObject)

        case "GeometryCollection":
            return try geometryCollection(jsonObject: jsonObject)

        default:
            throw GeoJSONReader.Errors.unsupportedType("Unsupported type \"\(type)\".")
        }
    }

    ///
    /// Parse a Point type.
    ///
    /// - Parameters:
    ///     - jsonObject: The GeoJSON object to read
    ///
    /// - Returns: A Point object representing the GeoJSON
    ///
    private func point(jsonObject: [String: Any]) throws -> Point {

        let coordinates = try Coordinates<[Any]>.coordinates(json: jsonObject)

        return try self.point(coordinates: coordinates)
    }

    ///
    /// Parse coordinates into a Point.
    ///
    /// - Parameters:
    ///     - coordinates: An array of any objects that one could parse into a point.  If not, an error is thrown.
    ///
    /// - Returns: A Point object representing the GeoJSON
    ///
    private func point(coordinates: [Any]) throws -> Point {

        return Point(try self.coordinate(array: coordinates), precision: self.precision, coordinateSystem: self.cs)
    }

    ///
    /// Read a GeoJSON object into a LineString.
    ///
    /// - Parameters:
    ///     - jsonObject: The GeoJSON object to read.
    ///
    /// - Returns: A LineString object representing the GeoJSON.
    ///
    private func lineString(jsonObject: [String: Any]) throws -> LineString {

        let coordinates = try Coordinates<[[Any]]>.coordinates(json: jsonObject)

        return LineString(try self.coordinates(jsonArray: coordinates), precision: self.precision, coordinateSystem: self.cs)
    }

    ///
    /// Parse an array of arrays of coordinates into a LineString.
    ///
    /// - Parameters:
    ///     - coordinates: An array of arrays of coordinates that one could parse into a line string.
    ///
    /// - Returns: A LineString object represented by the coordinate arrays.
    ///
    private func lineString(coordinates: [[Any]]) throws -> LineString {

        var elements: [Coordinate] = []

        for elementCoordinates in coordinates {
            elements.append(try self.coordinate(array: elementCoordinates))
        }

        return LineString(try self.coordinates(jsonArray: coordinates), precision: self.precision, coordinateSystem: self.cs)
    }

    ///
    /// Read a GeoJSON object into a Polygon..
    ///
    /// - Parameters:
    ///     - jsonObject: The GeoJSON object to read.
    ///
    /// - Returns: A Polygon object representing the GeoJSON.
    ///
    private func polygon(jsonObject: [String: Any]) throws -> Polygon {

        let coordinates = try Coordinates<[[[Any]]]>.coordinates(json: jsonObject)

        return try self.polygon(coordinates: coordinates)
    }

    ///
    /// Parse an array of arrays of arrays of coordinates into a Polygon.
    ///
    /// - Parameters:
    ///     - coordinates: An array of arrays of arrays of coordinates that one could parse into a polygon.
    ///
    /// - Returns: A Polygon object represented by the coordinate arrays.
    ///
    private func polygon(coordinates: [[[Any]]]) throws -> Polygon {

        var outerRing:  LinearRing = LinearRing(precision: self.precision, coordinateSystem: self.cs)
        var innerRings: [LinearRing] = []

        if coordinates.count > 0 {
            outerRing.append(contentsOf: try self.coordinates(jsonArray: coordinates[0]))
        }

        /// Get the inner rings
        for i in stride(from: 1, to: coordinates.count, by: 1) {
            innerRings.append(LinearRing(try self.coordinates(jsonArray: coordinates[i]), precision: self.precision, coordinateSystem: self.cs))
        }
        return Polygon(outerRing, innerRings: innerRings, precision: self.precision, coordinateSystem: self.cs)
    }

    ///
    /// Read a GeoJSON object into a MultiPoint..
    ///
    /// - Parameters:
    ///     - jsonObject: The GeoJSON object to read.
    ///
    /// - Returns: A MultiPoint object representing the GeoJSON.
    ///
    private func multiPoint(jsonObject: [String: Any]) throws -> MultiPoint {

        let coordinates = try Coordinates<[[Any]]>.coordinates(json: jsonObject)

        return try self.multiPoint(coordinates: coordinates)
    }

    ///
    /// Parse an array of arrays of coordinates into a MultiPoint.
    ///
    /// - Parameters:
    ///     - coordinates: An array of arrays of coordinates that one could parse into a multi point.
    ///
    /// - Returns: A MultiPoint object represented by the coordinate arrays.
    ///
    private func multiPoint(coordinates: [[Any]]) throws -> MultiPoint {

        var elements: [Point] = []

        for elementCoordinates in coordinates {
            elements.append(try self.point(coordinates: elementCoordinates))
        }

        return MultiPoint(elements, precision: self.precision, coordinateSystem: self.cs)
    }

    ///
    /// Read a GeoJSON object into a MultiLineString.
    ///
    /// - Parameters:
    ///     - jsonObject: The GeoJSON object to read.
    ///
    /// - Returns: A MultiLineString object representing the GeoJSON.
    ///
    private func multiLineString(jsonObject: [String: Any]) throws -> MultiLineString {

        let coordinates = try Coordinates<[ [[Any]] ]>.coordinates(json: jsonObject)

        return try self.multiLineString(coordinates: coordinates)
    }

    ///
    /// Parse an array of arrays of arrays of coordinates into a MultiLineString.
    ///
    /// - Parameters:
    ///     - coordinates: An array of arrays of arrays of coordinates that one could parse into a multi line string.
    ///
    /// - Returns: A MultiLineString object represented by the coordinate arrays.
    ///
    private func multiLineString(coordinates: [ [[Any]] ]) throws -> MultiLineString {

        var elements: [LineString] = []

        for elementCoordinates in coordinates {
            elements.append(try self.lineString(coordinates: elementCoordinates))
        }

        return MultiLineString(elements, precision: self.precision, coordinateSystem: self.cs)
    }

    ///
    /// Read a GeoJSON object into a MultiPolygon.
    ///
    /// - Parameters:
    ///     - jsonObject: The GeoJSON object to read.
    ///
    /// - Returns: A MultiPolygon object representing the GeoJSON.
    ///
    private func multiPolygon(jsonObject: [String: Any]) throws -> MultiPolygon {

        let coordinates = try Coordinates<[ [[[Any]]] ]>.coordinates(json: jsonObject)

        return try self.multiPolygon(coordinates: coordinates)
    }

    ///
    /// Parse an array of arrays of arrays of arrays of coordinates into a MultiPolygon.
    ///
    /// - Parameters:
    ///     - coordinates: An array of arrays of arrays of arrays of coordinates that one could parse into a multi polygon.
    ///
    /// - Returns: A MultiPolygon object represented by the coordinate arrays.
    ///
    private func multiPolygon(coordinates: [ [[[Any]]] ]) throws -> MultiPolygon {

        var elements: [Polygon] = []

        for elementCoordinates in coordinates {
            elements.append(try self.polygon(coordinates: elementCoordinates))
        }

        return MultiPolygon(elements, precision: self.precision, coordinateSystem: self.cs)
    }

    ///
    /// Read a GeoJSON object into a GeometryCollection.
    ///
    /// - Parameters:
    ///     - jsonObject: The GeoJSON object to read.
    ///
    /// - Returns: A GeometryCollection object representing the GeoJSON.
    ///
    private func geometryCollection(jsonObject: [String: Any]) throws -> GeometryCollection {
        var elements: [Geometry] = []

        guard let geometriesObject = jsonObject["geometries"] else {
            throw GeoJSONReader.Errors.missingAttribute("Missing required attribute \"geometries\".")
        }

        guard let geometries = geometriesObject as? [[String: Any]] else {
            throw GeoJSONReader.Errors.invalidJSON("Invalid structure for \"geometries\" attribute.")
        }

        for object in geometries {
            elements.append(try self.read(jsonObject: object))
        }
        return GeometryCollection(elements, precision: self.precision, coordinateSystem: self.cs)
    }

    ///
    /// Parse an array of array of GeoJSON objects into an array of coordinates.
    ///
    /// - Parameters:
    ///     - jsonArray: An array of arrays of GeoJSON objects that one could parse into an array of coordinates.
    ///
    /// - Returns: An array of Coordinates represented by the array of GeoJSON objects.
    ///
    private func coordinates(jsonArray: [[Any]]) throws -> [Coordinate] {
        var coordinates: [Coordinate] = []

        for coordinate in jsonArray {
            coordinates.append(try self.coordinate(array: coordinate))
        }
        return coordinates
    }

    ///
    /// Parse an array of values into a single coordinate.  Normally there will be two to four values.
    ///
    /// - Parameters:
    ///     - array: An array of values representing different components of a single coordinate.
    ///
    /// - Returns: A Coordinate represented by the values of the input array.
    ///
    internal /// @Testable
    func coordinate(array: [Any]) throws -> Coordinate {

        let coordinateValues = try array.map { (value) -> Double in
            switch value {
            case let value as Double:       return value
            case let value as NSNumber:     return Double(truncating: value)
            case let value as Int:          return Double(value)
            case let value as Float:        return Double(value)
            case let value as String:
                if let value = Double(value) {
                    return value
                }
                fallthrough
            default:
                throw GeoJSONReader.Errors.invalidJSON("Invalid structure for \"coordinates\" attribute.")
            }
        }

        guard coordinateValues.count >= 2 else {
            throw GeoJSONReader.Errors.invalidNumberOfCoordinates("Invalid number of coordinates (\(coordinateValues.count)) supplied for type \(String(reflecting: Coordinate.self)).")
        }

        return Coordinate(x: coordinateValues[0], y: coordinateValues[1], z: coordinateValues.count > 2 ? coordinateValues[2] : nil, m: coordinateValues.count > 3 ? coordinateValues[3] : nil)
    }
}

internal /// @Testable
class Coordinates<T> {

    ///
    /// Parse GeoJSON into a coordinate collection of type T.
    ///
    /// - Parameters:
    ///     - json: A GeoJSON object that one could parse into a collection of coordinates.
    ///
    /// - Returns: A collection of coordinates of type T represented by the GeoJSON object.
    ///
    internal /// @Testable
    class func coordinates(json: [String: Any]) throws -> T {

        guard let coordinatesObject = json["coordinates"] else {
            throw GeoJSONReader.Errors.missingAttribute("Missing required attribute \"coordinates\".")
        }
        guard let coordinates = coordinatesObject as? T else {
            throw GeoJSONReader.Errors.invalidJSON("Invalid structure for \"coordinates\" attribute.")
        }
        return coordinates
    }
}
