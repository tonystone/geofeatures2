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
    case none = 0, firstInSecond, secondInFirst, identical
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

                /// The IM for the two disjoint geometries of dimension .zero is FF0FFF0F2.
                /// The IM for two dimension .zero geometries intersecting at a set of points is either 0F0FFF0F2,
                /// if neither geometry is a subset of the other, 0FFFFF0F2, if the first geometry is a proper subset of the second,
                /// 0F0FFFFF2, if the second geometry is a proper subset of the first, and FFFFFFFF2, if the two sets of points are identical.

                let (resultGeometry, resultSubset) = intersectionGeometry(geometry1, geometry2)

                if intersectionGeometry != nil {

                    switch resultSubset {
                    case .none:
                        /// 0F0FFF0F2
                        return IntersectionMatrix(arrayLiteral: [
                            [.zero,  .empty, .zero],
                            [.empty, .empty, .empty],
                            [.zero,  .empty, .two]
                        ])
                    case .firstInSecond:
                        /// 0FFFFF0F2
                        return IntersectionMatrix(arrayLiteral: [
                            [.zero,  .empty, .empty],
                            [.empty, .empty, .empty],
                            [.zero,  .empty, .two]
                            ])
                    case .secondInFirst:
                        /// 0F0FFFFF2
                        return IntersectionMatrix(arrayLiteral: [
                            [.zero,  .empty, .zero],
                            [.empty, .empty, .empty],
                            [.empty, .empty, .two]
                            ])
                    case .identical:
                        /// FFFFFFFF2
                        return IntersectionMatrix(arrayLiteral: [
                            [.empty, .empty, .empty],
                            [.empty, .empty, .empty],
                            [.empty, .empty, .two]
                            ])
                    }

                } else {
                    /// Disjoint geometries, FF0FFF0F2
                    return IntersectionMatrix(arrayLiteral: [
                        [.empty, .empty, .zero],
                        [.empty, .empty, .empty],
                        [.zero,  .empty, .two]
                    ])
                }

            case .one: break
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
    fileprivate static func intersectionGeometry(_ geometry1: Geometry, _ geometry2: Geometry) -> (Geometry?, Subset) {

        switch geometry1.dimension {

        /// The interior of a geometry of dimension zero is the geometry itself.
        case .zero:

            switch geometry2.dimension {

            case .zero:
                /// For the intersection of two geometries of dimension .zero,
                /// it would be nice to use a Set here, then we could use the built-in Swift functions to simplify the code.
                /// We may need to make Point and MultiPoint hashable to do that.

                if let point1 = self as? Point<CoordinateType>, let point2 = geometry2 as? Point<CoordinateType> {
                    generateIntersection(point1, point2)
                } else if let point = geometry1 as? Point<CoordinateType>, let points = geometry2 as? MultiPoint<CoordinateType> {
                    return generateIntersection(points, point)
                } else if let points = geometry1 as? MultiPoint<CoordinateType>, let point = geometry2 as? Point<CoordinateType> {
                    return generateIntersection(points, point)
                } else if let points1 = geometry1 as? MultiPoint<CoordinateType>, let points2 = geometry2 as? Point<CoordinateType> {
                    return generateIntersection(points1, points2)
                }
            case .one: break
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

        return (nil, .none)
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

    fileprivate func generateIntersection(_ points1: MultiPoint<CoordinateType>, _ points2: MultiPoint<CoordinateType>) -> (Geometry?, Subset) {

        /// Should use Set here, if possible.
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
            return (multiPointIntersection, .identical)
        case (false, true):
            return (multiPointIntersection, .firstInSecond)
        case (true, false):
            return (multiPointIntersection, .secondInFirst)
        case (true, true):
            return (multiPointIntersection, .none)
        }
    }
}
