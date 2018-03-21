///
/// GeoFeatures+QuartzDrawable.swift
///
/// Copyright (c) Tony Stone, All rights reserved.
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
/// Created by Tony Stone on 3/17/18.
///

#if os(OSX) || os(iOS) || os(tvOS) || os(watchOS)

import CoreGraphics
import GeoFeatures

///
/// Protocol specifying the ability to convert the object into a Quartz 2D path.
///
public protocol QuartzDrawable {

    ///
    /// Draw `self` in the specified context.
    ///
    func draw(in context: CGContext, dirtyRect: CGRect, transform: CGAffineTransform)

    ///
    /// BoundingBox
    ///
    /// Note: this will be replaced with `func envelop() -> Geometry` when it's complete
    ///
    func boundingBox(transform: CGAffineTransform) -> CGRect
}

///
/// Defaults for protocol `QuartzDrawable`
///
public extension QuartzDrawable {

    ///
    /// Draw `self` in the specified context.
    ///
    func draw(in context: CGContext, dirtyRect: CGRect, transform: CGAffineTransform = CGAffineTransform.identity) {
        draw(in: context, dirtyRect: dirtyRect, transform: transform)
    }

    ///
    /// BoundingBox
    ///
    /// Note: this will be replaced with `func envelop() -> Geometry` when it's complete
    ///
    func boundingBox(transform: CGAffineTransform = CGAffineTransform.identity) -> CGRect {
        return boundingBox(transform: transform)
    }
}

///
/// Point drawing routines
///
/// Note: The drawing routine translates all Coordinate types to 2d flat space at the moment dropping z and m from 2DM, 3D, and 3DM coordinates.
///
extension GeoFeatures.Point: QuartzDrawable {

    public func draw(in context: CGContext, dirtyRect: CGRect, transform: CGAffineTransform) {
        context.addPath(self.path(transform: transform))
        context.drawPath(using: .fillStroke)
    }

    public func boundingBox(transform: CGAffineTransform) -> CGRect {
        return self.path(transform: transform).boundingBox
    }
}

///
/// LineString drawing implementation
///
extension GeoFeatures.LineString: QuartzDrawable {

    public func draw(in context: CGContext, dirtyRect: CGRect, transform: CGAffineTransform = CGAffineTransform.identity) {
        context.addPath(self.path(transform: transform))
        context.drawPath(using: self.isClosed() ? .fillStroke : .stroke)
    }

    public func boundingBox(transform: CGAffineTransform) -> CGRect {
        return self.path(transform: transform).boundingBox
    }
}

///
/// LinearRing drawing implementation
///
extension GeoFeatures.LinearRing: QuartzDrawable {

    public func draw(in context: CGContext, dirtyRect: CGRect, transform: CGAffineTransform) {
        context.addPath(self.path(transform: transform))
        context.drawPath(using: self.isClosed() ? .fillStroke : .stroke)
    }

    public func boundingBox(transform: CGAffineTransform) -> CGRect {
        return self.path(transform: transform).boundingBox
    }
}

///
/// Polygon drawing implementation
///
extension GeoFeatures.Polygon: QuartzDrawable {

    public func draw(in context: CGContext, dirtyRect: CGRect, transform: CGAffineTransform) {
        context.addPath(self.path(transform: transform))
        context.drawPath(using: .fillStroke)
    }

    public func boundingBox(transform: CGAffineTransform) -> CGRect {
        return self.outerRing.path(transform: transform).boundingBox
    }
}

///
/// MultiPoint drawing implementation
///
extension GeoFeatures.MultiPoint: QuartzDrawable {

    public func draw(in context: CGContext, dirtyRect: CGRect, transform: CGAffineTransform) {

        for case let geometry as QuartzDrawable in self  {
            geometry.draw(in: context, dirtyRect: dirtyRect, transform: transform)
        }
    }

    public func boundingBox(transform: CGAffineTransform) -> CGRect {
        var boundingBox = CGRect()
        for case let geometry as QuartzDrawable in self  {
            boundingBox = boundingBox.union(geometry.boundingBox(transform: transform))
        }
        return boundingBox
    }
}

///
/// MultiLineString drawing implementation
///
extension GeoFeatures.MultiLineString: QuartzDrawable {

    public func draw(in context: CGContext, dirtyRect: CGRect, transform: CGAffineTransform) {

        for case let geometry as QuartzDrawable in self  {
            geometry.draw(in: context, dirtyRect: dirtyRect, transform: transform)
        }
    }

    public func boundingBox(transform: CGAffineTransform) -> CGRect {
        var boundingBox = CGRect()
        for case let geometry as QuartzDrawable in self  {
            boundingBox = boundingBox.union(geometry.boundingBox(transform: transform))
        }
        return boundingBox
    }
}

///
/// MultiPolygon drawing implementation
///
extension GeoFeatures.MultiPolygon: QuartzDrawable {

    public func draw(in context: CGContext, dirtyRect: CGRect, transform: CGAffineTransform) {

        for case let geometry as QuartzDrawable in self  {
            geometry.draw(in: context, dirtyRect: dirtyRect, transform: transform)
        }
    }

    public func boundingBox(transform: CGAffineTransform) -> CGRect {
        var boundingBox = CGRect()
        for case let geometry as QuartzDrawable in self  {
            boundingBox = boundingBox.union(geometry.boundingBox(transform: transform))
        }
        return boundingBox
    }
}

///
/// GeometryCollection drawing implementation
///
extension GeoFeatures.GeometryCollection: QuartzDrawable {

    public func draw(in context: CGContext, dirtyRect: CGRect, transform: CGAffineTransform) {

        for case let geometry as QuartzDrawable in self  {
            geometry.draw(in: context, dirtyRect: dirtyRect, transform: transform)
        }
    }

    public func boundingBox(transform: CGAffineTransform) -> CGRect {
        var boundingBox = CGRect()
        for case let geometry as QuartzDrawable in self  {
            boundingBox = boundingBox.union(geometry.boundingBox(transform: transform))
        }
        return boundingBox
    }
}

#endif
