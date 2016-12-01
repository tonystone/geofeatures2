///
///  LineString+Geometry.swift
///
///  Copyright (c) 2016 Tony Stone
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
///  Created by Tony Stone on 2/15/2016.
///
import Swift

extension LineString: Geometry {

    public var dimension: Dimension { return .one }

    public func isEmpty() -> Bool {
        return self.count == 0
    }

    ///
    /// Given three colinear points p, q, r, the function checks if
    /// point q lies on line segment 'pr'.
    ///
    internal
    func onSegment(_ p: Point<CoordinateType>, _ q: Point<CoordinateType>, _ r: Point<CoordinateType>) -> Bool {
        if q.x <= Swift.max(p.x, r.x) && q.x >= Swift.min(p.x, r.x) && q.y <= Swift.max(p.y, r.y) && q.y >= Swift.min(p.y, r.y) {
            return true
        }

        return false
    }

    ///
    /// To find the orientation of an ordered triplet of Points, (p, q, r).
    /// The function returns the following values:
    /// 0 --> p, q and r are colinear
    /// 1 --> Clockwise
    /// 2 --> Counterclockwise
    ///
    internal
    func orientation(_ p: Point<CoordinateType>, _ q: Point<CoordinateType>, _ r: Point<CoordinateType>) -> Int {
        // See http://www.geeksforgeeks.org/orientation-3-ordered-points/ for details of the formula below.
        let value = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)

        if value == 0 { return 0 }  // colinear // TODO: May want to check if "value" is near 0 because it is a Double

        return (value > 0) ? 1 : 2 // clockwise or counterclockwise
    }

    ///
    /// Returns true if line segment 'p1q1' and 'p2q2' intersect.
    ///
    /// lastFirstOk set to true means its okay that q1 and p2 are the same point. This will be ignored for the intersection calculation.
    /// This will happen commonly in a LinearString.
    ///
    /// firstLastOk set to true means its okay that p1 and q2 are the same point. This will be ignored for the intersection calculation.
    /// This will happen commonly in a LinearRing.
    ///
    internal
    func segmentsIntersect(_ p1: Point<CoordinateType>, _ q1: Point<CoordinateType>, _ p2: Point<CoordinateType>, _ q2: Point<CoordinateType>, _ lastFirstOk: Bool = false, _ firstLastOk: Bool = false) -> Bool {

        // Find the four orientations needed for general and special cases
        let o1 = orientation(p1, q1, p2) // 0 = if q1 = p2 true
        let o2 = orientation(p1, q1, q2) // 0 = if p1 = q2 true
        let o3 = orientation(p2, q2, p1) // 0 = if p1 = q2 true
        let o4 = orientation(p2, q2, q1) // 0 = if q1 = p2 true

        // Points touch cases
        // q1 and p2 are the same point.
        if q1 == p2 {
            let onLineSegment1 = (o3 == 0 && onSegment(p2, p1, q2))
            let onLineSegment2 = (o2 == 0 && onSegment(p1, q2, q1))
            return (!lastFirstOk || onLineSegment1 || onLineSegment2)
        }

        // p1 and q2 are the same point.
        if p1 == q2 {
            let onLineSegment1 = (o4 == 0 && onSegment(p2, q1, q2))
            let onLineSegment2 = (o1 == 0 && onSegment(p1, p2, q1))
            return (!firstLastOk || onLineSegment1 || onLineSegment2)
        }

        // General case
        if o1 != o2 && o3 != o4 {
            return true
        }

        // Special cases
        // p1, q1 and p2 are colinear and p2 lies on segment p1q1
        if o1 == 0 && onSegment(p1, p2, q1) { return true }

        // p1, q1 and p2 are colinear and q2 lies on segment p1q1
        if o2 == 0 && onSegment(p1, q2, q1) { return true }

        // p2, q2 and p1 are colinear and p1 lies on segment p2q2
        if o3 == 0 && onSegment(p2, p1, q2) { return true }

        // p2, q2 and q1 are colinear and q1 lies on segment p2q2
        if o4 == 0 && onSegment(p2, q1, q2) { return true }

        return false // Doesn't fall in any of the above cases
    }

    ///
    /// Determine whether this LineString is considered simple.
    ///
    /// A LineString is simple if no two lines segments share a common point,
    /// other than the common endpoint they naturally share.
    ///
    /// It is also acceptable that the very first point and the last point are the same,
    /// in the case of a LinearRing, assuming there are at least three segments.
    ///
    /// The algorithm used to do the calculation is a modified form of the one found here:
    /// http://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
    ///
    public
    func isSimple() -> Bool {
        return buffer.withUnsafeMutablePointers { (header, elements) -> Bool in

            // If there are no more than two coordinates, there can be at most one line segment,
            // so this line segment cannot self-intersect.
            guard header.pointee.count > 2 else {
                return true
            }

            // There must be at least two line segments to get to this point.
            for i in 0..<header.pointee.count - 2 {
                let p1 = Point<CoordinateType>(coordinate: elements[i], precision: self.precision, coordinateSystem: self.coordinateSystem)
                let q1 = Point<CoordinateType>(coordinate: elements[i+1], precision: self.precision, coordinateSystem: self.coordinateSystem)
                for j in (i+1)..<header.pointee.count - 1 {
                    let p2 = Point<CoordinateType>(coordinate: elements[j], precision: self.precision, coordinateSystem: self.coordinateSystem)
                    let q2 = Point<CoordinateType>(coordinate: elements[j+1], precision: self.precision, coordinateSystem: self.coordinateSystem)
                    var intersect: Bool = false
                    if j == i+1 {
                        intersect = segmentsIntersect(p1, q1, p2, q2, true)
                    } else if i == 0 && j == header.pointee.count - 2 {
                        intersect = segmentsIntersect(p1, q1, p2, q2, false, true)
                    } else {
                        intersect = segmentsIntersect(p1, q1, p2, q2)
                    }
                    if intersect { return false }
                }

            }

            return true
        }
    }

    /**
     - Returns: the closure of the combinatorial boundary of this Geometry instance.

     - Note: The boundary of a LineString if empty is the empty MultiPoint. If not empty it is the first and last point.
     */

    public func boundary() -> Geometry {

        return self.buffer.withUnsafeMutablePointers { (header, elements) -> Geometry in

            var multiPoint = MultiPoint<CoordinateType>(precision: self.precision, coordinateSystem: self.coordinateSystem)

            if !self.isClosed() && header.pointee.count >= 2 {

                // Note: direct subscripts protected by self.count >= 2 above.
                multiPoint.append(Point<CoordinateType>(coordinate: elements[0], precision: self.precision, coordinateSystem: self.coordinateSystem))
                multiPoint.append(Point<CoordinateType>(coordinate: elements[header.pointee.count - 1], precision: self.precision, coordinateSystem: self.coordinateSystem))

            }
            return multiPoint
        }
    }

    public func equals(_ other: Geometry) -> Bool {
        if let other = other as? LineString<Element> {
            return self.elementsEqual(other, by: { (lhs: Element, rhs: Element) -> Bool in
                return lhs == rhs
            })
        }
        return false
    }
}
