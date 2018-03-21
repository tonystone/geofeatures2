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

import CoreGraphics
import GeoFeatures
import GeoFeaturesQuartz

#if os(OSX)

import AppKit

@IBDesignable
internal class CartesianGeometryVisualizationView: NSView {

    static let strokeColor = CGColor(red: 77/255, green: 169/255, blue: 255/255, alpha: 1.0)
    static let fillColor   = CGColor(red: 204/255, green: 230/255, blue: 255/255, alpha: 1.0)

    let geometry: Geometry & QuartzDrawable

    @IBInspectable var scale: CGFloat   = 1.0

    @IBInspectable var xOffset: CGFloat = 0.0
    @IBInspectable var yOffset: CGFloat = 0.0

    init(geometry: Geometry & QuartzDrawable) {
        self.geometry = geometry

        let viewBounds = NSRect(x: 0, y: 0, width: 200, height: 200)

        /// Find the bounding box of the shapes
        let boundingBox = geometry.boundingBox()

        if boundingBox.width * 1.25 > viewBounds.width || boundingBox.height * 1.25 > viewBounds.height {
            scale  = 0.75 * min(viewBounds.width/boundingBox.width, viewBounds.height/boundingBox.height)
        }
        xOffset = viewBounds.midX - boundingBox.midX * scale
        yOffset = viewBounds.midY - boundingBox.midY * scale

        super.init(frame: viewBounds)
    }

    required init?(coder: NSCoder) {
        self.geometry = GeometryCollection()
        super.init(coder: coder)
    }

    override func draw(_ dirtyRect: NSRect) {

        guard let context = NSGraphicsContext.current?.cgContext
            else { return }

        context.saveGState()

        /// Apply the transforms to scale and center the paths
        context.translateBy(x: xOffset, y: yOffset)
        context.scaleBy(x: scale, y: scale)

        context.setStrokeColor(CartesianGeometryVisualizationView.strokeColor)
        context.setFillColor  (CartesianGeometryVisualizationView.fillColor)

        context.setLineWidth(2.0)

        geometry.draw(in: context, dirtyRect: dirtyRect)

        context.restoreGState()
    }
}
#endif
