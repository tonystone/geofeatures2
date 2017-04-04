///
///  IntersectionMatrix+Helpers.swift
///  Pods
///
///  Created by Ed Swiss on 3/19/17.
///
///

import Foundation

import struct GeoFeatures.Point

private typealias CoordinateType = Coordinate2D

enum Subset: Int {
    case
    overlap = 0,            /// Indicates some parts of each geometry intersect the other and are outside the other
    firstInSecondInterior,  /// Indicates the first geometry is completely contained within the second geometry
    secondInFirstInterior,  /// Indicates the second geometry is completely contained within the first geometry
    identical,              /// Indicates the geometries are the same
    firstInSecondBoundary,  /// Indicates the first geometry exists
    secondInFirstBoundary
}

extension IntersectionMatrix {

    static func generateMatrix(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

        let interior = IntersectionMatrix.Index.interior.rawValue
        let boundary = IntersectionMatrix.Index.boundary.rawValue
        let exterior = IntersectionMatrix.Index.exterior.rawValue

        switch geometry1.dimension {

        /// The interior of a geometry of dimension zero is the geometry itself.  The boundary is empty.
        case .zero:

            switch geometry2.dimension {

            case .zero:

                let (_, resultIntersectionMatrix) = intersectionGeometry(geometry1, geometry2)

                return resultIntersectionMatrix

            case .one:
                /// The IM for the two disjoint geometries of dimension .one and .zero, in either order, is FF0FFF0F2.

                let (_, resultIntersectionMatrix) = intersectionGeometry(geometry1, geometry2)

                return resultIntersectionMatrix

            case .two: break
            default: break

            }

        case .one:
            /// TODO
            switch geometry2.dimension {
            case .zero: break
            case .one: break
            case .two: break
            default: break
            }

        case .two:
            /// TODO
            switch geometry2.dimension {
            case .zero: break
            case .one: break
            case .two: break
            default: break
            }

        default: break
        }

        return IntersectionMatrix()
    }

    /// Returns the intersection geometry and a boolean indicating whether the two geometries match.
    /// Note that in general the intersection of two geometries will result in a set of geometries, not just one.
    fileprivate static func intersectionGeometry(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, IntersectionMatrix) {

        switch geometry1.dimension {

        /// The interior of a geometry of dimension zero is the geometry itself.
        case .zero:

            switch geometry2.dimension {

            case .zero:
                /// For the intersection of two geometries of dimension .zero,
                /// it would be nice to use a Set here, then we could use the built-in Swift functions to simplify the code.
                /// We may need to make Point and MultiPoint hashable to do that.

                if let point1 = self as? Point<CoordinateType>, let point2 = geometry2 as? Point<CoordinateType> {
                    return generateIntersection(point1, point2)
                } else if let point = geometry1 as? Point<CoordinateType>, let points = geometry2 as? MultiPoint<CoordinateType> {
                    return generateIntersection(points, point)
                } else if let points = geometry1 as? MultiPoint<CoordinateType>, let point = geometry2 as? Point<CoordinateType> {
                    return generateIntersection(points, point)
                } else if let points1 = geometry1 as? MultiPoint<CoordinateType>, let points2 = geometry2 as? Point<CoordinateType> {
                    return generateIntersection(points1, points2)
                }
            case .one:
                if let point = self as? Point<CoordinateType>, let lineString = geometry2 as? LineString<CoordinateType> {
                    return generateIntersection(point, lineString)
                }
            case .two: break
            default: break
            }

        case .one:
            /// TODO
            switch geometry2.dimension {
            case .zero: break
            case .one: break
            case .two: break
            default: break
            }

        case .two:
            /// TODO
            switch geometry2.dimension {
            case .zero: break
            case .one: break
            case .two: break
            default: break
            }

        default: break
        }

        return (nil, IntersectionMatrix())
    }

    fileprivate static func generateIntersection(_ point1: Point<CoordinateType>, _ point2: Point<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Identical
        var identical = IntersectionMatrix()
        identical[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = identical
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .zero

        if point1 == point2 {
            return (point1, identical)
        }
        return (nil, disjoint)
    }

    fileprivate static func generateIntersection(_ points: MultiPoint<CoordinateType>, _ point: Point<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Identical
        var identical = IntersectionMatrix()
        identical[.exterior, .exterior] = .two

        /// Second in first
        var secondInFirst = IntersectionMatrix()
        secondInFirst[.interior, .interior] = .zero
        secondInFirst[.interior, .exterior] = .zero
        secondInFirst[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .zero
        disjoint[.exterior, .exterior] = .two

        for tempPoint in points {

            if tempPoint == point {

                if points.count > 1 {
                    return (point, secondInFirst)
                } else {
                    return (point, identical)
                }

            }

        }
        return (nil, disjoint)
    }

    fileprivate func generateIntersection(_ points1: MultiPoint<CoordinateType>, _ points2: MultiPoint<CoordinateType>) -> (Geometry?, IntersectionMatrix) {
        
        /// Identical
        var identical = IntersectionMatrix()
        identical[.exterior, .exterior] = .two

        /// First in second
        var firstInSecond = IntersectionMatrix()
        firstInSecond[.interior, .interior] = .zero
        firstInSecond[.exterior, .interior] = .zero
        firstInSecond[.exterior, .exterior] = .two

        /// Second in first
        var secondInFirst = IntersectionMatrix()
        secondInFirst[.interior, .interior] = .zero
        secondInFirst[.interior, .exterior] = .zero
        secondInFirst[.exterior, .exterior] = .two
        
        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Should use Set here, if possible.  That would simplify a lot of the calculations.
        /// Let's assume points1 and points2 are both a unique set of points.

        var pointInGeometry1NotMatched = false
        var pointInGeometry2NotMatched = false
        var multiPointIntersection = MultiPoint<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())
        var multiPointGeometry2Matched = MultiPoint<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())
        for tempPoint1 in points1 {

            var foundMatchingPoint = false
            for tempPoint2 in points2 {

                if tempPoint1 == tempPoint2 {
                    multiPointIntersection.append(tempPoint1)
                    multiPointGeometry2Matched.append(tempPoint2)
                    foundMatchingPoint = true
                    break
                }

            }
            if !foundMatchingPoint {
                pointInGeometry1NotMatched = true
            }

        }

        if points2.count != multiPointGeometry2Matched.count {
            pointInGeometry2NotMatched = true
        }

        switch (pointInGeometry1NotMatched, pointInGeometry2NotMatched) {
        case (false, false):
            return (multiPointIntersection, identical)
        case (false, true):
            return (multiPointIntersection, firstInSecond)
        case (true, false):
            return (multiPointIntersection, secondInFirst)
        case (true, true):
            return (multiPointIntersection, disjoint)
        }
    }

    /// Returns true if the first point is on the line segment defined by the next two points.
    fileprivate static func pointIsOnLineSegment(_ point: Point<CoordinateType>, point1: Point<CoordinateType>, point2: Point<CoordinateType>) -> Bool {

        /// Will likely use precision later, but use EPSILON for now.
        let EPSILON = 0.01

        /// Check if the point is in between the other two points in both x and y.
        if  (point.x < point1.x && point.x < point2.x) ||
            (point.x > point1.x && point.x > point2.x) ||
            (point.y < point1.y && point.y < point2.y) ||
            (point.y > point1.y && point.y > point2.y) {
            return false
        }

        /// Check for the cases where the line segment is horizontal or vertical
        if (point.x == point1.x && point.x == point2.x) || (point.y == point1.y && point.y == point2.y) {
            return true
        }

        /// General case
        let slope = (point2.y - point1.y) / (point2.x - point1.x)
        let value = point1.y - slope * point1.x
        if abs(point.y - (slope * point.x + value)) < EPSILON {
            return true
        }

        return false
    }

    fileprivate static func generateIntersection(_ point: Point<CoordinateType>, _ lineString: LineString<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Point matches endpoint
        var matchesEndPoint = IntersectionMatrix()
        matchesEndPoint[.interior, .boundary] = .zero
        matchesEndPoint[.exterior, .interior] = .one
        matchesEndPoint[.exterior, .boundary] = .zero /// Assuming the two endpoints of the line string are different
        matchesEndPoint[.exterior, .exterior] = .two

        /// Point on interior
        var pointOnInterior = IntersectionMatrix()
        pointOnInterior[.interior, .interior] = .zero
        pointOnInterior[.exterior, .boundary] = .zero /// Assuming the two endpoints of the line string are different
        pointOnInterior[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Check if the point equals either of the two endpoints of the line string.
        let firstPoint = lineString.first as? Point<CoordinateType>
        let lastPoint  = lineString.first as? Point<CoordinateType>

        if point == firstPoint || point == lastPoint {
            return (point, matchesEndPoint)
        }

        /// Check if the point is on any of the line segments in the line string.
        for firstPointIndex in 0..<lineString.count - 1 {
            guard let firstPoint  = lineString[firstPointIndex] as? Point<CoordinateType>,
                let secondPoint = lineString[firstPointIndex + 1] as? Point<CoordinateType> else {
                    /// No intersection
                    return (nil, disjoint)
            }

            if pointIsOnLineSegment(point, point1: firstPoint, point2: secondPoint) {
                return (point, pointOnInterior)
            }
        }

        /// No intersection
        return (nil, disjoint)
    }
}
