//
//  IntersectionMatrix+Helpers.swift
//  Pods
//
//  Created by Ed Swiss on 3/19/17.
//
//

import Foundation

import struct GeoFeatures.Point
//import struct CoordinateType

private typealias CoordinateType = Coordinate2D

enum Subset: Int { case none = 0, firstInSecond, secondInFirst, identical }

extension IntersectionMatrix { //: CoordinateType { // CoordinateType {
    
    static func generateMatrix(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {
        
        let interior = IntersectionMatrix.Index.interior.rawValue
        let boundary = IntersectionMatrix.Index.boundary.rawValue
        let exterior = IntersectionMatrix.Index.exterior.rawValue
//        let matrix   = IntersectionMatrix()
//        for row in 0...exterior {
//            for col in 0...exterior {
        
//        switch (row, col) {
//            
//        case (interior, interior):
        
        switch geometry1.dimension {
                
        // The interior of a geometry of dimension zero is the geometry itself.  The boundary is empty.
        case .zero:
                
            switch geometry2.dimension {
                
            case .zero:
                
//                The IM for the two disjoint geometries of dimension .zero is FF0FFF0F2. The IM for two dimension .zero geometries intersecting at a set of points is either 0F0FFF0F2, if neither geometry is a subset of the other, 0FFFFF0F2, if the first geometry is a proper subset of the second, 0F0FFFFF2, if the second geometry is a proper subset of the first, and FFFFFFFF2, if the two sets of points are identical.
                
                let resul = intersectionGeometry(geometry1, geometry2)
//                self[interior, interior] = (intersectionGeometry != nil) ? .zero : .empty]
                // Two geometries not identical, FF0FFF0F2.
                // Two geometries identical, FFFFFFFF2.
                if intersectionGeometry != nil {
                    return IntersectionMatrix(arrayLiteral: [
                        [.empty, .zero,  .one],
                        [.two,   .empty, .zero],
                        [.one,   .two,   .empty]
                    ])
                } else {
                    // Disjoint geometries, FF0FFF0F2
                    return IntersectionMatrix(arrayLiteral: [
                        [.empty, .empty, .zero],
                        [.empty, .empty, .empty],
                        [.zero,  .empty, .two]
                    ])

                }
                
            }
        }
    }
    
//                    if ![Dimension.zero, .one, .two].contains(self.matrix[row][col]) {
//                        return false
//                    }
//                    continue
//                case "F":
//                    
//                    if Dimension.empty != self.matrix[row][col] {
//                        return false
//                    }
//                    continue
//                case "*":
//                    /// All are valid
//                    continue
//                case "0":
//                    
//                    if Dimension.zero != self.matrix[row][col] {
//                        return false
//                    }
//                    continue
//                case "1":
//                    
//                    if Dimension.one != self.matrix[row][col] {
//                        return false
//                    }
//                    continue
//                case "2":
//                    
//                    if Dimension.two != self.matrix[row][col] {
//                        return false
//                    }
//                    continue
//                default:
//                    return false    // Invalid character passed
//                }
                    
//            }
//        }
//
//    }
    
    // Returns the intersection geometry and a boolean indicating whether the two geometries match.
    fileprivate static func intersectionGeometry(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, Bool) {
        
        switch geometry1.dimension {
            
        // The interior of a geometry of dimension zero is the geometry itself.
        case .zero:
            
            switch geometry2.dimension {
                
            case .zero:
                if let point1 = self as? Point<CoordinateType>, let point2 = geometry2 as? Point<CoordinateType> {
                    generateIntersection(point1, point2)
                } else if let point = geometry1 as? Point<CoordinateType>, let points = geometry2 as? MultiPoint<CoordinateType> {
                    return generateIntersection(points, point)
                } else if let points = geometry1 as? MultiPoint<CoordinateType>, let point = geometry2 as? Point<CoordinateType> {
                    return generateIntersection(points, point)
                } else if let points1 = geometry1 as? MultiPoint<CoordinateType>, let points2 = geometry2 as? Point<CoordinateType> {
                    return generateIntersection(points1, points2)
                }
            }
        }
        
    }
    
    fileprivate static func generateIntersection(_ point1: Point<CoordinateType>, _ point2: Point<CoordinateType>) -> (Geometry?, Subset) {
        if point1 == point2 {
            return (point1, .identical)
        }
        return (nil, .none)
    }
    
    fileprivate static func generateIntersection(_ points: MultiPoint<CoordinateType>, _ point: Point<CoordinateType>) -> (Geometry?, Subset) {
        for tempPoint in points {
            if tempPoint == point {
                if points.count > 1 {
                    return (point, .secondInFirst)
                } else {
                    return (point, .identical)
                }
            }
        }
        return (nil, .none)
    }
    
//    fileprivate func intersection(_ point: Point<CoordinateType>, _ points: MultiPoint<CoordinateType>) -> Geometry? {
//        for tempPoint in points {
//            if tempPoint == point {
//                return point
//            }
//        }
//        return nil
//    }
    
    fileprivate func generateIntersection(_ points1: MultiPoint<CoordinateType>, _ points2: MultiPoint<CoordinateType>) -> (Geometry?, Subset) {

        let match = true

        var multiPoint = MultiPoint<Coordinate2D>(precision: FloatingPrecision(), coordinateSystem: Cartesian())
        for tempPoint1 in points1 {
            for tempPoint2 in points2 {
                if tempPoint1 == tempPoint2 {
                    multiPoint.append(tempPoint1)
                }
            }
        }
        return (multiPoint.count > 0) ? multiPoint : nil
    }

}
