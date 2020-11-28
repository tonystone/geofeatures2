///
///  IntersectionMatrix+Helpers.swift
///  Pods
///
///  Created by Ed Swiss on 3/19/17.
///
///

import Foundation

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

    var firstInteriorTouchesSecondInterior: Dimension   = .empty
    var firstInteriorTouchesSecondBoundary: Dimension   = .empty
    var firstInteriorTouchesSecondExterior: Dimension   = .empty

    var firstBoundaryTouchesSecondInterior: Dimension   = .empty
    var firstBoundaryTouchesSecondBoundary: Dimension   = .empty
    var firstBoundaryTouchesSecondExterior: Dimension   = .empty

    var firstExteriorTouchesSecondInterior: Dimension   = .empty
    var firstExteriorTouchesSecondBoundary: Dimension   = .empty
    var firstExteriorTouchesSecondExterior: Dimension   = .two

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

    var firstTouchesSecondInteriorOrBoundaryOnly: Bool {
        return (firstTouchesSecondInterior > .empty || firstTouchesSecondBoundary > .empty) && firstTouchesSecondExterior == .empty
    }

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
}

extension IntersectionMatrix {

    static func generateMatrix(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

//        /// Note in the cases where one or two of the input geometries is a GeometryCollection, it is assumed that the GeometryCollections are not nested,
//        /// so you will not have a GeometryCollection inside a GeometryCollection.
//        /// This commented out code that includes GeometryCollections may be thrown out later, if we can safely assume they
//        /// will not be considered in intersection matrix calculations.
//        if let geometryCollection1 = geometry1 as? GeometryCollection, let geometryCollection2 = geometry2 as? GeometryCollection {
//            var finalIntersectionMatrix = IntersectionMatrix()
//            for tempGeometry1 in geometryCollection1 {
//                for tempGeometry2 in geometryCollection2 {
//                    let resultIntersectionMatrix = IntersectionMatrix.intersectionGeometry(tempGeometry1, tempGeometry2)
//                    update(intersectionMatrixBase: &finalIntersectionMatrix, intersectionMatrixNew: resultIntersectionMatrix)
//                }
//            }
//            return finalIntersectionMatrix
//        } else if let geometryCollection1 = geometry1 as? GeometryCollection {
//            var finalIntersectionMatrix = IntersectionMatrix()
//            for tempGeometry1 in geometryCollection1 {
//                let resultIntersectionMatrix = IntersectionMatrix.intersectionGeometry(tempGeometry1, geometry2)
//                update(intersectionMatrixBase: &finalIntersectionMatrix, intersectionMatrixNew: resultIntersectionMatrix)
//            }
//            return finalIntersectionMatrix
//        } else if let geometryCollection2 = geometry2 as? GeometryCollection {
//           var finalIntersectionMatrix = IntersectionMatrix()
//           for tempGeometry2 in geometryCollection2 {
//               let resultIntersectionMatrix = IntersectionMatrix.intersectionGeometry(geometry1, tempGeometry2)
//               update(intersectionMatrixBase: &finalIntersectionMatrix, intersectionMatrixNew: resultIntersectionMatrix)
//           }
//           return finalIntersectionMatrix
//        } else {
//            return IntersectionMatrix.intersectionGeometry(geometry1, geometry2)
//        }

        return IntersectionMatrix.intersectionGeometry(geometry1, geometry2)
    }

    /// Returns the intersection geometry and the intersection matrix.
    /// Note that in general the intersection of two geometries will result in a set of geometries, not just one.
    fileprivate static func intersectionGeometry(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

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

        return IntersectionMatrix()
    }

    /// For the intersection of two geometries of dimension .zero
    fileprivate static func intersectionGeometryZeroZero(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

        if let point1 = geometry1 as? Point, let point2 = geometry2 as? Point {
            return generateIntersection(point1, point2)
        } else if let point = geometry1 as? Point, let points = geometry2 as? MultiPoint {
            return generateIntersection(point, points)
        } else if let points = geometry1 as? MultiPoint, let point = geometry2 as? Point {
            let intersectionMatrix = generateIntersection(point, points)
            return intersectionMatrix.transposed()
        } else if let points1 = geometry1 as? MultiPoint, let points2 = geometry2 as? MultiPoint {
            return generateIntersection(points1, points2)
        }
        return IntersectionMatrix()
    }

    /// For the intersection of two geometries of dimension .zero and .one, respectively.
    fileprivate static func intersectionGeometryZeroOne(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

        if let point = geometry1 as? Point, let lineString = geometry2 as? LineString {
            return generateIntersection(point, lineString)
        } else if let points = geometry1 as? MultiPoint, let lineString = geometry2 as? LineString {
            return generateIntersection(points, lineString)
        } else if let point = geometry1 as? Point, let multilineString = geometry2 as? MultiLineString {
            return generateIntersection(point, multilineString)
        } else if let points = geometry1 as? MultiPoint, let multilineString = geometry2 as? MultiLineString {
            return generateIntersection(points, multilineString)
        } else if let point = geometry1 as? Point, let linearRing = geometry2 as? LinearRing {
            return generateIntersection(point, linearRing)
        } else if let points = geometry1 as? MultiPoint, let linearRing = geometry2 as? LinearRing {
            return generateIntersection(points, linearRing)
        }
        return IntersectionMatrix()
    }

    /// For the intersection of two geometries of dimension .zero and .two, respectively.
    fileprivate static func intersectionGeometryZeroTwo(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

        if let point = geometry1 as? Point, let polygon = geometry2 as? Polygon {
            return generateIntersection(point, polygon)
        } else if let points = geometry1 as? MultiPoint, let polygon = geometry2 as? Polygon {
            return generateIntersection(points, polygon)
        } else if let point = geometry1 as? Point, let multipolygon = geometry2 as? MultiPolygon {
            return generateIntersection(point, multipolygon)
        } else if let points = geometry1 as? MultiPoint, let multipolygon = geometry2 as? MultiPolygon {
            return generateIntersection(points, multipolygon)
        }
        return IntersectionMatrix()
    }

    /// For the intersection of two geometries of dimension .one and .zero, respectively.
    fileprivate static func intersectionGeometryOneZero(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

        if let lineString = geometry1 as? LineString, let point = geometry2 as? Point {
            let intersectionMatrix = generateIntersection(point, lineString)
            return intersectionMatrix.transposed()
        } else if let lineString = geometry1 as? LineString, let points = geometry2 as? MultiPoint {
            let intersectionMatrix = generateIntersection(points, lineString)
            return intersectionMatrix.transposed()
        } else if let multilineString = geometry1 as? MultiLineString, let point = geometry2 as? Point {
            let intersectionMatrix = generateIntersection(point, multilineString)
            return intersectionMatrix.transposed()
        } else if let multilineString = geometry1 as? MultiLineString, let points = geometry2 as? MultiPoint {
            let intersectionMatrix = generateIntersection(points, multilineString)
            return intersectionMatrix.transposed()
        } else if let linearRing = geometry1 as? LinearRing, let point = geometry2 as? Point {
            let intersectionMatrix = generateIntersection(point, linearRing)
            return intersectionMatrix.transposed()
        } else if let linearRing = geometry1 as? LinearRing, let points = geometry2 as? MultiPoint {
            let intersectionMatrix = generateIntersection(points, linearRing)
            return intersectionMatrix.transposed()
        }
        return IntersectionMatrix()
    }

    /// For the intersection of two geometries of dimension .one.
    fileprivate static func intersectionGeometryOneOne(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

        if let lineString1 = geometry1 as? LineString, let lineString2 = geometry2 as? LineString {
            return generateIntersection(lineString1, lineString2)
        } else if let lineString = geometry1 as? LineString, let multilineString = geometry2 as? MultiLineString {
            return generateIntersection(lineString, multilineString)
        } else if let lineString = geometry1 as? LineString, let linearRing = geometry2 as? LinearRing {
            return generateIntersection(lineString, linearRing)
        } else if let multilineString = geometry1 as? MultiLineString, let lineString = geometry2 as? LineString {
            let intersectionMatrix = generateIntersection(lineString, multilineString)
            return intersectionMatrix.transposed()
        } else if let multilineString1 = geometry1 as? MultiLineString, let multilineString2 = geometry2 as? MultiLineString {
            return generateIntersection(multilineString1, multilineString2)
        } else if let multilineString = geometry1 as? MultiLineString, let linearRing = geometry2 as? LinearRing {
            let intersectionMatrix = generateIntersection(linearRing, multilineString)
            return intersectionMatrix.transposed()
        } else if let linearRing = geometry1 as? LinearRing, let lineString = geometry2 as? LineString {
            let intersectionMatrix = generateIntersection(lineString, linearRing)
            return intersectionMatrix.transposed()
        } else if let linearRing = geometry1 as? LinearRing, let multilineString = geometry2 as? MultiLineString {
            return generateIntersection(linearRing, multilineString)
        } else if let linearRing1 = geometry1 as? LinearRing, let linearRing2 = geometry2 as? LinearRing {
            return generateIntersection(linearRing1, linearRing2)
        }
        return IntersectionMatrix()
    }

    /// For the intersection of two geometries of dimension .one and .two, respectively.
    fileprivate static func intersectionGeometryOneTwo(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

        if let lineString = geometry1 as? LineString, let polygon = geometry2 as? Polygon {
            return generateIntersection(lineString, polygon)
        } else if let lineString = geometry1 as? LineString, let multipolygon = geometry2 as? MultiPolygon {
            return generateIntersection(lineString, multipolygon)
        } else if let multilineString = geometry1 as? MultiLineString, let polygon = geometry2 as? Polygon {
            return generateIntersection(multilineString, polygon)
        } else if let multilineString = geometry1 as? MultiLineString, let multipolygon = geometry2 as? MultiPolygon {
            return generateIntersection(multilineString, multipolygon)
        } else if let linearRing = geometry1 as? LinearRing, let polygon = geometry2 as? Polygon {
            return generateIntersection(linearRing, polygon)
        } else if let linearRing = geometry1 as? LinearRing, let multipolygon = geometry2 as? MultiPolygon {
            return generateIntersection(linearRing, multipolygon)
        }
        return IntersectionMatrix()
    }

    /// For the intersection of two geometries of dimension .two and .zero, respectively.
    fileprivate static func intersectionGeometryTwoZero(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

        if let polgyon = geometry1 as? Polygon, let point = geometry2 as? Point {
            let intersectionMatrix = generateIntersection(point, polgyon)
            return intersectionMatrix.transposed()
        } else if let polgyon = geometry1 as? Polygon, let points = geometry2 as? MultiPoint {
            let intersectionMatrix = generateIntersection(points, polgyon)
            return intersectionMatrix.transposed()
        } else if let multipolygon = geometry1 as? MultiPolygon, let point = geometry2 as? Point {
            let intersectionMatrix = generateIntersection(point, multipolygon)
            return intersectionMatrix.transposed()
        } else if let multipolygon = geometry1 as? MultiPolygon, let points = geometry2 as? MultiPoint {
            let intersectionMatrix = generateIntersection(points, multipolygon)
            return intersectionMatrix.transposed()
        }
        return IntersectionMatrix()
    }

    /// For the intersection of two geometries of dimension .two and .one, respectively.
    fileprivate static func intersectionGeometryTwoOne(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

        if let polgyon = geometry1 as? Polygon, let lineString = geometry2 as? LineString {
            let intersectionMatrix = generateIntersection(lineString, polgyon)
            return intersectionMatrix.transposed()
        } else if let polgyon = geometry1 as? Polygon, let multilineString = geometry2 as? MultiLineString {
            let intersectionMatrix = generateIntersection(multilineString, polgyon)
            return intersectionMatrix.transposed()
        } else if let polgyon = geometry1 as? Polygon, let linearRing = geometry2 as? LinearRing {
            let intersectionMatrix = generateIntersection(linearRing, polgyon)
            return intersectionMatrix.transposed()
        } else if let multipolygon = geometry1 as? MultiPolygon, let lineString = geometry2 as? LineString {
            let intersectionMatrix = generateIntersection(lineString, multipolygon)
            return intersectionMatrix.transposed()
        } else if let multipolygon = geometry1 as? MultiPolygon, let multilineString = geometry2 as? MultiLineString {
            let intersectionMatrix = generateIntersection(multilineString, multipolygon)
            return intersectionMatrix.transposed()
        } else if let multipolygon = geometry1 as? MultiPolygon, let linearRing = geometry2 as? LinearRing {
            let intersectionMatrix = generateIntersection(linearRing, multipolygon)
            return intersectionMatrix.transposed()
        }
        return IntersectionMatrix()
    }

    /// For the intersection of two geometries of dimension .two.
    fileprivate static func intersectionGeometryTwoTwo(_ geometry1: Geometry, _ geometry2: Geometry) -> IntersectionMatrix {

        if let polgyon1 = geometry1 as? Polygon, let polygon2 = geometry2 as? Polygon {
            return generateIntersection(polgyon1, polygon2)
        } else if let polgyon = geometry1 as? Polygon, let multipolygon = geometry2 as? MultiPolygon {
            return generateIntersection(polgyon, multipolygon)
        } else if let multipolygon = geometry1 as? MultiPolygon, let polgyon = geometry2 as? Polygon {
            let intersectionMatrix = generateIntersection(polgyon, multipolygon)
            return intersectionMatrix.transposed()
        } else if let multipolygon1 = geometry1 as? MultiPolygon, let multipolygon2 = geometry2 as? MultiPolygon {
            return generateIntersection(multipolygon1, multipolygon2)
        }
        return IntersectionMatrix()
    }

    ///
    /// Dimension .zero and dimension .zero
    ///

    fileprivate static func generateIntersection(_ point1: Point, _ point2: Point) -> IntersectionMatrix {

        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .exterior] = .two

        if point1 == point2 {
            matrixIntersects[.interior, .interior] = .zero
            return matrixIntersects
        }

        matrixIntersects[.interior, .exterior] = .zero
        matrixIntersects[.exterior, .interior] = .zero
        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ point: Point, _ points: MultiPoint) -> IntersectionMatrix {

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

        /// Remove duplicates from the multipoint
        let reducedPoints = reduce(points)

        for tempPoint in reducedPoints {

            if tempPoint == point {

                if reducedPoints.count > 1 {
                    return firstInSecond
                } else {
                    return identical
                }

            }

        }
        return disjoint
    }

    fileprivate static func generateIntersection(_ points1: MultiPoint, _ points2: MultiPoint) -> IntersectionMatrix {

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

        /// Reduce both multi points to a unique set of points.
        let reducedPoints1 = reduce(points1)
        let reducedPoints2 = reduce(points2)

        var pointsMatched = false
        var pointInGeometry1NotMatched = false
        var pointInGeometry2NotMatched = false
        var multiPointIntersection = MultiPoint(precision: Floating(), coordinateSystem: Cartesian())
        var multiPointGeometry2Matched = MultiPoint(precision: Floating(), coordinateSystem: Cartesian())
        for tempPoint1 in reducedPoints1 {

            var foundMatchingPoint = false
            for tempPoint2 in reducedPoints2 {

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

        if reducedPoints2.count != multiPointGeometry2Matched.count {
            pointInGeometry2NotMatched = true
        }

        switch (pointInGeometry1NotMatched, pointInGeometry2NotMatched) {
        case (false, false):
            return identical
        case (false, true):
            return firstInSecond
        case (true, false):
            return secondInFirst
        case (true, true):
            if pointsMatched {
                return overlap
            } else {
                return disjoint
            }
        }
    }

    ///
    /// Dimension .zero and dimesion .one
    ///

    enum LocationType {
        case onBoundary, onInterior, onExterior
    }

    /// Returns true if the coordinate is on the line segment.
    fileprivate static func coordinateIsOnLineSegment(_ coordinate: Coordinate, segment: Segment) -> LocationType {

        /// Will likely use precision later, but use EPSILON for now.
        let EPSILON = 0.01

        /// Check if the coordinate is in between the line segment endpoints in both x and y.
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

        /// Check if the coordinate is on the boundary of the line segment
        if (coordinate == segmentLeft) || (coordinate == segmentRight) {
            return .onBoundary
        }

        /// Check for the case where the line segment is horizontal
        if (leftY == rightY) && (coordinate.y == leftY) && ((coordinate.x <= leftX && coordinate.x >= rightX) || (coordinate.x >= leftX && coordinate.x <= rightX)) {
            return .onInterior
        }

        /// Check for the cases where the line segment is vertical
        if (leftX == rightX) && (coordinate.x == leftX) && ((coordinate.y <= leftY && coordinate.y >= rightY) || (coordinate.y >= leftY && coordinate.y <= rightY)) {
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

    fileprivate static func generateIntersection(_ point: Point, _ lineString: LineString) -> IntersectionMatrix {

        /// Simple line string where all points are the same
        var simpleLineString = IntersectionMatrix()
        simpleLineString[.interior, .boundary] = .zero
        simpleLineString[.exterior, .exterior] = .two

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

        /// Check if the line string is simple, where all points are the same
        let reducedLineString = reduce(lineString)
        if reducedLineString.count == 2 && reducedLineString[0] == point.coordinate && reducedLineString[1] == point.coordinate {
            return simpleLineString
        }

        /// Check if the point equals either of the two endpoints of the line string.
        let mainCoord = point.coordinate
        let firstCoord = lineString.first
        let secondCoord  = lineString[lineString.count - 1]

        if mainCoord == firstCoord || mainCoord == secondCoord {
            return matchesEndPoint
        }

        /// Check if the point is on any of the line segments in the line string.
        for firstCoordIndex in 0..<lineString.count - 1 {
            let firstCoord  = lineString[firstCoordIndex]
            let secondCoord = lineString[firstCoordIndex + 1]
            let segment = Segment(left: firstCoord, right: secondCoord)
            if coordinateIsOnLineSegment(mainCoord, segment: segment) == .onInterior {
                return pointOnInterior
            }
        }

        /// No intersection
        return disjoint
    }

    fileprivate static func generateIntersection(_ point: Point, _ linearRing: LinearRing) -> IntersectionMatrix {

        /// Point matches linear ring
        var pointMatchesLinearRing = IntersectionMatrix()
        pointMatchesLinearRing[.interior, .interior] = .zero
        pointMatchesLinearRing[.exterior, .exterior] = .two

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

        /// Check if the point matches the linear ring.  In this case, the linear ring is really just a single point repeated.
        let reducedLinearRing = reduce(linearRing)
        if reducedLinearRing.count == 2 && reducedLinearRing[0] == point.coordinate && reducedLinearRing[1] == point.coordinate  {
            return pointMatchesLinearRing
        }

        /// Check if the point is on any of the line segments in the line string.
        let mainCoord = point.coordinate
        for firstCoordIndex in 0..<linearRing.count - 1 {
            let firstCoord  = linearRing[firstCoordIndex]
            let secondCoord = linearRing[firstCoordIndex + 1]
            let segment = Segment(left: firstCoord, right: secondCoord)
            let location = coordinateIsOnLineSegment(mainCoord, segment: segment)
            if location == .onInterior || location == .onBoundary {
                return pointOnInterior
            }
        }

        /// No intersection
        return disjoint
    }

    fileprivate static func generateIntersection(_ point: Point, _ multiLineString: MultiLineString) -> IntersectionMatrix {

        /// Simple multi line string where all points are the same
        var simpleMultiLineString = IntersectionMatrix()
        simpleMultiLineString[.interior, .boundary] = .zero
        simpleMultiLineString[.exterior, .exterior] = .two

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

        /// Check if the multi line string is simple, where all points are the same
        var isSimpleMultiLineString = true
        let reducedMultiLineString = reduce(multiLineString)
        for reducedLineString in reducedMultiLineString {
            if reducedLineString.count == 2 && reducedLineString[0] == point.coordinate && reducedLineString[1] == point.coordinate {
                continue
            } else {
                isSimpleMultiLineString = false
                break
            }
        }
        if isSimpleMultiLineString { return simpleMultiLineString }

        /// Check if the point equals any of the endpoints of any line string.
        let mainCoord = point.coordinate
        for lineString in multiLineString {
            let firstCoord = lineString.first
            let secondCoord  = lineString[lineString.count - 1]

            if mainCoord == firstCoord || mainCoord == secondCoord {
                return matchesEndPoint
            }
        }

        /// Check if the point is on any of the line segments in any of the line strings.
        for lineString in multiLineString {
            for firstCoordIndex in 0..<lineString.count - 1 {
                let firstCoord  = lineString[firstCoordIndex]
                let secondCoord = lineString[firstCoordIndex + 1]
                let segment = Segment(left: firstCoord, right: secondCoord)
                if coordinateIsOnLineSegment(mainCoord, segment: segment) == .onInterior {
                    return pointOnInterior
                }
            }
        }

        /// No intersection
        return disjoint
    }

    fileprivate static func reduce(_ points: MultiPoint) -> MultiPoint {

        var initialPointsArray = [Point]()
        for point in points {
            initialPointsArray.append(point)
        }

        let uniquePointsArray = initialPointsArray
        .enumerated()
        .filter{ initialPointsArray.firstIndex(of: $0.1) == $0.0 }
        .map{ $0.1 }

        return MultiPoint(uniquePointsArray)
    }

    fileprivate static func subset(_ coordinate: Coordinate, _ coordinates: [Coordinate]) -> Bool {

        for tempCoordinate in coordinates {
            if coordinate == tempCoordinate {
                return true
            }
        }
        return false
    }

    fileprivate static func subset(_ coordinates1: [Coordinate], _ coordinates2: [Coordinate]) -> Bool {

        for tempCoordinate in coordinates1 {
            if subset(tempCoordinate, coordinates2) {
                continue
            } else {
                return false
            }
        }
        return true
    }

    fileprivate static func subset(_ coordinate: Coordinate, _ multiPoint: MultiPoint) -> Bool {

        for point in multiPoint {
            if coordinate == point.coordinate {
                return true
            }
        }
        return false
    }

    fileprivate static func subset(_ coordinate: Coordinate, _ lineString: LineString) -> Bool {

        for firstCoordIndex in 0..<lineString.count - 1 {
            let firstCoord  = lineString[firstCoordIndex]
            let secondCoord = lineString[firstCoordIndex + 1]
            let segment = Segment(left: firstCoord, right: secondCoord)
            let location = coordinateIsOnLineSegment(coordinate, segment: segment)
            if location == .onInterior || location == .onBoundary {
                return true
            }
        }
        return false
    }

    fileprivate static func subset(_ coordinate: Coordinate, _ multiLineString: MultiLineString) -> Bool {

        for lineString in multiLineString {
            for firstCoordIndex in 0..<lineString.count - 1 {
                let firstCoord  = lineString[firstCoordIndex]
                let secondCoord = lineString[firstCoordIndex + 1]
                let segment = Segment(left: firstCoord, right: secondCoord)
                let location = coordinateIsOnLineSegment(coordinate, segment: segment)
                if location == .onInterior || location == .onBoundary {
                    return true
                }
            }
        }
        return false
    }

    fileprivate static func relatedTo(_ coordinates: [Coordinate], _ lineString: LineString) -> RelatedTo {

        var relatedTo = RelatedTo()

        guard let lineStringBoundary = lineString.boundary() as? MultiPoint else {
                return relatedTo
        }

        let lineStringBoundaryCoordinateArray = multiPointToCoordinateArray(lineStringBoundary)

        relatedTo.firstExteriorTouchesSecondInterior = .one

        if subset(lineStringBoundaryCoordinateArray, coordinates) {
            relatedTo.firstExteriorTouchesSecondBoundary = .empty
        } else {
            relatedTo.firstExteriorTouchesSecondBoundary = .zero
        }

        for tempCoordinate in coordinates {

            if subset(tempCoordinate, lineStringBoundaryCoordinateArray) {
                relatedTo.firstInteriorTouchesSecondBoundary = .zero
                continue
            }

            /// If this line is reached, a coordinate that touches the boundary of the line string has been removed
            for firstCoordIndex in 0..<lineString.count - 1 {
                let firstCoord  = lineString[firstCoordIndex]
                let secondCoord = lineString[firstCoordIndex + 1]
                let segment = Segment(left: firstCoord, right: secondCoord)
                let location = coordinateIsOnLineSegment(tempCoordinate, segment: segment)
                if location == .onInterior {
                    relatedTo.firstInteriorTouchesSecondInterior = .zero
                    break
                } else if location == .onBoundary {
                    /// Touching the boundary of any line segment is necessarily on the interior
                    relatedTo.firstInteriorTouchesSecondInterior = .zero
                    break
                }
                
                if firstCoordIndex == lineString.count - 2 {
                    relatedTo.firstInteriorTouchesSecondExterior = .zero
                }
            }
        }
        return relatedTo
    }

    fileprivate static func subset(_ coordinate: Coordinate, _ linearRing: LinearRing) -> Bool {

        for firstCoordIndex in 0..<linearRing.count - 1 {
            let firstCoord  = linearRing[firstCoordIndex]
            let secondCoord = linearRing[firstCoordIndex + 1]
            let segment = Segment(left: firstCoord, right: secondCoord)
            let location = coordinateIsOnLineSegment(coordinate, segment: segment)
            if location == .onInterior || location == .onBoundary {
                return true
            }
        }
        return false
    }

    /// The coordinates array consists of a collection of tuples where each item contains a Coordinate and a boolean indicating
    /// whether the Coordinate is a boundary point.
    fileprivate static func relatedTo(_ coordinates: [(Coordinate, Bool)], _ linearRing: LinearRing) -> RelatedTo {

        var relatedTo = RelatedTo()
        for (tempCoordinate, isBoundaryPoint) in coordinates {
            var pointIsOnExterior = true // The point cannot touch the boundary or interior of any segment to be on the exterior
            for firstCoordIndex in 0..<linearRing.count - 1 {
                let firstCoord  = linearRing[firstCoordIndex]
                let secondCoord = linearRing[firstCoordIndex + 1]
                let segment = Segment(left: firstCoord, right: secondCoord)
                let location = coordinateIsOnLineSegment(tempCoordinate, segment: segment)
                if location == .onInterior {
                    pointIsOnExterior = false
                    if isBoundaryPoint {
                        relatedTo.firstBoundaryTouchesSecondInterior = .zero
                    } else {
                        relatedTo.firstInteriorTouchesSecondInterior = .zero
                    }
                } else if location == .onBoundary {
                     /// The boundary of any line segment on the linear ring is necessarily on the interior of the linear ring
                    pointIsOnExterior = false
                    if isBoundaryPoint {
                        relatedTo.firstBoundaryTouchesSecondInterior = .zero
                    } else {
                        relatedTo.firstInteriorTouchesSecondInterior = .zero
                    }
                }
            }

            if pointIsOnExterior {
                if isBoundaryPoint {
                    relatedTo.firstBoundaryTouchesSecondExterior = .zero
                } else {
                    relatedTo.firstInteriorTouchesSecondExterior = .zero
                }
            }
        }
        return relatedTo
    }

    /// This assumes a GeometryCollection where all of the elements are LinearRings.
    /// The coordinates array is a collection of Coordinate, Bool tuples, where the Bool is a flag indicating whether the point is a boundary point.
    fileprivate static func relatedTo(_ coordinates: [(Coordinate, Bool)], _ geometryCollection: GeometryCollection) -> RelatedTo {

        var relatedTo = RelatedTo()

        for index in 0..<geometryCollection.count {

            guard let linearRing = geometryCollection[index] as? LinearRing else {
                return relatedTo
            }

            for (tempCoordinate, _) in coordinates {
                for firstCoordIndex in 0..<linearRing.count - 1 {
                    let firstCoord  = linearRing[firstCoordIndex]
                    let secondCoord = linearRing[firstCoordIndex + 1]
                    let segment = Segment(left: firstCoord, right: secondCoord)
                    let location = coordinateIsOnLineSegment(tempCoordinate, segment: segment)
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

    fileprivate static func relatedTo(_ coordinates: [Coordinate], _ multiLineString: MultiLineString) -> RelatedTo {

        var relatedTo = RelatedTo()

        guard let multiLineStringBoundary = multiLineString.boundary() as? MultiPoint else {
            return relatedTo
        }

        let multiLineStringCoordinateArray = multiPointToCoordinateArray(multiLineStringBoundary)

        for tempCoordinate in coordinates {

            if subset(tempCoordinate, multiLineStringCoordinateArray) {
                relatedTo.firstInteriorTouchesSecondBoundary = .zero
                continue
            }

            /// If this point is reached, any point that touches the boundary of the multi line string has been removed
            var tempPointNotTouchingAnyLineString = true
            for lineString in multiLineString {
                for firstCoordIndex in 0..<lineString.count - 1 {
                    let firstCoord  = lineString[firstCoordIndex]
                    let secondCoord = lineString[firstCoordIndex + 1]
                    let segment = Segment(left: firstCoord, right: secondCoord)
                    let location = coordinateIsOnLineSegment(tempCoordinate, segment: segment)
                    if location == .onInterior {
                        relatedTo.firstInteriorTouchesSecondInterior = .zero
                        tempPointNotTouchingAnyLineString = false
                    } else if location == .onBoundary {
                        /// Touching the boundary of any line segment is necessarily on the interior
                        relatedTo.firstInteriorTouchesSecondInterior = .zero
                        tempPointNotTouchingAnyLineString = false
                    }
                }
            }
            
            if tempPointNotTouchingAnyLineString {
                relatedTo.firstInteriorTouchesSecondExterior = .zero
            }
        }
        return relatedTo
    }

    /// Assume here that the polygon is a simple polygon with no holes, just a single simple boundary.
    /// Algorithm taken from: https://stackoverflow.com/questions/29344791/check-whether-a-point-is-inside-of-a-simple-polygon
    /// The algorithm was modified because we assume the polygon is defined as a LinearRing, whose first and last points are the same.
    /// The coordinate tuple is a Coordinate object and a flag indicating whether it is a boundary point.
    fileprivate static func relatedTo(_ coordinateTuple: (Coordinate, Bool), _ simplePolygon: Polygon) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary = simplePolygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0,
            let outerLinearRing = polygonBoundary[0] as? LinearRing,
            outerLinearRing.count > 0 else {
                return relatedToResult
        }

        /// Check if the point is on the boundary of the polygon
        var coordinatesTupleArray = [(Coordinate, Bool)]()
        coordinatesTupleArray.append(coordinateTuple)
        let tempRelatedToResult = relatedTo(coordinatesTupleArray, outerLinearRing)
        let isBoundaryPoint = coordinateTuple.1
        if tempRelatedToResult.firstTouchesSecondInterior != .empty || tempRelatedToResult.firstTouchesSecondBoundary != .empty {
            if isBoundaryPoint {
                relatedToResult.firstBoundaryTouchesSecondBoundary = .zero
            } else {
                relatedToResult.firstInteriorTouchesSecondBoundary = .zero
            }
            relatedToResult.firstExteriorTouchesSecondInterior = .two
            relatedToResult.firstExteriorTouchesSecondBoundary = .one
            return relatedToResult
        }

        /// Coordinate does not touch the polygon boundary
        let coordinate = coordinateTuple.0

        var isSubset = false

        var firstCoord  = outerLinearRing[0]

        for firstCoordIndex in 1..<outerLinearRing.count {
            let secondCoord = outerLinearRing[firstCoordIndex]

            if ((secondCoord.y >= coordinate.y) != (firstCoord.y >= coordinate.y)) &&
                (coordinate.x <= (firstCoord.x - secondCoord.x) * (coordinate.y - secondCoord.y) / (firstCoord.y - secondCoord.y) + secondCoord.x) {
                isSubset = !isSubset
            }

            firstCoord = secondCoord
        }

        relatedToResult = RelatedTo() /// Resets to default values
        relatedToResult.firstExteriorTouchesSecondInterior = .two
        relatedToResult.firstExteriorTouchesSecondBoundary = .one

        if isSubset {
            relatedToResult.firstInteriorTouchesSecondInterior = .zero
            if isBoundaryPoint {
                relatedToResult.firstBoundaryTouchesSecondInterior = .zero
            }
        } else {
            if isBoundaryPoint {
                relatedToResult.firstBoundaryTouchesSecondExterior = .zero
            } else {
                relatedToResult.firstInteriorTouchesSecondExterior = .zero
            }
        }

        return relatedToResult
    }

    fileprivate static func relatedTo(_ coordinate: Coordinate, _ simplePolygon: Polygon) -> RelatedTo {

        return relatedTo((coordinate, false), simplePolygon)
    }

    /// Assume here that the polygon is a general polygon with holes.
    /// Note we've changed the name so as not to conflict with the simple polygon case.  This may change later.
    /// The coordinate tuple is a Coordinate object and a flag indicating whether it is a boundary point.
    fileprivate static func relatedToGeneral(_ coordinateTuple: (Coordinate, Bool), _ polygon: Polygon) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary = polygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0,
            let outerLinearRing = polygonBoundary[0] as? LinearRing,
            outerLinearRing.count > 0 else {
                return relatedToResult
        }

        /// Get the relationship between the coordinate and the main polygon
        let tempPolygon = Polygon(outerLinearRing, precision: Floating(), coordinateSystem: Cartesian())
        let coordinateRelatedToResult = relatedTo(coordinateTuple, tempPolygon)

        /// Check if the coordinate is on the exterior of the main polygon
        if coordinateRelatedToResult.firstTouchesSecondExterior > .empty {
            return coordinateRelatedToResult
        }

        /// Check if the coordinate is on the boundary of the main polygon
        if coordinateRelatedToResult.firstTouchesSecondBoundary > .empty {
            return coordinateRelatedToResult
        }

        /// From this coordinate on, the coordinate must be on the interior of the main polygon.
        /// Now we have to check to see if the coordinate is on the boundary or interior of any holes.

        for index in 1..<polygonBoundary.count {

            guard let innerLinearRing = polygonBoundary[index] as? LinearRing,
                innerLinearRing.count > 0 else {
                    return coordinateRelatedToResult
            }

            /// Get the relationship between the coordinate and the hole
            let tempPolygon = Polygon(innerLinearRing, precision: Floating(), coordinateSystem: Cartesian())
            /// Flag the line below.
            /// This variable name is the same as one outside the loop.  Check this.
            let coordinateRelatedToResult = relatedTo(coordinateTuple, tempPolygon)

            /// Check if the coordinate is on the interior of the hole
            if coordinateRelatedToResult.firstTouchesSecondInterior > .empty {
                relatedToResult.firstInteriorTouchesSecondExterior = .zero
                return relatedToResult
            }

            /// Check if the coordinate is on the boundary of the hole
            if coordinateRelatedToResult.firstTouchesSecondBoundary > .empty {
                return coordinateRelatedToResult
            }

        }

        /// If we've gotten this far, the coordinate must on the interior of the polygon
        relatedToResult.firstInteriorTouchesSecondInterior = .zero

        return relatedToResult
    }

    /// Assume here that the multi polygon is a general multi polygon with a collection of non-intersecting general polygons.
    /// The coordinate tuple is a Coordinate object and a flag indicating whether it is a boundary point.
    fileprivate static func relatedTo(_ coordinateTuple: (Coordinate, Bool), _ multipolygon: MultiPolygon) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// There is a special case where a coordinate touches the exterior of a MultiPolygon only when it
        /// touches the exterior of every Polygon in the MultiPolygon.  Therefore, we will track the
        /// total number of times the point touches the exterior of a Polygon.
        var coordinateTouchesExteriorOfPolygonCount = 0

        /// Loop over the polygons and update the relatedToResult struct as needed on each pass.

        for polygon in multipolygon {

            /// Get the relationship between the coordinate and the polygon
            let coordinateRelatedToResult = relatedToGeneral(coordinateTuple, polygon)

            /// Update the exterior count
            if coordinateRelatedToResult.firstTouchesSecondExterior > .empty {
                coordinateTouchesExteriorOfPolygonCount += 1
            }

            /// Update the relatedToResult as needed
            update(relatedToBase: &relatedToResult, relatedToNew: coordinateRelatedToResult)

        }

        /// Update the interior, exterior or boundary, exterior parameter
        if coordinateTuple.1 { // Is this a boundary point?
            relatedToResult.firstBoundaryTouchesSecondExterior = .empty
            if coordinateTouchesExteriorOfPolygonCount == multipolygon.count {
                relatedToResult.firstBoundaryTouchesSecondExterior = .zero
            }
        } else {
            relatedToResult.firstInteriorTouchesSecondExterior = .empty
            if coordinateTouchesExteriorOfPolygonCount == multipolygon.count {
                relatedToResult.firstInteriorTouchesSecondExterior = .zero
            }
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

        /// firstExteriorTouchesSecondExterior will never be updated, since it will always be two.
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
    /// The coordinate tuple array consists of a tuple of Coordinate and Bool, where the Bool is a flag indicating whether the coordinate is a boundary point.
    fileprivate static func relatedTo(_ coordinatesTupleArray: [(Coordinate, Bool)], _ polygon: Polygon) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// It is assumed that the polygon boundary is a collection of LinearRings with the first
        /// being the main polygon boundary and the rest being the holes inside the polygon.
        /// In this case, we should have just one LinearRing, which is the outer LinearRing.
        guard let polygonBoundary = polygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0 else {
            return relatedToResult
        }

        /// Check if any of the coordinates are on the boundary
        let coordinatesRelatedToBoundary = relatedTo(coordinatesTupleArray, polygonBoundary)
        if coordinatesRelatedToBoundary.firstTouchesSecondInterior != .empty || coordinatesRelatedToBoundary.firstTouchesSecondBoundary != .empty {
            relatedToResult.firstInteriorTouchesSecondBoundary = .zero
        }

        var coordinatesOnInteriorOfMainRing     = [Coordinate]()
        var coordinatesOnInteriorOfInnerRings   = [Coordinate]()
        var coordinatesOnBoundaryOfInnerRings   = [Coordinate]()

        for (tempCoordinate, boundaryPoint) in coordinatesTupleArray {

            var firstTime = true

            for element in polygonBoundary {

                guard let linearRing = element as? LinearRing else {
                    return relatedToResult
                }

                let tempPolygon = Polygon(linearRing, precision: Floating(), coordinateSystem: Cartesian())

                let tempRelatedToResult = relatedTo((tempCoordinate, boundaryPoint), tempPolygon)

                /// The first linear ring is the outer boundary of the polygon
                if firstTime {
                    if tempRelatedToResult.firstTouchesSecondExterior > .empty {
                        relatedToResult.firstInteriorTouchesSecondExterior = .zero
                        break
                    } else if tempRelatedToResult.firstTouchesSecondBoundary > .empty {
                        relatedToResult.firstInteriorTouchesSecondBoundary = .zero
                        break
                    } else {
                        coordinatesOnInteriorOfMainRing.append(tempCoordinate)
                    }
                    firstTime = false

                } else {
                    /// The algorithm will only reach this point if the coordinate is on the interior of the main polygon.
                    /// Note, too, that the tempPolygon above now refers to one of the main polygon's holes.
                    /// If the coordinate is on the interior of a hole, it is on the exterior of the main polygon.
                    if tempRelatedToResult.firstTouchesSecondInterior > .empty {
                        coordinatesOnInteriorOfInnerRings.append(tempCoordinate)
                        relatedToResult.firstInteriorTouchesSecondExterior = .zero
                        break
                    }

                    if tempRelatedToResult.firstTouchesSecondBoundary > .empty {
                        coordinatesOnBoundaryOfInnerRings.append(tempCoordinate)
                        relatedToResult.firstInteriorTouchesSecondBoundary = .zero
                        break
                    }
                }
            }
        }

        if coordinatesOnInteriorOfMainRing.count > coordinatesOnInteriorOfInnerRings.count + coordinatesOnBoundaryOfInnerRings.count {
            relatedToResult.firstInteriorTouchesSecondInterior = .zero
        }

        return relatedToResult
    }

    /// Assume here that the polygon is a general polygon with holes.
    /// Note we've changed the name so as not to conflict with the simply polygon case.  This may change later.
    /// Each element of the coordinate tuple array consists of a Coordinate and Bool, where the Bool is a flag indicating whether the coordinate is a boundary point.
    fileprivate static func relatedToGeneral(_ coordinateTupleArray: [(Coordinate, Bool)], _ polygon: Polygon) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// Get the polygon boundary
        guard let polygonBoundary = polygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0,
            let outerLinearRing = polygonBoundary[0] as? LinearRing,
            outerLinearRing.count > 0 else {
                return relatedToResult
        }

        for (coordinate, boundaryPoint) in coordinateTupleArray {

            /// Get the relationships between each coordinate and the general polygon
            let coordinateRelatedToResult = relatedToGeneral((coordinate, boundaryPoint), polygon)

            /// Check if the coordinate is on the interior of the polygon
            if coordinateRelatedToResult.firstTouchesSecondInterior > .empty {
                if boundaryPoint {
                    relatedToResult.firstBoundaryTouchesSecondInterior = .zero
                } else {
                    relatedToResult.firstInteriorTouchesSecondInterior = .zero
                }
            }

            /// Check if the coordinate is on the boundary of the polygon
            if coordinateRelatedToResult.firstTouchesSecondBoundary > .empty {
                if boundaryPoint {
                    relatedToResult.firstBoundaryTouchesSecondBoundary = .zero
                } else {
                    relatedToResult.firstInteriorTouchesSecondBoundary = .zero
                }
            }

            /// Check if the coordinate is on the exterior of the polygon
            if coordinateRelatedToResult.firstTouchesSecondExterior > .empty {
                if boundaryPoint {
                    relatedToResult.firstBoundaryTouchesSecondExterior = .zero
                } else {
                    relatedToResult.firstInteriorTouchesSecondExterior = .zero
                }
            }

        }

        return relatedToResult
    }

    /// Assume here that the multi polygon is a general multi polygon with holes.
    /// The coordinate tuple array consists of a tuple of Coordinate and Bool, where the Bool is a flag indicating whether the coordinate is a boundary point.
    fileprivate static func relatedTo(_ coordinateTupleArray: [(Coordinate, Bool)], _ multipolygon: MultiPolygon) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// Loop over the coordinate tuples and update the relatedToResult struct as needed on each pass.

        for coodinateTuple in coordinateTupleArray {

            /// Get the relationships between each coordinate tuple and the general multipolygon
            let pointRelatedToResult = relatedTo(coodinateTuple, multipolygon)

            /// Update the relatedToResult as needed
            update(relatedToBase: &relatedToResult, relatedToNew: pointRelatedToResult)
        }

        return relatedToResult
    }

    fileprivate static func midpoint(_ coord1: Coordinate, _ coord2: Coordinate) -> Coordinate {

        return Coordinate(x: (coord1.x + coord2.x) / 2.0, y: (coord1.y + coord2.y) / 2.0)

    }

    /// This code parallels that where the second geometry is a simple polygon.
    /// The leftCoordinateBoundaryPoint and rightCoordinateBoundaryPoint flags apply to the segment.
    fileprivate static func relatedTo(_ segment: Segment, _ linearRing: LinearRing, leftCoordinateBoundaryPoint: Bool = false, rightCoordinateBoundaryPoint: Bool = false) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// For each line segment in the linear ring, check the following:
        /// - Is all the line segment in the interior of the linear ring?  If so, set the firstTouchesSecondInterior to .one.
        /// - Is a > 0 length proper subset of the line segment in the interior of the linear ring?  If so, set the firstTouchesSecondInterior to .one.
        ///   Also, generate an ordered array of points at which the line segment touches the interior.  (The line segment could touch the linear ring interior at
        ///   more than one sub line segment.)  This array will include the end points of sub line segments.  From this array generate a second array of the
        ///   midpoints.  Check whether each point in that array is inside or outside of the linear ring.  If inside, set the firstTouchesSecondInterior to .one.
        ///   If outside, set firstTouchesSecondExterior to .one.
        /// - Does the line segment touch the linear ring interior at one or more points?  If so, set the firstTouchesSecondInterior to .zero.
        /// - Does either line segment endpoint touch outside the linear ring?  If so, set the firstTouchesSecondExterior to .one.

        /// Array of geometries at which the segment intersects the linear ring boundary
        var intersectionGeometries = [Geometry]()

        /// Do a first pass to get the basic relationship of the line segment to the linear ring
        var segmentCompletelyContainedInLinearRing = false
        var segmentInteriorTouchesLinearRingExterior = true
        for firstCoordIndex in 0..<linearRing.count - 1 {
            let firstCoord  = linearRing[firstCoordIndex]
            let secondCoord = linearRing[firstCoordIndex + 1]
            let segment2 = Segment(left: firstCoord, right: secondCoord)

            let lineSegmentIntersection = intersection(segment: segment, other: segment2)

            if let intersectionGeometry = lineSegmentIntersection.geometry {
                intersectionGeometries.append(intersectionGeometry)

                if intersectionGeometry.dimension == .one {
                    relatedToResult.firstInteriorTouchesSecondInterior = .one
                    if lineSegmentIntersection.firstSubsetOfSecond {
                        /// The segment is completely contained in the linear ring
                        segmentCompletelyContainedInLinearRing = true
                        relatedToResult.firstInteriorTouchesSecondInterior = .one
                    }
                }

                if lineSegmentIntersection.firstSubsetOfSecond {
                    segmentInteriorTouchesLinearRingExterior = false
                }

                if !lineSegmentIntersection.secondSubsetOfFirst {
                    relatedToResult.firstExteriorTouchesSecondInterior = .one
                }
            }
        }

        if segmentInteriorTouchesLinearRingExterior {
            relatedToResult.firstInteriorTouchesSecondExterior = .one
        }

        if segmentCompletelyContainedInLinearRing {
            return relatedToResult
        } else {
            relatedToResult.firstInteriorTouchesSecondExterior = .one
            relatedToResult.firstBoundaryTouchesSecondExterior = .zero
        }

        /// Check the cases where no further work is needed.
        if (relatedToResult.firstTouchesSecondInterior == .one && relatedToResult.firstTouchesSecondExterior == .one) ||
            (relatedToResult.firstTouchesSecondInterior == .empty) ||
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
        ///
        /// Note, too, the following code has been commented out but left in for now.  The current tests do not test any of this, so this code may not be needed.

//        guard intersectionGeometries.count >= 2 else { return relatedToResult }
//
//        var midpointCoordinates = [Coordinate]()
//
//        for firstGeometryIndex in 0..<intersectionGeometries.count - 1 {
//            let intersectionGeometry1 = intersectionGeometries[firstGeometryIndex]
//            let intersectionGeometry2 = intersectionGeometries[firstGeometryIndex + 1]
//
//            var midpointCoord1: Coordinate?
//            var midpointCoord2: Coordinate?
//            if let point1 = intersectionGeometry1 as? Point, let point2 = intersectionGeometry2 as? Point {
//
//                midpointCoord1 = midpoint(point1.coordinate, point2.coordinate)
//
//            } else if let point = intersectionGeometry1 as? Point, let segment = intersectionGeometry2 as? Segment {
//
//                /// Since we don't know which end of the segment is sequentially next to the point, we add both midpoints
//                midpointCoord1 = midpoint(point.coordinate, segment.leftCoordinate)
//                midpointCoord2 = midpoint(point.coordinate, segment.rightCoordinate)
//
//            } else if let point = intersectionGeometry2 as? Point, let segment = intersectionGeometry1 as? Segment {
//
//                /// Since we don't know which end of the segment is sequentially next to the point, we add both midpoints
//                midpointCoord1 = midpoint(point.coordinate, segment.leftCoordinate)
//                midpointCoord2 = midpoint(point.coordinate, segment.rightCoordinate)
//
//            } else if let segment1 = intersectionGeometry1 as? Segment, let segment2 = intersectionGeometry2 as? Segment {
//
//                /// Both line segments lie on a straight line.
//                /// The midpoint of interest lies either (1) between the leftCoordinate of the first and the rightCoordinate of the second or
//                /// (2) the rightCoordinate of the first and the leftCoordinate of the second.  We add both midpoints.
//                midpointCoord1 = midpoint(segment1.leftCoordinate, segment2.rightCoordinate)
//                midpointCoord2 = midpoint(segment1.rightCoordinate, segment2.leftCoordinate)
//
//            }
//
//            if let midpointCoord1 = midpointCoord1 { midpointCoordinates.append(midpointCoord1) }
//            if let midpointCoord2 = midpointCoord2 { midpointCoordinates.append(midpointCoord2) }
//        }
//
//        /// The midpoints have all been generated.  Check whether each is inside or outside of the linear ring.
//
//        for coord in midpointCoordinates {
//
//            let pointRelatedToResult = relatedTo(coord, linearRing)
//
//            if pointRelatedToResult.firstInteriorTouchesSecondInterior > .empty {
//                relatedToResult.firstInteriorTouchesSecondInterior = pointRelatedToResult.firstInteriorTouchesSecondInterior
//            }
//
//            if pointRelatedToResult.firstBoundaryTouchesSecondInterior > .empty {
//                relatedToResult.firstBoundaryTouchesSecondInterior = pointRelatedToResult.firstBoundaryTouchesSecondInterior
//            }
//
//            if pointRelatedToResult.firstInteriorTouchesSecondExterior > .empty {
//                relatedToResult.firstInteriorTouchesSecondExterior = pointRelatedToResult.firstInteriorTouchesSecondExterior
//            }
//
//            if pointRelatedToResult.firstBoundaryTouchesSecondExterior > .empty {
//                relatedToResult.firstBoundaryTouchesSecondExterior = pointRelatedToResult.firstBoundaryTouchesSecondExterior
//            }
//
//        }
//
//        /// Return
//
        /// The line below is left in for completeness but is currently not hit by any tests.
        return relatedToResult
    }

    /// Assume here that the polygon is a simple polygon with no holes, just a single simple boundary.
    /// The leftCoordinateBoundaryPoint and rightCoordinateBoundaryPoint flags apply to the segment.
    fileprivate static func relatedTo(_ segment: Segment, _ simplePolygon: Polygon, leftCoordinateBoundaryPoint: Bool = false, rightCoordinateBoundaryPoint: Bool = false) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary = simplePolygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0,
            let mainPolygon = polygonBoundary[0] as? LinearRing,
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

        /// Array of geometries at which the segment intersects the polygon boundary.
        /// This array may contain duplicate items.
        var intersectionGeometries = [Geometry]()

        /// Do a first pass to get the intersections of the line segment and the polygon.
        /// The point here is to get the boundary relationships.
        /// TODO: This code may be a little rough. Refine later as needed.
        for firstCoordIndex in 0..<mainPolygon.count - 1 {
            let firstCoord  = mainPolygon[firstCoordIndex]
            let secondCoord = mainPolygon[firstCoordIndex + 1]
            let segment2 = Segment(left: firstCoord, right: secondCoord)

            /// Get the relationship between two segments
            let lineSegmentIntersection = intersection(segment: segment, other: segment2)

            /// If the two segments intersect, set boundary properties
            if let intersectionGeometry = lineSegmentIntersection.geometry {

                /// Append the new geometry to the geometry array, only if the geometry does not currently exist in the array
                let matchingGeometries = intersectionGeometries.filter{
                    switch ($0, intersectionGeometry) {
                    case is (Point, Point):
                        if $0 == intersectionGeometry {
                            return true
                        }
                        return false
                    default:
                        return false
                    }
                }
                if matchingGeometries.count == 0 {
                    intersectionGeometries.append(intersectionGeometry)
                }

                if intersectionGeometry.dimension == .one {
                    relatedToResult.firstInteriorTouchesSecondBoundary = .one
                } else if intersectionGeometry.dimension == .zero {
                    if lineSegmentIntersection.firstSegmentFirstBoundaryLocation == .onInterior || lineSegmentIntersection.firstSegmentFirstBoundaryLocation == .onBoundary {
                        if leftCoordinateBoundaryPoint {
                            relatedToResult.firstBoundaryTouchesSecondBoundary = .zero
                        } else {
                            if relatedToResult.firstInteriorTouchesSecondBoundary == .empty { relatedToResult.firstInteriorTouchesSecondBoundary = .zero }
                        }
                    } else if lineSegmentIntersection.firstSegmentSecondBoundaryLocation == .onInterior || lineSegmentIntersection.firstSegmentSecondBoundaryLocation == .onBoundary {
                        if rightCoordinateBoundaryPoint {
                            relatedToResult.firstBoundaryTouchesSecondBoundary = .zero
                        } else {
                            if relatedToResult.firstInteriorTouchesSecondBoundary == .empty { relatedToResult.firstInteriorTouchesSecondBoundary = .zero }
                        }
                    } else if lineSegmentIntersection.secondSegmentFirstBoundaryLocation == .onInterior || lineSegmentIntersection.secondSegmentSecondBoundaryLocation == .onInterior || lineSegmentIntersection.interiorsTouchAtPoint {
                        if relatedToResult.firstInteriorTouchesSecondBoundary == .empty { relatedToResult.firstInteriorTouchesSecondBoundary = .zero }
                    }
                }
            }
        }

        /// Get the relationship of the first coordinate of the line segment to the polygon.
        /// Note that the left coordinate has no boundary.
        let relatedToResultCoordinate1 = relatedTo(segment.leftCoordinate, simplePolygon)

        if relatedToResultCoordinate1.firstInteriorTouchesSecondInterior > .empty {
            relatedToResult.firstInteriorTouchesSecondInterior = .one
            relatedToResult.firstBoundaryTouchesSecondInterior = .zero
        }

        if relatedToResultCoordinate1.firstInteriorTouchesSecondExterior > .empty {
            relatedToResult.firstInteriorTouchesSecondExterior = .one
            if leftCoordinateBoundaryPoint { relatedToResult.firstBoundaryTouchesSecondExterior = .zero }
        }

        /// Get the relationship of the second coordinate of the line segment to the polygon.
        /// Note that the right coordinate has no boundary.
        let relatedToResultCoordinate2 = relatedTo(segment.rightCoordinate, simplePolygon)

        if relatedToResultCoordinate2.firstInteriorTouchesSecondInterior > .empty {
            relatedToResult.firstInteriorTouchesSecondInterior = .one
            relatedToResult.firstBoundaryTouchesSecondInterior = .zero
        }

        if relatedToResultCoordinate2.firstInteriorTouchesSecondExterior > .empty {
            relatedToResult.firstInteriorTouchesSecondExterior = .one
            if rightCoordinateBoundaryPoint { relatedToResult.firstBoundaryTouchesSecondExterior = .zero }
        }
        
        /// Update the exterior/interior and exterior/boundary values.
        /// Note the values below may not be correct for degenerate polygons.

        relatedToResult.firstExteriorTouchesSecondInterior = .two
        relatedToResult.firstExteriorTouchesSecondBoundary = .one

        /// Check the cases where no further work is needed.
        if (relatedToResult.firstTouchesSecondBoundary == .one && relatedToResult.firstTouchesSecondInterior == .one && relatedToResult.firstTouchesSecondExterior == .one) ||
            (relatedToResult.firstTouchesSecondBoundary == .empty) ||
            (intersectionGeometries.count <= 1) {
            return relatedToResult
        }

        /// TODO: This section needs more work.  It catches more of the edge cases where the line segment intersects the polygon multiple times.
        /// Check the case where the line segment interior lies on the interior or exterior of the polygon.  This is why we have been collecting the geometries.
        /// Do the following:
        /// - Generate an array of the midpoints of the consecutive geometries.
        /// - Check whether each point in that array is inside or outside of the polygon.
        ///   If inside, set the firstTouchesSecondInterior to .one.
        ///   If outside, set firstTouchesSecondExterior to .one.
        ///
        /// Note that this algorithm can likely be made better in the cases where two midpoints are created rather than just one.

        guard intersectionGeometries.count >= 2 else { return relatedToResult }
        
        let reducedGeometries = reduce(intersectionGeometries)

        var midpointCoordinates = [Coordinate]()

        for firstGeometryIndex in 0..<reducedGeometries.count - 1 {
            let intersectionGeometry1 = reducedGeometries[firstGeometryIndex]
            let intersectionGeometry2 = reducedGeometries[firstGeometryIndex + 1]

            var midpointCoord1: Coordinate?
            var midpointCoord2: Coordinate?
            if let point1 = intersectionGeometry1 as? Point, let point2 = intersectionGeometry2 as? Point {

                midpointCoord1 = midpoint(point1.coordinate, point2.coordinate)

            } else if let point = intersectionGeometry1 as? Point, let lineString = intersectionGeometry2 as? LineString {

                /// Since we don't know which end of the segment is sequentially next to the point, we add both midpoints
                let segment = Segment(other: lineString)
                midpointCoord1 = midpoint(point.coordinate, segment.leftCoordinate)
                midpointCoord2 = midpoint(point.coordinate, segment.rightCoordinate)

//            } else if let point = intersectionGeometry2 as? Point, let lineString = intersectionGeometry1 as? LineString {

                /// Since we don't know which end of the segment is sequentially next to the point, we add both midpoints
                /// (Note I'm leaving this section in for the time being, although it will never be executed because when reducing the geometry array,
                /// points will always come before line strings.)
//                let segment = Segment(other: lineString)
//                midpointCoord1 = midpoint(point.coordinate, segment.leftCoordinate)
//                midpointCoord2 = midpoint(point.coordinate, segment.rightCoordinate)

            } else if let lineString1 = intersectionGeometry1 as? LineString, let lineString2 = intersectionGeometry2 as? LineString {

                /// Both line segments lie on a straight line.
                /// The midpoint of interest lies either (1) between the leftCoordinate of the first and the rightCoordinate of the second or
                /// (2) the rightCoordinate of the first and the leftCoordinate of the second.  We add both midpoints.
                let segment1 = Segment(other: lineString1)
                let segment2 = Segment(other: lineString2)
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

            if pointRelatedToResult.firstInteriorTouchesSecondExterior > .empty {
                relatedToResult.firstInteriorTouchesSecondExterior = .one
            }

        }

        /// Return

        return relatedToResult
    }

    /// Assume here that the polygon is a simple polygon with no holes, just a single simple boundary.
    fileprivate static func relatedTo(_ lineString: LineString, _ simplePolygon: Polygon) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary = simplePolygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0,
            let outerLinearRing = polygonBoundary[0] as? LinearRing,
            outerLinearRing.count > 0 else {
                return relatedToResult
        }

        relatedToResult.firstExteriorTouchesSecondInterior = .two
        relatedToResult.firstExteriorTouchesSecondBoundary = .one
        if matches(lineString, outerLinearRing) {
            relatedToResult.firstExteriorTouchesSecondBoundary = .empty
        }

        /// Check the relationships between each line segment of the line string and the simple polygon

        for firstCoordIndex in 0..<lineString.count - 1 {

            let firstCoord  = lineString[firstCoordIndex]
            let secondCoord = lineString[firstCoordIndex + 1]
            let segment = Segment(left: firstCoord, right: secondCoord)
            var leftCoordinateBoundaryPoint = false
            var rightCoordinateBoundaryPoint = false
            if firstCoordIndex == 0 {
                leftCoordinateBoundaryPoint = true
            } else if firstCoordIndex == lineString.count - 2 {
                rightCoordinateBoundaryPoint = true
            }

            let segmentRelatedToResult = relatedTo(segment, simplePolygon, leftCoordinateBoundaryPoint: leftCoordinateBoundaryPoint, rightCoordinateBoundaryPoint: rightCoordinateBoundaryPoint)

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
    fileprivate static func relatedTo(_ linearRing1: LinearRing, _ linearRing2: LinearRing) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// Check the relationships between each line segment of the linear rings

        for firstCoordIndex in 0..<linearRing1.count - 1 {

            let firstCoord  = linearRing1[firstCoordIndex]
            let secondCoord = linearRing1[firstCoordIndex + 1]
            let segment = Segment(left: firstCoord, right: secondCoord)

            let segmentRelatedToResult = relatedTo(segment, linearRing2)

            if segmentRelatedToResult.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                relatedToResult.firstInteriorTouchesSecondInterior = segmentRelatedToResult.firstInteriorTouchesSecondInterior
            }

            if segmentRelatedToResult.firstInteriorTouchesSecondExterior > relatedToResult.firstInteriorTouchesSecondExterior {
                relatedToResult.firstInteriorTouchesSecondExterior = segmentRelatedToResult.firstInteriorTouchesSecondExterior
            }

        }

        if !subset(linearRing2, linearRing1) {
            relatedToResult.firstExteriorTouchesSecondInterior = .one
        }

        return relatedToResult
    }

    /// Assume here that the polygon is a simple polygon with no holes, just a single simple boundary.
    fileprivate static func relatedTo(_ linearRing: LinearRing, _ simplePolygon: Polygon) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// Get the polygon boundary
        guard let polygonBoundary = simplePolygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0,
            let outerLinearRing = polygonBoundary[0] as? LinearRing,
            outerLinearRing.count > 0 else {
                return relatedToResult
        }

        /// Check the relationships between each line segment of the linear ring and the simple polygon

        for firstCoordIndex in 0..<linearRing.count - 1 {

            let firstCoord  = linearRing[firstCoordIndex]
            let secondCoord = linearRing[firstCoordIndex + 1]
            let segment = Segment(left: firstCoord, right: secondCoord)

            let segmentRelatedToResult = relatedTo(segment, simplePolygon)

            if segmentRelatedToResult.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                relatedToResult.firstInteriorTouchesSecondInterior = segmentRelatedToResult.firstInteriorTouchesSecondInterior
            }

            if segmentRelatedToResult.firstInteriorTouchesSecondBoundary > relatedToResult.firstInteriorTouchesSecondBoundary {
                relatedToResult.firstInteriorTouchesSecondBoundary = segmentRelatedToResult.firstInteriorTouchesSecondBoundary
            }

            if segmentRelatedToResult.firstInteriorTouchesSecondExterior > relatedToResult.firstInteriorTouchesSecondExterior {
                relatedToResult.firstInteriorTouchesSecondExterior = segmentRelatedToResult.firstInteriorTouchesSecondExterior
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

    /// Assume here that both polygons are simple polygons with no holes, just a single simple boundary.
    fileprivate static func relatedTo(_ simplePolygon1: Polygon, _ simplePolygon2: Polygon) -> RelatedTo {

        var relatedToResult = RelatedTo()

        guard let polygonBoundary1 = simplePolygon1.boundary() as? GeometryCollection,
            polygonBoundary1.count > 0,
            let outerLinearRing1 = polygonBoundary1[0] as? LinearRing,
            outerLinearRing1.count > 0 else {
                return relatedToResult
        }

        guard let polygonBoundary2 = simplePolygon2.boundary() as? GeometryCollection,
            polygonBoundary2.count > 0,
            let outerLinearRing2 = polygonBoundary2[0] as? LinearRing,
            outerLinearRing2.count > 0 else {
                return relatedToResult
        }

        /// Check the relationships between each line segment of the first polygon boundary and the second polygon

        for firstCoordIndex in 0..<outerLinearRing1.count - 1 {

            let firstCoord  = outerLinearRing1[firstCoordIndex]
            let secondCoord = outerLinearRing1[firstCoordIndex + 1]
            let segment = Segment(left: firstCoord, right: secondCoord)

            let segmentRelatedToResult = relatedTo(segment, simplePolygon2)

            if segmentRelatedToResult.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                relatedToResult.firstInteriorTouchesSecondInterior = .two
            }

            if segmentRelatedToResult.firstBoundaryTouchesSecondInterior > relatedToResult.firstBoundaryTouchesSecondInterior {
                relatedToResult.firstBoundaryTouchesSecondInterior = .one
            }

            if segmentRelatedToResult.firstInteriorTouchesSecondBoundary > relatedToResult.firstInteriorTouchesSecondBoundary {
                relatedToResult.firstInteriorTouchesSecondBoundary = segmentRelatedToResult.firstInteriorTouchesSecondBoundary
            }

            if segmentRelatedToResult.firstInteriorTouchesSecondBoundary == .one {
                relatedToResult.firstBoundaryTouchesSecondBoundary = .one
            }

            if segmentRelatedToResult.firstInteriorTouchesSecondExterior > relatedToResult.firstInteriorTouchesSecondExterior {
                /// This could be wrong if the polygon is collapsed into a straight line.
                relatedToResult.firstInteriorTouchesSecondExterior = .two
            }

            if segmentRelatedToResult.firstExteriorTouchesSecondInterior > relatedToResult.firstExteriorTouchesSecondInterior {
                relatedToResult.firstExteriorTouchesSecondInterior = .two
            }

            if segmentRelatedToResult.firstExteriorTouchesSecondBoundary > relatedToResult.firstExteriorTouchesSecondBoundary {
                relatedToResult.firstExteriorTouchesSecondBoundary = .one
            }
        }

        /// Check the relationships between each line segment of the second polygon boundary and the first polygon.
        /// Update the relatedToResult based on that.

        var noSegmentOutsidePolygon1 = true
        for firstCoordIndex in 0..<outerLinearRing2.count - 1 {

            let firstCoord  = outerLinearRing2[firstCoordIndex]
            let secondCoord = outerLinearRing2[firstCoordIndex + 1]
            let segment = Segment(left: firstCoord, right: secondCoord)

            let segmentRelatedToResult = relatedTo(segment, simplePolygon1)

            if segmentRelatedToResult.firstInteriorTouchesSecondInterior > .empty {
                relatedToResult.firstInteriorTouchesSecondInterior = .two
                relatedToResult.firstInteriorTouchesSecondBoundary = .one
            }

            if segmentRelatedToResult.firstInteriorTouchesSecondExterior > .empty {
                noSegmentOutsidePolygon1 = false
            }
        }

        /// Check case where polygon2 is completely inside polygon1.

        if noSegmentOutsidePolygon1 {
            relatedToResult.firstExteriorTouchesSecondInterior = .empty
            relatedToResult.firstExteriorTouchesSecondBoundary = .empty
        }

        return relatedToResult
    }

    /// Assume here that both polygon arrays are the holes of a polygon and both arrays are non-empty.
    fileprivate static func relatedTo(_ simplePolygonArray1: [Polygon], _ simplePolygonArray2: [Polygon]) -> RelatedTo {

        var relatedToResult = RelatedTo()

        /// Check the relationships between each pair of polygons

        var finalInteriorExteriorDimension: Dimension = .empty
        var finalBoundaryExteriorDimension: Dimension = .empty
        var finalExteriorInteriorDimension: Dimension = .empty
        var finalExteriorBoundaryDimension: Dimension = .empty
        for simplePolygon1 in simplePolygonArray1 {
            var tempInteriorExteriorDimension: Dimension = .two
            var tempBoundaryExteriorDimension: Dimension = .one
            var tempExteriorInteriorDimension: Dimension = .two
            var tempExteriorBoundaryDimension: Dimension = .one
            for simplePolygon2 in simplePolygonArray2 {

                let polygonsRelatedToResult = relatedTo(simplePolygon1, simplePolygon2)

                if polygonsRelatedToResult.firstInteriorTouchesSecondInterior > relatedToResult.firstInteriorTouchesSecondInterior {
                    relatedToResult.firstInteriorTouchesSecondInterior = polygonsRelatedToResult.firstInteriorTouchesSecondInterior
                }

                if polygonsRelatedToResult.firstInteriorTouchesSecondBoundary > relatedToResult.firstInteriorTouchesSecondBoundary {
                    relatedToResult.firstInteriorTouchesSecondBoundary = polygonsRelatedToResult.firstInteriorTouchesSecondBoundary
                }

                if polygonsRelatedToResult.firstInteriorTouchesSecondExterior < tempInteriorExteriorDimension {
                    tempInteriorExteriorDimension = polygonsRelatedToResult.firstInteriorTouchesSecondExterior
                    tempBoundaryExteriorDimension = .one
                }

                if polygonsRelatedToResult.firstBoundaryTouchesSecondInterior > relatedToResult.firstBoundaryTouchesSecondInterior {
                    relatedToResult.firstBoundaryTouchesSecondInterior = polygonsRelatedToResult.firstBoundaryTouchesSecondInterior
                }

                if polygonsRelatedToResult.firstBoundaryTouchesSecondBoundary > relatedToResult.firstBoundaryTouchesSecondBoundary {
                    relatedToResult.firstBoundaryTouchesSecondBoundary = polygonsRelatedToResult.firstBoundaryTouchesSecondBoundary
                }

                if polygonsRelatedToResult.firstExteriorTouchesSecondInterior < tempExteriorInteriorDimension {
                    tempExteriorInteriorDimension = polygonsRelatedToResult.firstExteriorTouchesSecondInterior
                }

                if polygonsRelatedToResult.firstExteriorTouchesSecondBoundary < tempExteriorBoundaryDimension {
                    tempExteriorBoundaryDimension = polygonsRelatedToResult.firstExteriorTouchesSecondBoundary
                }
            }

            /// Update the final interior/exterior dimension as needed
            if finalInteriorExteriorDimension < tempInteriorExteriorDimension {
                finalInteriorExteriorDimension = tempInteriorExteriorDimension
            }

            /// Update the final boundary/exterior dimension as needed
            if finalBoundaryExteriorDimension < tempBoundaryExteriorDimension {
                finalBoundaryExteriorDimension = tempBoundaryExteriorDimension
            }

            /// Update the final exterior/interior dimension as needed
            if finalExteriorInteriorDimension < tempExteriorInteriorDimension {
                finalExteriorInteriorDimension = tempExteriorInteriorDimension
            }

            /// Update the final exterior/boundary dimension as needed
            if finalExteriorBoundaryDimension < tempExteriorBoundaryDimension {
                finalExteriorBoundaryDimension = tempExteriorBoundaryDimension
            }
        }

        /// There are special cases that need to be handled here.
        /// These have to do with the interior and the boundary of one polygon array to the other polygon array.

        relatedToResult.firstInteriorTouchesSecondExterior = finalInteriorExteriorDimension
        relatedToResult.firstBoundaryTouchesSecondExterior = finalBoundaryExteriorDimension
        relatedToResult.firstExteriorTouchesSecondInterior = finalExteriorInteriorDimension
        relatedToResult.firstExteriorTouchesSecondBoundary = finalExteriorBoundaryDimension

        return relatedToResult
    }

    fileprivate static func disjoint(_ polygon1: Polygon, _ polygon2: Polygon) -> Bool {

        /// Get the relationship of the outer ring of the first polygon to the second polygon.
        let outerRing1ToSecondPolygonMatrix = generateIntersection(polygon1.outerRing, polygon2)

        /// Check whether there is any overlap between the first outer ring and the second polygon.
        if outerRing1ToSecondPolygonMatrix[.interior, .interior] > .empty || outerRing1ToSecondPolygonMatrix[.interior, .boundary] > .empty ||
            outerRing1ToSecondPolygonMatrix[.boundary, .interior] > .empty || outerRing1ToSecondPolygonMatrix[.boundary, .boundary] > .empty {
            return false
        }

        /// Get the relationship of the outer ring of the second polygon to the first polygon.
        let outerRing2ToFirstPolygonMatrix = generateIntersection(polygon2.outerRing, polygon1)

        /// Check whether there is any overlap between the second outer ring and the first polygon.
        if outerRing2ToFirstPolygonMatrix[.interior, .interior] > .empty || outerRing2ToFirstPolygonMatrix[.interior, .boundary] > .empty ||
            outerRing2ToFirstPolygonMatrix[.boundary, .interior] > .empty || outerRing2ToFirstPolygonMatrix[.boundary, .boundary] > .empty {
            return false
        }

        /// No overlaps
        return true
    }

    /// This will pick out the linear rings in a geometry collection and return an array of those linear rings.
    /// For our current purposes, all of the objects in the geometry collection should be linear rings.
    fileprivate static func geometryCollectionToLinearRingArray(_ geometryCollection: GeometryCollection) -> [LinearRing] {

        var linearRings = [LinearRing]()

        for index in 0..<geometryCollection.count {

            guard let linearRing = geometryCollection[index] as? LinearRing else {
                continue
            }

            if linearRing.count == 0 { continue }

            linearRings.append(linearRing)
        }

        return linearRings
    }

    fileprivate static func linearRingsToPolygons(_ linearRings: [LinearRing]) -> [Polygon] {

        var polygons = [Polygon]()
        for linearRing in linearRings {
            let polygon = Polygon(linearRing)
            polygons.append(polygon)
        }
        return polygons
    }

    /// Assume here that both polygons are full polygons with holes
    fileprivate static func relatedToFull(_ polygon1: Polygon, _ polygon2: Polygon) -> RelatedTo {

        var relatedToResult = RelatedTo()

        let outerRing1 = polygon1.outerRing
        let innerRings1 = polygon1.innerRings
        let outerRing2 = polygon2.outerRing
        let innerRings2 = polygon2.innerRings

        /// Check if the two polygons are disjoint.
        if disjoint(polygon1, polygon2) {
            relatedToResult.firstInteriorTouchesSecondExterior = .two
            relatedToResult.firstBoundaryTouchesSecondExterior = .one
            relatedToResult.firstExteriorTouchesSecondInterior = .two
            relatedToResult.firstExteriorTouchesSecondBoundary = .one
            return relatedToResult
        }

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
                relatedToResult.firstExteriorTouchesSecondInterior = .two
            } else {
                /// Two different sets of inner rings that are both not empty
                let innerPolygons1 = linearRingsToPolygons(innerRings1)
                let innerPolygons2 = linearRingsToPolygons(innerRings2)
                let relatedToPolygonInnerRings = relatedTo(innerPolygons1, innerPolygons2)
                relatedToResult.firstInteriorTouchesSecondBoundary = relatedToPolygonInnerRings.firstExteriorTouchesSecondBoundary
                relatedToResult.firstInteriorTouchesSecondExterior = relatedToPolygonInnerRings.firstExteriorTouchesSecondInterior
                relatedToResult.firstBoundaryTouchesSecondInterior = relatedToPolygonInnerRings.firstBoundaryTouchesSecondExterior
                relatedToResult.firstBoundaryTouchesSecondExterior = relatedToPolygonInnerRings.firstBoundaryTouchesSecondInterior
                relatedToResult.firstExteriorTouchesSecondInterior = relatedToPolygonInnerRings.firstInteriorTouchesSecondExterior
                relatedToResult.firstExteriorTouchesSecondBoundary = relatedToPolygonInnerRings.firstInteriorTouchesSecondBoundary
            }

            return relatedToResult
        }

        /// The two outer rings are different.
        /// TODO: This might be a general solution, so the specialized case above where the outer rings
        /// are the same may not be needed.  Check that.

        /// Get the relationship of the outer ring of the first polygon to the second polygon.
        let outerRing1ToSecondPolygonMatrix = generateIntersection(polygon1.outerRing, polygon2)

        /// Get the relationship of the outer ring of the second polygon to the first polygon.
        let outerRing2ToFirstPolygonMatrix = generateIntersection(polygon2.outerRing, polygon1)

        if outerRing1ToSecondPolygonMatrix[.interior, .interior] > .empty {
            relatedToResult.firstInteriorTouchesSecondInterior = .two
            relatedToResult.firstBoundaryTouchesSecondInterior = .one
            if outerRing1ToSecondPolygonMatrix[.interior, .exterior] > .empty {
                relatedToResult.firstInteriorTouchesSecondBoundary = .one
            }
        }

        if outerRing2ToFirstPolygonMatrix[.interior, .interior] > .empty {
            relatedToResult.firstInteriorTouchesSecondInterior = .two
            relatedToResult.firstInteriorTouchesSecondBoundary = .one
            if outerRing2ToFirstPolygonMatrix[.interior, .exterior] > .empty {
                relatedToResult.firstBoundaryTouchesSecondInterior = .one
            }
        }

        if outerRing1ToSecondPolygonMatrix[.interior, .boundary] > .empty || outerRing2ToFirstPolygonMatrix[.interior, .boundary] > .empty {
            relatedToResult.firstBoundaryTouchesSecondBoundary = Swift.max(outerRing1ToSecondPolygonMatrix[.interior, .boundary], outerRing2ToFirstPolygonMatrix[.interior, .boundary])
        }

        if outerRing1ToSecondPolygonMatrix[.interior, .exterior] > .empty {
            relatedToResult.firstInteriorTouchesSecondExterior = .two
        }

        if outerRing1ToSecondPolygonMatrix[.interior, .exterior] > .empty {
            relatedToResult.firstBoundaryTouchesSecondExterior = .one
        }

        if outerRing2ToFirstPolygonMatrix[.interior, .exterior] > .empty {
            relatedToResult.firstExteriorTouchesSecondInterior = .two
            relatedToResult.firstExteriorTouchesSecondBoundary = .one
        }

        return relatedToResult
    }

    /// Get the holes for a polygon.  This will be an array of linear rings.
    fileprivate static func holes(_ polygon: Polygon) -> [LinearRing] {

        guard let polygonBoundary = polygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 1 else {
                return []
        }

        var innerLinearRings = [LinearRing]()
        for index in 1..<polygonBoundary.count {
            guard let linearRing = polygonBoundary[index] as? LinearRing else { return [] }
            innerLinearRings.append(linearRing)
        }

        return innerLinearRings
    }

    /// It is assumed that a RelatedTo structure has been generated for two linear rings,
    /// and now we want to know if the two match.
    fileprivate static func areLinearRingsIdentical(_ relatedToLinearRings: RelatedTo) -> Bool {
        return relatedToLinearRings.firstTouchesSecondInterior == .one && relatedToLinearRings.firstTouchesSecondExterior == .empty
    }

    fileprivate static func countIdentical(_ linearRingArray1: [LinearRing], _ linearRingArray2: [LinearRing]) -> Bool {

        return linearRingArray1.count == linearRingArray2.count
    }

    /// Does the line string match the linear ring?
    fileprivate static func matches(_ lineString: LineString, _ linearRing: LinearRing) -> Bool {

        guard lineString.count == linearRing.count else { return false }

        guard lineString.count >= 2 else { return false }

        guard lineString[0] == lineString[lineString.count - 1] else { return false }

        var lineStringCoordinates = [Coordinate]()
        for coordinate in lineString {
            lineStringCoordinates.append(coordinate)
        }

        let lineStringLR = LinearRing(lineStringCoordinates)

        let relatedToRings = relatedTo(lineStringLR, linearRing)

        if areLinearRingsIdentical(relatedToRings) {
            return true
        }

        return false
    }

    /// Does the linear ring match any of the linear rings in the array?
    fileprivate static func matchesOne(_ linearRing1: LinearRing, _ linearRingArray: [LinearRing]) -> Bool {

        for linearRing2 in linearRingArray {

            let relatedToRings = relatedTo(linearRing1, linearRing2)

            if areLinearRingsIdentical(relatedToRings) {
                return true
            }
        }

        return false
    }

    /// Does the first array of linear rings match a subset of the linear rings in the second array?
    fileprivate static func matchesSubset(_ linearRingArray1: [LinearRing], _ linearRingArray2: [LinearRing]) -> Bool {

        for linearRing1 in linearRingArray1 {

            if matchesOne(linearRing1, linearRingArray2) {
                continue
            } else {
                return false
            }
        }

        return true
    }

    fileprivate static func generateIntersection(_ points: MultiPoint, _ lineString: LineString) -> IntersectionMatrix {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .one
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .boundary] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Define the coordinate array that might be returned as a Geometry
        var resultCoordinateArray = [Coordinate]()

        /// Check if any of the points equals either of the two endpoints of the line string.
        guard let lineStringBoundary = lineString.boundary() as? MultiPoint else {
            return disjoint
        }

        /// Check whether the lineStringBoundary has at least two points and is closed.
        /// If so, the line string is really a linear ring, and we will treat it as such.
        guard (lineString.count >= 2) && lineStringBoundary.count == 2 else {
            let tempLinearRing = LinearRing(lineString)
            return generateIntersection(points, tempLinearRing)
        }

        let lineStringBoundaryCoordinateArray = multiPointToCoordinateArray(lineStringBoundary)
        let coordinateArray = multiPointToCoordinateArray(points)

        var coordinateOnBoundary = false
        var coordinateOnInterior = false
        var coordinateOnExterior = false

        for coordinate in coordinateArray {
            if subset(coordinate, lineStringBoundaryCoordinateArray) {
                coordinateOnBoundary = true
                resultCoordinateArray.append(coordinate)
            }
        }

        /// Check if any of the coordinates is on any of the line segments in the line string.
        for coordinate in coordinateArray {
            /// Ignore coordinates that intersect the boundary of the line string.
            /// These were just calculated.
            if subset(coordinate, resultCoordinateArray) {
                continue
            }

            /// Any intersection from here on is guaranteed to be in the interior.
            for firstCoordIndex in 0..<lineString.count - 1 {
                let firstCoord  = lineString[firstCoordIndex]
                let secondCoord = lineString[firstCoordIndex + 1]
                let segment = Segment(left: firstCoord, right: secondCoord)
                let touchesLineSegment = coordinateIsOnLineSegment(coordinate, segment: segment)
                /// If touchesLineSegment == .onBoundary, it is a boundary point for the segment but interior to the line string.
                if (touchesLineSegment == .onInterior) || (touchesLineSegment == .onBoundary) {
                    coordinateOnInterior = true
                    resultCoordinateArray.append(coordinate)
                }
            }
        }

        /// Check if any of the coordinates is not on the line string.
        for coordinate in coordinateArray {
            if !subset(coordinate, lineString) {
                coordinateOnExterior = true
                break
            }
        }

        /// Complete the matrix as needed and return the geometry and matrix if an intersection exists
        if coordinateOnInterior {
            matrixIntersects[.interior, .interior] = .zero
        }

        if coordinateOnBoundary {
            matrixIntersects[.interior, .boundary] = .zero
        }

        if coordinateOnExterior {
            matrixIntersects[.interior, .exterior] = .zero
        }

        if !subset(lineStringBoundaryCoordinateArray, coordinateArray) {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        if coordinateOnBoundary || coordinateOnInterior {
            return matrixIntersects
        }

        /// No intersection
        return disjoint
    }

    fileprivate static func generateIntersection(_ points: MultiPoint, _ linearRing: LinearRing) -> IntersectionMatrix {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .one
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .exterior] = .two

        /// Define the coordinate array that might be returned as a Geometry
        var resultCoordinateArray = [Coordinate]()

        /// Check for coordinates on the interior or exterior of the linear ring.  There is no boundary.
        let coordinateArray = multiPointToCoordinateArray(points)

        var coordinateOnInterior = false
        var coordinateOnExterior = false

        /// Check if any of the points is on any of the line segments in the linear ring.
        for coordinate in coordinateArray {
            /// Any intersection from here is guaranteed to be in the interior.
            for firstCoordIndex in 0..<linearRing.count - 1 {
                let firstCoord  = linearRing[firstCoordIndex]
                let secondCoord = linearRing[firstCoordIndex + 1]
                let segment = Segment(left: firstCoord, right: secondCoord)
                let location = coordinateIsOnLineSegment(coordinate, segment: segment)
                if location == .onInterior || location == .onBoundary {
                    coordinateOnInterior = true
                    resultCoordinateArray.append(coordinate)
                }
            }
        }

        /// Check if any of the coordinates is not on the linear ring.
        for coordinate in coordinateArray {
            if !subset(coordinate, linearRing) {
                coordinateOnExterior = true
                break
            }
        }

        /// Complete the matrix as needed and return the geometry and matrix if an intersection exists
        if coordinateOnInterior {
            matrixIntersects[.interior, .interior] = .zero
        }

        if coordinateOnExterior {
            matrixIntersects[.interior, .exterior] = .zero
        }

        let reducedLinearRing = reduce(linearRing)
        if reducedLinearRing.count == 2 && reducedLinearRing[0] == reducedLinearRing[1] && subset(reducedLinearRing[0], points) {
            matrixIntersects[.exterior, .interior] = .empty
        }

        if coordinateOnInterior {
            return matrixIntersects
        }

        /// No intersection
        return disjoint
    }

    fileprivate static func generateIntersection(_ points: MultiPoint, _ multiLineString: MultiLineString) -> IntersectionMatrix {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .one
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .boundary] = .zero
        disjoint[.exterior, .exterior] = .two

        /// Define the coordinate array that might be returned as a Geometry
        var resultCoordinateArray = [Coordinate]()

        /// Check if any of the points equals any of the endpoints of the multiline string.
        guard let multiLineStringBoundary = multiLineString.boundary() as? MultiPoint else {
            return disjoint
        }

        let multiLineStringBoundaryCoordinateArray = multiPointToCoordinateArray(multiLineStringBoundary)
        let coordinateArray = multiPointToCoordinateArray(points)
        
        var coordinateOnBoundary = false
        var coordinateOnInterior = false
        var coordinateOnExterior = false

        for coordinate in coordinateArray {
            if subset(coordinate, multiLineStringBoundaryCoordinateArray) {
                coordinateOnBoundary = true
                resultCoordinateArray.append(coordinate)
            }
        }

        /// Check if any of the coordinates is on any of the line segments in the multiline string.
        for coordinate in coordinateArray {
            /// Ignore coordinates that intersect the boundary of the multiline string.
            /// These were just calculated.
            if subset(coordinate, resultCoordinateArray) {
                continue
            }

            /// Any intersection here is guaranteed to be in the interior.
            for lineString in multiLineString {
                for firstCoordIndex in 0..<lineString.count - 1 {
                    let firstCoord  = lineString[firstCoordIndex]
                    let secondCoord = lineString[firstCoordIndex + 1]
                    let segment = Segment(left: firstCoord, right: secondCoord)
                    if coordinateIsOnLineSegment(coordinate, segment: segment)  == .onInterior {
                        coordinateOnInterior = true
                        resultCoordinateArray.append(coordinate)
                    }
                }
            }
        }

        /// Check if any of the coordinates is not on the multiline string.
        for coordinate in coordinateArray {
            if !subset(coordinate, multiLineString) {
                coordinateOnExterior = true
                break
            }
        }

        /// Complete the matrix as needed and return the geometry and matrix if an intersection exists
        if coordinateOnInterior {
            matrixIntersects[.interior, .interior] = .zero
        }

        if coordinateOnBoundary {
            matrixIntersects[.interior, .boundary] = .zero
        }

        if coordinateOnExterior {
            matrixIntersects[.interior, .exterior] = .zero
        }

        if !subset(multiLineStringBoundaryCoordinateArray, coordinateArray) {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        if coordinateOnBoundary || coordinateOnInterior {
            return matrixIntersects
        }

        /// No intersection
        return disjoint
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

    fileprivate static func generateIntersection(_ point: Point, _ polygon: Polygon) -> IntersectionMatrix {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .two
        matrixIntersects[.exterior, .boundary] = .one
        matrixIntersects[.exterior, .exterior] = .two

        var coordinates = [(Coordinate, Bool)]()
        coordinates.append((point.coordinate, false))

        let tempRelatedToResult = relatedTo(coordinates, polygon)

        if tempRelatedToResult.firstTouchesSecondInterior != .empty {
            matrixIntersects[.interior, .interior] = .zero
        } else if tempRelatedToResult.firstTouchesSecondBoundary != .empty {
            matrixIntersects[.interior, .boundary] = .zero
        } else if tempRelatedToResult.firstTouchesSecondExterior != .empty {
            matrixIntersects[.interior, .exterior] = .zero
        }

        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ point: Point, _ multipolygon: MultiPolygon) -> IntersectionMatrix {

        let relatedToCoordinateMP = relatedTo((point.coordinate, false), multipolygon)

        let matrixIntersects = intersectionMatrix(from: relatedToCoordinateMP)

        return matrixIntersects
    }

    fileprivate static func multiPointToCoordinateTupleArray(_ points: MultiPoint, _ allBoundaryPoints: Bool = false) -> [(Coordinate, Bool)] {

        var tupleArray = [(Coordinate, Bool)]()
        for point in points {
            tupleArray.append((point.coordinate, allBoundaryPoints))
        }
        return tupleArray
    }

    fileprivate static func multiPointToCoordinateArray(_ points: MultiPoint) -> [Coordinate] {

        var coordinateArray = [Coordinate]()
        for point in points {
            coordinateArray.append(point.coordinate)
        }
        return coordinateArray
    }

    fileprivate static func generateIntersection(_ points: MultiPoint, _ polygon: Polygon) -> IntersectionMatrix {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .two
        matrixIntersects[.exterior, .boundary] = .one
        matrixIntersects[.exterior, .exterior] = .two

        let coordinateTupleArray = multiPointToCoordinateTupleArray(points, false)

        let tempRelatedToResult = relatedTo(coordinateTupleArray, polygon)

        if tempRelatedToResult.firstTouchesSecondInterior != .empty {
            matrixIntersects[.interior, .interior] = .zero
        }

        if tempRelatedToResult.firstTouchesSecondBoundary != .empty {
            matrixIntersects[.interior, .boundary] = .zero
        }

        if tempRelatedToResult.firstTouchesSecondExterior != .empty {
            matrixIntersects[.interior, .exterior] = .zero
        }

        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ points: MultiPoint, _ multipolygon: MultiPolygon) -> IntersectionMatrix {

        let coordinateTupleArray = multiPointToCoordinateTupleArray(points, false)

        let relatedToCoordinatesMP = relatedTo(coordinateTupleArray, multipolygon)

        let matrixIntersects = intersectionMatrix(from: relatedToCoordinatesMP)

        /// No intersection
        return matrixIntersects
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
        
        var firstSubsetOfSecond: Bool {
            return firstSegmentFirstBoundaryLocation  != .onExterior &&
                   firstSegmentSecondBoundaryLocation != .onExterior
        }

        var secondSubsetOfFirst: Bool {
            return secondSegmentFirstBoundaryLocation  != .onExterior &&
                   secondSegmentSecondBoundaryLocation != .onExterior
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
    /// Check if the bounding boxes overlap for two one dimensional line ranges.
    /// The first value for each range is the minimum value and the second is the maximum value.
    ///
    fileprivate static func boundingBoxesOverlap1D(range1: (Double, Double), range2: (Double, Double)) -> Bool {
        return range1.1 >= range2.0 && range2.1 >= range1.0
    }

    ///
    /// Check if the bounding boxes overlap for two line segments
    ///
    fileprivate static func boundingBoxesOverlap2D(segment: Segment, other: Segment) -> Bool {
        let range1x = (Swift.min(segment.leftCoordinate.x, segment.rightCoordinate.x), Swift.max(segment.leftCoordinate.x, segment.rightCoordinate.x))
        let range1y = (Swift.min(segment.leftCoordinate.y, segment.rightCoordinate.y), Swift.max(segment.leftCoordinate.y, segment.rightCoordinate.y))
        let range2x = (Swift.min(other.leftCoordinate.x, other.rightCoordinate.x), Swift.max(other.leftCoordinate.x, other.rightCoordinate.x))
        let range2y = (Swift.min(other.leftCoordinate.y, other.rightCoordinate.y), Swift.max(other.leftCoordinate.y, other.rightCoordinate.y))
        let box1 = (range1x, range1y)
        let box2 = (range2x, range2y)

        return boundingBoxesOverlap1D(range1: box1.0, range2: box2.0) && boundingBoxesOverlap1D(range1: box1.1, range2: box2.1)
    }
    
    ///
    /// Return the bounding box of a line segment.  This is a tuple of tuples.
    /// The first element is the min and max x values, and the second element is the min and max y values.
    ///
    fileprivate static func boundingBox(_ segment: Segment) -> ((Double, Double), (Double, Double)) {
        let rangex = (Swift.min(segment.leftCoordinate.x, segment.rightCoordinate.x), Swift.max(segment.leftCoordinate.x, segment.rightCoordinate.x))
        let rangey = (Swift.min(segment.leftCoordinate.y, segment.rightCoordinate.y), Swift.max(segment.leftCoordinate.y, segment.rightCoordinate.y))
        return (rangex, rangey)
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
    fileprivate static func isLeft(p0: Coordinate, p1: Coordinate, p2: Coordinate) -> Double {
        return (p1.x - p0.x)*(p2.y - p0.y) - (p2.x - p0.x)*(p1.y -  p0.y)
    }

    ///
    /// Two line segments are passed in.
    /// If the first coordinate of the first segment, "segment", is a boundary point, firstCoordinateFirstSegmentBoundary should be true.
    /// If the second coordinate of the first segment, "segment", is a boundary point, secondCoordinateFirstSegmentBoundary should be true.
    /// If the first coordinate of the second segment, "other", is a boundary point, firstCoordinateSecondSegmentBoundary should be true.
    /// If the second coordinate of the second segment, "other", is a boundary point, secondCoordinateSecondSegmentBoundary should be true.
    ///
    fileprivate static func intersection(segment: Segment, other: Segment, firstCoordinateFirstSegmentBoundary: Bool = false, secondCoordinateFirstSegmentBoundary: Bool = false, firstCoordinateSecondSegmentBoundary: Bool = false, secondCoordinateSecondSegmentBoundary: Bool = false) -> LineSegmentIntersection {

        let precision = Floating()
        let csystem  = Cartesian()

        ///
        /// Check the bounding boxes.  They must overlap if there is an intersection.
        ///
        guard boundingBoxesOverlap2D(segment: segment, other: other) else {
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
        let leftSign   = isLeft(p0: segment.leftCoordinate, p1: segment.rightCoordinate, p2: other.leftCoordinate)
        let rightSign  = isLeft(p0: segment.leftCoordinate, p1: segment.rightCoordinate, p2: other.rightCoordinate)
        let leftSign2  = isLeft(p0: other.leftCoordinate, p1: other.rightCoordinate, p2: segment.leftCoordinate)
        let rightSign2 = isLeft(p0: other.leftCoordinate, p1: other.rightCoordinate, p2: segment.rightCoordinate)
        let oneLine    = leftSign == 0 && rightSign == 0 /// Both line segments lie on one line
        if  (segment1Boundary1Location != .onExterior) ||  (segment1Boundary2Location != .onExterior) ||
            (segment2Boundary1Location != .onExterior) ||  (segment2Boundary2Location != .onExterior) {

            var lineSegmentIntersection = LineSegmentIntersection(sb11: segment1Boundary1Location, sb12: segment1Boundary2Location, sb21: segment2Boundary1Location, sb22: segment2Boundary2Location)

            if (segment1Boundary1Location != .onExterior) &&  (segment1Boundary2Location != .onExterior) {
                /// Segment is completely contained in other
                lineSegmentIntersection.geometry = LineString([segment.leftCoordinate, segment.rightCoordinate], precision: precision, coordinateSystem: csystem)
            } else if (segment2Boundary1Location != .onExterior) &&  (segment2Boundary2Location != .onExterior) {
                /// Other is completely contained in segment
                lineSegmentIntersection.geometry = LineString([other.leftCoordinate, other.rightCoordinate], precision: precision, coordinateSystem: csystem)
            } else if (segment1Boundary1Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                lineSegmentIntersection.geometry = Point(segment.leftCoordinate, precision: precision, coordinateSystem: csystem)
                if !firstCoordinateFirstSegmentBoundary && !firstCoordinateSecondSegmentBoundary {
                    lineSegmentIntersection.interiorsTouchAtPoint = true
                }
            } else if (segment1Boundary1Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                lineSegmentIntersection.geometry = Point(segment.leftCoordinate, precision: precision, coordinateSystem: csystem)
                if !firstCoordinateFirstSegmentBoundary && !secondCoordinateSecondSegmentBoundary {
                    lineSegmentIntersection.interiorsTouchAtPoint = true
                }
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary1Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                lineSegmentIntersection.geometry = Point(segment.rightCoordinate, precision: precision, coordinateSystem: csystem)
                if !secondCoordinateFirstSegmentBoundary && !firstCoordinateSecondSegmentBoundary {
                    lineSegmentIntersection.interiorsTouchAtPoint = true
                }
            } else if (segment1Boundary2Location == .onBoundary) && (segment2Boundary2Location == .onBoundary) {
                /// Two segments meet at a single boundary point
                lineSegmentIntersection.geometry = Point(segment.rightCoordinate, precision: precision, coordinateSystem: csystem)
                if !secondCoordinateFirstSegmentBoundary && !secondCoordinateSecondSegmentBoundary {
                    lineSegmentIntersection.interiorsTouchAtPoint = true
                }
            } else if oneLine {
                /// If you reach here, the two line segments overlap by an amount > 0, but neither line segment is contained in the other.
                if (segment1Boundary1Location != .onExterior) &&  (segment2Boundary1Location != .onExterior) {
                    /// Line segments overlap from segment left to other left
                    lineSegmentIntersection.geometry = LineString([segment.leftCoordinate, other.leftCoordinate], precision: precision, coordinateSystem: csystem)
                } else if (segment1Boundary1Location != .onExterior) &&  (segment2Boundary2Location != .onExterior) {
                    /// Line segments overlap from segment left to other right
                    lineSegmentIntersection.geometry = LineString([segment.leftCoordinate, other.rightCoordinate], precision: precision, coordinateSystem: csystem)
                } else if (segment1Boundary2Location != .onExterior) &&  (segment2Boundary1Location != .onExterior) {
                    /// Line segments overlap from segment left to other left
                    lineSegmentIntersection.geometry = LineString([segment.rightCoordinate, other.leftCoordinate], precision: precision, coordinateSystem: csystem)
                } else if (segment1Boundary2Location != .onExterior) &&  (segment2Boundary2Location != .onExterior) {
                    /// Line segments overlap from segment left to other right
                    lineSegmentIntersection.geometry = LineString([segment.rightCoordinate, other.rightCoordinate], precision: precision, coordinateSystem: csystem)
                }
            } else {
                /// If you reach here, the two line segments touch at a single point that is on the boundary of one segment and the interior of the other.
                if segment1Boundary1Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point(segment.leftCoordinate, precision: precision, coordinateSystem: csystem)
                    if !firstCoordinateFirstSegmentBoundary {
                        lineSegmentIntersection.interiorsTouchAtPoint = true
                    }
                } else if segment1Boundary2Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point(segment.rightCoordinate, precision: precision, coordinateSystem: csystem)
                } else if segment2Boundary1Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point(other.leftCoordinate, precision: precision, coordinateSystem: csystem)
                } else if segment2Boundary2Location == .onInterior {
                    /// Segment boundary point 1 is on the interior of other
                    lineSegmentIntersection.geometry = Point(other.rightCoordinate, precision: precision, coordinateSystem: csystem)
                    if !secondCoordinateSecondSegmentBoundary {
                        lineSegmentIntersection.interiorsTouchAtPoint = true
                    }
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

        var interiorsIntersect = false
        if ((leftSign < 0 && rightSign > 0) || (leftSign > 0 && rightSign < 0)) && ((leftSign2 < 0 && rightSign2 > 0) || (leftSign2 > 0 && rightSign2 < 0)) {
            interiorsIntersect = true
        }

        return LineSegmentIntersection(sb11: segment1Boundary1Location, sb12: segment1Boundary2Location, sb21: segment2Boundary1Location, sb22: segment2Boundary2Location, interiors: interiorsIntersect, theGeometry: Point(Coordinate(x:x, y: y), precision: precision, coordinateSystem: csystem))
    }

    fileprivate static func intersects(_ points1: MultiPoint, _ points2: MultiPoint) -> Bool {

        let coordinates1 = multiPointToCoordinateArray(points1)
        let coordinates2 = multiPointToCoordinateArray(points2)
        return intersects(coordinates1, coordinates2)
    }

    fileprivate static func intersects(_ coordinates1: [Coordinate], _ coordinates2: [Coordinate]) -> Bool {

        for tempCoordinate in coordinates1 {
            if subset(tempCoordinate, coordinates2) {
                return true
            }
        }
        return false
    }

    /// Calculate the slope as a tuple.
    /// The first value is the slope, if the line is not vertical.
    /// The second value is a boolean flag indicating whether the line is vertical.  If it is, the first value is irrelevant and will typically be zero.
    fileprivate static func slope(_ coordinate1: Coordinate, _ coordinate2: Coordinate) -> (Double, Bool) {

        /// Check for the vertical case
        guard coordinate1.x != coordinate2.x else {
            return (0, true)
        }

        /// Normal case
        return ((coordinate2.y - coordinate1.y) / (coordinate2.x - coordinate1.x), false)
    }

    fileprivate static func slope(_ segment: Segment) -> (Double, Bool) {

        return slope(segment.leftCoordinate, segment.rightCoordinate)
    }

    /// Reduces a line string to a sequence of points such that each consecutive line segment will have a different slope
    fileprivate static func reduce(_ lineString: LineString) -> LineString {

        /// Must have at least two coordinates to reduce
        guard lineString.count >= 2 else {
            return lineString
        }

        /// Remove duplicate coordinates
        var tempLineString = LineString()
        tempLineString.append(lineString[0])
        for lsFirstCoordIndex in 0..<(lineString.count - 1) {
            let lsFirstCoord  = lineString[lsFirstCoordIndex]
            let lsSecondCoord = lineString[lsFirstCoordIndex + 1]
            if lsFirstCoord == lsSecondCoord { continue }
            tempLineString.append(lsSecondCoord)
        }
        if tempLineString.count == 1 {
            /// A valid line string will not have just one point, so duplicate the first point so there are two points.
            tempLineString.append(tempLineString[0])
        }

        /// Must have at least 3 coordinates or two lines segments for this algorithm to apply
        guard tempLineString.count >= 3 else {
            return tempLineString
        }

        var firstSlope: (Double, Bool)      /// The second value, if true, indicates a vertical line
        var secondSlope: (Double, Bool)
        var newLineString = LineString()
        newLineString.append(tempLineString[0])
        for lsFirstCoordIndex in 0..<tempLineString.count - 2 {
            let lsFirstCoord  = tempLineString[lsFirstCoordIndex]
            let lsSecondCoord = tempLineString[lsFirstCoordIndex + 1]
            let lsThirdCoord  = tempLineString[lsFirstCoordIndex + 2]
            firstSlope = slope(lsFirstCoord, lsSecondCoord)
            secondSlope = slope(lsSecondCoord, lsThirdCoord)

            if firstSlope != secondSlope {
                newLineString.append(tempLineString[lsFirstCoordIndex + 1])
            }
        }

        /// Add the last coordinate
        newLineString.append(tempLineString[tempLineString.count - 1])

        return newLineString
    }

    /// Creates a new linear ring from an original linear ring that starts and ends at the second to last point of the original
    fileprivate static func moveStartBackOne(_ linearRing: LinearRing) -> LinearRing {

        var newLinearRing = LinearRing(precision: Floating(), coordinateSystem: Cartesian())

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

    /// Returns a boolean indicating whether the second/middle coordinate is unnecessary and should be removed,
    /// since it's on the line segment between the first and third coordinates.
    fileprivate static func removeCoordinate(_ firstCoord: Coordinate, _ secondCoord: Coordinate, _ thirdCoord: Coordinate) -> Bool {

        let segment = Segment(left: firstCoord, right: thirdCoord)
        let location = coordinateIsOnLineSegment(secondCoord, segment: segment)
        if location == .onInterior || location == .onBoundary {
            return true
        }
        return false
    }

    /// Reduces a linear ring to a sequence of points such that each consecutive line segment will have a different slope
    fileprivate static func reduce(_ linearRing: LinearRing) -> LinearRing {

        /// This algorithm will reduce even invalid linear rings.
        guard linearRing.count >= 2 else {
            return linearRing
        }

        /// Remove duplicate coordinates
        var tempLinearRing = LinearRing()
        tempLinearRing.append(linearRing[0])
        for lrFirstCoordIndex in 0..<(linearRing.count - 1) {
            let lrFirstCoord  = linearRing[lrFirstCoordIndex]
            let lrSecondCoord = linearRing[lrFirstCoordIndex + 1]
            if lrFirstCoord == lrSecondCoord { continue }
            tempLinearRing.append(lrSecondCoord)
        }
        if tempLinearRing.count == 1 {
            /// A valid linear ring cannot have just one point, so add a duplicate of the first so there are two points.
            tempLinearRing.append(tempLinearRing[0])
        }

        guard tempLinearRing.count >= 3 else {
            return tempLinearRing
        }

        var firstSlope: (Double, Bool)      /// The second value, if true, indicates a vertical line
        var secondSlope: (Double, Bool)
        var newLinearRing = LinearRing()
        newLinearRing.append(tempLinearRing[0])
        for lrFirstCoordIndex in 0..<tempLinearRing.count - 2 {
            let lrFirstCoord  = tempLinearRing[lrFirstCoordIndex]
            let lrSecondCoord = tempLinearRing[lrFirstCoordIndex + 1]
            let lrThirdCoord  = tempLinearRing[lrFirstCoordIndex + 2]

            if !removeCoordinate(lrFirstCoord, lrSecondCoord, lrThirdCoord) {
                newLinearRing.append(lrSecondCoord)
            }
        }

        /// Add the last coordinate, which should be the same as the first
        newLinearRing.append(tempLinearRing[tempLinearRing.count - 1])

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

    /// This currently assumes a GeometryCollection where all of the elements are LinearRings.
    /// Specifically the LinearRings which represent the boundary of a Polygon.
    /// This function can be extended to handle other geometry collections.
    fileprivate static func reduce(_ geometryCollection: GeometryCollection) -> GeometryCollection {

        var reducedLinearRings = GeometryCollection(precision: Floating(), coordinateSystem: Cartesian())

        for index in 0..<geometryCollection.count {

            guard let linearRing = geometryCollection[index] as? LinearRing else {
                continue
            }

            if linearRing.count == 0 { continue }

            let reducedLinearRing = reduce(linearRing)
            reducedLinearRings.append(reducedLinearRing)
        }

        return reducedLinearRings
    }

    /// This currently assumes a Geometry array where all of the elements are either Points or LineStrings.
    /// Duplicate Points will have already been removed.
    /// This will remove all Points that are currently subsets of any of the LineStrings.
    /// This currently does not handle the case where LineStrings overlap or are subsets of one another.
    fileprivate static func reduce(_ geometryArray: [Geometry]) -> [Geometry] {

        guard geometryArray.count >= 2 else {
            return geometryArray
        }

        var points = [Point]()
        var lineStrings = [LineString]()
        var otherGeometries = [Geometry]()

        var reducedGeometryArray = [Geometry]()

        for geometry in geometryArray {
            switch geometry {
            case let point as Point:
                points.append(point)
            case let lineString as LineString:
                lineStrings.append(lineString)
            default:
                otherGeometries.append(geometry)
            }
        }

        guard lineStrings.count > 0 else {
            return geometryArray
        }

        for point in points {
            var pointInsideLineString = false
            for lineString in lineStrings {
                if subset(point.coordinate, lineString) {
                    pointInsideLineString = true
                    break
                }
            }
            if pointInsideLineString {
                continue
            }
            reducedGeometryArray.append(point)
        }

        reducedGeometryArray += lineStrings
        reducedGeometryArray += otherGeometries

        return reducedGeometryArray
    }

    /// Reduces a multi line string to a sequence of points on each line string such that each consecutive line segment will have a different slope.
    /// Note that for this first pass, we will handle each line string separately.
    /// TODO: Reduce connections between possibly connected line strings.
    fileprivate static func reduce(_ multiLineString: MultiLineString) -> MultiLineString {

        /// Define the MultiLineString geometry that might be returned
        var resultMultiLineString = MultiLineString(precision: Floating(), coordinateSystem: Cartesian())

        /// Reduce each of the multi line string
        for lineString in multiLineString {

            if lineString.count == 0 { continue }

            let reducedLineString = reduce(lineString)
            resultMultiLineString.append(reducedLineString)
        }

        return resultMultiLineString
    }

    /// Reduces an array of linear rings to another array of linear rings such that each consecutive
    /// line segment of each linear ring will have a different slope.
    fileprivate static func reduce(_ linearRingArray: [LinearRing]) -> [LinearRing] {

        /// Define the inear ring array that might be returned
        var resultLinearRingArray = [LinearRing]()

        /// Reduce each of the linear rings
        for linearRing in linearRingArray {

            /// Must have at least 3 points or two line segments for this algorithm to apply
            guard linearRing.count >= 3 else {
                resultLinearRingArray.append(linearRing)
                continue
            }

            var firstSlope: (Double, Bool)      /// The second value, if true, indicates a vertical line
            var secondSlope: (Double, Bool)
            var newLinearRing = LinearRing()
            newLinearRing.append(linearRing[0])
            for lsFirstCoordIndex in 0..<linearRing.count - 2 {
                let lsFirstCoord  = linearRing[lsFirstCoordIndex]
                let lsSecondCoord = linearRing[lsFirstCoordIndex + 1]
                let lsThirdCoord  = linearRing[lsFirstCoordIndex + 2]
                firstSlope = slope(lsFirstCoord, lsSecondCoord)
                secondSlope = slope(lsSecondCoord, lsThirdCoord)
                
                if firstSlope != secondSlope {
                    newLinearRing.append(linearRing[lsFirstCoordIndex + 1])
                }
            }

            /// Add the last coordinate
            newLinearRing.append(linearRing[linearRing.count - 1])

            /// Add the new linear ring to the resulting linear ring collection
            resultLinearRingArray.append(newLinearRing)
        }

        return resultLinearRingArray
    }

    /// Is segment1 contained in or a subset of segment2?
    fileprivate static func subset(_ segment1: Segment, _ segment2: Segment) -> Bool {

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
    fileprivate static func subset(_ lineString1: LineString, _ lineString2: LineString) -> Bool {

        for ls1FirstCoordIndex in 0..<lineString1.count - 1 {
            let ls1FirstCoord  = lineString1[ls1FirstCoordIndex]
            let ls1SecondCoord = lineString1[ls1FirstCoordIndex + 1]
            let segment1 = Segment(left: ls1FirstCoord, right: ls1SecondCoord)

            var segment1IsSubsetOfOtherSegment = false
            for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                let ls2FirstCoord  = lineString2[ls2FirstCoordIndex]
                let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1]
                let segment2 = Segment(left: ls2FirstCoord, right: ls2SecondCoord)

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
    /// The algorithm here assumes that both geometries have been reduced, so that no two consecutive segments have the same slope.
    fileprivate static func subset(_ lineString: LineString, _ linearRing: LinearRing) -> Bool {

        for lsFirstCoordIndex in 0..<lineString.count - 1 {
            let lsFirstCoord  = lineString[lsFirstCoordIndex]
            let lsSecondCoord = lineString[lsFirstCoordIndex + 1]
            let segment1 = Segment(left: lsFirstCoord, right: lsSecondCoord)

            var segment1IsSubsetOfOtherSegment = false
            for lrFirstCoordIndex in 0..<linearRing.count - 1 {
                let lrFirstCoord  = linearRing[lrFirstCoordIndex]
                let lrSecondCoord = linearRing[lrFirstCoordIndex + 1]
                let segment2 = Segment(left: lrFirstCoord, right: lrSecondCoord)

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

    /// Is the line string contained in or a subset of the linear ring array?
    /// The algorithm here assumes that all geometries have been reduced, so that no two consecutive segments have the same slope.
    /// It also assumes the line string is a subset of just one linear ring rather than some combination of linear rings.
    fileprivate static func subset(_ lineString: LineString, _ linearRings: [LinearRing]) -> Bool {

        for linearRing in linearRings {

            if subset(lineString, linearRing) {
                return true
            }
        }

        return false
    }

    /// Is the linear ring contained in or a subset of the line string?
    /// The algorithm here assumes that both geometries have been reduced, so that no two consecutive segments have the same slope.
    fileprivate static func subset(_ linearRing: LinearRing, _ lineString: LineString) -> Bool {

        for lrFirstCoordIndex in 0..<linearRing.count - 1 {
            let lrFirstCoord  = linearRing[lrFirstCoordIndex]
            let lrSecondCoord = linearRing[lrFirstCoordIndex + 1]
            let segment1 = Segment(left: lrFirstCoord, right: lrSecondCoord)

            var segment1IsSubsetOfOtherSegment = false
            for lsFirstCoordIndex in 0..<lineString.count - 1 {
                let lsFirstCoord  = lineString[lsFirstCoordIndex]
                let lsSecondCoord = lineString[lsFirstCoordIndex + 1]
                let segment2 = Segment(left: lsFirstCoord, right: lsSecondCoord)

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
    fileprivate static func subset(_ linearRing1: LinearRing, _ linearRing2: LinearRing) -> Bool {

        for lr1FirstCoordIndex in 0..<linearRing1.count - 1 {
            let lr1FirstCoord  = linearRing1[lr1FirstCoordIndex]
            let lr1SecondCoord = linearRing1[lr1FirstCoordIndex + 1]
            let segment1 = Segment(left: lr1FirstCoord, right: lr1SecondCoord)

            var segment1IsSubsetOfOtherSegment = false
            for lr2FirstCoordIndex in 0..<linearRing2.count - 1 {
                let lr2FirstCoord  = linearRing2[lr2FirstCoordIndex]
                let lr2SecondCoord = linearRing2[lr2FirstCoordIndex + 1]
                let segment2 = Segment(left: lr2FirstCoord, right: lr2SecondCoord)

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
    fileprivate static func subset(_ lineString1: LineString, _ multiLineString: MultiLineString) -> Bool {

        for ls1FirstCoordIndex in 0..<lineString1.count - 1 {
            let ls1FirstCoord  = lineString1[ls1FirstCoordIndex]
            let ls1SecondCoord = lineString1[ls1FirstCoordIndex + 1]
            let segment1 = Segment(left: ls1FirstCoord, right: ls1SecondCoord)

            if !subset(segment1, multiLineString) {
                return false
            }
        }

        return true
    }

    /// Is the linear ring contained in or a subset of the multi line string?
    /// The algorithm here assumes that both geometries have been reduced, so that no two consecutive segments have the same slope.
    /// TODO:
    fileprivate static func subset(_ linearRing: LinearRing, _ multiLineString: MultiLineString) -> Bool {

        for lrFirstCoordIndex in 0..<linearRing.count - 1 {
            let lrFirstCoord  = linearRing[lrFirstCoordIndex]
            let lrSecondCoord = linearRing[lrFirstCoordIndex + 1]
            let segment1 = Segment(left: lrFirstCoord, right: lrSecondCoord)

            var segment1IsSubsetOfOtherSegment = false

            for lineString in multiLineString {
                for lsFirstCoordIndex in 0..<lineString.count - 1 {
                    let lsFirstCoord  = lineString[lsFirstCoordIndex]
                    let lsSecondCoord = lineString[lsFirstCoordIndex + 1]
                    let segment2 = Segment(left: lsFirstCoord, right: lsSecondCoord)

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

    /// Is the linear ring contained in or a subset of the linear ring array?
    /// If the linear ring is a subset of the collection, it must match one of the linear rings, although the sequence of points need not match.
    /// The algorithm here assumes that both geometries have been reduced, so that no two consecutive segments have the same slope.
    fileprivate static func subset(_ linearRing: LinearRing, _ linearRings: [LinearRing]) -> Bool {

        for linearRing2 in linearRings {

            /// Check if the linear ring is inside the currently selected linear ring from the collection.
            if subset(linearRing, linearRing2) { return true }
        }

        /// The linear ring does not match any linear ring in the collection.
        return false
    }

    /// Is the multi line string contained in or a subset of the linear ring?
    /// The algorithm here assumes that both geometries have been reduced, so that no two consecutive segments have the same slope.
    fileprivate static func subset(_ multiLineString: MultiLineString, _ linearRing: LinearRing) -> Bool {

        for lineString in multiLineString {
            if !subset(lineString, linearRing) {
                return false
            }
        }

        return true
    }

    /// Subtracts segment1 from segment2 and returns an array of resulting segments that may have zero, one or two Segments in it.
    /// The algorithm here assumes that the segments have been previously checked to make sure they overlap by a segment of dimension one.
    fileprivate static func subtract(_ segment1: Segment, _ segment2: Segment) -> [Segment] {

        let boundingBox1 = boundingBox(segment1)
        let boundingBox2 = boundingBox(segment2)
        let boundingBox1XRange = boundingBox1.0
        let boundingBox1YRange = boundingBox1.1
        let boundingBox2XRange = boundingBox2.0
        let boundingBox2YRange = boundingBox2.1
        if (boundingBox1XRange.0 <= boundingBox2XRange.0) && (boundingBox1XRange.1 >= boundingBox2XRange.1) &&
           (boundingBox1YRange.0 <= boundingBox2YRange.0) && (boundingBox1YRange.1 >= boundingBox2YRange.1) {
            /// Segment1 subsumes segment2
            return []
        } else if (boundingBox1XRange.0 > boundingBox2XRange.0) && (boundingBox1XRange.1 < boundingBox2XRange.1) &&
                  (boundingBox1YRange.0 > boundingBox2YRange.0) && (boundingBox1YRange.1 < boundingBox2YRange.1) {
            /// Segment1 splits segment2 into two parts
            let newSegment1LeftX  = boundingBox2XRange.0
            let newSegment1LeftY  = boundingBox2YRange.0
            let newSegment1RightX = boundingBox1XRange.0
            let newSegment1RightY = boundingBox1YRange.0
            let newSegment2LeftX  = boundingBox1XRange.1
            let newSegment2LeftY  = boundingBox1YRange.1
            let newSegment2RightX = boundingBox1XRange.1
            let newSegment2RightY = boundingBox1YRange.1
            let newSegment1 = Segment(left: Coordinate(x: newSegment1LeftX, y: newSegment1LeftY), right: Coordinate(x: newSegment1RightX, y: newSegment1RightY))
            let newSegment2 = Segment(left: Coordinate(x: newSegment2LeftX, y: newSegment2LeftY), right: Coordinate(x: newSegment2RightX, y: newSegment2RightY))
            return [newSegment1, newSegment2]
        } else if (boundingBox1XRange.0 <= boundingBox2XRange.0) && (boundingBox1XRange.1 <= boundingBox2XRange.1) &&
                  (boundingBox1YRange.0 <= boundingBox2YRange.0) && (boundingBox1YRange.1 <= boundingBox2YRange.1) {
            /// Segment1 removes the left or bottom part of segment2
            let newSegmentLeftX  = boundingBox1XRange.1
            let newSegmentLeftY  = boundingBox1YRange.1
            let newSegmentRightX = boundingBox2XRange.1
            let newSegmentRightY = boundingBox2YRange.1
            let newSegment = Segment(left: Coordinate(x: newSegmentLeftX, y: newSegmentLeftY), right: Coordinate(x: newSegmentRightX, y: newSegmentRightY))
            return [newSegment]
        } else if (boundingBox1XRange.0 <= boundingBox2XRange.0) && (boundingBox1XRange.1 <= boundingBox2XRange.1) &&
                  (boundingBox1YRange.0 >= boundingBox2YRange.0) && (boundingBox1YRange.1 >= boundingBox2YRange.1) {
            /// Segment1 removes the top or left part of segment2
            let newSegmentLeftX  = boundingBox1XRange.1
            let newSegmentLeftY  = boundingBox1YRange.0
            let newSegmentRightX = boundingBox2XRange.1
            let newSegmentRightY = boundingBox2YRange.0
            let newSegment = Segment(left: Coordinate(x: newSegmentLeftX, y: newSegmentLeftY), right: Coordinate(x: newSegmentRightX, y: newSegmentRightY))
            return [newSegment]
        } else if (boundingBox1XRange.0 >= boundingBox2XRange.0) && (boundingBox1XRange.1 >= boundingBox2XRange.1) &&
                  (boundingBox1YRange.0 >= boundingBox2YRange.0) && (boundingBox1YRange.1 >= boundingBox2YRange.1) {
            /// Segment1 removes the top or right part of segment2
            let newSegmentLeftX  = boundingBox2XRange.0
            let newSegmentLeftY  = boundingBox2YRange.0
            let newSegmentRightX = boundingBox1XRange.0
            let newSegmentRightY = boundingBox1YRange.0
            let newSegment = Segment(left: Coordinate(x: newSegmentLeftX, y: newSegmentLeftY), right: Coordinate(x: newSegmentRightX, y: newSegmentRightY))
            return [newSegment]
        } else {
            /// (boundingBox1XRange.0 >= boundingBox2XRange.0) && (boundingBox1XRange.1 >= boundingBox2XRange.1) &&
            /// (boundingBox1YRange.0 <= boundingBox2YRange.0) && (boundingBox1YRange.1 <= boundingBox2YRange.1)
            /// Segment1 removes the top or right part of segment2
            let newSegmentLeftX  = boundingBox2XRange.0
            let newSegmentLeftY  = boundingBox2YRange.1
            let newSegmentRightX = boundingBox1XRange.0
            let newSegmentRightY = boundingBox1YRange.1
            let newSegment = Segment(left: Coordinate(x: newSegmentLeftX, y: newSegmentLeftY), right: Coordinate(x: newSegmentRightX, y: newSegmentRightY))
            return [newSegment]
        }
    }

    /// Is the segment contained in or a subset of the multi line string?
    /// The algorithm here assumes that the multi line string has been reduced, so that no two consecutive segments have the same slope.
    fileprivate static func subset(_ segment1: Segment, _ multiLineString: MultiLineString) -> Bool {

        for lineString in multiLineString {
            for lsFirstCoordIndex in 0..<lineString.count - 1 {
                let lsFirstCoord  = lineString[lsFirstCoordIndex]
                let lsSecondCoord = lineString[lsFirstCoordIndex + 1]
                let segment2 = Segment(left: lsFirstCoord, right: lsSecondCoord)

                let segmentIntersection = intersection(segment: segment1, other: segment2)
                if let geometry = segmentIntersection.geometry as? LineString {
                    let lineStringSegment = Segment(other: geometry)
                    let segmentArray = subtract(lineStringSegment, segment1)
                    if segmentArray.count == 0 {
                        return true
                    } else if segmentArray.count == 1 {
                        return subset(segmentArray[0], multiLineString)
                    } else {
                        for segment in segmentArray {
                            if !subset(segment, multiLineString) { return false }
                        }
                        return true
                    }
                }
            }
        }

        return false
    }

    /// Is the first multi line string contained in or a subset of the second multi line string?
    /// The algorithm here assumes that both geometries have been reduced, so that no two consecutive segments have the same slope.
    /// TODO:
    fileprivate static func subset(_ multiLineString1: MultiLineString, _ multiLineString2: MultiLineString) -> Bool {

        for lineString1 in multiLineString1 {
            for ls1FirstCoordIndex in 0..<lineString1.count - 1 {
                let ls1FirstCoord  = lineString1[ls1FirstCoordIndex]
                let ls1SecondCoord = lineString1[ls1FirstCoordIndex + 1]
                let segment1 = Segment(left: ls1FirstCoord, right: ls1SecondCoord)

                if !subset(segment1, multiLineString2) {
                    return false
                }
            }
        }

        return true
    }

    /// Is the multi line string contained in or a subset of the collection of linear rings?
    /// If the multi line string is a subset of the collection, each line string of the multi line string must be a subset of just one linear ring.
    /// The algorithm here assumes that both geometries have been reduced, so that no two consecutive segments have the same slope.
    fileprivate static func subset(_ multiLineString: MultiLineString, _ geometryCollection: GeometryCollection) -> Bool {
        
        for lineString in multiLineString {
            var lineStringInsideLinearRing = false
            for index in 0..<geometryCollection.count {
                
                guard let linearRing = geometryCollection[index] as? LinearRing else {
                    return false
                }
                
                /// Check if the line string is inside the currently selected linear ring from the collection.
                if subset(lineString, linearRing) {
                    lineStringInsideLinearRing = true
                    break
                }
            }
            
            if !lineStringInsideLinearRing { return false }
        }
        
        /// Each line string of the multi line string is inside a linear ring in the collection.
        return true
    }

    fileprivate static func generateIntersection(_ lineString1: LineString, _ lineString2: LineString) -> IntersectionMatrix {

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
        guard let lineStringBoundary1 = lineString1.boundary() as? MultiPoint,
              let lineStringBoundary2 = lineString2.boundary() as? MultiPoint else {
                return disjoint
        }

        let lineStringBoundaryCoordinateArray1 = multiPointToCoordinateArray(lineStringBoundary1)
        let lineStringBoundaryCoordinateArray2 = multiPointToCoordinateArray(lineStringBoundary2)

        let geometriesIntersect = intersects(lineStringBoundaryCoordinateArray1, lineStringBoundaryCoordinateArray2)
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
            let segment1 = Segment(left: ls1FirstCoord, right: ls1SecondCoord)
            let firstBoundary = (ls1FirstCoordIndex == 0)

            /// Any intersection from here on is guaranteed to be in the interior.
            for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                let ls2FirstCoord  = lineString2[ls2FirstCoordIndex]
                let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1]
                let segment2 = Segment(left: ls2FirstCoord, right: ls2SecondCoord)
                let secondBoundary = (ls2FirstCoordIndex == lineString2.count - 2)
                let lineSegmentIntersection = intersection(segment: segment1, other: segment2, firstCoordinateFirstSegmentBoundary: firstBoundary, secondCoordinateSecondSegmentBoundary: secondBoundary)

                /// Interior, interior
                if lineSegmentIntersection.geometry?.dimension == .one {
                    matrixIntersects[.interior, .interior] = .one
                } else if matrixIntersects[.interior, .interior] != .one && lineSegmentIntersection.interiorsTouchAtPoint {
                    matrixIntersects[.interior, .interior] = .zero
                }
            }
        }

        /// Interior, boundary
        let relatedB2Ls1 = relatedTo(lineStringBoundaryCoordinateArray2, lineString1)
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
        let relatedB1Ls2 = relatedTo(lineStringBoundaryCoordinateArray1, lineString2)
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
        if relatedB2Ls1.firstInteriorTouchesSecondExterior != .empty {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return matrixIntersects
    }

    /// There is an assumption here that the line string is not a linear ring
    fileprivate static func generateIntersection(_ lineString: LineString, _ linearRing: LinearRing) -> IntersectionMatrix {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .exterior] = .two

        /// Disjoint
        var disjoint = IntersectionMatrix()
        disjoint[.interior, .exterior] = .one
        disjoint[.boundary, .exterior] = .zero
        disjoint[.exterior, .interior] = .one
        disjoint[.exterior, .exterior] = .two

        /// Get the line string boundary
        guard let lineStringBoundary = lineString.boundary() as? MultiPoint else {
                return disjoint
        }

        let lineStringBoundaryCoordinateTupleArray = multiPointToCoordinateTupleArray(lineStringBoundary, true)

        ///
        /// Need to know the following:
        /// - Should the intersection function above return an IntersectionEvent or LineSegmentIntersection or?
        /// - Does "Set" work with sets of geometries, points, or other objects?
        ///

        /// Interior, interior
        for ls1FirstCoordIndex in 0..<lineString.count - 1 {
            let ls1FirstCoord  = lineString[ls1FirstCoordIndex]
            let ls1SecondCoord = lineString[ls1FirstCoordIndex + 1]
            let segment1 = Segment(left: ls1FirstCoord, right: ls1SecondCoord)
            let firstBoundary = (ls1FirstCoordIndex == 0)
            let secondBoundary = (ls1FirstCoordIndex == lineString.count - 2)

            /// Any intersection from here on is guaranteed to be in the interior.
            for ls2FirstCoordIndex in 0..<linearRing.count - 1 {
                let ls2FirstCoord  = linearRing[ls2FirstCoordIndex]
                let ls2SecondCoord = linearRing[ls2FirstCoordIndex + 1]
                let segment2 = Segment(left: ls2FirstCoord, right: ls2SecondCoord)
                let lineSegmentIntersection = intersection(segment: segment1, other: segment2, firstCoordinateFirstSegmentBoundary: firstBoundary, secondCoordinateFirstSegmentBoundary: secondBoundary)

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
        let relatedBlsLr = relatedTo(lineStringBoundaryCoordinateTupleArray, linearRing)
        if relatedBlsLr.firstTouchesSecondInterior != .empty {
            matrixIntersects[.boundary, .interior] = .zero
        }

        /// Boundary, exterior
        if relatedBlsLr.firstTouchesSecondExterior != .empty {
            matrixIntersects[.boundary, .exterior] = .zero
        }

        /// Exterior, Interior
        if !subset(reducedLr, reducedLs) {
            matrixIntersects[.exterior, .interior] = .one
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ lineString: LineString, _ multiLineString: MultiLineString) -> IntersectionMatrix {

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
        guard let lineStringBoundary = lineString.boundary() as? MultiPoint,
            let multiLineStringBoundary = multiLineString.boundary() as? MultiPoint else {
                return disjoint
        }

        let lineStringBoundaryCoordinateArray = multiPointToCoordinateArray(lineStringBoundary)
        let multiLineStringBoundaryCoordinateArray = multiPointToCoordinateArray(multiLineStringBoundary)

        let geometriesIntersect = intersects(lineStringBoundaryCoordinateArray, multiLineStringBoundaryCoordinateArray)
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
            let segment1 = Segment(left: ls1FirstCoord, right: ls1SecondCoord)
            let firstLSBoundary1 = (ls1FirstCoordIndex == 0)
            let secondLSBoundary1 = (ls1FirstCoordIndex == lineString.count - 2)

            /// Any intersection from here on is guaranteed to be in the interior.
            for lineString2 in multiLineString {
                for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                    let ls2FirstCoord  = lineString2[ls2FirstCoordIndex]
                    let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1]
                    let segment2 = Segment(left: ls2FirstCoord, right: ls2SecondCoord)
                    let firstLSBoundary2 = (ls2FirstCoordIndex == 0)
                    let secondLSBoundary2 = (ls2FirstCoordIndex == lineString2.count - 2)
                    let lineSegmentIntersection = intersection(segment: segment1, other: segment2, firstCoordinateFirstSegmentBoundary: firstLSBoundary1, secondCoordinateFirstSegmentBoundary: secondLSBoundary1, firstCoordinateSecondSegmentBoundary: firstLSBoundary2, secondCoordinateSecondSegmentBoundary: secondLSBoundary2)

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
        let relatedBmlsLs = relatedTo(multiLineStringBoundaryCoordinateArray, lineString)
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
        let relatedBlsMls = relatedTo(lineStringBoundaryCoordinateArray, multiLineString)
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
        let reducedMls2 = MultiLineString([reducedLs], precision: reducedLs.precision, coordinateSystem: reducedLs.coordinateSystem)
        if !subset(reducedMls, reducedMls2) {
            matrixIntersects[.exterior, .interior] = .one
        }

        /// Exterior, boundary
        if relatedBmlsLs.firstTouchesSecondExterior != .empty {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ linearRing1: LinearRing, _ linearRing2: LinearRing) -> IntersectionMatrix {

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
            if lr1FirstCoord == lr1SecondCoord { continue }
            let segment1 = Segment(left: lr1FirstCoord, right: lr1SecondCoord)

            /// Note the linear rings have no boundary.
            /// Any intersection from here on is guaranteed to be in the interior.
            for lr2FirstCoordIndex in 0..<linearRing2.count - 1 {
                let lr2FirstCoord  = linearRing2[lr2FirstCoordIndex]
                let lr2SecondCoord = linearRing2[lr2FirstCoordIndex + 1]
                if lr2FirstCoord == lr2SecondCoord { continue }
                let segment2 = Segment(left: lr2FirstCoord, right: lr2SecondCoord)
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
            matrixIntersects[.exterior, .interior] = .one
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ linearRing: LinearRing, _ multiLineString: MultiLineString) -> IntersectionMatrix {

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
        guard let multiLineStringBoundary = multiLineString.boundary() as? MultiPoint else {
                return disjoint
        }

        let multiLineStringBoundaryCoordinateTupleArray = multiPointToCoordinateTupleArray(multiLineStringBoundary, true)

        ///
        /// Need to know the following:
        /// - Should the intersection function above return an IntersectionEvent or LineSegmentIntersection or?
        /// - Does "Set" work with sets of geometries, points, or other objects?
        ///

        /// Interior, interior
        for lrFirstCoordIndex in 0..<linearRing.count - 1 {
            let lrFirstCoord  = linearRing[lrFirstCoordIndex]
            let lrSecondCoord = linearRing[lrFirstCoordIndex + 1]
            let segment1 = Segment(left: lrFirstCoord, right: lrSecondCoord)
            let firstBoundary = (lrFirstCoordIndex == 0)

            /// Any intersection from here on is guaranteed to be in the interior.
            for lineString in multiLineString {
                for lsFirstCoordIndex in 0..<lineString.count - 1 {
                    let lsFirstCoord  = lineString[lsFirstCoordIndex]
                    let lsSecondCoord = lineString[lsFirstCoordIndex + 1]
                    let segment2 = Segment(left: lsFirstCoord, right: lsSecondCoord)
                    let secondBoundary = (lsFirstCoordIndex == lineString.count - 2)
                    let lineSegmentIntersection = intersection(segment: segment1, other: segment2, firstCoordinateFirstSegmentBoundary: firstBoundary, secondCoordinateSecondSegmentBoundary: secondBoundary)

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
        let relatedBmlsLr = relatedTo(multiLineStringBoundaryCoordinateTupleArray, linearRing)
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
        if !subset(reducedMls, reducedLr) {
            matrixIntersects[.exterior, .interior] = .one
        }

        /// Exterior, boundary
        if relatedBmlsLr.firstTouchesSecondExterior != .empty {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ multiLineString1: MultiLineString, _ multiLineString2: MultiLineString) -> IntersectionMatrix {

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
        guard let multiLineStringBoundary1 = multiLineString1.boundary() as? MultiPoint,
            let multiLineStringBoundary2 = multiLineString2.boundary() as? MultiPoint else {
                return disjoint
        }

        let multiLineStringBoundaryCoordinateArray1 = multiPointToCoordinateArray(multiLineStringBoundary1)
        let multiLineStringBoundaryCoordinateArray2 = multiPointToCoordinateArray(multiLineStringBoundary2)

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
                let segment1 = Segment(left: ls1FirstCoord, right: ls1SecondCoord)
                let firstLSBoundary1 = (ls1FirstCoordIndex == 0)
                let secondLSBoundary1 = (ls1FirstCoordIndex == lineString1.count - 2)

                /// Any intersection from here on is guaranteed to be in the interior.
                for lineString2 in multiLineString2 {
                    for ls2FirstCoordIndex in 0..<lineString2.count - 1 {
                        let ls2FirstCoord  = lineString2[ls2FirstCoordIndex]
                        let ls2SecondCoord = lineString2[ls2FirstCoordIndex + 1]
                        let segment2 = Segment(left: ls2FirstCoord, right: ls2SecondCoord)
                        let firstLSBoundary2 = (ls2FirstCoordIndex == 0)
                        let secondLSBoundary2 = (ls2FirstCoordIndex == lineString2.count - 2)
                        let lineSegmentIntersection = intersection(segment: segment1, other: segment2, firstCoordinateFirstSegmentBoundary: firstLSBoundary1, secondCoordinateFirstSegmentBoundary: secondLSBoundary1, firstCoordinateSecondSegmentBoundary: firstLSBoundary2, secondCoordinateSecondSegmentBoundary: secondLSBoundary2)

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
        let relatedBmls2MLs1 = relatedTo(multiLineStringBoundaryCoordinateArray2, multiLineString1)
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
        let relatedBmls1Mls2 = relatedTo(multiLineStringBoundaryCoordinateArray1, multiLineString2)
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
        if !subset(reducedMls2, reducedMLs1) {
            matrixIntersects[.exterior, .interior] = .one
        }

        /// Exterior, boundary
        if relatedBmls2MLs1.firstTouchesSecondExterior != .empty {
            matrixIntersects[.exterior, .boundary] = .zero
        }

        /// Return the matrix.
        /// We will not calculate and return the geometry now.
        return matrixIntersects
    }

    ///
    /// Dimension .one and dimension .two
    ///

    /// The polygon here is a full polygon with holes
    fileprivate static func generateIntersection(_ lineString: LineString, _ polygon: Polygon) -> IntersectionMatrix {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .two
        matrixIntersects[.exterior, .boundary] = .one // This assumes the polygon boundary is not a subset of the input line string
        matrixIntersects[.exterior, .exterior] = .two

        /// Get the polygon boundary
        guard let polygonBoundary = polygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0,
            let outerLinearRing = polygonBoundary[0] as? LinearRing,
            outerLinearRing.count > 0 else {
                return matrixIntersects
        }

        /// Check whether the line string is completely contained in the polygon boundary
        let reducedLs = reduce(lineString)
        let reducedPolygonBoundary = reduce(polygonBoundary)
        let polygonBoundaryLinearRings = geometryCollectionToLinearRingArray(reducedPolygonBoundary)
        if subset(reducedLs, polygonBoundaryLinearRings) {
            matrixIntersects[.interior, .boundary] = .one
            matrixIntersects[.boundary, .boundary] = .zero
            return matrixIntersects
        }

        /// From here on we know the line string is not completely contained in the polygon boundary

        /// Get the endpoints of the line string (the line string boundary).
        /// Assume for now that there are two boundary points.

        guard let lineStringBoundary = lineString.boundary() as? MultiPoint else {
            return matrixIntersects
        }

        /// Check whether the lineStringBoundary has at least two points and is closed.
        /// If so, the line string is really a linear ring, and we will treat it as such.
        guard (lineString.count >= 2) && lineStringBoundary.count == 2 else {
            let tempLinearRing = LinearRing(lineString)
            return generateIntersection(tempLinearRing, polygon)
        }

        let lineStringBoundaryCoordinateArray = multiPointToCoordinateArray(lineStringBoundary)

        let lineStringBoundaryCoordinate1 = lineStringBoundaryCoordinateArray[0]
        let lineStringBoundaryCoordinate2 = lineStringBoundaryCoordinateArray[1]

        /// Must add an algorithm here to check whether a line segment is inside a polygon
        var lineStringInsideMainPolygon     = false /// Implies part of the line string lies inside the polygon

        var boundaryPoint1OutsidePolygon    = false
        var boundaryPoint2OutsidePolygon    = false

        var boundaryPoint1OnPolygonBoundary = false
        var boundaryPoint2OnPolygonBoundary = false

        /// Relate the line string to the main polygon and each of its holes
        var isMainPolygon = true
        var finalInteriorInteriorDimension: Dimension = .empty
        for element in polygonBoundary {

            guard let linearRing = element as? LinearRing else {
                return matrixIntersects
            }

            guard linearRing.count > 0 else { continue }

            let tempPolygon = Polygon(linearRing)

            let boundaryCoordinate1RelatedToResult  = relatedTo([(lineStringBoundaryCoordinate1, true)], tempPolygon)
            let boundaryCoordinate2RelatedToResult  = relatedTo([(lineStringBoundaryCoordinate2, true)], tempPolygon)
            let lineStringRelatedToResult           = relatedTo(lineString, tempPolygon)

            if isMainPolygon {

                if lineStringRelatedToResult.firstTouchesSecondInterior > .empty {
                    lineStringInsideMainPolygon = true
                    finalInteriorInteriorDimension = .one
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

                if boundaryCoordinate1RelatedToResult.firstTouchesSecondBoundary > .empty {
                    boundaryPoint1OnPolygonBoundary = true
                    matrixIntersects[.boundary, .boundary] = .zero
                }

                if boundaryCoordinate2RelatedToResult.firstTouchesSecondBoundary > .empty {
                    boundaryPoint2OnPolygonBoundary = true
                    matrixIntersects[.boundary, .boundary] = .zero
                }

                if boundaryCoordinate1RelatedToResult.firstTouchesSecondExterior > .empty {
                    boundaryPoint1OutsidePolygon = true
                    matrixIntersects[.boundary, .exterior] = .zero
                }

                if boundaryCoordinate2RelatedToResult.firstTouchesSecondExterior > .empty {
                    boundaryPoint2OutsidePolygon = true
                    matrixIntersects[.boundary, .exterior] = .zero
                }

                isMainPolygon = false

                /// If the line string does not touch the interior of the main polygon, we're done.
                if !lineStringInsideMainPolygon {
                    return matrixIntersects
                }

            } else {

                /// We will only consider cases here where the line string is inside the main polygon.
                /// If the line string touches only the main polygon boundary or is outside the main polygon,
                /// those cases have already been addressed.
                
                if lineStringRelatedToResult.firstTouchesSecondInteriorOrBoundaryOnly {
                    finalInteriorInteriorDimension = .empty
                }

                if lineStringRelatedToResult.firstInteriorTouchesSecondBoundary > matrixIntersects[.interior, .boundary] {
                    matrixIntersects[.interior, .boundary] = lineStringRelatedToResult.firstInteriorTouchesSecondBoundary
                }

                if lineStringRelatedToResult.firstTouchesSecondInterior > matrixIntersects[.interior, .exterior] {
                    matrixIntersects[.interior, .exterior] = lineStringRelatedToResult.firstTouchesSecondInterior
                }

                if lineStringRelatedToResult.firstBoundaryTouchesSecondBoundary > .empty {
                    matrixIntersects[.boundary, .boundary] = lineStringRelatedToResult.firstBoundaryTouchesSecondBoundary
                }

                if boundaryCoordinate1RelatedToResult.firstTouchesSecondBoundary > .empty {
                    boundaryPoint1OnPolygonBoundary = true
                    matrixIntersects[.boundary, .boundary] = .zero
                }

                if boundaryCoordinate2RelatedToResult.firstTouchesSecondBoundary > .empty {
                    boundaryPoint2OnPolygonBoundary = true
                    matrixIntersects[.boundary, .boundary] = .zero
                }

                if boundaryCoordinate1RelatedToResult.firstTouchesSecondInterior > .empty {
                    boundaryPoint1OutsidePolygon = true
                    matrixIntersects[.boundary, .exterior] = .zero
                }

                if boundaryCoordinate2RelatedToResult.firstTouchesSecondInterior > .empty {
                    boundaryPoint2OutsidePolygon = true
                    matrixIntersects[.boundary, .exterior] = .zero
                }
            }
        }

        /// We have to check that each boundary point is either on the boundary or outside the polygon
        /// before we know about the value of the boundary, interior entry.
        matrixIntersects[.boundary, .interior] = .empty
        if (!boundaryPoint1OnPolygonBoundary && !boundaryPoint1OutsidePolygon) || (!boundaryPoint2OnPolygonBoundary && !boundaryPoint2OutsidePolygon) {
            matrixIntersects[.boundary, .interior] = .zero
        }

        /// There is a special case here: line string interior with polygon interior.
        /// It's possible that the interior of the line string exists in one polygon hole but not another.
        /// In that case, the dimension of the interior/interior would be one for one hole and empty for the other.
        /// It is the lower of the two values that should be the final value.

        matrixIntersects[.interior, .interior] = finalInteriorInteriorDimension

        /// No intersection
        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ lineString: LineString, _ multipolygon: MultiPolygon) -> IntersectionMatrix {

        var matrixIntersects = IntersectionMatrix()

        /// Loop over the polygons and update the matrixIntersects struct as needed on each pass.

        var finalInteriorExteriorDimension: Dimension = .one
        for polygon in multipolygon {

            /// Get the relationship between the line string and the polygon
            let intersectionMatrixResult = generateIntersection(lineString, polygon)

            /// Update the intersection matrix as needed
            update(intersectionMatrixBase: &matrixIntersects, intersectionMatrixNew: intersectionMatrixResult)
            
            /// Update the temporary interior/exterior dimensions as needed
            if intersectionMatrixResult[.interior, .exterior] < finalInteriorExteriorDimension {
                finalInteriorExteriorDimension = intersectionMatrixResult[.interior, .exterior]
            }
        }

        /// There is a special case here: line string interior with multipolygon exterior.
        /// It's possible that the interior of the line string exists in one polygon but not another.
        /// In that case, the dimension of the interior/exterior would be one for one polygon and zero for the other.
        /// It is the lower of the two values that should be the final value.

        if matrixIntersects[.interior, .exterior] > finalInteriorExteriorDimension {
            matrixIntersects[.interior, .exterior] = finalInteriorExteriorDimension
        }

        /// There is a special case here: line string boundary with multipolygon exterior.
        /// It's possible that the boundary of the line string exists in two different polygons.
        /// We have to check for that case and fix it from the above calculations.

        guard let lineStringBoundary = lineString.boundary() as? MultiPoint else {
            return matrixIntersects
        }
        let boundaryMatrix = generateIntersection(lineStringBoundary, multipolygon)
        if boundaryMatrix[.boundary, .exterior] <  matrixIntersects[.boundary, .exterior] {
            matrixIntersects[.boundary, .exterior] = boundaryMatrix[.interior, .exterior]
        }

        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ linearRing: LinearRing, _ polygon: Polygon) -> IntersectionMatrix {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .two
        matrixIntersects[.exterior, .exterior] = .two

        /// Get the polygon boundary
        guard let polygonBoundary = polygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0,
            let outerLinearRing = polygonBoundary[0] as? LinearRing,
            outerLinearRing.count > 0 else {
                return matrixIntersects
        }
        
        /// Convert the polygon boundary to an array of linear rings
        let polygonBoundaryLinearRings = geometryCollectionToLinearRingArray(polygonBoundary)

        /// Check whether the linear ring is completely contained in the polygon boundary.
        /// If not, the exterior of the linear ring must intersect with the polygon boundary.
        let reducedLr  = reduce(linearRing)
        let reducedPB = reduce(polygonBoundaryLinearRings)
        if subset(reducedLr, reducedPB) {
            matrixIntersects[.interior, .boundary] = .one
            return matrixIntersects
        } else {
            matrixIntersects[.exterior, .boundary] = .one
        }

        /// From here on we know the linear ring is not completely contained in the polygon boundary

        var linearRingInsideMainPolygon = false /// Implies part of the linear ring lies inside the polygon
        
        var linearRingOutsideAllHoles = true /// Assume initially that the linear ring it outside all holes, assuming any holes exist

        /// Relate the linear ring to the main polygon and each of its holes
        var isMainPolygon = true
        for linearRingPolygon in polygonBoundaryLinearRings {

            let tempPolygon = Polygon(linearRingPolygon, precision: Floating(), coordinateSystem: Cartesian())

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
                /// Also, if there are no holes and the linear ring is inside the main polygon, the interiors overlap.
                if !linearRingInsideMainPolygon {
                    return matrixIntersects
                }

            } else {

                /// We will only consider cases here where the linear ring is inside the main polygon.
                /// If the linear ring touches only the main polygon boundary or is outside the main polygon,
                /// those cases have already been addressed.

                if linearRingRelatedToResult.firstTouchesSecondExterior == .empty {
                    linearRingOutsideAllHoles = false
                }

                if linearRingRelatedToResult.firstTouchesSecondBoundary > matrixIntersects[.interior, .boundary] {
                    matrixIntersects[.interior, .boundary] = linearRingRelatedToResult.firstTouchesSecondBoundary
                }

                if linearRingRelatedToResult.firstTouchesSecondInterior > matrixIntersects[.interior, .exterior] {
                    matrixIntersects[.interior, .exterior] = linearRingRelatedToResult.firstTouchesSecondInterior
                }
            }
        }
        
        if linearRingOutsideAllHoles {
            matrixIntersects[.interior, .interior] = .one
        }

        /// No intersection
        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ linearRing: LinearRing, _ multipolygon: MultiPolygon) -> IntersectionMatrix {

        var matrixIntersects = IntersectionMatrix()

        /// Loop over the polygons and update the matrixIntersects struct as needed on each pass.

        var finalInteriorExteriorDimension: Dimension = .one
        for polygon in multipolygon {

            /// Get the relationship between the linear ring and the polygon
            let intersectionMatrixResult = generateIntersection(linearRing, polygon)

            /// Update the intersection matrix as needed
            update(intersectionMatrixBase: &matrixIntersects, intersectionMatrixNew: intersectionMatrixResult)

            /// Update the  interior/exterior dimensions as needed
            if intersectionMatrixResult[.interior, .exterior] < finalInteriorExteriorDimension {
                finalInteriorExteriorDimension = intersectionMatrixResult[.interior, .exterior]
            }
        }

        /// There is a special case here: linear ring interior with multipolygon exterior.
        /// It's possible that the interior of the linear ring exists in one polygon but not another.
        /// In that case, the dimension of the interior/exterior would be one for one polygon and zero for the other.
        /// It is the lower of the two values that should be the final value.

        if matrixIntersects[.interior, .exterior] > finalInteriorExteriorDimension {
            matrixIntersects[.interior, .exterior] = finalInteriorExteriorDimension
        }

        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ multiLineString: MultiLineString, _ polygon: Polygon) -> IntersectionMatrix {

        /// Default intersection matrix
        var matrixIntersects = IntersectionMatrix()
        matrixIntersects[.exterior, .interior] = .two
        matrixIntersects[.exterior, .exterior] = .two

        /// Quick check for at least one non-empty line string in the multi line string
        var hasNonemptyLineString = false
        for lineString in multiLineString {

            if lineString.count > 0 {
                hasNonemptyLineString = true
                break
            }
        }
        if !hasNonemptyLineString {
            return matrixIntersects
        }

        /// Get the polygon boundary
        guard let polygonBoundary = polygon.boundary() as? GeometryCollection,
            polygonBoundary.count > 0,
            let outerLinearRing = polygonBoundary[0] as? LinearRing,
            outerLinearRing.count > 0 else {
                return matrixIntersects
        }

        /// Check whether the multi line string is completely contained in the polygon boundary
        let reducedMls  = reduce(multiLineString)
        let reducedPB = reduce(polygonBoundary)
        if subset(reducedMls, reducedPB) {
            matrixIntersects[.interior, .boundary] = .one
            matrixIntersects[.boundary, .boundary] = .zero
            return matrixIntersects
        }

        /// Check whether the polygon boundary is completely contained in the multi line string.
        /// If it is, this guarantees matrixIntersects[.exterior, .boundary] = .empty
        /// Note that because of the current definition of a multi line string not intersecting itself,
        /// a polygon boundary cannot be completely inside a multi line string.  Therefore, the subset test
        /// will be commented out, but possibly should be added in if that definition changes.
        matrixIntersects[.exterior, .boundary] = .one

        /// From here on we know the multi line string is not completely contained in the polygon boundary,
        /// and we know whether the polygon boundary is completely contained in the multi line string.

        /// Get the endpoints of the multi line string (the multi line string boundary) and their relationship to the polygon.
        /// Set some intersection matrix values depending on the result.

        guard let multiLineStringBoundary = multiLineString.boundary() as? MultiPoint else {
            return matrixIntersects
        }

        let multiLineStringBoundaryCoordindateTupleArray = multiPointToCoordinateTupleArray(multiLineStringBoundary, true)

        let boundaryCoordinatesRelatedToResult = relatedToGeneral(multiLineStringBoundaryCoordindateTupleArray, polygon)

        if boundaryCoordinatesRelatedToResult.firstBoundaryTouchesSecondInterior > .empty {
            matrixIntersects[.boundary, .interior] = boundaryCoordinatesRelatedToResult.firstBoundaryTouchesSecondInterior
        }

        if boundaryCoordinatesRelatedToResult.firstBoundaryTouchesSecondBoundary > .empty {
            matrixIntersects[.boundary, .boundary] = boundaryCoordinatesRelatedToResult.firstBoundaryTouchesSecondBoundary
        }

        if boundaryCoordinatesRelatedToResult.firstTouchesSecondExterior > .empty {
            matrixIntersects[.boundary, .exterior] = boundaryCoordinatesRelatedToResult.firstTouchesSecondExterior
        }

        var multiLineStringInsideMainPolygon = false /// Implies part of the multi line string lies inside the polygon

        /// Relate the multi line string to the main polygon.
        /// Collect an array of line strings that touch the interior of the main polygon
        /// that will be used to check against the holes.
        var interiorLineStrings = [LineString]()

        for lineString in multiLineString {

            guard lineString.count > 0 else {
                continue
            }

            let tempPolygon = Polygon(outerLinearRing, precision: Floating(), coordinateSystem: Cartesian())

            let lineStringRelatedToResult = relatedTo(lineString, tempPolygon)

            if lineStringRelatedToResult.firstTouchesSecondInterior > .empty {
                multiLineStringInsideMainPolygon = true
                interiorLineStrings.append(lineString)
            }

            if lineStringRelatedToResult.firstInteriorTouchesSecondBoundary > .empty {
                matrixIntersects[.interior, .boundary] = lineStringRelatedToResult.firstInteriorTouchesSecondBoundary
            }

            if lineStringRelatedToResult.firstTouchesSecondExterior == .one {
                matrixIntersects[.interior, .exterior] = .one
            }
        }

        /// If the multi line string does not touch the interior of the main polygon, we're done.
        if !multiLineStringInsideMainPolygon {
            return matrixIntersects
        }

        /// At least one line string touches the interior of the main linear ring.
        /// Relate each of the line strings that touch the interior of the main linear ring to each of its holes.
        var multiLineStringTouchesInterior = false
        let holesArray = holes(polygon)

        for lineString in interiorLineStrings {

            var lineStringTouchesInterior = true

            for linearRing in holesArray {

                guard linearRing.count > 0 else {
                    continue
                }

                let tempPolygon = Polygon(linearRing, precision: Floating(), coordinateSystem: Cartesian())

                let lineStringRelatedToResult = relatedTo(lineString, tempPolygon)

                if lineStringRelatedToResult.firstInteriorTouchesSecondBoundary > matrixIntersects[.interior, .boundary] {
                    matrixIntersects[.interior, .boundary] = lineStringRelatedToResult.firstInteriorTouchesSecondBoundary
                }

                if lineStringRelatedToResult.firstTouchesSecondInterior > matrixIntersects[.interior, .exterior] {
                    matrixIntersects[.interior, .exterior] = lineStringRelatedToResult.firstTouchesSecondInterior
                }

                if lineStringRelatedToResult.firstTouchesSecondExterior == .empty {
                    lineStringTouchesInterior = false
                }
            }

            multiLineStringTouchesInterior = multiLineStringTouchesInterior || lineStringTouchesInterior
        }

        /// We have to check whether the multi line string is completely contained in the main polygon and in a hole
        /// in order to set the interior, interior entry.
        if multiLineStringInsideMainPolygon {
            matrixIntersects[.interior, .interior] = (multiLineStringTouchesInterior ? .one : .empty)
        }

        /// Return
        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ multiLineString: MultiLineString, _ multipolygon: MultiPolygon) -> IntersectionMatrix {

        var matrixIntersects = IntersectionMatrix()

        /// Loop over the polygons and update the matrixIntersects struct as needed on each pass.

        var finalInteriorExteriorDimension: Dimension = .empty
        for lineString in multiLineString {
            var tempInteriorExteriorDimension: Dimension = .one
            for polygon in multipolygon {

                /// Get the relationship between the point and the polygon
                let intersectionMatrixResult = generateIntersection(lineString, polygon)

                /// Update the intersection matrix as needed
                update(intersectionMatrixBase: &matrixIntersects, intersectionMatrixNew: intersectionMatrixResult)

                /// Update the temporary interior/exterior dimensions as needed
                if intersectionMatrixResult[.interior, .exterior] < tempInteriorExteriorDimension {
                    tempInteriorExteriorDimension = intersectionMatrixResult[.interior, .exterior]
                }
            }
            /// Update the final interior/exterior dimensions as needed
            if finalInteriorExteriorDimension < tempInteriorExteriorDimension {
                finalInteriorExteriorDimension = tempInteriorExteriorDimension
            }
        }

        /// The boundary points of the multi line string could be distributed over multiple polygons.
        /// Check the boundary points and adjust accordingly.

        guard let multiLineStringBoundary = multiLineString.boundary() as? MultiPoint else {
            return matrixIntersects
        }

        let multiLineStringBoundaryCoordinateTupleArray = multiPointToCoordinateTupleArray(multiLineStringBoundary, true)

        let boundaryCoordinatesRelatedToResult = relatedTo(multiLineStringBoundaryCoordinateTupleArray, multipolygon)

        if boundaryCoordinatesRelatedToResult.firstBoundaryTouchesSecondExterior < matrixIntersects[.boundary, .exterior] {
            matrixIntersects[.boundary, .exterior] = boundaryCoordinatesRelatedToResult.firstBoundaryTouchesSecondExterior
        }
        
        /// There is a special case here: multi line string interior with multipolygon exterior.
        /// It's possible that the interior of the multi line string exists in one polygon but not another.
        /// In that case, the dimension of the interior/exterior would be one for one polygon and empty for the other.
        /// It is the lower of the two values that should be the final value.

        if matrixIntersects[.interior, .exterior] > finalInteriorExteriorDimension {
            matrixIntersects[.interior, .exterior] = finalInteriorExteriorDimension
        }

        return matrixIntersects
    }

    ///
    /// Dimension .two and dimension .two
    ///

    fileprivate static func generateIntersection(_ polygon1: Polygon, _ polygon2: Polygon) -> IntersectionMatrix {

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
        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ polygon: Polygon, _ multipolygon: MultiPolygon) -> IntersectionMatrix {

        var matrixIntersects = IntersectionMatrix()

        /// Loop over the polygons and update the matrixIntersects struct as needed on each pass.

        var finalInteriorExteriorDimension: Dimension = .two
        var finalBoundaryExteriorDimension: Dimension = .one
        for polygonFromMP in multipolygon {

            /// Get the relationship between the point and the polygon
            let intersectionMatrixResult = generateIntersection(polygon, polygonFromMP)

            /// Update the intersection matrix as needed
            update(intersectionMatrixBase: &matrixIntersects, intersectionMatrixNew: intersectionMatrixResult)

            /// Update the  interior/exterior dimensions as needed
            if intersectionMatrixResult[.interior, .exterior] < finalInteriorExteriorDimension {
                finalInteriorExteriorDimension = intersectionMatrixResult[.interior, .exterior]
            }

            /// Update the  boundary/exterior dimensions as needed
            if intersectionMatrixResult[.boundary, .exterior] < finalBoundaryExteriorDimension {
                finalBoundaryExteriorDimension = intersectionMatrixResult[.boundary, .exterior]
            }
        }

        /// There is a special case here: polygon interior with multipolygon exterior.
        /// It's possible that the interior of the polygon exists in one polygon of the multi polygon but not another.
        /// In that case, the dimension of the interior/exterior would be two for one polygon and zero for the other.
        /// It is the lower of the two values that should be the final value.

        if matrixIntersects[.interior, .exterior] > finalInteriorExteriorDimension {
            matrixIntersects[.interior, .exterior] = finalInteriorExteriorDimension
        }

        /// There is a special case here: polygon boundary with multipolygon exterior.
        /// It's possible that the boundary of the polygon exists in one polygon of the multi polygon but not another.
        /// In that case, the dimension of the boundary/exterior would be one for one polygon and zero for the other.
        /// It is the lower of the two values that should be the final value.

        if matrixIntersects[.boundary, .exterior] > finalBoundaryExteriorDimension {
            matrixIntersects[.boundary, .exterior] = finalBoundaryExteriorDimension
        }

        return matrixIntersects
    }

    fileprivate static func generateIntersection(_ multipolygon1: MultiPolygon, _ multipolygon2: MultiPolygon) -> IntersectionMatrix {

        var matrixIntersects = IntersectionMatrix()

        /// Loop over the polygons and update the matrixIntersects struct as needed on each pass.

        var finalInteriorExteriorDimension: Dimension = .empty
        var finalBoundaryExteriorDimension: Dimension = .empty
        var finalExteriorInteriorDimension: Dimension = .empty
        var finalExteriorBoundaryDimension: Dimension = .empty
        for polygon1 in multipolygon1 {

            var tempInteriorExteriorDimension: Dimension = .two
            var tempBoundaryExteriorDimension: Dimension = .one
            var tempExteriorInteriorDimension: Dimension = .two
            var tempExteriorBoundaryDimension: Dimension = .one

            for polygon2 in multipolygon2 {

                /// Get the relationship between the point and the polygon
                let intersectionMatrixResult = generateIntersection(polygon1, polygon2)

                /// Update the intersection matrix as needed
                update(intersectionMatrixBase: &matrixIntersects, intersectionMatrixNew: intersectionMatrixResult)

                /// Update the  interior/exterior dimension as needed
                if intersectionMatrixResult[.interior, .exterior] < tempInteriorExteriorDimension {
                    tempInteriorExteriorDimension = intersectionMatrixResult[.interior, .exterior]
                }

                /// Update the  boundary/exterior dimension as needed
                if intersectionMatrixResult[.boundary, .exterior] < tempBoundaryExteriorDimension {
                    tempBoundaryExteriorDimension = intersectionMatrixResult[.boundary, .exterior]
                }

                /// Update the  exterior/interior dimension as needed
                if intersectionMatrixResult[.exterior, .interior] < tempExteriorInteriorDimension {
                    tempExteriorInteriorDimension = intersectionMatrixResult[.exterior, .interior]
                }

                /// Update the  exterior/boundary dimension as needed
                if intersectionMatrixResult[.exterior, .boundary] < tempExteriorBoundaryDimension {
                    tempExteriorBoundaryDimension = intersectionMatrixResult[.exterior, .boundary]
                }
            }

            /// Update the  interior/exterior dimension as needed
            if finalInteriorExteriorDimension < tempInteriorExteriorDimension {
                finalInteriorExteriorDimension = tempInteriorExteriorDimension
            }

            /// Update the  boundary/exterior dimension as needed
            if finalBoundaryExteriorDimension < tempBoundaryExteriorDimension {
                finalBoundaryExteriorDimension = tempBoundaryExteriorDimension
            }

            /// Update the  exterior/interior dimension as needed
            if finalExteriorInteriorDimension < tempExteriorInteriorDimension {
                finalExteriorInteriorDimension = tempExteriorInteriorDimension
            }

            /// Update the  exterior/boundary dimension as needed
            if finalExteriorBoundaryDimension < tempExteriorBoundaryDimension {
                finalExteriorBoundaryDimension = tempExteriorBoundaryDimension
            }
        }

        /// There is a special case here: multipolygon interior with multipolygon exterior.
        /// It's possible that the interior of a polygon in the first multipolygon exists in one polygon of the second multipolygon but not another.
        /// In that case, the dimension of the interior/exterior would be two for one polygon and zero for the other.
        /// It is the lower of the two values that should be the final value.

        if matrixIntersects[.interior, .exterior] > finalInteriorExteriorDimension {
            matrixIntersects[.interior, .exterior] = finalInteriorExteriorDimension
        }

        /// There is a special case here: multipolygon boundary with multipolygon exterior.
        /// It's possible that the boundary of a polygon in the first multipolygon exists in one polygon of the second multipolygon but not another.
        /// In that case, the dimension of the boundary/exterior would be one for one polygon and zero for the other.
        /// It is the lower of the two values that should be the final value.

        if matrixIntersects[.boundary, .exterior] > finalBoundaryExteriorDimension {
            matrixIntersects[.boundary, .exterior] = finalBoundaryExteriorDimension
        }

        /// There is a special case here: multipolygon exterior with multipolygon interior.
        /// It's possible that the interior of a polygon in the first multipolygon exists in one polygon of the second multipolygon but not another.
        /// In that case, the dimension of the exterior/interior would be two for one polygon and zero for the other.
        /// It is the lower of the two values that should be the final value.

        if matrixIntersects[.exterior, .interior] > finalExteriorInteriorDimension {
            matrixIntersects[.exterior, .interior] = finalExteriorInteriorDimension
        }

        /// There is a special case here: multipolygon boundary with multipolygon exterior.
        /// It's possible that the boundary of a polygon in the first multipolygon exists in one polygon of the second multipolygon but not another.
        /// In that case, the dimension of the boundary/exterior would be one for one polygon and zero for the other.
        /// It is the lower of the two values that should be the final value.

        if matrixIntersects[.exterior, .boundary] > finalExteriorBoundaryDimension {
            matrixIntersects[.exterior, .boundary] = finalExteriorBoundaryDimension
        }

        return matrixIntersects
    }
}
