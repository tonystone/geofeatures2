///
///  IntersectionMatrix+Helpers.swift
///  Pods
///
///  Created by Ed Swiss on 3/19/17.
///
///

import Foundation

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

/// Describes the relationship between the first and second geometries
struct RelatedTo {

    var firstInteriorTouchesSecondBoundary: Dimension           = .empty
    var firstBoundaryTouchesSecondBoundary: Dimension           = .empty
    var firstExteriorTouchesSecondBoundary: Dimension           = .empty
    var firstTouchesSecondBoundary: Dimension {
        var tempDimension: Dimension = .empty
        if firstInteriorTouchesSecondBoundary > tempDimension {
            tempDimension = firstInteriorTouchesSecondBoundary
        }
        if firstBoundaryTouchesSecondBoundary > tempDimension {
            tempDimension = firstBoundaryTouchesSecondBoundary
        }
        return tempDimension
    }

    var firstInteriorTouchesSecondInterior: Dimension   = .empty
    var firstBoundaryTouchesSecondInterior: Dimension   = .empty
    var firstExteriorTouchesSecondInterior: Dimension   = .empty
    var firstTouchesSecondInterior: Dimension {
        var tempDimension: Dimension = .empty
        if firstInteriorTouchesSecondInterior > tempDimension {
            tempDimension = firstInteriorTouchesSecondInterior
        }
        if firstBoundaryTouchesSecondInterior > tempDimension {
            tempDimension = firstBoundaryTouchesSecondInterior
        }
        return tempDimension
    }
    var firstTouchesSecondInteriorOnly: Bool {
        return firstTouchesSecondInterior > .empty && firstTouchesSecondBoundary == .empty && firstTouchesSecondExterior == .empty
    }

    var firstInteriorTouchesSecondExterior: Dimension   = .empty
    var firstBoundaryTouchesSecondExterior: Dimension   = .empty
    var firstExteriorTouchesSecondExterior: Dimension   = .two
    var firstTouchesSecondExterior: Dimension {
        var tempDimension: Dimension = .empty
        if firstInteriorTouchesSecondExterior > tempDimension {
            tempDimension = firstInteriorTouchesSecondExterior
        }
        if firstBoundaryTouchesSecondExterior > tempDimension {
            tempDimension = firstBoundaryTouchesSecondExterior
        }
        return tempDimension
    }
    var firstTouchesSecondExteriorOnly: Bool {
        return firstTouchesSecondExterior > .empty && firstTouchesSecondBoundary == .empty && firstTouchesSecondInterior == .empty
    }
}

///
/// Low level type to represent a segment of a line used in geometric computations.
///
fileprivate class SweepLineSegment<CoordinateType: Coordinate & CopyConstructable> {

    internal var leftCoordinate:  CoordinateType
    internal var rightCoordinate: CoordinateType

    init(leftEvent: LeftEvent<CoordinateType>) {
        self.leftCoordinate  = leftEvent.coordinate
        self.rightCoordinate = leftEvent.rightEvent.coordinate
    }
}

extension IntersectionMatrix {

    static func generateMatrix(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

        let (_, resultIntersectionMatrix) = IntersectionMatrix.intersectionGeometry(geometry1, geometry2)

        return resultIntersectionMatrix
    }

    /// Returns the intersection geometry and the intersection matrix.
    /// Note that in general the intersection of two geometries will result in a set of geometries, not just one.
    fileprivate static func intersectionGeometry(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, IntersectionMatrix) {

        switch geometry1.dimension {

        /// The interior of a geometry of dimension zero is the geometry itself.
        case .zero:

            switch geometry2.dimension {

            case .zero:
                return intersectionGeometryZeroZero(geometry1, geometry2)
            case .one:
                return intersectionGeometryZeroOne(geometry1, geometry2)
            case .two:
                return intersectionGeometryZeroTwo(geometry1, geometry2)
            default: break
            }

        case .one:
            /// TODO
            switch geometry2.dimension {
            case .zero:
                return intersectionGeometryOneZero(geometry1, geometry2)
            case .one:
                return intersectionGeometryOneOne(geometry1, geometry2)
            case .two:
                return intersectionGeometryOneTwo(geometry1, geometry2)
            default: break
            }

        case .two:
            /// TODO
            switch geometry2.dimension {
            case .zero:
                return intersectionGeometryTwoZero(geometry1, geometry2)
            case .one:
                return intersectionGeometryTwoOne(geometry1, geometry2)
            case .two:
                return intersectionGeometryTwoTwo(geometry1, geometry2)
            default: break
            }

        default: break
        }

        return (nil, IntersectionMatrix())
    }

    /// For the intersection of two geometries of dimension .zero
    fileprivate static func intersectionGeometryZeroZero(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, IntersectionMatrix) {

        if let point1 = geometry1 as? Point<CoordinateType>, let point2 = geometry2 as? Point<CoordinateType> {
            return generateIntersection(point1, point2)
        } else if let point = geometry1 as? Point<CoordinateType>, let points = geometry2 as? MultiPoint<CoordinateType> {
            return generateIntersection(point, points)
        } else if let points = geometry1 as? MultiPoint<CoordinateType>, let point = geometry2 as? Point<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(point, points)
            return (geometry, intersectionMatrix.transposed())
        } else if let points1 = geometry1 as? MultiPoint<CoordinateType>, let points2 = geometry2 as? MultiPoint<CoordinateType> {
            return generateIntersection(points1, points2)
        }
        return (nil, IntersectionMatrix())
    }

    /// For the intersection of two geometries of dimension .zero and .one, respectively.
    fileprivate static func intersectionGeometryZeroOne(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, IntersectionMatrix) {

        if let point = geometry1 as? Point<CoordinateType>, let lineString = geometry2 as? LineString<CoordinateType> {
            return generateIntersection(point, lineString)
        } else if let points = geometry1 as? MultiPoint<CoordinateType>, let lineString = geometry2 as? LineString<CoordinateType> {
            return generateIntersection(points, lineString)
        } else if let point = geometry1 as? Point<CoordinateType>, let multilineString = geometry2 as? MultiLineString<CoordinateType> {
            return generateIntersection(point, multilineString)
        } else if let points = geometry1 as? MultiPoint<CoordinateType>, let multilineString = geometry2 as? MultiLineString<CoordinateType> {
            return generateIntersection(points, multilineString)
        } else if let point = geometry1 as? Point<CoordinateType>, let linearRing = geometry2 as? LinearRing<CoordinateType> {
            return generateIntersection(point, linearRing)
        } else if let points = geometry1 as? MultiPoint<CoordinateType>, let linearRing = geometry2 as? LinearRing<CoordinateType> {
            return generateIntersection(points, linearRing)
        }
        return (nil, IntersectionMatrix())
    }

    /// For the intersection of two geometries of dimension .zero and .two, respectively.
    fileprivate static func intersectionGeometryZeroTwo(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, IntersectionMatrix) {

        if let point = geometry1 as? Point<CoordinateType>, let polygon = geometry2 as? Polygon<CoordinateType> {
            return generateIntersection(point, polygon)
        } else if let points = geometry1 as? MultiPoint<CoordinateType>, let polygon = geometry2 as? Polygon<CoordinateType> {
            return generateIntersection(points, polygon)
        } else if let point = geometry1 as? Point<CoordinateType>, let multipolygon = geometry2 as? MultiPolygon<CoordinateType> {
            return generateIntersection(point, multipolygon)
        } else if let points = geometry1 as? MultiPoint<CoordinateType>, let multipolygon = geometry2 as? MultiPolygon<CoordinateType> {
            return generateIntersection(points, multipolygon)
        }
        return (nil, IntersectionMatrix())
    }

    /// For the intersection of two geometries of dimension .one and .zero, respectively.
    fileprivate static func intersectionGeometryOneZero(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, IntersectionMatrix) {

        if let lineString = geometry1 as? LineString<CoordinateType>, let point = geometry2 as? Point<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(point, lineString)
            return (geometry, intersectionMatrix.transposed())
        } else if let lineString = geometry1 as? LineString<CoordinateType>, let points = geometry2 as? MultiPoint<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(points, lineString)
            return (geometry, intersectionMatrix.transposed())
        } else if let multilineString = geometry1 as? MultiLineString<CoordinateType>, let point = geometry2 as? Point<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(point, multilineString)
            return (geometry, intersectionMatrix.transposed())
        } else if let multilineString = geometry1 as? MultiLineString<CoordinateType>, let points = geometry2 as? MultiPoint<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(points, multilineString)
            return (geometry, intersectionMatrix.transposed())
        } else if let linearRing = geometry1 as? LinearRing<CoordinateType>, let point = geometry2 as? Point<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(point, linearRing)
            return (geometry, intersectionMatrix.transposed())
        } else if let linearRing = geometry1 as? LinearRing<CoordinateType>, let points = geometry2 as? MultiPoint<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(points, linearRing)
            return (geometry, intersectionMatrix.transposed())
        }
        return (nil, IntersectionMatrix())
    }

    /// For the intersection of two geometries of dimension .one.
    fileprivate static func intersectionGeometryOneOne(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, IntersectionMatrix) {

        if let lineString1 = geometry1 as? LineString<CoordinateType>, let lineString2 = geometry2 as? LineString<CoordinateType> {
            return generateIntersection(lineString1, lineString2)
        } else if let lineString = geometry1 as? LineString<CoordinateType>, let multilineString = geometry2 as? MultiLineString<CoordinateType> {
            return generateIntersection(lineString, multilineString)
        } else if let lineString = geometry1 as? LineString<CoordinateType>, let linearRing = geometry2 as? LinearRing<CoordinateType> {
            return generateIntersection(lineString, linearRing)
        } else if let multilineString = geometry1 as? MultiLineString<CoordinateType>, let lineString = geometry2 as? LineString<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(lineString, multilineString)
            return (geometry, intersectionMatrix.transposed())
        } else if let multilineString1 = geometry1 as? MultiLineString<CoordinateType>, let multilineString2 = geometry2 as? MultiLineString<CoordinateType> {
            return generateIntersection(multilineString1, multilineString2)
        } else if let multilineString = geometry1 as? MultiLineString<CoordinateType>, let linearRing = geometry2 as? LinearRing<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(linearRing, multilineString)
            return (geometry, intersectionMatrix.transposed())
        } else if let linearRing = geometry1 as? LinearRing<CoordinateType>, let lineString = geometry2 as? LineString<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(lineString, linearRing)
            return (geometry, intersectionMatrix.transposed())
        } else if let linearRing = geometry1 as? LinearRing<CoordinateType>, let multilineString = geometry2 as? MultiLineString<CoordinateType> {
            return generateIntersection(linearRing, multilineString)
        } else if let linearRing1 = geometry1 as? LinearRing<CoordinateType>, let linearRing2 = geometry2 as? LinearRing<CoordinateType> {
            return generateIntersection(linearRing1, linearRing2)
        }
        return (nil, IntersectionMatrix())
    }

    /// For the intersection of two geometries of dimension .one and .two, respectively.
    fileprivate static func intersectionGeometryOneTwo(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, IntersectionMatrix) {

        if let lineString = geometry1 as? LineString<CoordinateType>, let polygon = geometry2 as? Polygon<CoordinateType> {
            return generateIntersection(lineString, polygon)
        } else if let lineString = geometry1 as? LineString<CoordinateType>, let multipolygon = geometry2 as? MultiPolygon<CoordinateType> {
            return generateIntersection(lineString, multipolygon)
        } else if let multilineString = geometry1 as? MultiLineString<CoordinateType>, let polygon = geometry2 as? Polygon<CoordinateType> {
            return generateIntersection(multilineString, polygon)
        } else if let multilineString = geometry1 as? MultiLineString<CoordinateType>, let multipolygon = geometry2 as? MultiPolygon<CoordinateType> {
            return generateIntersection(multilineString, multipolygon)
        } else if let linearRing = geometry1 as? LinearRing<CoordinateType>, let polygon = geometry2 as? Polygon<CoordinateType> {
            return generateIntersection(linearRing, polygon)
        } else if let linearRing = geometry1 as? LinearRing<CoordinateType>, let multipolygon = geometry2 as? MultiPolygon<CoordinateType> {
            return generateIntersection(linearRing, multipolygon)
        }
        return (nil, IntersectionMatrix())
    }

    /// For the intersection of two geometries of dimension .two and .zero, respectively.
    fileprivate static func intersectionGeometryTwoZero(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, IntersectionMatrix) {

        if let polgyon = geometry1 as? Polygon<CoordinateType>, let point = geometry2 as? Point<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(point, polgyon)
            return (geometry, intersectionMatrix.transposed())
        } else if let polgyon = geometry1 as? Polygon<CoordinateType>, let points = geometry2 as? MultiPoint<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(points, polgyon)
            return (geometry, intersectionMatrix.transposed())
        } else if let multipolygon = geometry1 as? MultiPolygon<CoordinateType>, let point = geometry2 as? Point<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(point, multipolygon)
            return (geometry, intersectionMatrix.transposed())
        } else if let multipolygon = geometry1 as? MultiPolygon<CoordinateType>, let points = geometry2 as? MultiPoint<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(points, multipolygon)
            return (geometry, intersectionMatrix.transposed())
        }
        return (nil, IntersectionMatrix())
    }

    /// For the intersection of two geometries of dimension .two and .one, respectively.
    fileprivate static func intersectionGeometryTwoOne(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, IntersectionMatrix) {

        if let polgyon = geometry1 as? Polygon<CoordinateType>, let lineString = geometry2 as? LineString<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(lineString, polgyon)
            return (geometry, intersectionMatrix.transposed())
        } else if let polgyon = geometry1 as? Polygon<CoordinateType>, let multilineString = geometry2 as? MultiLineString<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(multilineString, polgyon)
            return (geometry, intersectionMatrix.transposed())
        } else if let polgyon = geometry1 as? Polygon<CoordinateType>, let linearRing = geometry2 as? LinearRing<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(linearRing, polgyon)
            return (geometry, intersectionMatrix.transposed())
        } else if let multipolygon = geometry1 as? MultiPolygon<CoordinateType>, let lineString = geometry2 as? LineString<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(lineString, multipolygon)
            return (geometry, intersectionMatrix.transposed())
        } else if let multipolygon = geometry1 as? MultiPolygon<CoordinateType>, let multilineString = geometry2 as? MultiLineString<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(multilineString, multipolygon)
            return (geometry, intersectionMatrix.transposed())
        } else if let multipolygon = geometry1 as? MultiPolygon<CoordinateType>, let linearRing = geometry2 as? LinearRing<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(linearRing, multipolygon)
            return (geometry, intersectionMatrix.transposed())
        }
        return (nil, IntersectionMatrix())
    }

    /// For the intersection of two geometries of dimension .two.
    fileprivate static func intersectionGeometryTwoTwo(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, IntersectionMatrix) {

        if let polgyon1 = geometry1 as? Polygon<CoordinateType>, let polygon2 = geometry2 as? Polygon<CoordinateType> {
            return generateIntersection(polgyon1, polygon2)
        } else if let polgyon = geometry1 as? Polygon<CoordinateType>, let multipolygon = geometry2 as? MultiPolygon<CoordinateType> {
            return generateIntersection(polgyon, multipolygon)
        } else if let multipolygon = geometry1 as? MultiPolygon<CoordinateType>, let polgyon = geometry2 as? Polygon<CoordinateType> {
            let (geometry, intersectionMatrix) = generateIntersection(polgyon, multipolygon)
            return (geometry, intersectionMatrix.transposed())
        } else if let multipolygon1 = geometry1 as? MultiPolygon<CoordinateType>, let multipolygon2 = geometry2 as? MultiPolygon<CoordinateType> {
            return generateIntersection(multipolygon1, multipolygon2)
        }
        return (nil, IntersectionMatrix())
    }

    ///
    /// Dimension .zero and dimension .zero
    ///

    fileprivate static func generateIntersection(_ point1: Point<CoordinateType>, _ point2: Point<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .exterior] = .two

        if point1 == point2 {
            matrixIntersects[.interior, .interior] = .zero
            return (point1, matrixIntersects)
        }

        matrixIntersects[.interior, .exterior] = .zero
        matrixIntersects[.exterior, .interior] = .zero
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ point: Point<CoordinateType>, _ points: MultiPoint<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Identical
        var identical = IntersectionMatrix()
        identical[.interior, .interior] = .zero
        identical[.exterior, .exterior] = .two

        /// First in second
        var firstInSecond = IntersectionMatrix()
        firstInSecond[.interior, .interior] = .zero
        firstInSecond[.exterior, .interior] = .zero /// Assuming there are at least two distinct points in the points collection
        firstInSecond[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .zero
        disjoint[.exterior, .exterior] = .two

        for tempPoint in points {

            if tempPoint == point {

                if points.count > 1 {
                    return (point, firstInSecond)
                } else {
                    return (point, identical)
                }

            }

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

    fileprivate static func generateIntersection(_ points1: MultiPoint<CoordinateType>, _ points2: MultiPoint<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Identical
        var identical = IntersectionMatrix()
        identical[.interior, .interior] = .zero
        identical[.exterior, .exterior] = .two
        
        /// Intersect but neither is a subset of the other
        var overlap = IntersectionMatrix()
        overlap[.interior, .interior] = .zero
        overlap[.interior, .exterior] = .zero
        overlap[.exterior, .interior] = .zero
        overlap[.exterior, .exterior] = .two

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

        var pointsMatched = false
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
                    pointsMatched = true
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
            if pointsMatched {
                return (multiPointIntersection, overlap)
            } else {
                return (multiPointIntersection, disjoint)
            }
        }
    }

    ///
    /// Dimension .zero and dimesion .one
    ///

    enum LocationType {
        case onBoundary, onInterior, onExterior
    }

    /// Returns true if the first point is on the line segment defined by the next two points.
    fileprivate static func coordinateIsOnLineSegment(_ coordinate: CoordinateType, segment: Segment<CoordinateType>) -> LocationType {

        /// Will likely use precision later, but use EPSILON for now.
        let EPSILON = 0.01

        /// Check if the point is in between the other two points in both x and y.
        let segmentLeft     = segment.leftCoordinate
        let segmentRight    = segment.rightCoordinate
        let leftX           = segmentLeft.x
        let leftY           = segmentLeft.y
        let rightX          = segmentRight.x
        let rightY          = segmentRight.y
        if  (coordinate.x < leftX && coordinate.x < rightX) ||
            (coordinate.x > leftX && coordinate.x > rightX) ||
            (coordinate.y < leftY && coordinate.y < rightY) ||
            (coordinate.y > leftY && coordinate.y > rightY) {
            return .onExterior
        }

        /// Check if the point is on the boundary of the line segment
        if (coordinate == segmentLeft) || (coordinate == segmentRight) {
            return .onBoundary
        }

        /// Check for the cases where the line segment is horizontal or vertical
        if (coordinate.x == leftX && coordinate.x == rightX) || (coordinate.y == leftY && coordinate.y == rightY) {
            return .onInterior
        }

        /// General case
        let slope = (rightY - leftY) / (rightX - leftX)
        let value = leftY - slope * leftX
        if abs(coordinate.y - (slope * coordinate.x + value)) < EPSILON {
            return .onInterior
        }

        return .onExterior
    }

    fileprivate static func pointIsOnLineSegment(_ point: Point<CoordinateType>, segment: Segment<CoordinateType>) -> LocationType {
        return coordinateIsOnLineSegment(point.coordinate, segment: segment)
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
        pointOnInterior[.exterior, .interior] = .one
        pointOnInterior[.exterior, .boundary] = .zero /// Assuming the two endpoints of the line string are different
        pointOnInterior[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .boundary] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Check if the point equals either of the two endpoints of the line string.
        let firstCoord = lineString.first
        let secondCoord  = lineString[lineString.count - 1]

        if point.coordinate == firstCoord || point.coordinate == secondCoord {
            return (point, matchesEndPoint)
        }

        /// Check if the point is on any of the line segments in the line string.
        for firstCoordIndex in 0..<lineString.count - 1 {
            let firstCoord  = lineString[firstCoordIndex]
            let secondCoord = lineString[firstCoordIndex + 1]
            let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
            if pointIsOnLineSegment(point, segment: segment) == .onInterior {
                return (point, pointOnInterior)
            }
        }

        /// No intersection
        return (nil, disjoint)
    }

    fileprivate static func generateIntersection(_ point: Point<CoordinateType>, _ linearRing: LinearRing<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Point on interior
        var pointOnInterior = IntersectionMatrix()
        pointOnInterior[.interior, .interior] = .zero
        pointOnInterior[.exterior, .interior] = .one
        pointOnInterior[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .exterior] = .two

        /// Check if the point is on any of the line segments in the line string.
        for firstCoordIndex in 0..<linearRing.count - 1 {
            let firstCoord  = linearRing[firstCoordIndex]
            let secondCoord = linearRing[firstCoordIndex + 1]
            let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
            if pointIsOnLineSegment(point, segment: segment) == .onInterior {
                return (point, pointOnInterior)
            }
        }

        /// No intersection
        return (nil, disjoint)
    }

    fileprivate static func generateIntersection(_ point: Point<CoordinateType>, _ multiLineString: MultiLineString<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Point matches endpoint
        var matchesEndPoint = IntersectionMatrix()
        matchesEndPoint[.interior, .boundary] = .zero
        matchesEndPoint[.exterior, .interior] = .one
        matchesEndPoint[.exterior, .boundary] = .zero
        matchesEndPoint[.exterior, .exterior] = .two

        /// Point on interior
        var pointOnInterior = IntersectionMatrix()
        pointOnInterior[.interior, .interior] = .zero
        pointOnInterior[.exterior, .interior] = .one
        pointOnInterior[.exterior, .boundary] = .zero
        pointOnInterior[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .boundary] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Check if the point equals any of the endpoints of any line string.
        for lineString in multiLineString {
            let firstCoord = lineString.first
            let secondCoord  = lineString[lineString.count - 1]

            if point.coordinate == firstCoord || point.coordinate == secondCoord {
                return (point, matchesEndPoint)
            }
        }

        /// Check if the point is on any of the line segments in any of the line strings.
        for lineString in multiLineString {
            for firstCoordIndex in 0..<lineString.count - 1 {
                let firstCoord  = lineString[firstCoordIndex]
                let secondCoord = lineString[firstCoordIndex + 1]
                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                if pointIsOnLineSegment(point, segment: segment) == .onInterior {
                    return (point, pointOnInterior)
                }
            }
        }

        /// No intersection
        return (nil, disjoint)
    }

    fileprivate static func subset(_ point: Point<CoordinateType>, _ points: MultiPoint<CoordinateType>) -> Bool {

        for tempPoint in points {
            if point == tempPoint {
                return true
            }
        }
        return false
    }

    fileprivate static func subset(_ points1: MultiPoint<CoordinateType>, _ points2: MultiPoint<CoordinateType>) -> Bool {

        for tempPoint in points1 {
            if subset(tempPoint, points2) {
                continue
            } else {
                return false
            }
        }
        return true
    }

    fileprivate static func subset(_ point: Point<CoordinateType>, _ lineString: LineString<CoordinateType>) -> Bool {

        for firstCoordIndex in 0..<lineString.count - 1 {
            let firstCoord  = lineString[firstCoordIndex]
            let secondCoord = lineString[firstCoordIndex + 1]
            let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
            let location = pointIsOnLineSegment(point, segment: segment)
            if location == .onInterior || location == .onBoundary {
                return true
            }
        }
        return false
    }

    fileprivate static func subset(_ point: Point<CoordinateType>, _ multiLineString: MultiLineString<CoordinateType>) -> Bool {

        for lineString in multiLineString {
            for firstCoordIndex in 0..<lineString.count - 1 {
                let firstCoord  = lineString[firstCoordIndex]
                let secondCoord = lineString[firstCoordIndex + 1]
                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                let location = pointIsOnLineSegment(point, segment: segment)
                if location == .onInterior || location == .onBoundary {
                    return true
                }
            }
        }
        return false
    }

    fileprivate static func relatedTo(_ points: MultiPoint<CoordinateType>, _ lineString: LineString<CoordinateType>) -> RelatedTo {

        var relatedTo = RelatedTo()

        guard let lineStringBoundary = lineString.boundary() as? MultiPoint<CoordinateType> else {
                return relatedTo
        }
        
        relatedTo.firstExteriorTouchesSecondInterior = .one
        
        if subset(lineStringBoundary, points) {
            relatedTo.firstExteriorTouchesSecondBoundary = .empty
        } else {
            relatedTo.firstExteriorTouchesSecondBoundary = .zero
        }

        for tempPoint in points {

            if subset(tempPoint, lineStringBoundary) {
                relatedTo.firstInteriorTouchesSecondBoundary = .zero
                continue
            }

            /// If this point is reached, a point that touches the boundary of the line string has been removed
            for firstCoordIndex in 0..<lineString.count - 1 {
                let firstCoord  = lineString[firstCoordIndex]
                let secondCoord = lineString[firstCoordIndex + 1]
                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                let location = pointIsOnLineSegment(tempPoint, segment: segment)
                if location == .onInterior {
                    relatedTo.firstInteriorTouchesSecondInterior = .zero
                } else if location == .onBoundary {
                    /// Touching the boundary of any line segment is necessarily on the interior
                    relatedTo.firstInteriorTouchesSecondInterior = .zero
                } else {
                    relatedTo.firstInteriorTouchesSecondExterior = .zero
                }
            }
        }
        return relatedTo
    }

    fileprivate static func subset(_ point: Point<CoordinateType>, _ linearRing: LinearRing<CoordinateType>) -> Bool {

        for firstCoordIndex in 0..<linearRing.count - 1 {
            let firstCoord  = linearRing[firstCoordIndex]
            let secondCoord = linearRing[firstCoordIndex + 1]
            let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
            let location = pointIsOnLineSegment(point, segment: segment)
            if location == .onInterior || location == .onBoundary {
                return true
            }
        }
        return false
    }

    fileprivate static func relatedTo(_ points: MultiPoint<CoordinateType>, _ linearRing: LinearRing<CoordinateType>) -> RelatedTo {

        var relatedTo = RelatedTo()
        for tempPoint in points {
            for firstCoordIndex in 0..<linearRing.count - 1 {
                let firstCoord  = linearRing[firstCoordIndex]
                let secondCoord = linearRing[firstCoordIndex + 1]
                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                let location = pointIsOnLineSegment(tempPoint, segment: segment)
                if location == .onInterior {
                    relatedTo.firstInteriorTouchesSecondInterior = .zero
                } else if location == .onBoundary {
                     /// The boundary of any line segment on the linear ring is necessarily on the interior of the linear ring
                    relatedTo.firstInteriorTouchesSecondInterior = .zero
                } else {
                    relatedTo.firstInteriorTouchesSecondExterior = .zero
                }
            }
        }
        return relatedTo
    }

    /// This assumes a GeometryCollection where all of the elements are LinearRings.
    fileprivate static func relatedTo(_ points: MultiPoint<CoordinateType>, _ geometryCollection: GeometryCollection) -> RelatedTo {

        var relatedTo = RelatedTo()

        for index in 0..<geometryCollection.count {

            guard let linearRing = geometryCollection[index] as? LinearRing<CoordinateType> else {
                return relatedTo
            }

            for tempPoint in points {
                for firstCoordIndex in 0..<linearRing.count - 1 {
                    let firstCoord  = linearRing[firstCoordIndex]
                    let secondCoord = linearRing[firstCoordIndex + 1]
                    let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                    let location = pointIsOnLineSegment(tempPoint, segment: segment)
                    if location == .onInterior {
                        relatedTo.firstInteriorTouchesSecondInterior = .zero
                    } else if location == .onBoundary {
                        /// The boundary of any line segment on the linear ring is necessarily on the interior of the linear ring
                        relatedTo.firstInteriorTouchesSecondInterior = .zero
                    } else {
                        relatedTo.firstInteriorTouchesSecondExterior = .zero
                    }
                }
            }
        }

        return relatedTo
    }

    fileprivate static func relatedTo(_ points: MultiPoint<CoordinateType>, _ multiLineString: MultiLineString<CoordinateType>) -> RelatedTo {

        var relatedTo = RelatedTo()

        guard let multiLineStringBoundary = multiLineString.boundary() as? MultiPoint<CoordinateType> else {
            return relatedTo
        }

        for tempPoint in points {

            if subset(tempPoint, multiLineStringBoundary) {
                relatedTo.firstInteriorTouchesSecondBoundary = .zero
                continue
            }

            /// If this point is reached, any point that touches the boundary of the multi line string has been removed
            for lineString in multiLineString {
                for firstCoordIndex in 0..<lineString.count - 1 {
                    let firstCoord  = lineString[firstCoordIndex]
                    let secondCoord = lineString[firstCoordIndex + 1]
                    let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                    let location = pointIsOnLineSegment(tempPoint, segment: segment)
                    if location == .onInterior {
                        relatedTo.firstInteriorTouchesSecondInterior = .zero
                    } else if location == .onBoundary {
                        /// Touching the boundary of any line segment is necessarily on the interior
                        relatedTo.firstInteriorTouchesSecondInterior = .zero
                    } else {
                        relatedTo.firstInteriorTouchesSecondExterior = .zero
                    }
                }
            }
        }
        return relatedTo
    }

    /// This code parallels that of a point and a simple polygon.
    /// Algorithm taken from: https://stackoverflow.com/questions/29344791/check-whether-a-point-is-inside-of-a-simple-polygon
    fileprivate static func relatedTo(_ point: Point<CoordinateType>, _ linearRing: LinearRing<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// Check if the point is on the boundary of the linear ring
        var points = MultiPoint<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())
        points.append(point)
        let tempRelatedToResult = relatedTo(points, linearRing)
        if tempRelatedToResult.firstTouchesSecondInterior != .empty || tempRelatedToResult.firstTouchesSecondBoundary != .empty {
            relatedToResult.firstInteriorTouchesSecondBoundary = .zero
            return relatedToResult
        }

        let pointCoord = point.coordinate

        var secondCoord = linearRing[linearRing.count + 1]

        var isSubset = false

        for firstCoordIndex in 0..<linearRing.count - 1 {
            let firstCoord  = linearRing[firstCoordIndex]

            if ((firstCoord.y >= pointCoord.y) != (secondCoord.y >= pointCoord.y)) &&
                (pointCoord.x <= (secondCoord.x - firstCoord.x) * (pointCoord.y - firstCoord.y) / (secondCoord.y - firstCoord.y) + firstCoord.x) {
                isSubset = !isSubset
            }

            secondCoord = firstCoord
        }

        relatedToResult = RelatedTo() /// Resets to default values

        if isSubset {
            relatedToResult.firstInteriorTouchesSecondInterior = .zero
        } else {
            relatedToResult.firstInteriorTouchesSecondExterior = .zero
        }

        return relatedToResult
    }

    /// Assume here that the polygon is a simple polygon with no holes, just a single simple boundary.
    /// Algorithm taken from: https://stackoverflow.com/questions/29344791/check-whether-a-point-is-inside-of-a-simple-polygon
    /// The algorithm was modified because we assume the polygon is defined as a LinearRing, whose first and last points are the same.
    fileprivate static func relatedTo(_ point: Point<CoordinateType>, _ simplePolygon: Polygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary = simplePolygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0,
            let outerLinearRing = polygonBoundary[0] as? LinearRing<CoordinateType>,
            outerLinearRing.count > 0 else {
                return relatedToResult
        }

        /// Check if the point is on the boundary of the polygon
        var points = MultiPoint<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())
        points.append(point)
        let tempRelatedToResult = relatedTo(points, outerLinearRing)
        if tempRelatedToResult.firstTouchesSecondInterior != .empty || tempRelatedToResult.firstTouchesSecondBoundary != .empty {
            relatedToResult.firstInteriorTouchesSecondBoundary = .zero
            return relatedToResult
        }

        let pointCoord = point.coordinate

        var isSubset = false

        var firstCoord  = outerLinearRing[0]

        for firstCoordIndex in 1..<outerLinearRing.count {
            let secondCoord = outerLinearRing[firstCoordIndex]

            if ((secondCoord.y >= pointCoord.y) != (firstCoord.y >= pointCoord.y)) &&
                (pointCoord.x <= (firstCoord.x - secondCoord.x) * (pointCoord.y - secondCoord.y) / (firstCoord.y - secondCoord.y) + secondCoord.x) {
                isSubset = !isSubset
            }
            
            firstCoord = secondCoord
        }

        relatedToResult = RelatedTo() /// Resets to default values

        if isSubset {
            relatedToResult.firstInteriorTouchesSecondInterior = .zero
        } else {
            relatedToResult.firstInteriorTouchesSecondExterior = .zero
        }

        return relatedToResult
    }

    fileprivate static func relatedTo(_ coordinate: CoordinateType, _ simplePolygon: Polygon<CoordinateType>) -> RelatedTo {

        let point = Point<CoordinateType>(coordinate: coordinate, precision: FloatingPrecision(), coordinateSystem: Cartesian())
        return relatedTo(point, simplePolygon)
    }

    fileprivate static func relatedTo(_ coordinate: CoordinateType, _ linearRing: LinearRing<CoordinateType>) -> RelatedTo {

        let point = Point<CoordinateType>(coordinate: coordinate, precision: FloatingPrecision(), coordinateSystem: Cartesian())
        return relatedTo(point, linearRing)
    }

    /// Assume here that the polygon is a general polygon with holes.
    /// Note we've changed the name so as not to conflict with the simply polygon case.  This may change later.
    fileprivate static func relatedToGeneral(_ point: Point<CoordinateType>, _ polygon: Polygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary = polygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0,
            let outerLinearRing = polygonBoundary[0] as? LinearRing<CoordinateType>,
            outerLinearRing.count > 0 else {
                return relatedToResult
        }

        /// Get the relationship between the point and the main polygon
        let tempPolygon = Polygon<CoordinateType>(outerRing: outerLinearRing, precision: FloatingPrecision(), coordinateSystem: Cartesian())
        let pointRelatedToResult = relatedTo(point, tempPolygon)

        /// Check if the point is on the exterior of the main polygon
        if pointRelatedToResult.firstTouchesSecondExterior > .empty {
            return pointRelatedToResult
        }

        /// Check if the point is on the boundary of the main polygon
        if pointRelatedToResult.firstTouchesSecondBoundary > .empty {
            return pointRelatedToResult
        }

        /// From this point on, the point must be on the interior of the main polygon.
        /// Now we have to check to see if the point is on the boundary or interior of any holes.

        for index in 1..<polygonBoundary.count {
            
            guard let innerLinearRing = polygonBoundary[index] as? LinearRing<CoordinateType>,
                innerLinearRing.count > 0 else {
                    return pointRelatedToResult
            }

            /// Get the relationship between the point and the hole
            let tempPolygon = Polygon<CoordinateType>(outerRing: innerLinearRing, precision: FloatingPrecision(), coordinateSystem: Cartesian())
            let pointRelatedToResult = relatedTo(point, tempPolygon)

            /// Check if the point is on the interior of the hole
            if pointRelatedToResult.firstTouchesSecondInterior > .empty {
                relatedToResult.firstInteriorTouchesSecondExterior = .zero
                return relatedToResult
            }

            /// Check if the point is on the boundary of the hole
            if pointRelatedToResult.firstTouchesSecondBoundary > .empty {
                return pointRelatedToResult
            }

        }

        /// If we've gotten this far, the point must on the interior of the polygon
        relatedToResult.firstInteriorTouchesSecondInterior = .zero

        return relatedToResult
    }

    /// Assume here that the multi polygon is a general multi polygon with a collection of non-intersecting general polygons.
    fileprivate static func relatedTo(_ point: Point<CoordinateType>, _ multipolygon: MultiPolygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// Loop over the polygons and update the relatedToResult struct as needed on each pass.

        for polygon in multipolygon {

            /// Get the relationship between the point and the polygon
            let pointRelatedToResult = relatedTo(point, polygon)

            /// Update the relatedToResult as needed
            update(relatedToBase: &relatedToResult, relatedToNew: pointRelatedToResult)

        }

        return relatedToResult
    }

    /// This function takes one RelatedTo struct, the base struct, and compares a new RelatedTo struct to it.
    /// If the values of the new RelatedTo struct are greater than the base struct, the base struct is updated with the new values.
    fileprivate static func update(relatedToBase: inout RelatedTo, relatedToNew: RelatedTo) {

        if relatedToNew.firstInteriorTouchesSecondInterior > relatedToBase.firstInteriorTouchesSecondInterior {
            relatedToBase.firstInteriorTouchesSecondInterior = relatedToNew.firstInteriorTouchesSecondInterior
        }

        if relatedToNew.firstInteriorTouchesSecondBoundary > relatedToBase.firstInteriorTouchesSecondBoundary {
            relatedToBase.firstInteriorTouchesSecondBoundary = relatedToNew.firstInteriorTouchesSecondBoundary
        }

        if relatedToNew.firstInteriorTouchesSecondExterior > relatedToBase.firstInteriorTouchesSecondExterior {
            relatedToBase.firstInteriorTouchesSecondExterior = relatedToNew.firstInteriorTouchesSecondExterior
        }

        if relatedToNew.firstBoundaryTouchesSecondInterior > relatedToBase.firstBoundaryTouchesSecondInterior {
            relatedToBase.firstBoundaryTouchesSecondInterior = relatedToNew.firstBoundaryTouchesSecondInterior
        }

        if relatedToNew.firstBoundaryTouchesSecondBoundary > relatedToBase.firstBoundaryTouchesSecondBoundary {
            relatedToBase.firstBoundaryTouchesSecondBoundary = relatedToNew.firstBoundaryTouchesSecondBoundary
        }

        if relatedToNew.firstBoundaryTouchesSecondExterior > relatedToBase.firstBoundaryTouchesSecondExterior {
            relatedToBase.firstBoundaryTouchesSecondExterior = relatedToNew.firstBoundaryTouchesSecondExterior
        }

        if relatedToNew.firstExteriorTouchesSecondInterior > relatedToBase.firstExteriorTouchesSecondInterior {
            relatedToBase.firstExteriorTouchesSecondInterior = relatedToNew.firstExteriorTouchesSecondInterior
        }

        if relatedToNew.firstExteriorTouchesSecondBoundary > relatedToBase.firstExteriorTouchesSecondBoundary {
            relatedToBase.firstExteriorTouchesSecondBoundary = relatedToNew.firstExteriorTouchesSecondBoundary
        }

        if relatedToNew.firstExteriorTouchesSecondExterior > relatedToBase.firstExteriorTouchesSecondExterior {
            relatedToBase.firstExteriorTouchesSecondExterior = relatedToNew.firstExteriorTouchesSecondExterior
        }
    }

    /// This function takes one IntersectionMatrix struct, the base struct, and compares a new IntersectionMatrix struct to it.
    /// If the values of the new IntersectionMatrix struct are greater than the base struct, the base struct is updated with the new values.
    /// Note the RelatedTo struct has evolved into an IntersectionMatrix equivalent.
    /// We may use both or simply replace RelatedTo with IntersectionMatric everywhere.
    fileprivate static func update(intersectionMatrixBase: inout IntersectionMatrix, intersectionMatrixNew: IntersectionMatrix) {

        if intersectionMatrixNew[.interior, .interior] > intersectionMatrixBase[.interior, .interior] {
            intersectionMatrixBase[.interior, .interior] = intersectionMatrixNew[.interior, .interior]
        }

        if intersectionMatrixNew[.interior, .boundary] > intersectionMatrixBase[.interior, .boundary] {
            intersectionMatrixBase[.interior, .boundary] = intersectionMatrixNew[.interior, .boundary]
        }

        if intersectionMatrixNew[.interior, .exterior] > intersectionMatrixBase[.interior, .exterior] {
            intersectionMatrixBase[.interior, .exterior] = intersectionMatrixNew[.interior, .exterior]
        }

        if intersectionMatrixNew[.boundary, .interior] > intersectionMatrixBase[.boundary, .interior] {
            intersectionMatrixBase[.boundary, .interior] = intersectionMatrixNew[.boundary, .interior]
        }

        if intersectionMatrixNew[.boundary, .boundary] > intersectionMatrixBase[.boundary, .boundary] {
            intersectionMatrixBase[.boundary, .boundary] = intersectionMatrixNew[.boundary, .boundary]
        }

        if intersectionMatrixNew[.boundary, .exterior] > intersectionMatrixBase[.boundary, .exterior] {
            intersectionMatrixBase[.boundary, .exterior] = intersectionMatrixNew[.boundary, .exterior]
        }

        if intersectionMatrixNew[.exterior, .interior] > intersectionMatrixBase[.exterior, .interior] {
            intersectionMatrixBase[.exterior, .interior] = intersectionMatrixNew[.exterior, .interior]
        }

        if intersectionMatrixNew[.exterior, .boundary] > intersectionMatrixBase[.exterior, .boundary] {
            intersectionMatrixBase[.exterior, .boundary] = intersectionMatrixNew[.exterior, .boundary]
        }

        if intersectionMatrixNew[.exterior, .exterior] > intersectionMatrixBase[.exterior, .exterior] {
            intersectionMatrixBase[.exterior, .exterior] = intersectionMatrixNew[.exterior, .exterior]
        }
    }

    /// The polygon is a general polygon.  This polygon has holes.
    fileprivate static func relatedTo(_ points: MultiPoint<CoordinateType>, _ polygon: Polygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// It is assumed that the polygon boundary is a collection of LinearRings with the first
        /// being the main polygon boundary and the rest being the holes inside the polygon.
        /// In this case, we should have just one LinearRing, which is the outer LinearRing.
        guard let polygonBoundary = polygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0 else {
            return relatedToResult
        }

        /// Check if any of the points are on the boundary
        let pointsRelatedToBoundary = relatedTo(points, polygonBoundary)
        if pointsRelatedToBoundary.firstTouchesSecondInterior != .empty || pointsRelatedToBoundary.firstTouchesSecondBoundary != .empty {
            relatedToResult.firstInteriorTouchesSecondBoundary = .zero
        }

        var pointsOnInteriorOfMainRing      = GeometryCollection(precision: FloatingPrecision(), coordinateSystem: Cartesian())
        var pointsOnInteriorOfInnerRings    = GeometryCollection(precision: FloatingPrecision(), coordinateSystem: Cartesian())
        var pointsOnBoundaryOfInnerRings    = GeometryCollection(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        for tempPoint in points {

            var firstTime = true

            for element in polygonBoundary {

                guard let linearRing = element as? LinearRing<CoordinateType> else {
                    return relatedToResult
                }

                let tempPolygon = Polygon<CoordinateType>(outerRing: linearRing, precision: FloatingPrecision(), coordinateSystem: Cartesian())

                let tempRelatedToResult = relatedTo(tempPoint, tempPolygon)

                /// The first linear ring is the outer boundary of the polygon
                if firstTime {
                    if tempRelatedToResult.firstTouchesSecondExterior > .empty {
                        relatedToResult.firstInteriorTouchesSecondExterior = .zero
                        break
                    } else if tempRelatedToResult.firstTouchesSecondBoundary > .empty {
                        relatedToResult.firstInteriorTouchesSecondBoundary = .zero
                        break
                    } else {
                        pointsOnInteriorOfMainRing.append(tempPoint)
                    }
                    firstTime = false

                } else {
                    /// The algorithm will only reach this point if the point is on the interior of the main polygon.
                    /// Note, too, that the tempPolygon above now refers to one of the main polygon's holes.
                    /// If the point is on the interior of a hole, it is on the exterior of the main polygon.
                    if tempRelatedToResult.firstTouchesSecondInterior > .empty {
                        pointsOnInteriorOfInnerRings.append(tempPoint)
                        relatedToResult.firstInteriorTouchesSecondExterior = .zero
                        break
                    }

                    if tempRelatedToResult.firstTouchesSecondBoundary > .empty {
                        pointsOnBoundaryOfInnerRings.append(tempPoint)
                        relatedToResult.firstInteriorTouchesSecondBoundary = .zero
                        break
                    }
                }
            }
        }

        if pointsOnInteriorOfMainRing.count > pointsOnInteriorOfInnerRings.count + pointsOnBoundaryOfInnerRings.count {
            relatedToResult.firstInteriorTouchesSecondInterior = .zero
        }

        return relatedToResult
    }

    /// Assume here that the polygon is a general polygon with holes.
    /// Note we've changed the name so as not to conflict with the simply polygon case.  This may change later.
    fileprivate static func relatedToGeneral(_ points: MultiPoint<CoordinateType>, _ polygon: Polygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary = polygon.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary.count > 0,
            let lineString = polygonBoundary.first,
            lineString.count > 0 else {
                return relatedToResult
        }

        for point in points {

            /// Get the relationships between each point and the general polygon
            let pointRelatedToResult = relatedToGeneral(point, polygon)

            /// Check if the point is on the interior of the polygon
            if pointRelatedToResult.firstTouchesSecondInterior > .empty {
                relatedToResult.firstInteriorTouchesSecondInterior = .zero
            }

            /// Check if the point is on the boundary of the polygon
            if pointRelatedToResult.firstTouchesSecondBoundary > .empty {
                relatedToResult.firstInteriorTouchesSecondBoundary = .zero
            }

            /// Check if the point is on the exterior of the polygon
            if pointRelatedToResult.firstTouchesSecondInterior > .empty {
                relatedToResult.firstInteriorTouchesSecondExterior = .zero
            }

        }

        return relatedToResult
    }

    /// Assume here that the multi polygon is a general multi polygon with holes.
    fileprivate static func relatedTo(_ points: MultiPoint<CoordinateType>, _ multipolygon: MultiPolygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// Loop over the polygons and update the relatedToResult struct as needed on each pass.

        for point in points {

            /// Get the relationships between each point and the general multipolygon
            let pointRelatedToResult = relatedTo(point, multipolygon)

            /// Update the relatedToResult as needed
            update(relatedToBase: &relatedToResult, relatedToNew: pointRelatedToResult)

        }

        return relatedToResult
    }

    fileprivate static func midpoint(_ coord1: CoordinateType, _ coord2: CoordinateType) -> CoordinateType {

        return CoordinateType(x: (coord1.x + coord2.x) / 2.0, y: (coord1.y + coord2.y) / 2.0)

    }

    /// This code parallels that where the second geometry is a simple polygon.
    fileprivate static func relatedTo(_ segment: Segment<CoordinateType>, _ linearRing: LinearRing<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// For each line segment in the line string, check the following:
        /// - Is all the line segment in the boundary of the linear ring?  If so, set the firstTouchesSecondBoundary to .one.
        /// - Is a > 0 length proper subset of the line segment in the boundary of the linear ring?  If so, set the firstTouchesSecondBoundary to .one.
        ///   Also, generate an ordered array of points at which the line segment touches the boundary.  (The line segment could touch the linear ring boundary at
        ///   more than one sub line segment.)  This array will include the end points of sub line segments.  From this array generate a second array of the
        ///   midpoints.  Check whether each point in that array is inside or outside of the linear ring.  If inside, set the firstTouchesSecondInterior to .one.
        ///   If outside, set firstTouchesSecondExterior to .one.
        /// - Does the line segment touch the linear ring boundary at one or more points?  If so, set the firstTouchesSecondBoundary to .zero.
        /// - Does either line segment endpoint touch inside the linear ring?  If so, set the firstTouchesSecondInterior to .one.
        /// - Does either line segment endpoint touch outside the linear ring?  If so, set the firstTouchesSecondExterior to .one.
        /// - If at any point firstTouchesSecondBoundary, firstTouchesSecondInterior, and firstTouchesSecondExterior are all .one, then stop and return.
        ///
        /// Also, add functions to RelatedTo like isInside, isOutside, isInBoundary.

        /// Array of geometries at which the segment intersects the linear ring boundary
        var intersectionGeometries = [Geometry]()

        /// Do a first pass to get the basic relationship of the line segment to the linear ring
        for firstCoordIndex in 0..<linearRing.count - 1 {
            let firstCoord  = linearRing[firstCoordIndex]
            let secondCoord = linearRing[firstCoordIndex + 1]
            let segment2 = Segment<CoordinateType>(left: firstCoord, right: secondCoord)

            let lineSegmentIntersection = intersection(segment: segment, other: segment2)

            if let intersectionGeometry = lineSegmentIntersection.geometry {
                intersectionGeometries.append(intersectionGeometry)

                if intersectionGeometry.dimension == .one {
                    relatedToResult.firstInteriorTouchesSecondBoundary = .one
                } else if intersectionGeometry.dimension != .one && intersectionGeometry.dimension == .zero {
                    if lineSegmentIntersection.firstSegmentFirstBoundaryLocation == .onInterior || lineSegmentIntersection.firstSegmentFirstBoundaryLocation == .onInterior {
                        relatedToResult.firstInteriorTouchesSecondBoundary = .zero
                    }
                }

                if lineSegmentIntersection.firstSegmentFirstBoundaryLocation == .onBoundary || lineSegmentIntersection.firstSegmentFirstBoundaryLocation == .onBoundary {
                    relatedToResult.firstBoundaryTouchesSecondBoundary = .zero
                }
            }

            let relatedToResultCoordinate = relatedTo(firstCoord, linearRing)

            if relatedToResultCoordinate.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                relatedToResult.firstInteriorTouchesSecondInterior = relatedToResultCoordinate.firstInteriorTouchesSecondInterior
            }

            if relatedToResultCoordinate.firstBoundaryTouchesSecondInterior > relatedToResult.firstBoundaryTouchesSecondInterior {
                relatedToResult.firstBoundaryTouchesSecondInterior = relatedToResultCoordinate.firstBoundaryTouchesSecondInterior
            }

            if relatedToResultCoordinate.firstInteriorTouchesSecondExterior > relatedToResult.firstInteriorTouchesSecondExterior {
                relatedToResult.firstInteriorTouchesSecondExterior = relatedToResultCoordinate.firstInteriorTouchesSecondExterior
            }

            if relatedToResultCoordinate.firstBoundaryTouchesSecondExterior > relatedToResult.firstBoundaryTouchesSecondExterior {
                relatedToResult.firstBoundaryTouchesSecondExterior = relatedToResultCoordinate.firstBoundaryTouchesSecondExterior
            }

            /// Check the very last coordinate of the linear ring boundary
            if firstCoordIndex == linearRing.count - 2 {
                let relatedToResultCoordinate = relatedTo(firstCoord, linearRing)

                if relatedToResultCoordinate.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                    relatedToResult.firstInteriorTouchesSecondInterior = relatedToResultCoordinate.firstInteriorTouchesSecondInterior
                }

                if relatedToResultCoordinate.firstBoundaryTouchesSecondInterior > relatedToResult.firstBoundaryTouchesSecondInterior {
                    relatedToResult.firstBoundaryTouchesSecondInterior = relatedToResultCoordinate.firstBoundaryTouchesSecondInterior
                }

                if relatedToResultCoordinate.firstInteriorTouchesSecondExterior > relatedToResult.firstInteriorTouchesSecondExterior {
                    relatedToResult.firstInteriorTouchesSecondExterior = relatedToResultCoordinate.firstInteriorTouchesSecondExterior
                }

                if relatedToResultCoordinate.firstBoundaryTouchesSecondExterior > relatedToResult.firstBoundaryTouchesSecondExterior {
                    relatedToResult.firstBoundaryTouchesSecondExterior = relatedToResultCoordinate.firstBoundaryTouchesSecondExterior
                }
            }
        }

        /// Check the cases where no further work is needed.
        if (relatedToResult.firstTouchesSecondBoundary == .one && relatedToResult.firstTouchesSecondInterior == .one && relatedToResult.firstTouchesSecondExterior == .one) ||
            (relatedToResult.firstTouchesSecondBoundary == .empty) ||
            (intersectionGeometries.count <= 1) {
            return relatedToResult
        }

        /// Check the case where the line segment interior lies on the interior or exterior of the linear ring.  This is why we have been collecting the geometries.
        /// Do the following:
        /// - Generate an array of the midpoints of the consecutive geometries.
        /// - Check whether each point in that array is inside or outside of the linear ring.
        ///   If inside, set the firstTouchesSecondInterior to .one.
        ///   If outside, set firstTouchesSecondExterior to .one.
        ///
        /// Note that this algorithm can likely be made better in the cases where two midpoints are created rather than just one.

        guard intersectionGeometries.count >= 2 else { return relatedToResult }

        var midpointCoordinates = [CoordinateType]()

        for firstGeometryIndex in 0..<intersectionGeometries.count - 1 {
            let intersectionGeometry1 = intersectionGeometries[firstGeometryIndex]
            let intersectionGeometry2 = intersectionGeometries[firstGeometryIndex + 1]

            var midpointCoord1: CoordinateType?
            var midpointCoord2: CoordinateType?
            if let point1 = intersectionGeometry1 as? Point<CoordinateType>, let point2 = intersectionGeometry2 as? Point<CoordinateType> {

                midpointCoord1 = midpoint(point1.coordinate, point2.coordinate)

            } else if let point = intersectionGeometry1 as? Point<CoordinateType>, let segment = intersectionGeometry2 as? Segment<CoordinateType> {

                /// Since we don't know which end of the segment is sequentially next to the point, we add both midpoints
                midpointCoord1 = midpoint(point.coordinate, segment.leftCoordinate)
                midpointCoord2 = midpoint(point.coordinate, segment.rightCoordinate)

            } else if let point = intersectionGeometry2 as? Point<CoordinateType>, let segment = intersectionGeometry1 as? Segment<CoordinateType> {

                /// Since we don't know which end of the segment is sequentially next to the point, we add both midpoints
                midpointCoord1 = midpoint(point.coordinate, segment.leftCoordinate)
                midpointCoord2 = midpoint(point.coordinate, segment.rightCoordinate)

            } else if let segment1 = intersectionGeometry1 as? Segment<CoordinateType>, let segment2 = intersectionGeometry2 as? Segment<CoordinateType> {

                /// Both line segments lie on a straight line.
                /// The midpoint of interest lies either (1) between the leftCoordinate of the first and the rightCoordinate of the second or
                /// (2) the rightCoordinate of the first and the leftCoordinate of the second.  We add both midpoints.
                midpointCoord1 = midpoint(segment1.leftCoordinate, segment2.rightCoordinate)
                midpointCoord2 = midpoint(segment1.rightCoordinate, segment2.leftCoordinate)

            }

            if let midpointCoord1 = midpointCoord1 { midpointCoordinates.append(midpointCoord1) }
            if let midpointCoord2 = midpointCoord2 { midpointCoordinates.append(midpointCoord2) }
        }

        /// The midpoints have all been generated.  Check whether each is inside or outside of the linear ring.

        for coord in midpointCoordinates {

            let pointRelatedToResult = relatedTo(coord, linearRing)

            if pointRelatedToResult.firstInteriorTouchesSecondInterior > .empty {
                relatedToResult.firstInteriorTouchesSecondInterior = pointRelatedToResult.firstInteriorTouchesSecondInterior
            }

            if pointRelatedToResult.firstBoundaryTouchesSecondInterior > .empty {
                relatedToResult.firstBoundaryTouchesSecondInterior = pointRelatedToResult.firstBoundaryTouchesSecondInterior
            }

            if pointRelatedToResult.firstInteriorTouchesSecondExterior > .empty {
                relatedToResult.firstInteriorTouchesSecondExterior = pointRelatedToResult.firstInteriorTouchesSecondExterior
            }

            if pointRelatedToResult.firstBoundaryTouchesSecondExterior > .empty {
                relatedToResult.firstBoundaryTouchesSecondExterior = pointRelatedToResult.firstBoundaryTouchesSecondExterior
            }

        }

        /// Return

        return relatedToResult
    }

    /// Assume here that the polygon is a simple polygon with no holes, just a single simple boundary.
    fileprivate static func relatedTo(_ segment: Segment<CoordinateType>, _ simplePolygon: Polygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary = simplePolygon.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary.count > 0,
            let mainPolygon = polygonBoundary.first,
            mainPolygon.count > 0 else {
                return relatedToResult
        }

        /// For each line segment in the line string, check the following:
        /// - Is all the line segment in the boundary of the polygon?  If so, set the firstTouchesSecondBoundary to .one.
        /// - Is a > 0 length proper subset of the line segment in the boundary of the polygon?  If so, set the firstTouchesSecondBoundary to .one.
        ///   Also, generate an ordered array of points at which the line segment touches the boundary.  (The line segment could touch the polygon boundary at
        ///   more than one sub line segment.)  This array will include the end points of sub line segments.  From this array generate a second array of the
        ///   midpoints.  Check whether each point in that array is inside or outside of the polygon.  If inside, set the firstTouchesSecondInterior to .one.
        ///   If outside, set firstTouchesSecondExterior to .one.
        /// - Does the line segment touch the polygon boundary at one or more points?  If so, set the firstTouchesSecondBoundary to .zero.
        /// - Does either line segment endpoint touch inside the polygon?  If so, set the firstTouchesSecondInterior to .one.
        /// - Does either line segment endpoint touch outside the polygon?  If so, set the firstTouchesSecondExterior to .one.
        /// - If at any point firstTouchesSecondBoundary, firstTouchesSecondInterior, and firstTouchesSecondExterior are all .one, then stop and return.
        ///
        /// Also, add functions to RelatedTo like isInside, isOutside, isInBoundary.

        /// Array of geometries at which the segment intersects the polygon boundary
        var intersectionGeometries = [Geometry]()

        /// Do a first pass to get the basic relationship of the line segment to the polygon
        for firstCoordIndex in 0..<mainPolygon.count - 1 {
            let firstCoord  = mainPolygon[firstCoordIndex]
            let secondCoord = mainPolygon[firstCoordIndex + 1]
            let segment2 = Segment<CoordinateType>(left: firstCoord, right: secondCoord)

            let lineSegmentIntersection = intersection(segment: segment, other: segment2)

            if let intersectionGeometry = lineSegmentIntersection.geometry {
                intersectionGeometries.append(intersectionGeometry)

                if intersectionGeometry.dimension == .one {
                    relatedToResult.firstInteriorTouchesSecondBoundary = .one
                } else if intersectionGeometry.dimension != .one && intersectionGeometry.dimension == .zero {
                    if lineSegmentIntersection.firstSegmentFirstBoundaryLocation == .onInterior || lineSegmentIntersection.firstSegmentFirstBoundaryLocation == .onInterior {
                        relatedToResult.firstInteriorTouchesSecondBoundary = .zero
                    }
                }

                if lineSegmentIntersection.firstSegmentFirstBoundaryLocation == .onBoundary || lineSegmentIntersection.firstSegmentFirstBoundaryLocation == .onBoundary {
                    relatedToResult.firstBoundaryTouchesSecondBoundary = .zero
                }
            }

            let relatedToResultCoordinate = relatedTo(firstCoord, simplePolygon)

            if relatedToResultCoordinate.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                relatedToResult.firstInteriorTouchesSecondInterior = relatedToResultCoordinate.firstInteriorTouchesSecondInterior
            }

            if relatedToResultCoordinate.firstBoundaryTouchesSecondInterior > relatedToResult.firstBoundaryTouchesSecondInterior {
                relatedToResult.firstBoundaryTouchesSecondInterior = relatedToResultCoordinate.firstBoundaryTouchesSecondInterior
            }

            if relatedToResultCoordinate.firstInteriorTouchesSecondExterior > relatedToResult.firstInteriorTouchesSecondExterior {
                relatedToResult.firstInteriorTouchesSecondExterior = relatedToResultCoordinate.firstInteriorTouchesSecondExterior
            }

            if relatedToResultCoordinate.firstBoundaryTouchesSecondExterior > relatedToResult.firstBoundaryTouchesSecondExterior {
                relatedToResult.firstBoundaryTouchesSecondExterior = relatedToResultCoordinate.firstBoundaryTouchesSecondExterior
            }

            /// Check the very last coordinate of the polygon boundary
            if firstCoordIndex == mainPolygon.count - 2 {
                let relatedToResultCoordinate = relatedTo(firstCoord, simplePolygon)

                if relatedToResultCoordinate.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                    relatedToResult.firstInteriorTouchesSecondInterior = relatedToResultCoordinate.firstInteriorTouchesSecondInterior
                }

                if relatedToResultCoordinate.firstBoundaryTouchesSecondInterior > relatedToResult.firstBoundaryTouchesSecondInterior {
                    relatedToResult.firstBoundaryTouchesSecondInterior = relatedToResultCoordinate.firstBoundaryTouchesSecondInterior
                }

                if relatedToResultCoordinate.firstInteriorTouchesSecondExterior > relatedToResult.firstInteriorTouchesSecondExterior {
                    relatedToResult.firstInteriorTouchesSecondExterior = relatedToResultCoordinate.firstInteriorTouchesSecondExterior
                }

                if relatedToResultCoordinate.firstBoundaryTouchesSecondExterior > relatedToResult.firstBoundaryTouchesSecondExterior {
                    relatedToResult.firstBoundaryTouchesSecondExterior = relatedToResultCoordinate.firstBoundaryTouchesSecondExterior
                }
            }
        }

        /// Check the cases where no further work is needed.
        if (relatedToResult.firstTouchesSecondBoundary == .one && relatedToResult.firstTouchesSecondInterior == .one && relatedToResult.firstTouchesSecondExterior == .one) ||
            (relatedToResult.firstTouchesSecondBoundary == .empty) ||
            (intersectionGeometries.count <= 1) {
            return relatedToResult
        }

        /// Check the case where the line segment interior lies on the interior or exterior of the polygon.  This is why we have been collecting the geometries.
        /// Do the following:
        /// - Generate an array of the midpoints of the consecutive geometries.
        /// - Check whether each point in that array is inside or outside of the polygon.
        ///   If inside, set the firstTouchesSecondInterior to .one.
        ///   If outside, set firstTouchesSecondExterior to .one.
        ///
        /// Note that this algorithm can likely be made better in the cases where two midpoints are created rather than just one.

        guard intersectionGeometries.count >= 2 else { return relatedToResult }

        var midpointCoordinates = [CoordinateType]()

        for firstGeometryIndex in 0..<intersectionGeometries.count - 1 {
            let intersectionGeometry1 = intersectionGeometries[firstGeometryIndex]
            let intersectionGeometry2 = intersectionGeometries[firstGeometryIndex + 1]

            var midpointCoord1: CoordinateType?
            var midpointCoord2: CoordinateType?
            if let point1 = intersectionGeometry1 as? Point<CoordinateType>, let point2 = intersectionGeometry2 as? Point<CoordinateType> {

                midpointCoord1 = midpoint(point1.coordinate, point2.coordinate)

            } else if let point = intersectionGeometry1 as? Point<CoordinateType>, let segment = intersectionGeometry2 as? Segment<CoordinateType> {

                /// Since we don't know which end of the segment is sequentially next to the point, we add both midpoints
                midpointCoord1 = midpoint(point.coordinate, segment.leftCoordinate)
                midpointCoord2 = midpoint(point.coordinate, segment.rightCoordinate)

            } else if let point = intersectionGeometry2 as? Point<CoordinateType>, let segment = intersectionGeometry1 as? Segment<CoordinateType> {

                /// Since we don't know which end of the segment is sequentially next to the point, we add both midpoints
                midpointCoord1 = midpoint(point.coordinate, segment.leftCoordinate)
                midpointCoord2 = midpoint(point.coordinate, segment.rightCoordinate)

            } else if let segment1 = intersectionGeometry1 as? Segment<CoordinateType>, let segment2 = intersectionGeometry2 as? Segment<CoordinateType> {

                /// Both line segments lie on a straight line.
                /// The midpoint of interest lies either (1) between the leftCoordinate of the first and the rightCoordinate of the second or
                /// (2) the rightCoordinate of the first and the leftCoordinate of the second.  We add both midpoints.
                midpointCoord1 = midpoint(segment1.leftCoordinate, segment2.rightCoordinate)
                midpointCoord2 = midpoint(segment1.rightCoordinate, segment2.leftCoordinate)

            }

            if let midpointCoord1 = midpointCoord1 { midpointCoordinates.append(midpointCoord1) }
            if let midpointCoord2 = midpointCoord2 { midpointCoordinates.append(midpointCoord2) }
        }

        /// The midpoints have all been generated.  Check whether each is inside or outside of the polygon.

        for coord in midpointCoordinates {

            let pointRelatedToResult = relatedTo(coord, simplePolygon)

            if pointRelatedToResult.firstInteriorTouchesSecondInterior > .empty {
                relatedToResult.firstInteriorTouchesSecondInterior = pointRelatedToResult.firstInteriorTouchesSecondInterior
            }

            if pointRelatedToResult.firstBoundaryTouchesSecondInterior > .empty {
                relatedToResult.firstBoundaryTouchesSecondInterior = pointRelatedToResult.firstBoundaryTouchesSecondInterior
            }

            if pointRelatedToResult.firstInteriorTouchesSecondExterior > .empty {
                relatedToResult.firstInteriorTouchesSecondExterior = pointRelatedToResult.firstInteriorTouchesSecondExterior
            }

            if pointRelatedToResult.firstBoundaryTouchesSecondExterior > .empty {
                relatedToResult.firstBoundaryTouchesSecondExterior = pointRelatedToResult.firstBoundaryTouchesSecondExterior
            }

        }

        /// Return

        return relatedToResult
    }

    /// Assume here that the polygon is a simple polygon with no holes, just a single simple boundary.
    fileprivate static func relatedTo(_ lineString: LineString<CoordinateType>, _ simplePolygon: Polygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary = simplePolygon.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary.count > 0,
            let mainPolygon = polygonBoundary.first,
            mainPolygon.count > 0 else {
                return relatedToResult
        }

        /// Check the relationships between each line segment of the line string and the simple polygon

        for firstCoordIndex in 0..<lineString.count - 1 {

            let firstCoord  = lineString[firstCoordIndex]
            let secondCoord = lineString[firstCoordIndex + 1]
            let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)

            let segmentRelatedToResult = relatedTo(segment, simplePolygon)

            if segmentRelatedToResult.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                relatedToResult.firstInteriorTouchesSecondInterior = segmentRelatedToResult.firstInteriorTouchesSecondInterior
            }

            if segmentRelatedToResult.firstBoundaryTouchesSecondInterior > relatedToResult.firstBoundaryTouchesSecondInterior {
                relatedToResult.firstBoundaryTouchesSecondInterior = segmentRelatedToResult.firstBoundaryTouchesSecondInterior
            }

            if segmentRelatedToResult.firstInteriorTouchesSecondBoundary > relatedToResult.firstInteriorTouchesSecondBoundary {
                relatedToResult.firstInteriorTouchesSecondBoundary = segmentRelatedToResult.firstInteriorTouchesSecondBoundary
            }

            if segmentRelatedToResult.firstBoundaryTouchesSecondBoundary > relatedToResult.firstBoundaryTouchesSecondBoundary {
                relatedToResult.firstBoundaryTouchesSecondBoundary = segmentRelatedToResult.firstBoundaryTouchesSecondBoundary
            }

            if segmentRelatedToResult.firstInteriorTouchesSecondExterior > relatedToResult.firstInteriorTouchesSecondExterior {
                relatedToResult.firstInteriorTouchesSecondExterior = segmentRelatedToResult.firstInteriorTouchesSecondExterior
            }

            if segmentRelatedToResult.firstBoundaryTouchesSecondExterior > relatedToResult.firstBoundaryTouchesSecondExterior {
                relatedToResult.firstBoundaryTouchesSecondExterior = segmentRelatedToResult.firstBoundaryTouchesSecondExterior
            }

        }

        return relatedToResult
    }

    /// These relationships will most often be used when relating parts of a polygon to one another.
    fileprivate static func relatedTo(_ linearRing1: LinearRing<CoordinateType>, _ linearRing2: LinearRing<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// Check the relationships between each line segment of the linear rings

        for firstCoordIndex in 0..<linearRing1.count - 1 {

            let firstCoord  = linearRing1[firstCoordIndex]
            let secondCoord = linearRing1[firstCoordIndex + 1]
            let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)

            let segmentRelatedToResult = relatedTo(segment, linearRing2)

            if segmentRelatedToResult.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                relatedToResult.firstInteriorTouchesSecondInterior = segmentRelatedToResult.firstInteriorTouchesSecondInterior
            }

            if segmentRelatedToResult.firstInteriorTouchesSecondBoundary > relatedToResult.firstInteriorTouchesSecondBoundary {
                relatedToResult.firstInteriorTouchesSecondBoundary = segmentRelatedToResult.firstInteriorTouchesSecondBoundary
            }

            if segmentRelatedToResult.firstExteriorTouchesSecondInterior > relatedToResult.firstExteriorTouchesSecondInterior {
                relatedToResult.firstExteriorTouchesSecondInterior = segmentRelatedToResult.firstExteriorTouchesSecondInterior
            }

            if segmentRelatedToResult.firstExteriorTouchesSecondBoundary > relatedToResult.firstExteriorTouchesSecondBoundary {
                relatedToResult.firstExteriorTouchesSecondBoundary = segmentRelatedToResult.firstExteriorTouchesSecondBoundary
            }

        }

        return relatedToResult
    }

    /// Assume here that the polygon is a simple polygon with no holes, just a single simple boundary.
    fileprivate static func relatedTo(_ linearRing: LinearRing<CoordinateType>, _ simplePolygon: Polygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary = simplePolygon.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary.count > 0,
            let mainPolygon = polygonBoundary.first,
            mainPolygon.count > 0 else {
                return relatedToResult
        }

        /// Check the relationships between each line segment of the linear ring and the simple polygon

        for firstCoordIndex in 0..<linearRing.count - 1 {

            let firstCoord  = linearRing[firstCoordIndex]
            let secondCoord = linearRing[firstCoordIndex + 1]
            let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)

            let segmentRelatedToResult = relatedTo(segment, simplePolygon)

            if segmentRelatedToResult.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                relatedToResult.firstInteriorTouchesSecondInterior = segmentRelatedToResult.firstInteriorTouchesSecondInterior
            }

            if segmentRelatedToResult.firstInteriorTouchesSecondBoundary > relatedToResult.firstInteriorTouchesSecondBoundary {
                relatedToResult.firstInteriorTouchesSecondBoundary = segmentRelatedToResult.firstInteriorTouchesSecondBoundary
            }

            if segmentRelatedToResult.firstExteriorTouchesSecondInterior > relatedToResult.firstExteriorTouchesSecondInterior {
                relatedToResult.firstExteriorTouchesSecondInterior = segmentRelatedToResult.firstExteriorTouchesSecondInterior
            }

            if segmentRelatedToResult.firstExteriorTouchesSecondBoundary > relatedToResult.firstExteriorTouchesSecondBoundary {
                relatedToResult.firstExteriorTouchesSecondBoundary = segmentRelatedToResult.firstExteriorTouchesSecondBoundary
            }

        }

        return relatedToResult
    }

    /// These relationships will most often be used when relating parts of a polygon to one another.
    fileprivate static func relatedTo(_ linearRing1: LinearRing<CoordinateType>, _ linearRingArray: [LinearRing<CoordinateType>]) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// Check the relationships between the linear ring and each linear ring of the array

        for linearRing2 in linearRingArray {

            let relatedToRings = relatedTo(linearRing1, linearRing2)

            if relatedToRings.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                relatedToResult.firstInteriorTouchesSecondInterior = relatedToRings.firstInteriorTouchesSecondInterior
            }

            if relatedToRings.firstInteriorTouchesSecondBoundary > relatedToResult.firstInteriorTouchesSecondBoundary {
                relatedToResult.firstInteriorTouchesSecondBoundary = relatedToRings.firstInteriorTouchesSecondBoundary
            }

            if relatedToRings.firstExteriorTouchesSecondInterior > relatedToResult.firstExteriorTouchesSecondInterior {
                relatedToResult.firstExteriorTouchesSecondInterior = relatedToRings.firstExteriorTouchesSecondInterior
            }

            if relatedToRings.firstExteriorTouchesSecondBoundary > relatedToResult.firstExteriorTouchesSecondBoundary {
                relatedToResult.firstExteriorTouchesSecondBoundary = relatedToRings.firstExteriorTouchesSecondBoundary
            }

        }

        return relatedToResult
    }

    /// These relationships will most often be used when relating parts of a polygon to one another.
    fileprivate static func relatedTo(_ linearRingArray1: [LinearRing<CoordinateType>], _ linearRingArray2: [LinearRing<CoordinateType>]) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// Check the relationships between the linear ring and each linear ring of the array

        for linearRing1 in linearRingArray1 {

            let relatedToRings = relatedTo(linearRing1, linearRingArray2)

            if relatedToRings.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                relatedToResult.firstInteriorTouchesSecondInterior = relatedToRings.firstInteriorTouchesSecondInterior
            }

            if relatedToRings.firstInteriorTouchesSecondBoundary > relatedToResult.firstInteriorTouchesSecondBoundary {
                relatedToResult.firstInteriorTouchesSecondBoundary = relatedToRings.firstInteriorTouchesSecondBoundary
            }

            if relatedToRings.firstExteriorTouchesSecondInterior > relatedToResult.firstExteriorTouchesSecondInterior {
                relatedToResult.firstExteriorTouchesSecondInterior = relatedToRings.firstExteriorTouchesSecondInterior
            }

            if relatedToRings.firstExteriorTouchesSecondBoundary > relatedToResult.firstExteriorTouchesSecondBoundary {
                relatedToResult.firstExteriorTouchesSecondBoundary = relatedToRings.firstExteriorTouchesSecondBoundary
            }

        }

        return relatedToResult
    }

    /// Assume here that the polygon is a simple polygon with no holes, just a single simple boundary.
    fileprivate static func relatedTo(_ multiLineString: MultiLineString<CoordinateType>, _ simplePolygon: Polygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary = simplePolygon.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary.count > 0,
            let mainPolygon = polygonBoundary.first,
            mainPolygon.count > 0 else {
                return relatedToResult
        }

        /// Check the relationships between each line segment of the line string and the simple polygon

        for lineString in multiLineString {
            for firstCoordIndex in 0..<lineString.count - 1 {

                let firstCoord  = lineString[firstCoordIndex]
                let secondCoord = lineString[firstCoordIndex + 1]
                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)

                let segmentRelatedToResult = relatedTo(segment, simplePolygon)

                if segmentRelatedToResult.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                    relatedToResult.firstInteriorTouchesSecondInterior = segmentRelatedToResult.firstInteriorTouchesSecondInterior
                }

                if segmentRelatedToResult.firstBoundaryTouchesSecondInterior > relatedToResult.firstBoundaryTouchesSecondInterior {
                    relatedToResult.firstBoundaryTouchesSecondInterior = segmentRelatedToResult.firstBoundaryTouchesSecondInterior
                }

                if segmentRelatedToResult.firstInteriorTouchesSecondBoundary > relatedToResult.firstInteriorTouchesSecondBoundary {
                    relatedToResult.firstInteriorTouchesSecondBoundary = segmentRelatedToResult.firstInteriorTouchesSecondBoundary
                }

                if segmentRelatedToResult.firstBoundaryTouchesSecondBoundary > relatedToResult.firstBoundaryTouchesSecondBoundary {
                    relatedToResult.firstBoundaryTouchesSecondBoundary = segmentRelatedToResult.firstBoundaryTouchesSecondBoundary
                }

                if segmentRelatedToResult.firstInteriorTouchesSecondExterior > relatedToResult.firstInteriorTouchesSecondExterior {
                    relatedToResult.firstInteriorTouchesSecondExterior = segmentRelatedToResult.firstInteriorTouchesSecondExterior
                }

                if segmentRelatedToResult.firstBoundaryTouchesSecondExterior > relatedToResult.firstBoundaryTouchesSecondExterior {
                    relatedToResult.firstBoundaryTouchesSecondExterior = segmentRelatedToResult.firstBoundaryTouchesSecondExterior
                }

            }
        }

        return relatedToResult
    }

    /// Assume here that both polygons are simple polygons with no holes, just a single simple boundary.
    fileprivate static func relatedTo(_ simplePolygon1: Polygon<CoordinateType>, _ simplePolygon2: Polygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary1 = simplePolygon1.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary1.count > 0,
            let mainPolygon1 = polygonBoundary1.first,
            mainPolygon1.count > 0 else {
                return relatedToResult
        }

        guard let polygonBoundary2 = simplePolygon2.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary2.count > 0,
            let mainPolygon2 = polygonBoundary2.first,
            mainPolygon2.count > 0 else {
                return relatedToResult
        }

        /// Check whether the first polygon boundary is completely contained in the second polygon boundary
        let reducedPB1 = reduce(polygonBoundary1)
        let reducedPB2 = reduce(polygonBoundary2)
        if subset(reducedPB1, reducedPB2) {
            relatedToResult.firstBoundaryTouchesSecondBoundary = .one
            return relatedToResult
        }

        /// Check the relationships between each line segment of the first polygon boundary and the second polygon

        for lineString in polygonBoundary1 {
            for firstCoordIndex in 0..<lineString.count - 1 {

                let firstCoord  = lineString[firstCoordIndex]
                let secondCoord = lineString[firstCoordIndex + 1]
                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)

                let segmentRelatedToResult = relatedTo(segment, simplePolygon2)

                if segmentRelatedToResult.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                    relatedToResult.firstInteriorTouchesSecondInterior = segmentRelatedToResult.firstInteriorTouchesSecondInterior
                }

                if segmentRelatedToResult.firstBoundaryTouchesSecondInterior > relatedToResult.firstBoundaryTouchesSecondInterior {
                    relatedToResult.firstBoundaryTouchesSecondInterior = segmentRelatedToResult.firstBoundaryTouchesSecondInterior
                }

                if segmentRelatedToResult.firstInteriorTouchesSecondBoundary > relatedToResult.firstInteriorTouchesSecondBoundary {
                    relatedToResult.firstInteriorTouchesSecondBoundary = segmentRelatedToResult.firstInteriorTouchesSecondBoundary
                }

                if segmentRelatedToResult.firstBoundaryTouchesSecondBoundary > relatedToResult.firstBoundaryTouchesSecondBoundary {
                    relatedToResult.firstBoundaryTouchesSecondBoundary = segmentRelatedToResult.firstBoundaryTouchesSecondBoundary
                }

                if segmentRelatedToResult.firstInteriorTouchesSecondExterior > relatedToResult.firstInteriorTouchesSecondExterior {
                    relatedToResult.firstInteriorTouchesSecondExterior = segmentRelatedToResult.firstInteriorTouchesSecondExterior
                }

                if segmentRelatedToResult.firstBoundaryTouchesSecondExterior > relatedToResult.firstBoundaryTouchesSecondExterior {
                    relatedToResult.firstBoundaryTouchesSecondExterior = segmentRelatedToResult.firstBoundaryTouchesSecondExterior
                }
            }
        }

        return relatedToResult
    }

    /// Assume here that both polygons are full polygons with holes
    fileprivate static func relatedToFull(_ polygon1: Polygon<CoordinateType>, _ polygon2: Polygon<CoordinateType>) -> RelatedTo {

        var relatedToResult = RelatedTo()

        let outerRing1 = polygon1.outerRing
        let innerRings1 = polygon1.innerRings
        let outerRing2 = polygon2.outerRing
        let innerRings2 = polygon2.innerRings

        /// Get the relationship between the two outer linear rings and determine if they are the same.
        /// If the two outer linear rings are the same, then the holes need to be examined for equality.
        let relatedToOuterRings = relatedTo(outerRing1, outerRing2)

        if areLinearRingsIdentical(relatedToOuterRings) {

            relatedToResult.firstInteriorTouchesSecondInterior = .two
            relatedToResult.firstBoundaryTouchesSecondBoundary = .one

            if innerRings1.count == 0 && innerRings2.count == 0 {
                /// No inner rings.  Do nothing.
                return relatedToResult
            } else if innerRings1.count == 0 && innerRings2.count > 0 {
                relatedToResult.firstInteriorTouchesSecondBoundary = .one
                relatedToResult.firstInteriorTouchesSecondExterior = .two
                return relatedToResult
            } else if innerRings1.count > 0 && innerRings2.count == 0 {
                relatedToResult.firstBoundaryTouchesSecondInterior = .one
                return relatedToResult
            }

            /// To reach this point, innerRings1.count > 0 && innerRings2.count > 0

            let relatedToInnerRings = relatedTo(innerRings1, innerRings2)

            if matchesSubset(innerRings1, innerRings2) {

                if countIdentical(innerRings1, innerRings2) {
                    /// The two sets of inner rings are identical.  Do nothing.
                } else {
                    /// innerRings1.count < innerRings2.count
                    relatedToResult.firstInteriorTouchesSecondBoundary = .one
                    relatedToResult.firstInteriorTouchesSecondExterior = .two
                }
            } else if matchesSubset(innerRings2, innerRings1) {
                /// innerRings2.count < innerRings1.count
                relatedToResult.firstBoundaryTouchesSecondInterior = .one
            } else {
                /// Two different sets of inner rings that are both not empty
                relatedToResult.firstInteriorTouchesSecondBoundary = relatedToInnerRings.firstExteriorTouchesSecondBoundary
                relatedToResult.firstInteriorTouchesSecondExterior = relatedToInnerRings.firstExteriorTouchesSecondInterior
                relatedToResult.firstBoundaryTouchesSecondInterior = relatedToInnerRings.firstBoundaryTouchesSecondExterior
                relatedToResult.firstBoundaryTouchesSecondExterior = relatedToInnerRings.firstBoundaryTouchesSecondInterior
                relatedToResult.firstExteriorTouchesSecondInterior = relatedToInnerRings.firstInteriorTouchesSecondExterior
                relatedToResult.firstExteriorTouchesSecondBoundary = relatedToInnerRings.firstInteriorTouchesSecondBoundary
            }

            return relatedToResult
        }

        /// The two outer rings are different.
        /// TODO: This might be a general solution, so the specialized case above where the outer rings
        /// are the same may not be needed.  Check that.

        let relatedToInnerRings = relatedTo(innerRings1, innerRings2)

        relatedToResult = relatedToOuterRings

        if relatedToInnerRings.firstExteriorTouchesSecondBoundary > relatedToResult.firstInteriorTouchesSecondBoundary {
            relatedToResult.firstInteriorTouchesSecondBoundary = relatedToInnerRings.firstExteriorTouchesSecondBoundary
        }

        if relatedToInnerRings.firstExteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondExterior {
            relatedToResult.firstInteriorTouchesSecondExterior = relatedToInnerRings.firstExteriorTouchesSecondInterior
        }

        if relatedToInnerRings.firstBoundaryTouchesSecondExterior > relatedToResult.firstBoundaryTouchesSecondInterior {
            relatedToResult.firstBoundaryTouchesSecondInterior = relatedToInnerRings.firstBoundaryTouchesSecondExterior
        }

        if relatedToInnerRings.firstBoundaryTouchesSecondBoundary > relatedToResult.firstBoundaryTouchesSecondBoundary {
            relatedToResult.firstBoundaryTouchesSecondBoundary = relatedToInnerRings.firstBoundaryTouchesSecondBoundary
        }

        if relatedToInnerRings.firstBoundaryTouchesSecondInterior > relatedToResult.firstBoundaryTouchesSecondExterior {
            relatedToResult.firstBoundaryTouchesSecondExterior = relatedToInnerRings.firstBoundaryTouchesSecondInterior
        }

        if relatedToInnerRings.firstInteriorTouchesSecondExterior > relatedToResult.firstExteriorTouchesSecondInterior {
            relatedToResult.firstExteriorTouchesSecondInterior = relatedToInnerRings.firstInteriorTouchesSecondExterior
        }

        if relatedToInnerRings.firstInteriorTouchesSecondBoundary > relatedToResult.firstExteriorTouchesSecondBoundary {
            relatedToResult.firstExteriorTouchesSecondBoundary = relatedToInnerRings.firstInteriorTouchesSecondBoundary
        }

        return relatedToResult
    }

    /// Get the holes for a polygon
    fileprivate static func holes(_ polygon: Polygon<CoordinateType>) -> [Polygon<CoordinateType>] {

        var polygonArray = [Polygon<CoordinateType>]()

        guard let polygonBoundary = polygon.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary.count > 0 else {
                return polygonArray
        }

        for index in 1..<polygonBoundary.count {
            let tempLineString = polygonBoundary[index]
            let tempPolygon = Polygon<CoordinateType>(outerRing: tempLineString, precision: FloatingPrecision(), coordinateSystem: Cartesian())
            polygonArray.append(tempPolygon)
        }

        return polygonArray
    }

    /// It is assumed that a RelatedTo structure has been generated for two linear rings,
    /// and now we want to know if the two match.
    fileprivate static func areLinearRingsIdentical(_ relatedToLinearRings: RelatedTo) -> Bool {
        return relatedToLinearRings.firstTouchesSecondInterior == .empty && relatedToLinearRings.firstTouchesSecondExterior == .empty && relatedToLinearRings.firstBoundaryTouchesSecondBoundary > .empty
    }

    /// It is assumed that a RelatedTo structure has been generated for two polgyons,
    /// and now we want to know if the main boundaries of the polygons are match.
    fileprivate static func areMainPolygonBoundariesIdentical(_ relatedToPolygons: RelatedTo) -> Bool {
        return relatedToPolygons.firstTouchesSecondInterior == .empty && relatedToPolygons.firstTouchesSecondExterior == .empty
    }

    /// It is assumed that a RelatedTo structure has been generated for two polgyons,
    /// and now we want to know if the main boundaries of the polygons are match.
    /// This is the same as areMainPolygonBoundariesIdentical.
    fileprivate static func areMainPolygonsIdentical(_ relatedToPolygons: RelatedTo) -> Bool {
        return areMainPolygonBoundariesIdentical(relatedToPolygons)
    }

    fileprivate static func areSimplePolygonsIdentical(_ simplePolygon1: Polygon<CoordinateType>, _ simplePolygon2: Polygon<CoordinateType>) -> Bool {
        let relatedToPolygons = relatedTo(simplePolygon1, simplePolygon2)
        return areMainPolygonBoundariesIdentical(relatedToPolygons)
    }

    fileprivate static func countIdentical(_ linearRingArray1: [LinearRing<CoordinateType>], _ linearRingArray2: [LinearRing<CoordinateType>]) -> Bool {

        return linearRingArray1.count == linearRingArray2.count
    }

    fileprivate static func holeCountIdentical(_ polygon1: Polygon<CoordinateType>, _ polygon2: Polygon<CoordinateType>) -> Bool {

        guard let polygonBoundary1 = polygon1.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary1.count > 0 else {
                return false
        }

        guard let polygonBoundary2 = polygon2.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary2.count > 0 else {
                return false
        }

        return polygonBoundary1.count == polygonBoundary2.count
    }

    /// Does the linear ring match any of the linear rings in the array?
    fileprivate static func matchesOne(_ linearRing1: LinearRing<CoordinateType>, _ linearRingArray: [LinearRing<CoordinateType>]) -> Bool {

        for linearRing2 in linearRingArray {

            let relatedToRings = relatedTo(linearRing1, linearRing2)

            if areLinearRingsIdentical(relatedToRings) {
                return true
            }
        }

        return false
    }

    /// Does the first array of linear rings match a subset of the linear rings in the second array?
    fileprivate static func matchesSubset(_ linearRingArray1: [LinearRing<CoordinateType>], _ linearRingArray2: [LinearRing<CoordinateType>]) -> Bool {

        for linearRing1 in linearRingArray1 {

            if matchesOne(linearRing1, linearRingArray2) {
                continue
            } else {
                return false
            }
        }

        return true
    }

    /// Using a RelateTo structure which compares two sets of linear ring arrays,
    /// does the first array of linear rings match a subset of the linear rings in the second array?
    fileprivate static func matchesSubset(_ relatedToLinearRingArrays: RelatedTo) -> Bool {

        return relatedToLinearRingArrays.firstBoundaryTouchesSecondBoundary > .empty &&
            relatedToLinearRingArrays.firstTouchesSecondInterior == .empty &&
            relatedToLinearRingArrays.firstTouchesSecondExterior == .empty
    }

    /// Using a RelateTo structure which compares two sets of linear ring arrays,
    /// is the first array of linear rings completely inside a subset of the linear rings in the second array?
    /// This means the two sets do not touch on a boundary.
    fileprivate static func firstInsideSecond(_ relatedToLinearRingArrays: RelatedTo) -> Bool {

        return relatedToLinearRingArrays.firstBoundaryTouchesSecondBoundary == .empty &&
            relatedToLinearRingArrays.firstTouchesSecondInterior > .empty &&
            relatedToLinearRingArrays.firstTouchesSecondExterior == .empty
    }

    /// Using a RelateTo structure which compares two sets of linear ring arrays,
    /// is the first array of linear rings completely outside of the linear rings in the second array?
    /// This means the two sets do not touch on a boundary.
    fileprivate static func firstOutsideSecond(_ relatedToLinearRingArrays: RelatedTo) -> Bool {

        return relatedToLinearRingArrays.firstBoundaryTouchesSecondBoundary == .empty &&
            relatedToLinearRingArrays.firstTouchesSecondInterior == .empty &&
            relatedToLinearRingArrays.firstTouchesSecondExterior > .empty
    }

    /// Does the simple polygon match any of the simple polygons in the array?
    fileprivate static func matchesOne(_ simplePolygon1: Polygon<CoordinateType>, _ simplePolygonArray: [Polygon<CoordinateType>]) -> Bool {

        for simplePolygon2 in simplePolygonArray {

            if areSimplePolygonsIdentical(simplePolygon1, simplePolygon2) {
                return true
            }
        }

        return false
    }

    /// Does the first array of simple polygons match a subset of the simple polygons in the second array?
    fileprivate static func matchesSubset(_ simplePolygonArray1: [Polygon<CoordinateType>], _ simplePolygonArray2: [Polygon<CoordinateType>]) -> Bool {

        for simplePolygon1 in simplePolygonArray1 {

            if matchesOne(simplePolygon1, simplePolygonArray2) {
                continue
            } else {
                return false
            }
        }

        return true
    }

    /// Does the first array of simple polygons match the second array of the simple polygons?
    /// Note that we assume the same polygon does not appear more than once in either array.
    /// TODO: Expand this to accommodate duplicates?
    fileprivate static func matches(_ simplePolygonArray1: [Polygon<CoordinateType>], _ simplePolygonArray2: [Polygon<CoordinateType>]) -> Bool {

        return matchesSubset(simplePolygonArray1, simplePolygonArray2) && simplePolygonArray1.count == simplePolygonArray2.count
    }

    /// Is the first simple polygon completely in the interior of the second simple polygon?
    fileprivate static func isInInterior(_ simplePolygon1: Polygon<CoordinateType>, _ simplePolygon2: Polygon<CoordinateType>) -> Bool {

        let relatedToPolygons = relatedTo(simplePolygon1, simplePolygon2)
        return relatedToPolygons.firstTouchesSecondInterior > .empty && relatedToPolygons.firstTouchesSecondBoundary == .empty && relatedToPolygons.firstTouchesSecondExterior == .empty
    }

    /// Is the first simple polygon completely in the interior of any the simple polygons in the simple polygon array?
    fileprivate static func isInInterior(_ simplePolygon1: Polygon<CoordinateType>, _ simplePolygonArray: [Polygon<CoordinateType>]) -> Bool {

        for simplePolygon2 in simplePolygonArray {
            let relatedToPolygons = relatedTo(simplePolygon1, simplePolygon2)
            if relatedToPolygons.firstTouchesSecondInterior > .empty && relatedToPolygons.firstTouchesSecondBoundary == .empty && relatedToPolygons.firstTouchesSecondExterior == .empty {
                return true
            }
        }

        return false
    }

    fileprivate static func relatedToAsPolygon(_ lineString: LineString<CoordinateType>, _ linearRing: LinearRing<CoordinateType>) -> RelatedTo {

        /// Convert a linear ring to a simple polygon
        let simplePolygon = Polygon<CoordinateType>(outerRing: linearRing, precision: FloatingPrecision(), coordinateSystem: Cartesian())

        return relatedTo(lineString, simplePolygon)
    }

    fileprivate static func relatedToAsPolygon(_ lineString1: LineString<CoordinateType>, _ lineString2: LineString<CoordinateType>) -> RelatedTo {

        /// Convert the second line string to a simple polygon
        var tempLineString = lineString2
        let firstCoord  = tempLineString[0]
        let lastCoord   = tempLineString[tempLineString.count - 1]
        if firstCoord != lastCoord {
            tempLineString.append(firstCoord)
        }

        let linearRing = LinearRing<CoordinateType>(elements: tempLineString, precision: FloatingPrecision(), coordinateSystem: Cartesian())
        let simplePolygon = Polygon<CoordinateType>(outerRing: linearRing, precision: FloatingPrecision(), coordinateSystem: Cartesian())

        return relatedTo(lineString1, simplePolygon)
    }

    fileprivate static func intersect(_ points1: MultiPoint<CoordinateType>, _ points2: MultiPoint<CoordinateType>) -> Bool {

        for tempPoint in points1 {
            if subset(tempPoint, points2) {
                return true
            }
        }
        return false
    }

    fileprivate static func generateIntersection(_ points: MultiPoint<CoordinateType>, _ lineString: LineString<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Point matches endpoint
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .one
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .boundary] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Define the MultiPoint geometry that might be returned
        var resultGeometry = MultiPoint<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        /// Check if any of the points equals either of the two endpoints of the line string.
        guard let lineStringBoundary = lineString.boundary() as? MultiPoint<CoordinateType> else {
            return (nil, disjoint)
        }

        var pointOnBoundary = false
        var pointOnInterior = false
        var pointOnExterior = false

        for point in points {
            if subset(point, lineStringBoundary) {
                pointOnBoundary = true
                resultGeometry.append(point)
            }
        }

        /// Check if any of the points is on any of the line segments in the line string.
        for point in points {
            /// Ignore points that intersect the boundary of the line string.
            /// These were just calculated.
            if subset(point, resultGeometry) {
                continue
            }

            /// Any intersection from here on is guaranteed to be in the interior.
            for firstCoordIndex in 0..<lineString.count - 1 {
                let firstCoord  = lineString[firstCoordIndex]
                let secondCoord = lineString[firstCoordIndex + 1]
                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                if pointIsOnLineSegment(point, segment: segment) == .onInterior {
                    pointOnInterior = true
                    resultGeometry.append(point)
                }
            }
        }

        /// Check if any of the points is not on the line string.
        for point in points {
            if !subset(point, lineString) {
                pointOnExterior = true
                break
            }
        }

        /// Complete the matrix as needed and return the geometry and matrix if an intersection exists
        if pointOnInterior {
            matrixIntersects[.interior, .interior] = .zero
        }

        if pointOnBoundary {
            matrixIntersects[.interior, .boundary] = .zero
        }

        if pointOnExterior {
            matrixIntersects[.interior, .exterior] = .zero
        }

        if !subset(lineStringBoundary, points) {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        if pointOnBoundary || pointOnInterior {
            return (resultGeometry, matrixIntersects)
        }

        /// No intersection
        return (nil, disjoint)
    }

    fileprivate static func generateIntersection(_ points: MultiPoint<CoordinateType>, _ linearRing: LinearRing<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Point matches endpoint
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .one
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .exterior] = .two

        /// Define the MultiPoint geometry that might be returned
        var resultGeometry = MultiPoint<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        /// Check for points on the interior or exterior of the linear ring.  There is no boundary.
        var pointOnInterior = false
        var pointOnExterior = false

        /// Check if any of the points is on any of the line segments in the linear ring.
        for point in points {
            /// Any intersection from here is guaranteed to be in the interior.
            for firstCoordIndex in 0..<linearRing.count - 1 {
                let firstCoord  = linearRing[firstCoordIndex]
                let secondCoord = linearRing[firstCoordIndex + 1]
                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                let location = pointIsOnLineSegment(point, segment: segment)
                if location == .onInterior || location == .onBoundary {
                    pointOnInterior = true
                    resultGeometry.append(point)
                }
            }
        }

        /// Check if any of the points is not on the linear ring.
        for point in points {
            if !subset(point, linearRing) {
                pointOnExterior = true
                break
            }
        }

        /// Complete the matrix as needed and return the geometry and matrix if an intersection exists
        if pointOnInterior {
            matrixIntersects[.interior, .interior] = .zero
        }

        if pointOnExterior {
            matrixIntersects[.interior, .exterior] = .zero
        }

        if pointOnInterior {
            return (resultGeometry, matrixIntersects)
        }

        /// No intersection
        return (nil, disjoint)
    }

    fileprivate static func generateIntersection(_ points: MultiPoint<CoordinateType>, _ multiLineString: MultiLineString<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Point matches endpoint
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .one
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .boundary] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Define the MultiPoint geometry that might be returned
        var resultGeometry = MultiPoint<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        /// Check if any of the points equals any of the endpoints of the multiline string.
        guard let multiLineStringBoundary = multiLineString.boundary() as? MultiPoint<CoordinateType> else {
            return (nil, disjoint)
        }

        var pointOnBoundary = false
        var pointOnInterior = false
        var pointOnExterior = false

        for point in points {
            if subset(point, multiLineStringBoundary) {
                pointOnBoundary = true
                resultGeometry.append(point)
            }
        }

        /// Check if any of the points is on any of the line segments in the multiline string.
        for point in points {
            /// Ignore points that intersect the boundary of the multiline string.
            /// These were just calculated.
            if subset(point, resultGeometry) {
                continue
            }

            /// Any intersection here is guaranteed to be in the interior.
            for lineString in multiLineString {
                for firstCoordIndex in 0..<lineString.count - 1 {
                    let firstCoord  = lineString[firstCoordIndex]
                    let secondCoord = lineString[firstCoordIndex + 1]
                    let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                    if pointIsOnLineSegment(point, segment: segment)  == .onInterior {
                        pointOnInterior = true
                        resultGeometry.append(point)
                    }
                }
            }
        }

        /// Check if any of the points is not on the multiline string.
        for point in points {
            if !subset(point, multiLineString) {
                pointOnExterior = true
                break
            }
        }

        /// Complete the matrix as needed and return the geometry and matrix if an intersection exists
        if pointOnInterior {
            matrixIntersects[.interior, .interior] = .zero
        }

        if pointOnBoundary {
            matrixIntersects[.interior, .boundary] = .zero
        }

        if pointOnExterior {
            matrixIntersects[.interior, .exterior] = .zero
        }

        if !subset(multiLineStringBoundary, points) {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        if pointOnBoundary || pointOnInterior {
            return (resultGeometry, matrixIntersects)
        }

        /// No intersection
        return (nil, disjoint)
    }

    ///
    /// Dimension .zero and dimension .two
    ///

    fileprivate static func intersectionMatrix(from relatedTo: RelatedTo) -> IntersectionMatrix {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()

        matrixIntersects[.interior, .interior] = relatedTo.firstInteriorTouchesSecondInterior
        matrixIntersects[.interior, .boundary] = relatedTo.firstInteriorTouchesSecondBoundary
        matrixIntersects[.interior, .exterior] = relatedTo.firstInteriorTouchesSecondExterior

        matrixIntersects[.boundary, .interior] = relatedTo.firstBoundaryTouchesSecondInterior
        matrixIntersects[.boundary, .boundary] = relatedTo.firstBoundaryTouchesSecondBoundary
        matrixIntersects[.boundary, .exterior] = relatedTo.firstBoundaryTouchesSecondExterior

        matrixIntersects[.exterior, .interior] = relatedTo.firstExteriorTouchesSecondInterior
        matrixIntersects[.exterior, .boundary] = relatedTo.firstExteriorTouchesSecondBoundary
        matrixIntersects[.exterior, .exterior] = relatedTo.firstExteriorTouchesSecondExterior

        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ point: Point<CoordinateType>, _ polygon: Polygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .two
        matrixIntersects[.exterior, .boundary] = .one
        matrixIntersects[.exterior, .exterior] = .two

        var points = MultiPoint<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())
        points.append(point)

        let tempRelatedToResult = relatedTo(points, polygon)

        if tempRelatedToResult.firstTouchesSecondInterior != .empty {
            matrixIntersects[.interior, .interior] = .zero
        } else if tempRelatedToResult.firstTouchesSecondBoundary != .empty {
            matrixIntersects[.interior, .boundary] = .zero
        } else if tempRelatedToResult.firstTouchesSecondExterior != .empty {
            matrixIntersects[.interior, .exterior] = .zero
        }

        /// No intersection
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ point: Point<CoordinateType>, _ multipolygon: MultiPolygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        let relatedToPointMP = relatedTo(point, multipolygon)

        let matrixIntersects = intersectionMatrix(from: relatedToPointMP)

        /// No intersection
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ points: MultiPoint<CoordinateType>, _ polygon: Polygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .two
        matrixIntersects[.exterior, .boundary] = .one
        matrixIntersects[.exterior, .exterior] = .two

        let tempRelatedToResult = relatedTo(points, polygon)

        if tempRelatedToResult.firstTouchesSecondInterior != .empty {
            matrixIntersects[.interior, .interior] = .zero
        }

        if tempRelatedToResult.firstTouchesSecondBoundary != .empty {
            matrixIntersects[.interior, .boundary] = .zero
        }

        if tempRelatedToResult.firstTouchesSecondExterior != .empty {
            matrixIntersects[.interior, .exterior] = .zero
        }

        /// No intersection
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ points: MultiPoint<CoordinateType>, _ multipolygon: MultiPolygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        let relatedToPointsMP = relatedTo(points, multipolygon)

        let matrixIntersects = intersectionMatrix(from: relatedToPointsMP)

        /// No intersection
        return (nil, matrixIntersects)
    }

    ///
    /// Dimension .one and dimesion .one
    ///

    struct LineSegmentIntersection {

        var firstSegmentFirstBoundaryLocation: LocationType     // The location of the first boundary point of the first segment relative to the second segment
        var firstSegmentSecondBoundaryLocation: LocationType    // The location of the second boundary point of the first segment relative to the second segment
        var secondSegmentFirstBoundaryLocation: LocationType    // The location of the first boundary point of the second segment relative to the first segment
        var secondSegmentSecondBoundaryLocation: LocationType   // The location of the second boundary point of the second segment relative to the first segment
        var interiorsTouchAtPoint: Bool

        var segmentsIntersect: Bool {
            return  firstSegmentFirstBoundaryLocation   != .onExterior ||
                    firstSegmentSecondBoundaryLocation  != .onExterior ||
                    secondSegmentFirstBoundaryLocation  != .onExterior ||
                    secondSegmentSecondBoundaryLocation != .onExterior ||
                    interiorsTouchAtPoint
        }

        var geometry: Geometry?

        init(sb11: LocationType = .onExterior, sb12: LocationType = .onExterior, sb21: LocationType = .onExterior, sb22: LocationType = .onExterior, interiors: Bool = false, theGeometry: Geometry? = nil) {
            firstSegmentFirstBoundaryLocation   = sb11          /// Position of first boundary point of first segment relative to the second segment
            firstSegmentSecondBoundaryLocation  = sb12          /// Position of second boundary point of first segment relative to the second segment
            secondSegmentFirstBoundaryLocation  = sb21          /// Position of first boundary point of second segment relative to the first segment
            secondSegmentSecondBoundaryLocation = sb22          /// Position of second boundary point of first segment relative to the first segment
            interiorsTouchAtPoint               = interiors
            geometry                            = theGeometry
        }
    }

    ///
    /// Check if the bounding boxes overlap for two line segments
    ///
    fileprivate static func boundingBoxesOverlap(segment: Segment<CoordinateType>, other: Segment<CoordinateType>) -> Bool {
        if  (segment.leftCoordinate.x >= other.leftCoordinate.x && segment.leftCoordinate.x <= other.rightCoordinate.x) ||
            (segment.leftCoordinate.x >= other.rightCoordinate.x && segment.leftCoordinate.x <= other.leftCoordinate.x) ||
            (segment.rightCoordinate.x >= other.leftCoordinate.x && segment.rightCoordinate.x <= other.rightCoordinate.x) ||
            (segment.rightCoordinate.x >= other.rightCoordinate.x && segment.rightCoordinate.x <= other.leftCoordinate.x) ||
            (segment.leftCoordinate.y >= other.leftCoordinate.y && segment.leftCoordinate.y <= other.rightCoordinate.y) ||
            (segment.leftCoordinate.y >= other.rightCoordinate.y && segment.leftCoordinate.y <= other.leftCoordinate.y) ||
            (segment.rightCoordinate.y >= other.leftCoordinate.y && segment.rightCoordinate.y <= other.rightCoordinate.y) ||
            (segment.rightCoordinate.y >= other.rightCoordinate.y && segment.rightCoordinate.y <= other.leftCoordinate.y) {
            return true
        }
        return false
    }

    ///
    /// 2x2 Determinant
    ///
    /// | a b |
    /// | c d |
    ///
    /// Returns a value of ad - bc
    ///
    fileprivate static func det2d(a: Double, b: Double, c: Double, d: Double) -> Double {
        return a*d - b*c
    }

    ///
    /// Returns a numeric value indicating where point p2 is relative to the line determined by p0 and p1.
    /// value > 0 implies p2 is on the left
    /// value = 0 implies p2 is on the line
    /// value < 0 implies p2 is to the right
    ///
    fileprivate static func isLeft(p0: CoordinateType, p1: CoordinateType, p2: CoordinateType) -> Double {
        return (p1.x - p0.x)*(p2.y - p0.y) - (p2.x - p0.x)*(p1.y -  p0.y)
    }

    fileprivate typealias SegmentType = SweepLineSegment<CoordinateType>

    fileprivate static func intersection(segment: Segment<CoordinateType>, other: Segment<CoordinateType>) -> LineSegmentIntersection {

        let precsion = FloatingPrecision()
        let csystem  = Cartesian()

        ///
        /// Check the bounding boxes.  They must overlap if there is an intersection.
        ///
        guard boundingBoxesOverlap(segment: segment, other: other) else {
            return LineSegmentIntersection()
        }

        ///
        /// Get location of endpoints
        ///
        let segment1Boundary1Location = coordinateIsOnLineSegment(segment.leftCoordinate, segment: other)
        let segment1Boundary2Location = coordinateIsOnLineSegment(segment.rightCoordinate, segment: other)
        let segment2Boundary1Location = coordinateIsOnLineSegment(other.leftCoordinate, segment: segment)
        let segment2Boundary2Location = coordinateIsOnLineSegment(other.rightCoordinate, segment: segment)

        ///
        /// Check cases where at least one boundary point of one segment touches the other line segment
        ///
        let leftSign  = isLeft(p0: segment.leftCoordinate, p1: segment.rightCoordinate, p2: other.leftCoordinate)
        let rightSign = isLeft(p0: segment.leftCoordinate, p1: segment.rightCoordinate, p2: other.rightCoordinate)
        let oneLine   = leftSign == 0 && rightSign == 0 /// Both line segments lie on one line
        if  (segment1Boundary1Location != .onExterior) ||  (segment1Boundary2Location != .onExterior) ||
            (segment2Boundary1Location != .onExterior) ||  (segment2Boundary2Location != .onExterior) {

            var lineSegmentIntersection = LineSegmentIntersection(sb11: segment1Boundary1Location, sb12: segment1Boundary2Location, sb21: segment2Boundary1Location, sb22: segment2Boundary2Location)

            if (segment1Boundary1Location != .onExterior) &&  (segment1Boundary2Location != .onExterior) {
                /// Segment is completely contained in other
                lineSegmentIntersection.geometry = LineString<CoordinateType>(elements: [segment.leftCoordinate, segment.rightCoordinate], precision: precsion, coordinateSystem: csystem)
            } else if (segment2Boundary1Location != .onExterior) &&  (segment2Boundary2Location != .onExterior) {
                /// Other is completely contained in segment
                lineSegmentIntersection.geometry = LineString<CoordinateType>(elements: [segment.leftCoordinate, segment.rightCoordinate], precision: precsion, coordinateSystem: csystem)
            } else if (segment1Boundary1Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) ||
                      (segment1Boundary1Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                lineSegmentIntersection.geometry = Point<CoordinateType>(coordinate: segment.leftCoordinate, precision: precsion, coordinateSystem: csystem)
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) ||
                      (segment1Boundary2Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                lineSegmentIntersection.geometry = Point<CoordinateType>(coordinate: segment.rightCoordinate, precision: precsion, coordinateSystem: csystem)
            } else if oneLine {
                /// If you reach here, the two line segments overlap by an amount > 0, but neither line segment is contained in the other.
                if (segment1Boundary1Location != .onExterior) &&  (segment2Boundary1Location != .onExterior) {
                    /// Line segments overlap from segment left to other left
                    lineSegmentIntersection.geometry = LineString<CoordinateType>(elements: [segment.leftCoordinate, other.leftCoordinate], precision: precsion, coordinateSystem: csystem)
                } else if (segment1Boundary1Location != .onExterior) &&  (segment2Boundary2Location != .onExterior) {
                    /// Line segments overlap from segment left to other right
                    lineSegmentIntersection.geometry = LineString<CoordinateType>(elements: [segment.leftCoordinate, other.rightCoordinate], precision: precsion, coordinateSystem: csystem)
                } else if (segment1Boundary2Location != .onExterior) &&  (segment2Boundary1Location != .onExterior) {
                    /// Line segments overlap from segment left to other left
                    lineSegmentIntersection.geometry = LineString<CoordinateType>(elements: [segment.rightCoordinate, other.leftCoordinate], precision: precsion, coordinateSystem: csystem)
                } else if (segment1Boundary2Location != .onExterior) &&  (segment2Boundary2Location != .onExterior) {
                    /// Line segments overlap from segment left to other right
                    lineSegmentIntersection.geometry = LineString<CoordinateType>(elements: [segment.rightCoordinate, other.rightCoordinate], precision: precsion, coordinateSystem: csystem)
                }
            } else {
                /// If you reach here, the two line segments touch at a single point that is on the boundary of one segment and the interior of the other.
                if segment1Boundary1Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point<CoordinateType>(coordinate: segment.leftCoordinate, precision: precsion, coordinateSystem: csystem)
                } else if segment1Boundary2Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point<CoordinateType>(coordinate: segment.rightCoordinate, precision: precsion, coordinateSystem: csystem)
                } else if segment2Boundary1Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point<CoordinateType>(coordinate: other.leftCoordinate, precision: precsion, coordinateSystem: csystem)
                } else if segment2Boundary2Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point<CoordinateType>(coordinate: other.rightCoordinate, precision: precsion, coordinateSystem: csystem)
                }
            }
            return lineSegmentIntersection
        }

        ///
        /// Check whether the two segments intersect at an interior point of each.
        /// Since the cases where the segments touch at a boundary point have all been handled, intersecting here is guaranteed to be in segments' interior.
        ///
        /// The two segments will intersect if and only if the signs of the isLeft function are non-zero and are different for both segments.
        /// This means one segment cannot be completely on one side of the other.
        ///
        /// TODO: We will need to separate out the = 0 cases below because these imply the segments fall on the same line.
        ///
        /// The line segments must intersect at a single point.  Calculate and return the point of intersection.
        ///
        let x1 = segment.leftCoordinate.x
        let y1 = segment.leftCoordinate.y
        let x2 = segment.rightCoordinate.x
        let y2 = segment.rightCoordinate.y
        let x3 = other.leftCoordinate.x
        let y3 = other.leftCoordinate.y
        let x4 = other.rightCoordinate.x
        let y4 = other.rightCoordinate.y

        let det1 = det2d(a: x1, b: y1, c: x2, d: y2)
        let det2 = det2d(a: x3, b: y3, c: x4, d: y4)
        let det3 = det2d(a: x1, b: 1, c: x2, d: 1)
        let det4 = det2d(a: x3, b: 1, c: x4, d: 1)
        let det5 = det2d(a: y1, b: 1, c: y2, d: 1)
        let det6 = det2d(a: y3, b: 1, c: y4, d: 1)

        let numx = det2d(a: det1, b: det3, c: det2, d: det4)
        let numy = det2d(a: det1, b: det5, c: det2, d: det6)
        let den  = det2d(a: det3, b: det5, c: det4, d: det6) // The denominator

        ///
        /// TODO: Add check for den = 0.
        /// The den is 0 when (x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4) = 0
        /// For now we will add guard statement to make sure the den is not zero.
        /// Note that if den is zero, it implies the two line segments are either parallel or
        /// fall on the same line and may or may not overlap.
        /// These cases must be addressed separately.
        ///
        guard den != 0 else {
            /// TODO: Might also have to check for near zero.
            return LineSegmentIntersection()
        }

        let x = numx / den
        let y = numy / den

        return LineSegmentIntersection(sb11: segment1Boundary1Location, sb12: segment1Boundary2Location, sb21: segment2Boundary1Location, sb22: segment2Boundary2Location, interiors: true, theGeometry: Point<CoordinateType>(coordinate: CoordinateType(array: [x, y]), precision: precsion, coordinateSystem: csystem))
    }

    fileprivate static func intersects(_ points1: MultiPoint<CoordinateType>, _ points2: MultiPoint<CoordinateType>) -> Bool {

        for tempPoint in points1 {
            if subset(tempPoint, points2) {
                return true
            }
        }
        return false
    }

    /// Calculate the slope as a tuple.
    /// The first value is the slope, if the line is not vertical.
    /// The second value is a boolean flag indicating whether the line is vertical.  If it is, the first value is irrelevant and will typically be zero.
    fileprivate static func slope(_ coordinate1: CoordinateType, _ coordinate2: CoordinateType) -> (Double, Bool) {

        /// Check for the vertical case
        guard coordinate1.x != coordinate2.x else {
            return (0, true)
        }

        /// Normal case
        return ((coordinate2.y - coordinate1.y) / (coordinate2.x - coordinate1.x), false)
    }

    fileprivate static func slope(_ segment: Segment<CoordinateType>) -> (Double, Bool) {

        return slope(segment.leftCoordinate, segment.rightCoordinate)
    }

    /// Reduces a line string to a sequence of points such that each consecutive line segment will have a different slope
    fileprivate static func reduce(_ lineString: LineString<CoordinateType>) -> LineString<CoordinateType> {

        /// Must have at least 3 points or two lines segments for this algorithm to apply
        guard lineString.count >= 3 else {
            return lineString
        }

        var firstSlope: (Double, Bool)      /// The second value, if true, indicates a vertical line
        var secondSlope: (Double, Bool)
        var newLineString = LineString<CoordinateType>()
        newLineString.append(lineString[0])
        for lsFirstCoordIndex in 0..<lineString.count - 2 {
            let lsFirstCoord  = lineString[lsFirstCoordIndex]
            let lsSecondCoord = lineString[lsFirstCoordIndex + 1]
            let lsThirdCoord  = lineString[lsFirstCoordIndex + 2]
            firstSlope = slope(lsFirstCoord, lsSecondCoord)
            secondSlope = slope(lsSecondCoord, lsThirdCoord)

            if firstSlope != secondSlope {
                newLineString.append(lineString[lsFirstCoordIndex + 1])
            }
        }

        /// Add the last coordinate
        newLineString.append(lineString[lineString.count - 1])

        return newLineString
    }

    /// Creates a new linear ring from an original linear ring that starts and ends at the second to last point of the original
    fileprivate static func moveStartBackOne(_ linearRing: LinearRing<CoordinateType>) -> LinearRing<CoordinateType> {

        var newLinearRing = LinearRing<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        guard linearRing.count >= 2 else {
            return linearRing
        }

        let lrFirstCoord  = linearRing[linearRing.count - 2]
        newLinearRing.append(lrFirstCoord)

        for lrCoordIndex in 0..<linearRing.count - 1 {
            let coord  = linearRing[lrCoordIndex]
            newLinearRing.append(coord)
        }

        return newLinearRing
    }

    /// Reduces a linear ring to a sequence of points such that each consecutive line segment will have a different slope
    fileprivate static func reduce(_ linearRing: LinearRing<CoordinateType>) -> LinearRing<CoordinateType> {

        /// Must have at least 3 points or two lines segments for this algorithm to apply.
        /// Could insist on 4 so you ignore the case where the segments overlap.
        guard linearRing.count >= 3 else {
            return linearRing
        }

        var firstSlope: (Double, Bool)      /// The second value, if true, indicates a vertical line
        var secondSlope: (Double, Bool)
        var newLinearRing = LinearRing<CoordinateType>()
        newLinearRing.append(linearRing[0])
        for lrFirstCoordIndex in 0..<linearRing.count - 2 {
            let lrFirstCoord  = linearRing[lrFirstCoordIndex]
            let lrSecondCoord = linearRing[lrFirstCoordIndex + 1]
            let lrThirdCoord  = linearRing[lrFirstCoordIndex + 2]
            firstSlope = slope(lrFirstCoord, lrSecondCoord)
            secondSlope = slope(lrSecondCoord, lrThirdCoord)

            if firstSlope != secondSlope {
                newLinearRing.append(linearRing[lrFirstCoordIndex + 1])
            }
        }

        /// Add the last coordinate, which should be the same as the first
        newLinearRing.append(linearRing[linearRing.count - 1])

        /// Now check whether the first and last segments of the new linear ring are on a straight line.
        /// If they are, change the first point of the linear ring to be the second to last point of the new linear ring.
        let lrFirstCoord  = newLinearRing[0]
        let lrSecondCoord = newLinearRing[1]
        let lrThirdCoord  = newLinearRing[newLinearRing.count - 2]
        let lrFourthCoord = newLinearRing[newLinearRing.count - 1]
        firstSlope = slope(lrFirstCoord, lrSecondCoord)
        secondSlope = slope(lrThirdCoord, lrFourthCoord)

        if firstSlope == secondSlope {
            newLinearRing = moveStartBackOne(newLinearRing)
        }

        return newLinearRing
    }

    /// Reduces a multi line string to a sequence of points on each line string such that each consecutive line segment will have a different slope.
    /// Note that for this first pass, we will handle each line string separately.
    /// TODO: Reduce connections between possibly connected line strings.
    fileprivate static func reduce(_ multiLineString: MultiLineString<CoordinateType>) -> MultiLineString<CoordinateType> {

        /// Define the MultiLineString geometry that might be returned
        var resultMultiLineString = MultiLineString<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        /// Reduce each of the multi line string
        for lineString in multiLineString {

            /// Must have at least 3 points or two lines segments for this algorithm to apply
            guard lineString.count >= 3 else {
                resultMultiLineString.append(lineString)
                continue
            }

            var firstSlope: (Double, Bool)      /// The second value, if true, indicates a vertical line
            var secondSlope: (Double, Bool)
            var newLineString = LineString<CoordinateType>()
            newLineString.append(lineString[0])
            for lsFirstCoordIndex in 0..<lineString.count - 2 {
                let lsFirstCoord  = lineString[lsFirstCoordIndex]
                let lsSecondCoord = lineString[lsFirstCoordIndex + 1]
                let lsThirdCoord  = lineString[lsFirstCoordIndex + 2]
                firstSlope = slope(lsFirstCoord, lsSecondCoord)
                secondSlope = slope(lsSecondCoord, lsThirdCoord)

                if firstSlope != secondSlope {
                    newLineString.append(lineString[lsFirstCoordIndex + 1])
                }
            }

            /// Add the last coordinate
            newLineString.append(lineString[lineString.count - 1])

            /// Add the new line string to the resulting multi line string
            resultMultiLineString.append(lineString)
        }

        return resultMultiLineString
    }

    /// Is segment1 contained in or a subset of segment2?
    fileprivate static func subset(_ segment1: Segment<CoordinateType>, _ segment2: Segment<CoordinateType>) -> Bool {

        /// If the slopes are not the same one segment being contained in another is not possible
        let slope1 = slope(segment1)
        let slope2 = slope(segment2)
        guard slope1 == slope2 else {
            return false
        }

        /// Slopes are the same.  Check if both coordinates of the first segment lie on the second
        let location1 = coordinateIsOnLineSegment(segment1.leftCoordinate, segment: segment2)
        let location2 = coordinateIsOnLineSegment(segment1.rightCoordinate, segment: segment2)
        if location1 != .onExterior && location2 != .onExterior {
            return true
        } else {
            return false
        }
    }

    /// Is line string 1 contained in or a subset of line string 2?
    /// The algorithm here assumes that both line strings have been reduced, so that no two consecutive segments have the same slope.
    fileprivate static func subset(_ lineString1: LineString<CoordinateType>, _ lineString2: LineString<CoordinateType>) -> Bool {

        for ls1FirstCoordIndex in 0..<lineString1.count - 1 {
            let ls1FirstCoord  = lineString1[ls1FirstCoordIndex]
            let ls1SecondCoord = lineString1[ls1FirstCoordIndex + 1]
            let segment1 = Segment<CoordinateType>(left: ls1FirstCoord, right: ls1SecondCoord)

            var segment1IsSubsetOfOtherSegment = false
            for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                let ls2FirstCoord  = lineString2[ls2FirstCoordIndex]
                let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1]
                let segment2 = Segment<CoordinateType>(left: ls2FirstCoord, right: ls2SecondCoord)

                if subset(segment1, segment2) {
                    segment1IsSubsetOfOtherSegment = true
                    break
                }
            }

            if !segment1IsSubsetOfOtherSegment {
                return false
            }
        }

        return true
    }

    /// Is the line string contained in or a subset of the linear ring?
    /// The algorithm here assumes that both line strings have been reduced, so that no two consecutive segments have the same slope.
    fileprivate static func subset(_ lineString: LineString<CoordinateType>, _ linearRing: LinearRing<CoordinateType>) -> Bool {

        for lsFirstCoordIndex in 0..<lineString.count - 1 {
            let lsFirstCoord  = lineString[lsFirstCoordIndex]
            let lsSecondCoord = lineString[lsFirstCoordIndex + 1]
            let segment1 = Segment<CoordinateType>(left: lsFirstCoord, right: lsSecondCoord)

            var segment1IsSubsetOfOtherSegment = false
            for lrFirstCoordIndex in 0..<linearRing.count - 1 {
                let lrFirstCoord  = linearRing[lrFirstCoordIndex]
                let lrSecondCoord = linearRing[lrFirstCoordIndex + 1]
                let segment2 = Segment<CoordinateType>(left: lrFirstCoord, right: lrSecondCoord)

                if subset(segment1, segment2) {
                    segment1IsSubsetOfOtherSegment = true
                    break
                }
            }

            if !segment1IsSubsetOfOtherSegment {
                return false
            }
        }

        return true
    }

    /// Is the first linear ring contained in or a subset of the second linear ring?
    /// The algorithm here assumes that both linear rings have been reduced, so that no two consecutive segments have the same slope.
    fileprivate static func subset(_ linearRing1: LinearRing<CoordinateType>, _ linearRing2: LinearRing<CoordinateType>) -> Bool {

        for lr1FirstCoordIndex in 0..<linearRing1.count - 1 {
            let lr1FirstCoord  = linearRing1[lr1FirstCoordIndex]
            let lr1SecondCoord = linearRing1[lr1FirstCoordIndex + 1]
            let segment1 = Segment<CoordinateType>(left: lr1FirstCoord, right: lr1SecondCoord)

            var segment1IsSubsetOfOtherSegment = false
            for lr2FirstCoordIndex in 0..<linearRing2.count - 1 {
                let lr2FirstCoord  = linearRing2[lr2FirstCoordIndex]
                let lr2SecondCoord = linearRing2[lr2FirstCoordIndex + 1]
                let segment2 = Segment<CoordinateType>(left: lr2FirstCoord, right: lr2SecondCoord)

                if subset(segment1, segment2) {
                    segment1IsSubsetOfOtherSegment = true
                    break
                }
            }

            if !segment1IsSubsetOfOtherSegment {
                return false
            }
        }

        return true
    }

    /// Is the line string contained in or a subset of the multi line string?
    /// The algorithm here assumes that both geometries have been reduced, so that no two consecutive segments have the same slope.
    /// TODO:
    fileprivate static func subset(_ lineString1: LineString<CoordinateType>, _ multiLineString: MultiLineString<CoordinateType>) -> Bool {

        for ls1FirstCoordIndex in 0..<lineString1.count - 1 {
            let ls1FirstCoord  = lineString1[ls1FirstCoordIndex]
            let ls1SecondCoord = lineString1[ls1FirstCoordIndex + 1]
            let segment1 = Segment<CoordinateType>(left: ls1FirstCoord, right: ls1SecondCoord)

            var segment1IsSubsetOfOtherSegment = false

            for lineString2 in multiLineString {
                for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                    let ls2FirstCoord  = lineString2[ls2FirstCoordIndex]
                    let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1]
                    let segment2 = Segment<CoordinateType>(left: ls2FirstCoord, right: ls2SecondCoord)

                    if subset(segment1, segment2) {
                        segment1IsSubsetOfOtherSegment = true
                        break
                    }
                }

                if segment1IsSubsetOfOtherSegment {
                    break
                }
            }

            if !segment1IsSubsetOfOtherSegment {
                return false
            }
        }

        return true
    }

    /// Is the linear ring contained in or a subset of the multi line string?
    /// The algorithm here assumes that both geometries have been reduced, so that no two consecutive segments have the same slope.
    /// TODO:
    fileprivate static func subset(_ linearRing: LinearRing<CoordinateType>, _ multiLineString: MultiLineString<CoordinateType>) -> Bool {

        for lrFirstCoordIndex in 0..<linearRing.count - 1 {
            let lrFirstCoord  = linearRing[lrFirstCoordIndex]
            let lrSecondCoord = linearRing[lrFirstCoordIndex + 1]
            let segment1 = Segment<CoordinateType>(left: lrFirstCoord, right: lrSecondCoord)

            var segment1IsSubsetOfOtherSegment = false

            for lineString in multiLineString {
                for lsFirstCoordIndex in 0..<lineString.count - 1 {
                    let lsFirstCoord  = lineString[lsFirstCoordIndex]
                    let lsSecondCoord = lineString[lsFirstCoordIndex + 1]
                    let segment2 = Segment<CoordinateType>(left: lsFirstCoord, right: lsSecondCoord)

                    if subset(segment1, segment2) {
                        segment1IsSubsetOfOtherSegment = true
                        break
                    }
                }

                if segment1IsSubsetOfOtherSegment {
                    break
                }
            }

            if !segment1IsSubsetOfOtherSegment {
                return false
            }
        }

        return true
    }

    /// Is the frist multi line string contained in or a subset of the second multi line string?
    /// The algorithm here assumes that both geometries have been reduced, so that no two consecutive segments have the same slope.
    /// TODO:
    fileprivate static func subset(_ multiLineString1: MultiLineString<CoordinateType>, _ multiLineString2: MultiLineString<CoordinateType>) -> Bool {

        for lineString1 in multiLineString1 {
            for ls1FirstCoordIndex in 0..<lineString1.count - 1 {
                let ls1FirstCoord  = lineString1[ls1FirstCoordIndex]
                let ls1SecondCoord = lineString1[ls1FirstCoordIndex + 1]
                let segment1 = Segment<CoordinateType>(left: ls1FirstCoord, right: ls1SecondCoord)

                var segment1IsSubsetOfOtherSegment = false

                for lineString2 in multiLineString2 {
                    for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                        let ls2FirstCoord  = lineString2[ls2FirstCoordIndex]
                        let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1]
                        let segment2 = Segment<CoordinateType>(left: ls2FirstCoord, right: ls2SecondCoord)

                        if subset(segment1, segment2) {
                            segment1IsSubsetOfOtherSegment = true
                            break
                        }
                    }

                    if segment1IsSubsetOfOtherSegment {
                        break
                    }
                }

                if !segment1IsSubsetOfOtherSegment {
                    return false
                }
            }
        }

        return true
    }

    fileprivate static func generateIntersection(_ lineString1: LineString<CoordinateType>, _ lineString2: LineString<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .one
        disjoint[.boundary, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .boundary] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Check if any of the endpoints of the first line string equals either of the two endpoints of the second line string.
        guard let lineStringBoundary1 = lineString1.boundary() as? MultiPoint<CoordinateType>,
              let lineStringBoundary2 = lineString2.boundary() as? MultiPoint<CoordinateType> else {
                return (nil, disjoint)
        }
        let geometriesIntersect = intersects(lineStringBoundary1, lineStringBoundary2)
        if geometriesIntersect {
            matrixIntersects[.boundary, .boundary] = .zero
        }

        ///
        /// Need to know the following:
        /// - Should the intersection function above return an IntersectionEvent or LineSegmentIntersection or?
        /// - Should there be a LineSegment object other than a SweepLineSegment, or should I just use points?
        /// - Should I be worrying about the geometries now?
        /// - Intersection of two geometries can return a geometry collection in general.  Do that or what?
        /// - Does "Set" work with sets of geometries, points, or other objects?
        ///

        /// Interior, interior
        for ls1FirstCoordIndex in 0..<lineString1.count - 1 {
            let ls1FirstCoord  = lineString1[ls1FirstCoordIndex]
            let ls1SecondCoord = lineString1[ls1FirstCoordIndex + 1]
            let segment1 = Segment<CoordinateType>(left: ls1FirstCoord, right: ls1SecondCoord)

            /// Any intersection from here on is guaranteed to be in the interior.
            for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                let ls2FirstCoord  = lineString2[ls2FirstCoordIndex]
                let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1]
                let segment2 = Segment<CoordinateType>(left: ls2FirstCoord, right: ls2SecondCoord)
                let lineSegmentIntersection = intersection(segment: segment1, other: segment2)

                /// Interior, interior
                if lineSegmentIntersection.geometry?.dimension == .one {
                    matrixIntersects[.interior, .interior] = .one
                } else if matrixIntersects[.interior, .interior] != .one && lineSegmentIntersection.interiorsTouchAtPoint {
                    matrixIntersects[.interior, .interior] = .zero
                }
            }
        }

        /// Interior, boundary
        let relatedB2Ls1 = relatedTo(lineStringBoundary2, lineString1)
        if relatedB2Ls1.firstTouchesSecondInterior != .empty {
            matrixIntersects[.interior, .boundary] = .zero
        }

        /// Interior, exterior
        let reducedLs1 = reduce(lineString1)
        let reducedLs2 = reduce(lineString2)
        if !subset(reducedLs1, reducedLs2) {
            matrixIntersects[.interior, .exterior] = .one
        }

        /// Boundary, interior
        let relatedB1Ls2 = relatedTo(lineStringBoundary1, lineString2)
        if relatedB1Ls2.firstTouchesSecondInterior != .empty {
            matrixIntersects[.boundary, .interior] = .zero
        }

        /// Boundary, boundary
        if relatedB1Ls2.firstTouchesSecondBoundary != .empty {
            matrixIntersects[.boundary, .boundary] = .zero
        }

        /// Boundary, exterior
        if relatedB1Ls2.firstTouchesSecondExterior != .empty {
            matrixIntersects[.boundary, .exterior] = .zero
        }

        /// Exterior, interior
        if !subset(reducedLs2, reducedLs1) {
            matrixIntersects[.exterior, .interior] = .one
        }

        /// Exterior, boundary
        if relatedB2Ls1.firstTouchesSecondExterior != .empty {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return (nil, matrixIntersects)
    }

    /// There is an assumption here that the line string is not a linear ring
    fileprivate static func generateIntersection(_ lineString: LineString<CoordinateType>, _ linearRing: LinearRing<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .one
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .one
        disjoint[.boundary, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .exterior] = .two

        /// Get the line string boundary
        guard let lineStringBoundary = lineString.boundary() as? MultiPoint<CoordinateType> else {
                return (nil, disjoint)
        }

        ///
        /// Need to know the following:
        /// - Should the intersection function above return an IntersectionEvent or LineSegmentIntersection or?
        /// - Does "Set" work with sets of geometries, points, or other objects?
        ///

        /// Interior, interior
        for ls1FirstCoordIndex in 0..<lineString.count - 1 {
            let ls1FirstCoord  = lineString[ls1FirstCoordIndex]
            let ls1SecondCoord = lineString[ls1FirstCoordIndex + 1]
            let segment1 = Segment<CoordinateType>(left: ls1FirstCoord, right: ls1SecondCoord)

            /// Any intersection from here on is guaranteed to be in the interior.
            for ls2FirstCoordIndex in 0..<linearRing.count - 1 {
                let ls2FirstCoord  = linearRing[ls2FirstCoordIndex]
                let ls2SecondCoord = linearRing[ls2FirstCoordIndex + 1]
                let segment2 = Segment<CoordinateType>(left: ls2FirstCoord, right: ls2SecondCoord)
                let lineSegmentIntersection = intersection(segment: segment1, other: segment2)

                /// Interior, interior
                if lineSegmentIntersection.geometry?.dimension == .one {
                    matrixIntersects[.interior, .interior] = .one
                } else if matrixIntersects[.interior, .interior] != .one && lineSegmentIntersection.interiorsTouchAtPoint {
                    matrixIntersects[.interior, .interior] = .zero
                }
            }
        }

        /// Note the linear ring has no boundary

        /// Interior, exterior
        let reducedLs = reduce(lineString)
        let reducedLr = reduce(linearRing)
        if !subset(reducedLs, reducedLr) {
            matrixIntersects[.interior, .exterior] = .one
        }

        /// Boundary, interior
        let relatedBlsLr = relatedTo(lineStringBoundary, linearRing)
        if relatedBlsLr.firstTouchesSecondInterior != .empty {
            matrixIntersects[.boundary, .interior] = .zero
        }

        /// Boundary, exterior
        if relatedBlsLr.firstTouchesSecondExterior != .empty {
            matrixIntersects[.boundary, .exterior] = .zero
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ lineString: LineString<CoordinateType>, _ multiLineString: MultiLineString<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .one
        disjoint[.boundary, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .boundary] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Check if any of the endpoints of the line string equals any of the endpoints of the multi line string.
        guard let lineStringBoundary = lineString.boundary() as? MultiPoint<CoordinateType>,
            let multiLineStringBoundary = multiLineString.boundary() as? MultiPoint<CoordinateType> else {
                return (nil, disjoint)
        }

        let geometriesIntersect = intersects(lineStringBoundary, multiLineStringBoundary)
        if geometriesIntersect {
            matrixIntersects[.boundary, .boundary] = .zero
        }

        ///
        /// Need to know the following:
        /// - Should the intersection function above return an IntersectionEvent or LineSegmentIntersection or?
        /// - Does "Set" work with sets of geometries, points, or other objects?
        ///

        /// Interior, interior
        for ls1FirstCoordIndex in 0..<lineString.count - 1 {
            let ls1FirstCoord  = lineString[ls1FirstCoordIndex]
            let ls1SecondCoord = lineString[ls1FirstCoordIndex + 1]
            let segment1 = Segment<CoordinateType>(left: ls1FirstCoord, right: ls1SecondCoord)

            /// Any intersection from here on is guaranteed to be in the interior.
            for lineString2 in multiLineString {
                for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                    let ls2FirstCoord  = lineString2[ls2FirstCoordIndex]
                    let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1]
                    let segment2 = Segment<CoordinateType>(left: ls2FirstCoord, right: ls2SecondCoord)
                    let lineSegmentIntersection = intersection(segment: segment1, other: segment2)

                    /// Interior, interior
                    if lineSegmentIntersection.geometry?.dimension == .one {
                        matrixIntersects[.interior, .interior] = .one
                    } else if matrixIntersects[.interior, .interior] != .one && lineSegmentIntersection.interiorsTouchAtPoint {
                        matrixIntersects[.interior, .interior] = .zero
                    }
                }
            }
        }

        /// Interior, boundary
        let relatedBmlsLs = relatedTo(multiLineStringBoundary, lineString)
        if relatedBmlsLs.firstTouchesSecondInterior != .empty {
            matrixIntersects[.interior, .boundary] = .zero
        }

        /// Interior, exterior
        let reducedLs  = reduce(lineString)
        let reducedMls = reduce(multiLineString)
        if !subset(reducedLs, reducedMls) {
            matrixIntersects[.interior, .exterior] = .one
        }

        /// Boundary, interior
        let relatedBlsMls = relatedTo(lineStringBoundary, multiLineString)
        if relatedBlsMls.firstTouchesSecondInterior != .empty {
            matrixIntersects[.boundary, .interior] = .zero
        }

        /// Boundary, boundary
        if relatedBlsMls.firstTouchesSecondBoundary != .empty {
            matrixIntersects[.boundary, .boundary] = .zero
        }

        /// Boundary, exterior
        if relatedBlsMls.firstTouchesSecondExterior != .empty {
            matrixIntersects[.boundary, .exterior] = .zero
        }

        /// Exterior, interior
        if !subset(reducedLs, reducedMls) {
            matrixIntersects[.exterior, .interior] = .one
        }

        /// Exterior, boundary
        if relatedBmlsLs.firstTouchesSecondExterior != .empty {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ linearRing1: LinearRing<CoordinateType>, _ linearRing2: LinearRing<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .one
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .exterior] = .two

        ///
        /// Need to know the following:
        /// - Should the intersection function above return an IntersectionEvent or LineSegmentIntersection or?
        /// - Does "Set" work with sets of geometries, points, or other objects?
        ///

        /// Interior, interior
        for lr1FirstCoordIndex in 0..<linearRing1.count - 1 {
            let lr1FirstCoord  = linearRing1[lr1FirstCoordIndex]
            let lr1SecondCoord = linearRing1[lr1FirstCoordIndex + 1]
            let segment1 = Segment<CoordinateType>(left: lr1FirstCoord, right: lr1SecondCoord)

            /// Note the linear rings have no boundary.
            /// Any intersection from here on is guaranteed to be in the interior.
            for lr2FirstCoordIndex in 0..<linearRing2.count - 1 {
                let lr2FirstCoord  = linearRing2[lr2FirstCoordIndex]
                let lr2SecondCoord = linearRing2[lr2FirstCoordIndex + 1]
                let segment2 = Segment<CoordinateType>(left: lr2FirstCoord, right: lr2SecondCoord)
                let lineSegmentIntersection = intersection(segment: segment1, other: segment2)

                /// Interior, interior
                if lineSegmentIntersection.geometry?.dimension == .one {
                    matrixIntersects[.interior, .interior] = .one
                } else if matrixIntersects[.interior, .interior] != .one && lineSegmentIntersection.interiorsTouchAtPoint {
                    matrixIntersects[.interior, .interior] = .zero
                }
            }
        }

        /// Interior, exterior
        let reducedLr1 = reduce(linearRing1)
        let reducedLr2 = reduce(linearRing2)
        if !subset(reducedLr1, reducedLr2) {
            matrixIntersects[.interior, .exterior] = .one
        }

        /// Exterior, interior
        if !subset(reducedLr2, reducedLr1) {
            matrixIntersects[.interior, .exterior] = .one
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ linearRing: LinearRing<CoordinateType>, _ multiLineString: MultiLineString<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .one
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .boundary] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Get the multi line string boundary
        guard let multiLineStringBoundary = multiLineString.boundary() as? MultiPoint<CoordinateType> else {
                return (nil, disjoint)
        }

        ///
        /// Need to know the following:
        /// - Should the intersection function above return an IntersectionEvent or LineSegmentIntersection or?
        /// - Does "Set" work with sets of geometries, points, or other objects?
        ///

        /// Interior, interior
        for lrFirstCoordIndex in 0..<linearRing.count - 1 {
            let lrFirstCoord  = linearRing[lrFirstCoordIndex]
            let lrSecondCoord = linearRing[lrFirstCoordIndex + 1]
            let segment1 = Segment<CoordinateType>(left: lrFirstCoord, right: lrSecondCoord)

            /// Any intersection from here on is guaranteed to be in the interior.
            for lineString in multiLineString {
                for lsFirstCoordIndex in 0..<lineString.count - 1 {
                    let lsFirstCoord  = lineString[lsFirstCoordIndex]
                    let lsSecondCoord = lineString[lsFirstCoordIndex + 1]
                    let segment2 = Segment<CoordinateType>(left: lsFirstCoord, right: lsSecondCoord)
                    let lineSegmentIntersection = intersection(segment: segment1, other: segment2)

                    /// Interior, interior
                    if lineSegmentIntersection.geometry?.dimension == .one {
                        matrixIntersects[.interior, .interior] = .one
                    } else if matrixIntersects[.interior, .interior] != .one && lineSegmentIntersection.interiorsTouchAtPoint {
                        matrixIntersects[.interior, .interior] = .zero
                    }
                }
            }
        }

        /// Interior, boundary
        let relatedBmlsLr = relatedTo(multiLineStringBoundary, linearRing)
        if relatedBmlsLr.firstTouchesSecondInterior != .empty {
            matrixIntersects[.interior, .boundary] = .zero
        }

        /// Interior, exterior
        let reducedLr  = reduce(linearRing)
        let reducedMls = reduce(multiLineString)
        if !subset(reducedLr, reducedMls) {
            matrixIntersects[.interior, .exterior] = .one
        }

        /// Exterior, interior
        if !subset(reducedLr, reducedMls) {
            matrixIntersects[.exterior, .interior] = .one
        }

        /// Exterior, boundary
        if relatedBmlsLr.firstTouchesSecondExterior != .empty {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ multiLineString1: MultiLineString<CoordinateType>, _ multiLineString2: MultiLineString<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .one
        disjoint[.boundary, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .boundary] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Check if any of the endpoints of the first multi line string equals any of the endpoints of the second multi line string.
        guard let multiLineStringBoundary1 = multiLineString1.boundary() as? MultiPoint<CoordinateType>,
            let multiLineStringBoundary2 = multiLineString2.boundary() as? MultiPoint<CoordinateType> else {
                return (nil, disjoint)
        }

        let geometriesIntersect = intersects(multiLineStringBoundary1, multiLineStringBoundary2)
        if geometriesIntersect {
            matrixIntersects[.boundary, .boundary] = .zero
        }

        ///
        /// Need to know the following:
        /// - Should the intersection function above return an IntersectionEvent or LineSegmentIntersection or?
        /// - Does "Set" work with sets of geometries, points, or other objects?
        ///

        /// Interior, interior
        for lineString1 in multiLineString1 {
            for ls1FirstCoordIndex in 0..<lineString1.count - 1 {
                let ls1FirstCoord  = lineString1[ls1FirstCoordIndex]
                let ls1SecondCoord = lineString1[ls1FirstCoordIndex + 1]
                let segment1 = Segment<CoordinateType>(left: ls1FirstCoord, right: ls1SecondCoord)

                /// Any intersection from here on is guaranteed to be in the interior.
                for lineString2 in multiLineString2 {
                    for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                        let ls2FirstCoord  = lineString2[ls2FirstCoordIndex]
                        let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1]
                        let segment2 = Segment<CoordinateType>(left: ls2FirstCoord, right: ls2SecondCoord)
                        let lineSegmentIntersection = intersection(segment: segment1, other: segment2)

                        /// Interior, interior
                        if lineSegmentIntersection.geometry?.dimension == .one {
                            matrixIntersects[.interior, .interior] = .one
                        } else if matrixIntersects[.interior, .interior] != .one && lineSegmentIntersection.interiorsTouchAtPoint {
                            matrixIntersects[.interior, .interior] = .zero
                        }
                    }
                }
            }
        }

        /// Interior, boundary
        let relatedBmls2MLs1 = relatedTo(multiLineStringBoundary2, multiLineString1)
        if relatedBmls2MLs1.firstTouchesSecondInterior != .empty {
            matrixIntersects[.interior, .boundary] = .zero
        }

        /// Interior, exterior
        let reducedMLs1 = reduce(multiLineString1)
        let reducedMls2 = reduce(multiLineString2)
        if !subset(reducedMLs1, reducedMls2) {
            matrixIntersects[.interior, .exterior] = .one
        }

        /// Boundary, interior
        let relatedBmls1Mls2 = relatedTo(multiLineStringBoundary1, multiLineString2)
        if relatedBmls1Mls2.firstTouchesSecondInterior != .empty {
            matrixIntersects[.boundary, .interior] = .zero
        }

        /// Boundary, boundary
        if relatedBmls1Mls2.firstTouchesSecondBoundary != .empty {
            matrixIntersects[.boundary, .boundary] = .zero
        }

        /// Boundary, exterior
        if relatedBmls1Mls2.firstTouchesSecondExterior != .empty {
            matrixIntersects[.boundary, .exterior] = .zero
        }

        /// Exterior, interior
        if !subset(reducedMLs1, reducedMls2) {
            matrixIntersects[.exterior, .interior] = .one
        }

        /// Exterior, boundary
        if relatedBmls2MLs1.firstTouchesSecondExterior != .empty {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return (nil, matrixIntersects)
    }

    ///
    /// Dimension .one and dimension .two
    ///

    /// The polygon here is a full polygon with holes
    fileprivate static func generateIntersection(_ lineString: LineString<CoordinateType>, _ polygon: Polygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .two
        matrixIntersects[.exterior, .boundary] = .one // This assumes the polygon boundary is not a subset of the input line string
        matrixIntersects[.exterior, .exterior] = .two

        /// Get the polygon boundary
        guard let polygonBoundary = polygon.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary.count > 0,
            let mainPolygon = polygonBoundary.first,
            mainPolygon.count > 0 else {
                return (nil, matrixIntersects)
        }

        /// Check whether the line string is completely contained in the polygon boundary
        let reducedLs  = reduce(lineString)
        let reducedPB = reduce(polygonBoundary)
        if subset(reducedLs, reducedPB) {
            matrixIntersects[.interior, .boundary] = .one
            matrixIntersects[.boundary, .boundary] = .zero
            return (nil, matrixIntersects)
        }

        /// From here on we know the line string is not completely contained in the polygon boundary

        /// Get the endpoints of the line string (the line string boundary).
        /// Assume for now that there are two boundary points.

        guard let lineStringBoundary = lineString.boundary() as? MultiPoint<CoordinateType> else {
            return (nil, matrixIntersects)
        }

        let lineStringBoundaryPoint1 = lineStringBoundary[0]
        let lineStringBoundaryPoint2 = lineStringBoundary[1]

        /// Must add an algorithm here to check whether a line segment is inside a polygon
        var lineStringInsideMainPolygon     = false /// Implies part of the line string lies inside the polygon

        var boundaryPoint1OutsidePolygon    = false
        var boundaryPoint2OutsidePolygon    = false

        var boundaryPoint1OnPolygonBoundary = false
        var boundaryPoint2OnPolygonBoundary = false

        /// Relate the line string to the main polygon and each of its holes
        var isMainPolygon = true
        for lineStringSimplePolygon in polygonBoundary {

            let tempPolygon = Polygon<CoordinateType>(outerRing: lineStringSimplePolygon, precision: FloatingPrecision(), coordinateSystem: Cartesian())

            let boundaryPoint1RelatedToResult   = relatedTo(lineStringBoundaryPoint1, tempPolygon)
            let boundaryPoint2RelatedToResult   = relatedTo(lineStringBoundaryPoint2, tempPolygon)
            let lineStringRelatedToResult       = relatedTo(lineString, tempPolygon)

            if isMainPolygon {

                if lineStringRelatedToResult.firstTouchesSecondInterior > .empty {
                    lineStringInsideMainPolygon = true
                }

                if lineStringRelatedToResult.firstInteriorTouchesSecondBoundary > .empty {
                    matrixIntersects[.interior, .boundary] = lineStringRelatedToResult.firstInteriorTouchesSecondBoundary
                }

                if lineStringRelatedToResult.firstTouchesSecondExterior == .one {
                    matrixIntersects[.interior, .exterior] = .one
                }

                if lineStringRelatedToResult.firstBoundaryTouchesSecondInterior > .empty {
                    matrixIntersects[.boundary, .interior] = lineStringRelatedToResult.firstBoundaryTouchesSecondInterior
                }

                if lineStringRelatedToResult.firstBoundaryTouchesSecondBoundary > .empty {
                    matrixIntersects[.boundary, .boundary] = lineStringRelatedToResult.firstBoundaryTouchesSecondBoundary
                }

                if boundaryPoint1RelatedToResult.firstTouchesSecondBoundary > .empty {
                    boundaryPoint1OnPolygonBoundary = true
                    matrixIntersects[.boundary, .boundary] = .zero
                }

                if boundaryPoint2RelatedToResult.firstTouchesSecondBoundary > .empty {
                    boundaryPoint2OnPolygonBoundary = true
                    matrixIntersects[.boundary, .boundary] = .zero
                }

                if boundaryPoint1RelatedToResult.firstTouchesSecondExterior > .empty {
                    boundaryPoint1OutsidePolygon = true
                    matrixIntersects[.boundary, .exterior] = .zero
                }

                if boundaryPoint2RelatedToResult.firstTouchesSecondExterior > .empty {
                    boundaryPoint2OutsidePolygon = true
                    matrixIntersects[.boundary, .exterior] = .zero
                }

                isMainPolygon = false

                /// If the line string does not touch the interior of the main polygon, we're done.
                if !lineStringInsideMainPolygon {
                    return (nil, matrixIntersects)
                }

            } else {

                /// We will only consider cases here where the line string is inside the main polygon.
                /// If the line string touches only the main polygon boundary or is outside the main polygon,
                /// those cases have already been addressed.

                if lineStringRelatedToResult.firstTouchesSecondExterior > matrixIntersects[.interior, .interior] {
                    matrixIntersects[.interior, .interior] = lineStringRelatedToResult.firstTouchesSecondExterior
                }

                if lineStringRelatedToResult.firstTouchesSecondBoundary > matrixIntersects[.interior, .boundary] {
                    matrixIntersects[.interior, .boundary] = lineStringRelatedToResult.firstTouchesSecondBoundary
                }

                if lineStringRelatedToResult.firstTouchesSecondInterior > matrixIntersects[.interior, .exterior] {
                    matrixIntersects[.interior, .exterior] = lineStringRelatedToResult.firstTouchesSecondInterior
                }

                if lineStringRelatedToResult.firstBoundaryTouchesSecondBoundary > .empty {
                    matrixIntersects[.boundary, .boundary] = lineStringRelatedToResult.firstBoundaryTouchesSecondBoundary
                }

                if boundaryPoint1RelatedToResult.firstTouchesSecondBoundary > .empty {
                    boundaryPoint1OnPolygonBoundary = true
                    matrixIntersects[.boundary, .boundary] = .zero
                }

                if boundaryPoint2RelatedToResult.firstTouchesSecondBoundary > .empty {
                    boundaryPoint2OnPolygonBoundary = true
                    matrixIntersects[.boundary, .boundary] = .zero
                }

                if boundaryPoint1RelatedToResult.firstTouchesSecondInterior > .empty {
                    boundaryPoint1OutsidePolygon = true
                    matrixIntersects[.boundary, .exterior] = .zero
                }

                if boundaryPoint2RelatedToResult.firstTouchesSecondInterior > .empty {
                    boundaryPoint2OutsidePolygon = true
                    matrixIntersects[.boundary, .exterior] = .zero
                }
            }
        }

        /// We have to check that each boundary point is either on the boundary or outside the polygon
        /// before we know about the value of the boundary, interior entry.
        if (!boundaryPoint1OnPolygonBoundary && !boundaryPoint1OutsidePolygon) || (!boundaryPoint2OnPolygonBoundary && !boundaryPoint2OutsidePolygon) {
            matrixIntersects[.boundary, .interior] = .zero
        }

        /// No intersection
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ lineString: LineString<CoordinateType>, _ multipolygon: MultiPolygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        var matrixIntersects = IntersectionMatrix()

        /// Loop over the polygons and update the matrixIntersects struct as needed on each pass.

        for polygon in multipolygon {

            /// Get the relationship between the point and the polygon
            let (_, intersectionMatrixResult) = generateIntersection(lineString, polygon)

            /// Update the intersection matrix as needed
            update(intersectionMatrixBase: &matrixIntersects, intersectionMatrixNew: intersectionMatrixResult)

        }

        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ linearRing: LinearRing<CoordinateType>, _ polygon: Polygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .two
        matrixIntersects[.exterior, .exterior] = .two

        /// Get the polygon boundary
        guard let polygonBoundary = polygon.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary.count > 0,
            let mainPolygon = polygonBoundary.first,
            mainPolygon.count > 0 else {
                return (nil, matrixIntersects)
        }

        /// Check whether the linear ring is completely contained in the polygon boundary.
        /// If not, the exterior of the linear ring must intersect with the polygon boundary.
        let reducedLr  = reduce(linearRing)
        let reducedPB = reduce(polygonBoundary)
        if subset(reducedLr, reducedPB) {
            matrixIntersects[.interior, .boundary] = .one
            return (nil, matrixIntersects)
        } else {
            matrixIntersects[.exterior, .boundary] = .one
        }

        /// From here on we know the linear ring is not completely contained in the polygon boundary

        var linearRingInsideMainPolygon     = false /// Implies part of the linear ring lies inside the polygon

        /// Relate the linear ring to the main polygon and each of its holes
        var isMainPolygon = true
        for lineStringSimplePolygon in polygonBoundary {

            let tempPolygon = Polygon<CoordinateType>(outerRing: lineStringSimplePolygon, precision: FloatingPrecision(), coordinateSystem: Cartesian())

            let linearRingRelatedToResult = relatedTo(linearRing, tempPolygon)

            if isMainPolygon {

                if linearRingRelatedToResult.firstTouchesSecondInterior > .empty {
                    linearRingInsideMainPolygon = true
                }

                if linearRingRelatedToResult.firstInteriorTouchesSecondBoundary > .empty {
                    matrixIntersects[.interior, .boundary] = linearRingRelatedToResult.firstInteriorTouchesSecondBoundary
                }

                if linearRingRelatedToResult.firstTouchesSecondExterior == .one {
                    matrixIntersects[.interior, .exterior] = .one
                }

                isMainPolygon = false

                /// If the linear ring does not touch the interior of the main polygon, we're done.
                if !linearRingInsideMainPolygon {
                    return (nil, matrixIntersects)
                }

            } else {

                /// We will only consider cases here where the linear ring is inside the main polygon.
                /// If the linear ring touches only the main polygon boundary or is outside the main polygon,
                /// those cases have already been addressed.

                if linearRingRelatedToResult.firstTouchesSecondExterior > matrixIntersects[.interior, .interior] {
                    matrixIntersects[.interior, .interior] = linearRingRelatedToResult.firstTouchesSecondExterior
                }

                if linearRingRelatedToResult.firstTouchesSecondBoundary > matrixIntersects[.interior, .boundary] {
                    matrixIntersects[.interior, .boundary] = linearRingRelatedToResult.firstTouchesSecondBoundary
                }

                if linearRingRelatedToResult.firstTouchesSecondInterior > matrixIntersects[.interior, .exterior] {
                    matrixIntersects[.interior, .exterior] = linearRingRelatedToResult.firstTouchesSecondInterior
                }
            }
        }

        /// No intersection
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ linearRing: LinearRing<CoordinateType>, _ multipolygon: MultiPolygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        var matrixIntersects = IntersectionMatrix()

        /// Loop over the polygons and update the matrixIntersects struct as needed on each pass.

        for polygon in multipolygon {

            /// Get the relationship between the point and the polygon
            let (_, intersectionMatrixResult) = generateIntersection(linearRing, polygon)

            /// Update the intersection matrix as needed
            update(intersectionMatrixBase: &matrixIntersects, intersectionMatrixNew: intersectionMatrixResult)

        }

        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ multiLineString: MultiLineString<CoordinateType>, _ polygon: Polygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .two
        matrixIntersects[.exterior, .exterior] = .two

        /// Get the polygon boundary
        guard let polygonBoundary = polygon.boundary() as? MultiLineString<CoordinateType>,
            polygonBoundary.count > 0,
            let mainPolygon = polygonBoundary.first,
            mainPolygon.count > 0 else {
                return (nil, matrixIntersects)
        }

        /// Check whether the multi line string is completely contained in the polygon boundary
        let reducedMls  = reduce(multiLineString)
        let reducedPB = reduce(polygonBoundary)
        if subset(reducedMls, reducedPB) {
            matrixIntersects[.interior, .boundary] = .one
            matrixIntersects[.boundary, .boundary] = .zero
            return (nil, matrixIntersects)
        }

        /// Check whether the polygon boundary is completely contained in the multi line string.
        /// If it is, this guarantees matrixIntersects[.exterior, .boundary] = .empty
        matrixIntersects[.exterior, .boundary] = .one
        if subset(reducedPB, reducedMls) {
            matrixIntersects[.exterior, .boundary] = .empty
        }

        /// From here on we know the multi line string is not completely contained in the polygon boundary,
        /// and we know whether the polygon boundary is completely contained in the multi line string.

        /// Get the endpoints of the multi line string (the multi line string boundary) and their relationship to the polygon.
        /// Set some intersection matrix values depending on the result.

        guard let multiLineStringBoundary = multiLineString.boundary() as? MultiPoint<CoordinateType> else {
            return (nil, matrixIntersects)
        }

        let boundaryPointsRelatedToResult = relatedToGeneral(multiLineStringBoundary, polygon)

        if boundaryPointsRelatedToResult.firstBoundaryTouchesSecondInterior > .empty {
            matrixIntersects[.boundary, .interior] = boundaryPointsRelatedToResult.firstBoundaryTouchesSecondInterior
        }

        if boundaryPointsRelatedToResult.firstBoundaryTouchesSecondBoundary > .empty {
            matrixIntersects[.boundary, .boundary] = boundaryPointsRelatedToResult.firstBoundaryTouchesSecondBoundary
        }

        if boundaryPointsRelatedToResult.firstTouchesSecondExterior > .empty {
            matrixIntersects[.boundary, .exterior] = boundaryPointsRelatedToResult.firstTouchesSecondExterior
        }

        var multiLineStringInsideMainPolygon    = false /// Implies part of the multi line string lies inside the polygon

        /// Relate the multi line string to the main polygon and each of its holes
        var isMainPolygon = true
        var multiLineStringCompletelyContainedInHole = false
        for lineStringSimplePolygon in polygonBoundary {

            let tempPolygon = Polygon<CoordinateType>(outerRing: lineStringSimplePolygon, precision: FloatingPrecision(), coordinateSystem: Cartesian())

            let multiLineStringRelatedToResult = relatedTo(multiLineString, tempPolygon)

            if isMainPolygon {

                if multiLineStringRelatedToResult.firstTouchesSecondInterior > .empty {
                    multiLineStringInsideMainPolygon = true
                }

                if multiLineStringRelatedToResult.firstInteriorTouchesSecondBoundary > .empty {
                    matrixIntersects[.interior, .boundary] = multiLineStringRelatedToResult.firstInteriorTouchesSecondBoundary
                }

                if multiLineStringRelatedToResult.firstTouchesSecondExterior == .one {
                    matrixIntersects[.interior, .exterior] = .one
                }

                isMainPolygon = false

                /// If the multi line string does not touch the interior of the main polygon, we're done.
                if !multiLineStringInsideMainPolygon {
                    return (nil, matrixIntersects)
                }

            } else {

                /// We will only consider cases here where the multi line string is inside the main polygon
                /// and not completely contained in the polygon boundary.
                /// If the multi line string touches only the polygon boundary or is outside the main polygon,
                /// those cases have already been addressed.

                if multiLineStringRelatedToResult.firstInteriorTouchesSecondBoundary > matrixIntersects[.interior, .boundary] {
                    matrixIntersects[.interior, .boundary] = multiLineStringRelatedToResult.firstInteriorTouchesSecondBoundary
                }

                if multiLineStringRelatedToResult.firstTouchesSecondInterior > matrixIntersects[.interior, .exterior] {
                    matrixIntersects[.interior, .exterior] = multiLineStringRelatedToResult.firstTouchesSecondInterior
                }

                if multiLineStringRelatedToResult.firstTouchesSecondExterior == .empty {
                    multiLineStringCompletelyContainedInHole = true
                }
            }
        }

        /// We have to check whether the multi line string is completely contained in the main polygon and in a hole
        /// in order to set the interior, interior entry.
        if multiLineStringInsideMainPolygon {
            matrixIntersects[.interior, .interior] = .one
            if multiLineStringCompletelyContainedInHole {
                matrixIntersects[.interior, .interior] = .empty
            }
        }

        /// No intersection
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ multiLineString: MultiLineString<CoordinateType>, _ multipolygon: MultiPolygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        var matrixIntersects = IntersectionMatrix()

        /// Loop over the polygons and update the matrixIntersects struct as needed on each pass.

        for polygon in multipolygon {

            /// Get the relationship between the point and the polygon
            let (_, intersectionMatrixResult) = generateIntersection(multiLineString, polygon)

            /// Update the intersection matrix as needed
            update(intersectionMatrixBase: &matrixIntersects, intersectionMatrixNew: intersectionMatrixResult)

        }

        return (nil, matrixIntersects)
    }

    ///
    /// Dimension .two and dimension .two
    ///

    fileprivate static func generateIntersection(_ polygon1: Polygon<CoordinateType>, _ polygon2: Polygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()

        let relatedTo = relatedToFull(polygon1, polygon2)

        matrixIntersects[.interior, .interior] = relatedTo.firstInteriorTouchesSecondInterior
        matrixIntersects[.interior, .boundary] = relatedTo.firstInteriorTouchesSecondBoundary
        matrixIntersects[.interior, .exterior] = relatedTo.firstInteriorTouchesSecondExterior

        matrixIntersects[.boundary, .interior] = relatedTo.firstBoundaryTouchesSecondInterior
        matrixIntersects[.boundary, .boundary] = relatedTo.firstBoundaryTouchesSecondBoundary
        matrixIntersects[.boundary, .exterior] = relatedTo.firstBoundaryTouchesSecondExterior

        matrixIntersects[.exterior, .interior] = relatedTo.firstExteriorTouchesSecondInterior
        matrixIntersects[.exterior, .boundary] = relatedTo.firstExteriorTouchesSecondBoundary
        matrixIntersects[.exterior, .exterior] = relatedTo.firstExteriorTouchesSecondExterior

        /// No intersection
        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ polygon: Polygon<CoordinateType>, _ multipolygon: MultiPolygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        var matrixIntersects = IntersectionMatrix()

        /// Loop over the polygons and update the matrixIntersects struct as needed on each pass.

        for polygonFromMP in multipolygon {

            /// Get the relationship between the point and the polygon
            let (_, intersectionMatrixResult) = generateIntersection(polygon, polygonFromMP)

            /// Update the intersection matrix as needed
            update(intersectionMatrixBase: &matrixIntersects, intersectionMatrixNew: intersectionMatrixResult)

        }

        return (nil, matrixIntersects)
    }

    fileprivate static func generateIntersection(_ multipolygon1: MultiPolygon<CoordinateType>, _ multipolygon2: MultiPolygon<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        var matrixIntersects = IntersectionMatrix()

        /// Loop over the polygons and update the matrixIntersects struct as needed on each pass.

        for polygonFromMP in multipolygon1 {

            /// Get the relationship between the point and the polygon
            let (_, intersectionMatrixResult) = generateIntersection(polygonFromMP, multipolygon2)

            /// Update the intersection matrix as needed
            update(intersectionMatrixBase: &matrixIntersects, intersectionMatrixNew: intersectionMatrixResult)

        }

        return (nil, matrixIntersects)
    }

    ///
    /// - returns: An Array of `LinearRing`s representing the outerRings of this MultiPolygon
    ///
    /// - see also: `LinearRing`
    ///
    fileprivate static func outerRings(multipolygon: MultiPolygon<CoordinateType>) -> [LinearRing<CoordinateType>] {
        if multipolygon.buffer.header.count > 1 {
            return multipolygon.buffer.withUnsafeMutablePointers { header, elements in
                var rings = [LinearRing<CoordinateType>]()

                for i in stride(from: 1, to: header.pointee.count, by: 1) {
                    rings.append(elements[i].outerRing)
                }
                return rings
            }
        }
        return []
    }

    ///
    /// - returns: An Array of `LinearRing`s representing the innerRings of this MultiPolygon
    ///
    /// - see also: `LinearRing`
    ///
    fileprivate static func innerRings(multipolygon: MultiPolygon<CoordinateType>) -> [[LinearRing<CoordinateType>]] {
        if multipolygon.buffer.header.count > 1 {
            return multipolygon.buffer.withUnsafeMutablePointers { header, elements in
                var rings = [[LinearRing<CoordinateType>]]()

                for i in stride(from: 1, to: header.pointee.count, by: 1) {
                    rings.append(elements[i].innerRings)
                }
                return rings
            }
        }
        return []
    }
}
