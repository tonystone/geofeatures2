//
//  Polygon+Visualize.swift
//  Pods
//
//  Created by Matthew Sniff on 2/29/16.
//
//

import Foundation

extension Polygon : Renderer, RendererContext {
    
    public func drawBezierPath(polygon: Polygon<Coordinate2D>, shapeProps: ShapeProps = ShapeProps(canvasSize: CGSize(width: 500, height: 500), strokeColor: UIColor.blueColor())) -> UIImage {
        
        // start context
        UIGraphicsBeginImageContextWithOptions(shapeProps.canvasSize, false, 0)

        // set path creation
        let polyPath = UIBezierPath()
        
        // set stroke color
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), shapeProps.strokeColor.CGColor)

        // start drawing at first point in the poly set
        polyPath.moveToPoint(CGPointMake(CGFloat(polygon.outerRing[0].x), CGFloat(polygon.outerRing[0].y)))
        
        // create rest of the outer ring of polygon
        for index in 1 ... polygon.outerRing.count - 1 {
            polyPath.addLineToPoint(CGPointMake(CGFloat(polygon.outerRing[index].x), CGFloat(polygon.outerRing[index].y)))
        }
        
        // scale up
        // let scale = CGFloat(3);
        // polyPath.applyTransform(CGAffineTransformMakeScale(scale, scale))
        
        // close path for polygons
        polyPath.closePath()
        polyPath.stroke()
        
        // end context, return image
        return self.imageFromContextAndClose()
        
    }
    
    
}
