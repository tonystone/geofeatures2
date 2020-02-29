///
/// CGContext+GeoFeatures.swift
///
/// Copyright (c) 2018 Tony Stone, All rights reserved.
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
/// Created by Tony Stone on 3/23/18.
///
#if os(OSX) || os(iOS) || os(tvOS) || os(watchOS)

import CoreGraphics
import GeoFeatures

///
/// GeoFeatures Geometry Quartz Drawing Routines.
///
/// - Note: The path routines translate all Coordinate types to 2d flat space dropping z and m from 2DM, 3D, and 3DM coordinates.
///
extension CGContext {

    ///
    /// Adds a previously created Geometry object to the current path in a graphics context.
    ///
    /// - Parameter geometry: A Geometry object.
    ///
    public func add(_ geometry: Geometry) {

        guard let representable = geometry as? PathRepresentable
            else { return }

        self.addPath(representable.path())
    }
}

///
/// GeoFeatures Geometry Quartz Drawing Routines.
///
/// Note: The drawing routines translate all Coordinate types to 2d flat space dropping z and m from 2DM, 3D, and 3DM coordinates.
///
extension CGContext {

    ///
    /// Draws the `Point`.
    ///
    /// - Parameters:
    ///     - point: The Point geometry to draw.
    ///     - mode: A `CGPathDrawingMode` drawing mode constant (fill, eoFill, stroke, fillStroke, or eoFillStroke) or nil for the default mode for the given shape.
    ///
    /// - Remarks: If nil is passed as the mode (the default value), the geometry will be drawn and filled based on the shape type (e.g. a closed LineString is filled, while an open LineString is not).
    ///
    public func draw(_ point: Point, using mode: CGPathDrawingMode? = nil) {
        self.add(point)
        self.drawPath(using: mode ?? .fillStroke)
    }

    ///
    /// Draws the `LineString`.
    ///
    /// - Parameters:
    ///     - lineString: The LineString geometry to draw.
    ///     - mode: A `CGPathDrawingMode` drawing mode constant (fill, eoFill, stroke, fillStroke, or eoFillStroke) or nil for the default mode for the given shape.
    ///
    /// - Remarks: If nil is passed as the mode (the default value), the geometry will be drawn and filled based on the shape type (e.g. a closed LineString is filled, while an open LineString is not).
    ///
    public func draw(_ lineString: LineString, using mode: CGPathDrawingMode? = nil) {
        self.add(lineString)
        self.drawPath(using: mode ?? (lineString.isClosed() ? .fillStroke : .stroke))
    }

    ///
    /// Draws the `LinearRing`.
    ///
    /// - Parameters:
    ///     - linearRing: The LinearRing geometry to draw.
    ///     - mode: A `CGPathDrawingMode` drawing mode constant (fill, eoFill, stroke, fillStroke, or eoFillStroke) or nil for the default mode for the given shape.
    ///
    /// - Remarks: If nil is passed as the mode (the default value), the geometry will be drawn and filled based on the shape type (e.g. a closed LineString is filled, while an open LineString is not).
    ///
    public func draw(_ linearRing: LinearRing, using mode: CGPathDrawingMode? = nil) {
        self.add(linearRing)
        self.drawPath(using: mode ?? (linearRing.isClosed() ? .fillStroke : .stroke))
    }

    ///
    /// Draws the `Polygon`.
    ///
    /// - Parameters:
    ///     - polygon: The Polygon geometry to draw.
    ///     - mode: A `CGPathDrawingMode` drawing mode constant (fill, eoFill, stroke, fillStroke, or eoFillStroke) or nil for the default mode for the given shape.
    ///
    /// - Remarks: If nil is passed as the mode (the default value), the geometry will be drawn and filled based on the shape type (e.g. a closed LineString is filled, while an open LineString is not).
    ///
    public func draw(_ polygon: Polygon, using mode: CGPathDrawingMode? = nil) {
        self.add(polygon)
        self.drawPath(using: mode ?? .fillStroke)
    }

    ///
    /// Draws the `MultiPoint`.
    ///
    /// - Parameters:
    ///     - multiPoint: The MultiPoint geometry to draw.
    ///     - mode: A `CGPathDrawingMode` drawing mode constant (fill, eoFill, stroke, fillStroke, or eoFillStroke) or nil for the default mode for the given shape.
    ///
    /// - Remarks: If nil is passed as the mode (the default value), the geometry will be drawn and filled based on the shape type (e.g. a closed LineString is filled, while an open LineString is not).
    ///
    public func draw(_ multiPoint: MultiPoint, using mode: CGPathDrawingMode? = nil) {
        for point in multiPoint {
            self.draw(point, using: mode)
        }
    }

    ///
    /// Draws the `MultiLineString`.
    ///
    /// - Parameters:
    ///     - multiLineString: The MultiLineString geometry to draw.
    ///     - mode: A `CGPathDrawingMode` drawing mode constant (fill, eoFill, stroke, fillStroke, or eoFillStroke) or nil for the default mode for the given shape.
    ///
    /// - Remarks: If nil is passed as the mode (the default value), the geometry will be drawn and filled based on the shape type (e.g. a closed LineString is filled, while an open LineString is not).
    ///
    public func draw(_ multiLineString: MultiLineString, using mode: CGPathDrawingMode? = nil) {
        for lineString in multiLineString {
            self.draw(lineString, using: mode)
        }
    }

    ///
    /// Draws the `MultiPolygon`.
    ///
    /// - Parameters:
    ///     - multiPolygon: The MultiPolygon geometry to draw.
    ///     - mode: A `CGPathDrawingMode` drawing mode constant (fill, eoFill, stroke, fillStroke, or eoFillStroke) or nil for the default mode for the given shape.
    ///
    /// - Remarks: If nil is passed as the mode (the default value), the geometry will be drawn and filled based on the shape type (e.g. a closed LineString is filled, while an open LineString is not).
    ///
    public func draw(_ multiPolygon: MultiPolygon, using mode: CGPathDrawingMode? = nil) {
        for polygon in multiPolygon {
            self.draw(polygon, using: mode)
        }
    }

    ///
    /// Draws the `GeometryCollection`.
    ///
    /// - Parameters:
    ///     - geometryCollection: The GeometryCollection geometry to draw.
    ///     - mode: A `CGPathDrawingMode` drawing mode constant (fill, eoFill, stroke, fillStroke, or eoFillStroke) or nil for the default mode for the given shape.
    ///
    /// - Remarks: If nil is passed as the mode (the default value), the geometry will be drawn and filled based on the shape type (e.g. a closed LineString is filled, while an open LineString is not).
    ///
    public func draw(_ geometryCollection: GeometryCollection, using mode: CGPathDrawingMode? = nil) {
        for geometry in geometryCollection {
            self.draw(geometry, using: mode)
        }
    }

    ///
    /// Draws the `Geometry`.
    ///
    /// - Parameters:
    ///     - geometry: The Geometry geometry to draw.
    ///     - mode: A `CGPathDrawingMode` drawing mode constant (fill, eoFill, stroke, fillStroke, or eoFillStroke) or nil for the default mode for the given shape.
    ///
    /// - Remarks: If nil is passed as the mode (the default value), the geometry will be drawn and filled based on the shape type (e.g. a closed LineString is filled, while an open LineString is not).
    ///
    public func draw(_ geometry: Geometry, using mode: CGPathDrawingMode? = nil) {
        switch geometry {
        case let point              as Point:               self.draw(point, using: mode);              break
        case let lineString         as LineString:          self.draw(lineString, using: mode);         break
        case let linearRing         as LinearRing:          self.draw(linearRing, using: mode);         break
        case let polygon            as Polygon:             self.draw(polygon, using: mode);            break
        case let multiPoint         as MultiPoint:          self.draw(multiPoint, using: mode);         break
        case let multiLineString    as MultiLineString:     self.draw(multiLineString, using: mode);    break
        case let multiPolygon       as MultiPolygon:        self.draw(multiPolygon, using: mode);       break
        case let geometryCollection as GeometryCollection:  self.draw(geometryCollection, using: mode); break
        default: break
        }
    }
}

#endif
