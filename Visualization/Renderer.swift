import UIKit
import CoreGraphics

public struct ShapeProps {
    var canvasSize: CGSize
    var strokeColor: UIColor
}

// MARK: Define Protocols
public protocol Renderer {

    func drawBezierPath(polygon: Polygon<Coordinate2D>, shapeProps: ShapeProps) -> UIImage
    
}

protocol RendererContext {

    func imageFromContextAndClose() -> UIImage
    
}

// MARK: Implemented Protocols
extension RendererContext {
    
    // return image created and close context
    func imageFromContextAndClose() -> UIImage {
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
}
