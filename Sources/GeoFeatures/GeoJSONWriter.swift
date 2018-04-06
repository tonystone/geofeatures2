///
///  GeoJSONWriter
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
///  Created by Tony Stone on 12/17/16.
///
import Swift
import Foundation

private let TYPE        = "type"
private let COORDINATES = "coordinates"

public enum GeoJSONWriterError: Error {
    case unsupportedType(String)
}

///
/// GeoJSONWriter writer for GeoFeatures based on the Internet Engineering Task Force (IETF) proposed standard "The GeoJSON Format"
///
/// For more information see [Internet Engineering Task Force (IETF) - The GeoJSON Format](https://tools.ietf.org/html/rfc7946#section-4)
///
public class GeoJSONWriter {

    public enum Axis {
        case z, m
    }

    public enum Errors: Error  {
        case invalidNumberOfCoordinates(String)
    }

    ///
    /// Initialize this writer
    ///
    public init(axes: [Axis] = []) {
        self.output = (axes.contains(.z), axes.contains(.m))
    }

    ///
    /// Based on the geometry passed in, converts it into a Object representation as specified by
    /// the GeoJSON draft spec.
    ///
    /// - Parameter geometry: A `Geometry` type to be converted to GeoJSON
    ///
    /// - Returns: GeoJSON Object for supported type.
    ///
    /// - Throws: `GeoJSONWriterError.unsupportedType` if the `geometry` parameter type is unsupported.
    ///
    public func write(_ geometry: Geometry) throws -> [String: Any] {

        switch geometry {

        case let point as Point:
            return try self.pointObject(point)

        case let lineString as LineString:
            return try self.lineStringObject(lineString)

        case let polygon as Polygon:
            return try self.polygonObject(polygon)

        case let multiPoint as MultiPoint:
            return try self.multiPointObject(multiPoint)

        default:
            throw GeoJSONWriterError.unsupportedType("Unsupported type \"\(String(describing: geometry.self))\".")
        }
    }

    private let output: (z: Bool, m: Bool)
}

extension GeoJSONWriter {

    ///
    /// Creates a Point GeoJSON Object.
    ///
    fileprivate func pointObject(_ point: Point) throws -> [String: Any] {
        return [TYPE: "Point", COORDINATES: try self.coordinateArray(point.coordinate)]
    }

    ///
    /// Creates a LineString GeoJSON Object.
    ///
    fileprivate func lineStringObject(_ lineString: LineString) throws -> [String: Any] {
        return [TYPE: "LineString", COORDINATES: try lineString.map({ try self.coordinateArray($0) })]
    }

    ///
    /// Creates a Polygon GeoJSON Object.
    ///
    fileprivate func polygonObject(_ polygon: Polygon) throws -> [String: Any] {
        var coordinates =  [try polygon.outerRing.map({ try self.coordinateArray($0) })]

        for ring in polygon.innerRings {
            coordinates.append(try ring.map({ try self.coordinateArray($0) }))
        }
        return [TYPE: "Polygon", COORDINATES: coordinates]
    }

    ///
    /// Creates a MultiPoint GeoJSON Object.
    ///
    fileprivate func multiPointObject(_ multiPoint: MultiPoint) throws -> [String: Any] {
        return [TYPE: "MultiPoint", COORDINATES: try multiPoint.map({ try self.coordinateArray($0.coordinate) })]
    }

    ///
    /// Creates an array of values for printing.
    ///
    fileprivate func coordinateArray(_ coordinate: Coordinate) throws -> [Double] {

        var coordinateArray = [coordinate.x, coordinate.y]

        if output.z {
            guard let z = coordinate.z
                else { throw Errors.invalidNumberOfCoordinates("Coordinate \(coordinate) is missing the Z axis.") }

            coordinateArray.append(z)
        }

        if output.m {
            guard let m = coordinate.m
                else { throw Errors.invalidNumberOfCoordinates("Coordinate \(coordinate) is missing the M axis.") }

            coordinateArray.append(m)
        }
        return coordinateArray
    }
}
