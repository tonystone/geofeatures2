import UIKit
import CoreGraphics

public class RendererClass {
    
    var canvasSize: CGSize
    var currentGraphicsContext: CGContextRef?
    var fillColor: UIColor
    var strokeColor: UIColor
    
    // init properties
    public init(canvasSize: (CGFloat, CGFloat) = (300, 300), fillColor: UIColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5), strokeColor: UIColor = UIColor.blueColor()) {
        self.canvasSize = CGSizeMake(canvasSize.0, canvasSize.1)
        self.fillColor = fillColor
        self.strokeColor = strokeColor
    }
    
    // create new drawing context
    private func createNewImageContext() {
        
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
        currentGraphicsContext = UIGraphicsGetCurrentContext()
        
        // set fill & stroke
        fillColor.setFill()
        strokeColor.setStroke()
    }
    
    // return image created and close context
    private static func imageFromContextAndClose() -> UIImage {
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    
    
    
//    // draw basic line
//    public func drawLine() -> UIImage {
//        
//        self.createNewImageContext()
//        
//        CGContextMoveToPoint(currentGraphicsContext!, 0, 0)
//        CGContextAddLineToPoint(currentGraphicsContext!, 200, 200)
//        CGContextStrokePath(currentGraphicsContext!)
//        
//        return Renderer.imageFromContextAndClose()
//    }
    
//    // draw basic rectangle
//    public func drawRectangle() -> UIImage {
//        
//        self.createNewImageContext()
//        
//        let rectangle = CGRect(x: 0, y: 0, width: 100, height: 100)
//        CGContextAddRect(currentGraphicsContext!, rectangle)
//        CGContextSetLineWidth(currentGraphicsContext!, 10)
//        CGContextDrawPath(currentGraphicsContext!, .FillStroke)
//        
//        return Renderer.imageFromContextAndClose()
//    }
//    
//    // draw using bezier path
//    public func createShapeUsingBezier() -> UIImage {
//        
//        self.createNewImageContext()
//        
//        let arrowPath = UIBezierPath()
//        arrowPath.moveToPoint(CGPointMake(50, 0))
//        arrowPath.addLineToPoint(CGPointMake(70, 25))
//        arrowPath.addLineToPoint(CGPointMake(60, 25))
//        arrowPath.addLineToPoint(CGPointMake(60, 75))
//        arrowPath.addLineToPoint(CGPointMake(40, 75))
//        arrowPath.addLineToPoint(CGPointMake(40, 25))
//        arrowPath.addLineToPoint(CGPointMake(30, 25))
//        arrowPath.addLineToPoint(CGPointMake(50, 0))
//        arrowPath.closePath()
//        arrowPath.stroke()
//        
//        return Renderer.imageFromContextAndClose()
//        
//    }
    
    //    internal func drawCircle() -> UIImage {
    //
    //        // create image context & grab it
    //        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
    //
    //        // create rectangle with context params
    //        let rectangle = CGRect(x: 50, y: 50, width: 100, height: 100)
    //        CGContextSetStrokeColorWithColor(currentGraphicsContext, UIColor.blackColor().CGColor)
    //        CGContextSetLineWidth(currentGraphicsContext, 10)
    //        CGContextAddEllipseInRect(currentGraphicsContext,rectangle)
    //        CGContextStrokePath(currentGraphicsContext)
    //
    //        // spit out new image & end image context
    //        UIGraphicsEndImageContext()
    //        return imageFromContext
    //    }
    //
    //    internal func drawArc() -> UIImage {
    //
    //        // create image context & grab it
    //        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
    //
    //        // create rectangle with context params
    //        CGContextSetStrokeColorWithColor(currentGraphicsContext, UIColor.blackColor().CGColor)
    //        CGContextSetLineWidth(currentGraphicsContext,3)
    //        CGContextAddArc(currentGraphicsContext, 100,100,50,3.14,0,1)
    //        CGContextStrokePath(currentGraphicsContext)
    //
    //        // spit out new image & end image context
    //        UIGraphicsEndImageContext()
    //        return imageFromContext
    //    }
    //
    //    internal func drawPoly() -> UIImage {
    //
    //        // create image context & grab it
    //        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
    //
    //        // create rectangle with context params
    //        CGContextSetStrokeColorWithColor(currentGraphicsContext, UIColor.blackColor().CGColor)
    //        CGContextMoveToPoint(currentGraphicsContext, 25, 150)
    //        CGContextAddLineToPoint(currentGraphicsContext, 175, 150)
    //        CGContextAddLineToPoint(currentGraphicsContext, 100, 50)
    //        CGContextAddLineToPoint(currentGraphicsContext, 25, 150)
    //        CGContextStrokePath(currentGraphicsContext)
    //
    //        // spit out new image & end image context
    //        UIGraphicsEndImageContext()
    //        return imageFromContext
    //    }
    //
    //    internal func drawFilledPoly() -> UIImage {
    //
    //        // create image context & grab it
    //        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
    //
    //        // create rectangle with context params
    //        CGContextMoveToPoint(currentGraphicsContext, 25, 150)
    //        CGContextAddLineToPoint(currentGraphicsContext, 175, 150)
    //        CGContextAddLineToPoint(currentGraphicsContext, 100, 50)
    //        CGContextAddLineToPoint(currentGraphicsContext, 25, 150)
    //        CGContextSetFillColorWithColor(currentGraphicsContext, UIColor.redColor().CGColor)
    //        CGContextFillPath(currentGraphicsContext)
    //
    //        // spit out new image & end image context
    //        UIGraphicsEndImageContext()
    //        return imageFromContext
    //    }
    
    //    internal func drawFilledEllipse() -> UIImage {
    //
    //        // create image context & grab it
    //        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
    //
    //        CGContextSetLineWidth(context, 8.0)
    //        CGContextSetStrokeColorWithColor(currentGraphicsContext,UIColor.redColor().CGColor)
    //        let rectangle = CGRectMake(150,150,frame.size.width-50,frame.size.height-100)
    //        CGContextAddEllipseInRect(currentGraphicsContext, rectangle)
    //        CGContextStrokePath(currentGraphicsContext)
    //        CGContextSetFillColorWithColor(currentGraphicsContext,UIColor.greenColor().CGColor)
    //        CGContextFillEllipseInRect(currentGraphicsContext, rectangle)
    //
    //        // spit out new image & end image context
    //        UIGraphicsEndImageContext()
    //        return imageFromContext
    //    }
    //
    
    //    internal func drawMultipleLines() -> UIImage {
    //
    //        // create image context & grab it
    //        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
    //
    //        CGContextSetStrokeColorWithColor(currentGraphicsContext, UIColor.redColor().CGColor)
    //        let lines = [CGPointMake(25,250),CGPointMake(15,150),CGPointMake(100,20),CGPointMake(25,150)]
    //        CGContextAddLines(currentGraphicsContext,lines,4)
    //        CGContextStrokePath(currentGraphicsContext)
    //
    //        // spit out new image & end image context
    //        UIGraphicsEndImageContext()
    //        return imageFromContext
    //    }
    //
    //    internal func drawGradient() -> UIImage {
    //
    //        // create image context & grab it
    //        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
    //
    //        let colorspace = CGColorSpaceCreateDeviceRGB()
    //        let colors = [UIColor.redColor().CGColor,UIColor.blueColor().CGColor]
    //        let locations: [CGFloat] = [ 0.0, 0.5]
    //        let gradient = CGGradientCreateWithColors(colorspace,colors,locations)
    //        let startPoint = CGPointMake(0,0)
    //        let endPoint =  CGPointMake(200,200)
    //        CGContextDrawLinearGradient(currentGraphicsContext, gradient,startPoint, endPoint, CGGradientDrawingOptions())
    //
    //        // spit out new image & end image context
    //        UIGraphicsEndImageContext()
    //        return imageFromContext
    //    }
    
    //    internal func drawHappyFace() -> UIImage {
    //
    //        // create image context & grab it
    //        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
    //
    //        let face = CGRectMake(150,150,frame.size.width-100,frame.size.height-100)
    //        CGContextAddEllipseInRect(currentGraphicsContext, face)
    //        CGContextSetFillColorWithColor(currentGraphicsContext,UIColor.yellowColor().CGColor)
    //        CGContextFillEllipseInRect(currentGraphicsContext, face)
    //        let leftEye = CGRectMake(75,75,10,10)
    //        CGContextSetFillColorWithColor(currentGraphicsContext,UIColor.blackColor().CGColor)
    //        CGContextFillEllipseInRect(currentGraphicsContext, leftEye)
    //        let rightEye = CGRectMake(115,75,10,10)
    //        CGContextFillEllipseInRect(currentGraphicsContext, rightEye)
    //        CGContextSetLineWidth(currentGraphicsContext, 3.0)
    //        CGContextAddArc(currentGraphicsContext, 100,100,30,3.14,0,1)
    //        CGContextStrokePath(currentGraphicsContext)
    //
    //        // spit out new image & end image context
    //        UIGraphicsEndImageContext()
    //        return imageFromContext
    //    }
    //
    
}

