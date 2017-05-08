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

/// Describes the relationship between the first and second geometries
struct RelatedTo {

    var firstTouchesSecondBoundary: Bool = false
    var firstTouchesSecondInterior: Bool = false
    var firstTouchesSecondExterior: Bool = false
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

    ///
    /// Dimension .zero and dimesion .zero
    ///

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

    fileprivate static func generateIntersection(_ point: Point<CoordinateType>, _ points: MultiPoint<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Identical
        var identical = IntersectionMatrix()
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
        disjoint[.exterior, .exterior] = .two

        /// Check if the point equals either of the two endpoints of the line string.
        let firstPoint = lineString.first as? Point<CoordinateType>
        let lastPoint  = lineString[lineString.count - 1] as? Point<CoordinateType>

        if point == firstPoint || point == lastPoint {
            return (point, matchesEndPoint)
        }

        /// Check if the point is on any of the line segments in the line string.
        for firstCoordIndex in 0..<lineString.count - 1 {
            guard let firstCoord  = lineString[firstCoordIndex] as? CoordinateType,
                let secondCoord = lineString[firstCoordIndex + 1] as? CoordinateType else {
                    /// No intersection
                    return (nil, disjoint)
            }

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
            guard let firstCoord  = linearRing[firstCoordIndex] as? CoordinateType,
                let secondCoord = linearRing[firstCoordIndex + 1] as? CoordinateType else {
                    /// No intersection
                    return (nil, disjoint)
            }

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
        disjoint[.exterior, .exterior] = .two

        /// Check if the point equals any of the endpoints of any line string.
        for lineString in multiLineString {
            let firstPoint = lineString.first as? Point<CoordinateType>
            let lastPoint  = lineString[lineString.count - 1] as? Point<CoordinateType>

            if point == firstPoint || point == lastPoint {
                return (point, matchesEndPoint)
            }
        }

        /// Check if the point is on any of the line segments in any of the line strings.
        for lineString in multiLineString {
            for firstCoordIndex in 0..<lineString.count - 1 {
                guard let firstCoord  = lineString[firstCoordIndex] as? CoordinateType,
                    let secondCoord = lineString[firstCoordIndex + 1] as? CoordinateType else {
                        /// No intersection
                        return (nil, disjoint)
                }

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

    fileprivate static func relatedTo(_ points: MultiPoint<CoordinateType>, _ lineString: LineString<CoordinateType>) -> RelatedTo {

        var relatedTo = RelatedTo()

        guard let lineStringBoundary = lineString.boundary() as? MultiPoint<CoordinateType> else {
                return relatedTo
        }

        for tempPoint in points {

            if subset(tempPoint, lineStringBoundary) {
                relatedTo.firstTouchesSecondBoundary = true
                continue
            }

            /// If this point is reached, a point that touches the boundary of the line string has been removed
            for firstCoordIndex in 0..<lineString.count - 1 {
                guard let firstCoord  = lineString[firstCoordIndex] as? CoordinateType,
                      let secondCoord = lineString[firstCoordIndex + 1] as? CoordinateType else {
                        /// One of the two points on the line string is invalid.  Return the default relationship.
                        return relatedTo
                }

                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                let location = pointIsOnLineSegment(tempPoint, segment: segment)
                if location == .onInterior {
                    relatedTo.firstTouchesSecondInterior = true
                } else if location == .onBoundary {
                    /// Touching the boundary of any line segment is necessarily on the interior
                    relatedTo.firstTouchesSecondInterior = true
                } else {
                    relatedTo.firstTouchesSecondExterior = true
                }
            }
        }
        return relatedTo
    }

    fileprivate static func relatedTo(_ points: MultiPoint<CoordinateType>, _ linearRing: LinearRing<CoordinateType>) -> RelatedTo {

        var relatedTo = RelatedTo()
        for tempPoint in points {
            for firstCoordIndex in 0..<linearRing.count - 1 {
                guard let firstCoord  = linearRing[firstCoordIndex] as? CoordinateType,
                    let secondCoord = linearRing[firstCoordIndex + 1] as? CoordinateType else {
                        /// One of the two points on the line string is invalid.  Return the default relationship.
                        return relatedTo
                }

                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                let location = pointIsOnLineSegment(tempPoint, segment: segment)
                if location == .onInterior {
                    relatedTo.firstTouchesSecondInterior = true
                } else if location == .onBoundary {
                     /// The boundary of any line segment on the linear ring is necessarily on the interior of the linear ring
                    relatedTo.firstTouchesSecondInterior = true
                } else {
                    relatedTo.firstTouchesSecondExterior = true
                }
            }
        }
        return relatedTo
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
        disjoint[.exterior, .exterior] = .two

        /// Define the MultiPoint geometry that might be returned
        var resultGeometry = MultiPoint<Coordinate2D>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        /// Check if any of the points equals either of the two endpoints of the line string.
        var lineStringBoundary = MultiPoint<Coordinate2D>(precision: FloatingPrecision(), coordinateSystem: Cartesian())
        guard let firstPoint = lineString.first as? Point<CoordinateType>,
            let lastPoint  = lineString.first as? Point<CoordinateType> else {
                /// One of the two boundary points on the line string is invalid.  No intersection.
                return (nil, disjoint)
        }
        lineStringBoundary.append(firstPoint)
        lineStringBoundary.append(lastPoint)

        var pointOnBoundary = false
        var pointOnInterior = false
        var pointOnExterior = false

        for point in points {
            if point == firstPoint || point == lastPoint {
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
                guard let firstCoord  = lineString[firstCoordIndex] as? CoordinateType,
                    let secondCoord = lineString[firstCoordIndex + 1] as? CoordinateType else {
                        /// One of the two points on the line string is invalid.  No intersection.
                        return (nil, disjoint)
                }

                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                if pointIsOnLineSegment(point, segment: segment) == .onInterior {
                    pointOnInterior = true
                    resultGeometry.append(point)
                }
            }
        }

        /// Check if any of the points is not on the line string.
        for point in points {
            if !subset(point, resultGeometry) {
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
        var resultGeometry = MultiPoint<Coordinate2D>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        /// Check for points on the interior or exterior of the linear ring.  There is no boundary.
        var pointOnInterior = false
        var pointOnExterior = false

        /// Check if any of the points is on any of the line segments in the linear ring.
        for point in points {
            /// Any intersection from here is guaranteed to be in the interior.
            for firstCoordIndex in 0..<linearRing.count - 1 {
                guard let firstCoord  = linearRing[firstCoordIndex] as? CoordinateType,
                    let secondCoord = linearRing[firstCoordIndex + 1] as? CoordinateType else {
                        /// One of the two points on the line string is invalid.  No intersection.
                        return (nil, disjoint)
                }

                let segment = Segment<CoordinateType>(left: firstCoord, right: secondCoord)
                if pointIsOnLineSegment(point, segment: segment) == .onInterior {
                    pointOnInterior = true
                    resultGeometry.append(point)
                }
            }
        }

        /// Check if any of the points is not on the linear ring.
        for point in points {
            if !subset(point, resultGeometry) {
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
        disjoint[.exterior, .exterior] = .two

        /// Define the MultiPoint geometry that might be returned
        var resultGeometry = MultiPoint<Coordinate2D>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

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
                    guard let firstCoord  = lineString[firstCoordIndex] as? CoordinateType,
                          let secondCoord = lineString[firstCoordIndex + 1] as? CoordinateType else {
                            /// One of the two points on the line string is invalid.  No intersection.
                            return (nil, disjoint)
                    }

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
            if !subset(point, resultGeometry) {
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
    /// Dimension .one and dimesion .one
    ///

///    The IM for the two disjoint geometries of dimension .one is
///    (1) FF1FF0102, if both geometries are not LinearRings, or
///    (2) FF1FFF102, if the first geometry is a LinearRing,
///    (3) FF1FF01F2, if the second geometry is a LinearRing, or
///    (4) FF1FFF1F2, if both geometries are LinearRings.

    struct LineSegmentIntersection {

        var firstSegmentfirstBoundaryLocation: LocationType     // The location of the first boundary point of the first segment relative to the second segment
        var firstSegmentSecondBoundaryLocation: LocationType    // The location of the second boundary point of the first segment relative to the second segment
        var secondSegmentfirstBoundaryLocation: LocationType    // The location of the first boundary point of the second segment relative to the first segment
        var secondSegmentSecondBoundaryLocation: LocationType   // The location of the second boundary point of the second segment relative to the first segment
        var interiorsTouchAtPoint: Bool

        var segmentsIntersect: Bool {
            return  firstSegmentfirstBoundaryLocation   != .onExterior ||
                    firstSegmentSecondBoundaryLocation  != .onExterior ||
                    secondSegmentfirstBoundaryLocation  != .onExterior ||
                    secondSegmentSecondBoundaryLocation != .onExterior ||
                    interiorsTouchAtPoint
        }

        var geometry: Geometry?

        init(sb11: LocationType = .onExterior, sb12: LocationType = .onExterior, sb21: LocationType = .onExterior, sb22: LocationType = .onExterior, interiors: Bool = false, theGeometry: Geometry? = nil) {
            firstSegmentfirstBoundaryLocation   = sb11          /// Position of first boundary point of first segment relative to the second segment
            firstSegmentSecondBoundaryLocation  = sb12          /// Position of second boundary point of first segment relative to the second segment
            secondSegmentfirstBoundaryLocation  = sb21          /// Position of first boundary point of second segment relative to the first segment
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
        var segment1Boundary1Location = coordinateIsOnLineSegment(segment.leftCoordinate, segment: other)
        var segment1Boundary2Location = coordinateIsOnLineSegment(segment.rightCoordinate, segment: other)
        var segment2Boundary1Location = coordinateIsOnLineSegment(other.leftCoordinate, segment: segment)
        var segment2Boundary2Location = coordinateIsOnLineSegment(other.rightCoordinate, segment: segment)

        ///
        /// Check cases where at least one boundary point of one segment touches the other line segment
        ///
        var leftSign  = isLeft(p0: segment.leftCoordinate, p1: segment.rightCoordinate, p2: other.leftCoordinate)
        var rightSign = isLeft(p0: segment.leftCoordinate, p1: segment.rightCoordinate, p2: other.rightCoordinate)
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

        return LineSegmentIntersection(sb11: segment1Boundary1Location, sb12: segment1Boundary2Location, sb21: segment2Boundary1Location, sb22: segment2Boundary2Location, interiors: true, theGeometry: Point<CoordinateType>(coordinate: try CoordinateType(array: [x, y]), precision: precsion, coordinateSystem: csystem))
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
            guard let lsFirstCoord  = lineString[lsFirstCoordIndex] as? CoordinateType,
                  let lsSecondCoord = lineString[lsFirstCoordIndex + 1] as? CoordinateType,
                  let lsThirdCoord  = lineString[lsFirstCoordIndex + 2] as? CoordinateType else {
                    /// One of the three points on the line string is invalid.  No reduction.
                    return lineString
            }

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

    fileprivate static func moveStartBackOne(_ linearRing: LinearRing<CoordinateType>) -> LinearRing<CoordinateType> {

        var newLinearRing = LinearRing<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        guard let lrFirstCoord  = linearRing[linearRing.count - 2] as? CoordinateType else {
            /// Point not valid
            return linearRing
        }
        newLinearRing.append(lrFirstCoord)

        for lrCoordIndex in 0..<linearRing.count - 1 {
            guard let coord  = linearRing[lrCoordIndex] as? CoordinateType else {
                    /// One of the points on the linear ring is invalid.  No update.
                    return linearRing
            }

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
            guard let lrFirstCoord  = linearRing[lrFirstCoordIndex] as? CoordinateType,
                let lrSecondCoord = linearRing[lrFirstCoordIndex + 1] as? CoordinateType,
                let lrThirdCoord  = linearRing[lrFirstCoordIndex + 2] as? CoordinateType else {
                    /// One of the three points on the linear ring is invalid.  No reduction.
                    return linearRing
            }

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
        guard let lrFirstCoord  = newLinearRing[0] as? CoordinateType,
            let lrSecondCoord = newLinearRing[1] as? CoordinateType,
            let lrThirdCoord  = newLinearRing[newLinearRing.count - 2] as? CoordinateType,
            let lrFourthCoord = newLinearRing[newLinearRing.count - 1] as? CoordinateType else {
                return linearRing
        }

        firstSlope = slope(lrFirstCoord, lrSecondCoord)
        secondSlope = slope(lrThirdCoord, lrFourthCoord)

        if firstSlope == secondSlope {
            newLinearRing = moveStartBackOne(newLinearRing)
        }

        return newLinearRing
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
            guard let ls1FirstCoord  = lineString1[ls1FirstCoordIndex] as? CoordinateType,
                  let ls1SecondCoord = lineString1[ls1FirstCoordIndex + 1] as? CoordinateType else {
                    /// One of the two points on the line string is invalid.  No subset.
                    return false
            }

            let segment1 = Segment<CoordinateType>(left: ls1FirstCoord, right: ls1SecondCoord)

            var segment1IsSubsetOfOtherSegment = false
            for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                guard let ls2FirstCoord  = lineString2[ls2FirstCoordIndex] as? CoordinateType,
                      let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1] as? CoordinateType else {
                        /// One of the two points on the line string is invalid.  No subset.
                        return false
                }

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
            guard let lsFirstCoord  = lineString[lsFirstCoordIndex] as? CoordinateType,
                let lsSecondCoord = lineString[lsFirstCoordIndex + 1] as? CoordinateType else {
                    /// One of the two points on the line string is invalid.  No subset.
                    return false
            }

            let segment1 = Segment<CoordinateType>(left: lsFirstCoord, right: lsSecondCoord)

            var segment1IsSubsetOfOtherSegment = false
            for lrFirstCoordIndex in 0..<linearRing.count - 1 {
                guard let lrFirstCoord  = linearRing[lrFirstCoordIndex] as? CoordinateType,
                    let lrSecondCoord = linearRing[lrFirstCoordIndex + 1] as? CoordinateType else {
                        /// One of the two points on the line ring is invalid.  No subset.
                        return false
                }

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

    fileprivate static func generateIntersection(_ lineString1: LineString<CoordinateType>, _ lineString2: LineString<CoordinateType>) -> (Geometry?, IntersectionMatrix) {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .one
        disjoint[.boundary, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .interior] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Define the MultiPoint geometry that might be returned
        var resultGeometryMultiPoint = MultiPoint<Coordinate2D>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        /// Define the LineString geometry that might be returned
        var resultGeometryLineString = LineString<Coordinate2D>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        /// Check if any of the endpoints of the first line string equals either of the two endpoints of the second line string.
        guard let lineStringBoundary1 = lineString1.boundary() as? MultiPoint<CoordinateType>,
              let lineStringBoundary2 = lineString2.boundary() as? MultiPoint<CoordinateType> else {
                return (nil, disjoint)
        }
        var geometriesIntersect = intersects(lineStringBoundary1, lineStringBoundary2)
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
            guard let ls1FirstCoord  = lineString1[ls1FirstCoordIndex] as? CoordinateType,
                  let ls1SecondCoord = lineString1[ls1FirstCoordIndex + 1] as? CoordinateType else {
                    /// One of the two points on the line string is invalid.  No intersection.
                    return (nil, disjoint)
            }

            let segment1 = Segment<CoordinateType>(left: ls1FirstCoord, right: ls1SecondCoord)

            /// Any intersection from here on is guaranteed to be in the interior.
            for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                guard let ls2FirstCoord  = lineString2[ls2FirstCoordIndex] as? CoordinateType,
                      let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1] as? CoordinateType else {
                        /// One of the two points on the line string is invalid.  No intersection.
                        return (nil, disjoint)
                }

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
        if relatedB2Ls1.firstTouchesSecondInterior {
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
        if relatedB1Ls2.firstTouchesSecondInterior {
            matrixIntersects[.boundary, .interior] = .zero
        }

        /// Boundary, boundary
        if relatedB1Ls2.firstTouchesSecondBoundary {
            matrixIntersects[.boundary, .boundary] = .zero
        }

        /// Boundary, exterior
        if relatedB1Ls2.firstTouchesSecondExterior {
            matrixIntersects[.boundary, .exterior] = .zero
        }

        /// Exterior, interior
        if !subset(reducedLs2, reducedLs1) {
            matrixIntersects[.exterior, .interior] = .one
        }

        /// Exterior, boundary
        if relatedB2Ls1.firstTouchesSecondExterior {
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

        /// Define the MultiPoint geometry that might be returned
        var resultGeometryMultiPoint = MultiPoint<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

        /// Define the LineString geometry that might be returned
        var resultGeometryLineString = LineString<CoordinateType>(precision: FloatingPrecision(), coordinateSystem: Cartesian())

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
            guard let ls1FirstCoord  = lineString[ls1FirstCoordIndex] as? CoordinateType,
                let ls1SecondCoord = lineString[ls1FirstCoordIndex + 1] as? CoordinateType else {
                    /// One of the two points on the line string is invalid.  No intersection.
                    return (nil, disjoint)
            }

            let segment1 = Segment<CoordinateType>(left: ls1FirstCoord, right: ls1SecondCoord)

            /// Any intersection from here on is guaranteed to be in the interior.
            for ls2FirstCoordIndex in 0..<linearRing.count - 1 {
                guard let ls2FirstCoord  = linearRing[ls2FirstCoordIndex] as? CoordinateType,
                    let ls2SecondCoord = linearRing[ls2FirstCoordIndex + 1] as? CoordinateType else {
                        /// One of the two points on the line string is invalid.  No intersection.
                        return (nil, disjoint)
                }

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
        if relatedBlsLr.firstTouchesSecondInterior {
            matrixIntersects[.boundary, .interior] = .zero
        }

        /// Boundary, exterior
        if relatedBlsLr.firstTouchesSecondExterior {
            matrixIntersects[.boundary, .exterior] = .zero
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return (nil, matrixIntersects)
    }
}
