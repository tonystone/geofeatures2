///
/// GeometryVisualizationView.swift
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
/// Created by Tony Stone on 3/16/18.
///

#if os(OSX) || os(iOS)

import CoreGraphics
import GeoFeatures
import GeoFeaturesQuartz

#if os(OSX)
    import AppKit
    typealias CartesianGeometryVisualizationViewBaseType = NSView

    func currentContext() -> CGContext? {
        return NSGraphicsContext.current?.cgContext
    }
#elseif os(iOS)
    import UIKit
    typealias CartesianGeometryVisualizationViewBaseType = UIView

    func currentContext() -> CGContext? {
        return UIGraphicsGetCurrentContext()
    }
#endif

@IBDesignable
internal class CartesianGeometryVisualizationView: CartesianGeometryVisualizationViewBaseType {

    private static let strokeColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [77/255.0,  169/255.0, 255/255.0, 1.0] as [CGFloat])
    private static let fillColor   = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [204/255.0,  230/255.0, 255/255.0, 1.0] as [CGFloat])

    private let geometry: Geometry

    @IBInspectable var scale: CGFloat   = 1.0

    @IBInspectable var xOffset: CGFloat = 0.0
    @IBInspectable var yOffset: CGFloat = 0.0

    public init(geometry: Geometry) {
        self.geometry = geometry

        let viewBounds = Bounds(min: (x: 0, y: 0), max: (x: 200, y: 200))

        /// Find the bounding box of the shapes
        let bounds = geometry.bounds() ?? viewBounds

        if bounds.width * 1.25 > viewBounds.width || bounds.height * 1.25 > viewBounds.height {
            scale  = CGFloat(0.75 * Swift.min(viewBounds.width/bounds.width, viewBounds.height/bounds.height))
        }
        xOffset = CGFloat(viewBounds.mid.x - bounds.mid.x * Double(scale))
        yOffset = CGFloat(viewBounds.mid.y - bounds.mid.y * Double(scale))

        super.init(frame: viewBounds.cgRect)
    }

    required init?(coder: NSCoder) {
        self.geometry = GeometryCollection()
        super.init(coder: coder)
    }

    override func draw(_ dirtyRect: CGRect) {
        self.draw(dirtyRect, context: currentContext())
    }

    internal /* @testable */
    func draw(_ dirtyRect: CGRect, context: CGContext?, blendMode: CGBlendMode = .normal) {

        guard let context = context
            else { return }

        context.saveGState()
        
        context.setBlendMode(blendMode)

        /// Apply the transforms to scale and center the paths
        context.translateBy(x: xOffset, y: yOffset)
        context.scaleBy(x: scale, y: scale)
        context.setLineCap(CGLineCap.round)
        context.setLineWidth(2.0)


        if let color = CartesianGeometryVisualizationView.strokeColor {
            context.setStrokeColor(color)
        }
        if let color = CartesianGeometryVisualizationView.fillColor {
            context.setFillColor(color)
        }

        context.draw(geometry)

        context.restoreGState()
    }
}

private extension Bounds {

    var width:  Double { return max.x - min.x }
    var height: Double { return max.y - min.y }

    var cgRect: CGRect { return CGRect(x: min.x, y: min.y, width: max.x, height: max.y) }
}

#endif
