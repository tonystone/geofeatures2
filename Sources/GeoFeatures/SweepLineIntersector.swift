///
///  SweepLineIntersector.swift
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
///  Created by Tony Stone on 12/17/16.
///
import Swift

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

///
/// SweepLineSegment is Comparable so it can be added to a b-tree and searched.
///
extension SweepLineSegment: Comparable {} /// TODO: Swift 4: where CoordinateType: Equatable

fileprivate func == <CoordinateType: Coordinate & CopyConstructable>(lhs: SweepLineSegment<CoordinateType>, rhs: SweepLineSegment<CoordinateType>) -> Bool {
    return lhs.leftCoordinate == rhs.leftCoordinate && lhs.rightCoordinate == rhs.rightCoordinate
}

fileprivate func < <CoordinateType: Coordinate & CopyConstructable>(lhs: SweepLineSegment<CoordinateType>, rhs: SweepLineSegment<CoordinateType>) -> Bool {
    return false /// TODO implement
}

///
/// Implementation of a SweepLine structure
///
internal class SweepLineIntersector<CoordinateType: Coordinate & CopyConstructable & _ArrayConstructable>: Intersector {

    fileprivate typealias SegmentType = SweepLineSegment<CoordinateType>

    public func intersects(coordinates: [CoordinateType]) -> Bool {
        return false
    }

    public func intersections(coordinates: [CoordinateType]) -> [CoordinateType] {

        ///
        /// Create an EventQueue from the coordinates which will be sorted  by increasing x and y
        ///
        var events: EventQueue<CoordinateType>   = EventQueue(coordinates: coordinates)

        ///
        /// The SweepLine will keep track of our position
        ///
        var sweepLine: AVLTree<SegmentType> = AVLTree()

        ///
        /// Intersections will contain all the intersection points found
        ///
        var intersections: [CoordinateType] = []

        ///
        /// While there are events in the queue, test each
        /// with their neighbors for intersections
        ///
        while let event = events.next() {

            if let event = event as? LeftEvent {
                ///
                /// Create a segment from the left and right edges of this event
                ///
                let segmentEvent = SweepLineSegment(leftEvent: event)

                /// Add it to the `SweepLine`
                let segmentEventNode = sweepLine.insert(value: segmentEvent)

                ///
                /// Find the segment above and below this one in the `SweepLine`
                ///
                let segmentAbove = sweepLine.previous(node: segmentEventNode)?.value
                let segmentBelow = sweepLine.next    (node: segmentEventNode)?.value

                ///
                /// If the  event segment intersects with the segment above or below the event,
                /// add the new intersection event to the event queue.
                ///
                if let intersectionEvent = self.intersection(segment: segmentEvent, other: segmentAbove) {
                    events.insert(event: intersectionEvent)
                }
                if let intersectionEvent = self.intersection(segment: segmentEvent, other: segmentBelow) {
                    events.insert(event: intersectionEvent)
                }

            } else if let event = event as? RightEvent {

                /// TODO

            } else if let event = event as? IntersectionEvent {

                /// TODO

            }
            events.delete(event: event)
        }
        return intersections
    }

    public func intersectionMatrix(coordinates: [CoordinateType]) -> IntersectionMatrix {
        return IntersectionMatrix()
    }
}

fileprivate extension SweepLineIntersector {

    ///
    /// 2x2 Determinant
    ///
    /// | a b |
    /// | c d |
    ///
    /// Returns a value of ad - bc
    ///
    fileprivate func det2d(a: Double, b: Double, c: Double, d: Double) -> Double {
        return a*d - b*c
    }

    ///
    /// Returns a numeric value indicating where point p2 is relative to the line determined by p0 and p1.
    /// value > 0 implies p2 is on the left
    /// value = 0 implies p2 is on the line
    /// value < 0 implies p2 is to the right
    ///
    fileprivate func isLeft(p0: CoordinateType, p1: CoordinateType, p2: CoordinateType) -> Double {
        return (p1.x - p0.x)*(p2.y - p0.y) - (p2.x - p0.x)*(p1.y -  p0.y)
    }

    fileprivate func intersection(segment: SegmentType?, other: SegmentType?) -> IntersectionEvent<CoordinateType>? {

        ///
        /// There is no intersection if one of the values is nil
        ///
        guard let segment = segment, let other = other else {
            return nil
        }

        ///
        /// For now we will ignore intersections that occur at just the endpoints.
        /// We will also ignore the case where the two lines segments overlap for a non-zero distance.
        /// TODO: These assumptions will need to be handled later.
        ///
        /// For now we will return a single point of intersection, assuming that point occurs between the
        /// endpoints of at least one segment.
        ///
        guard segment.leftCoordinate != other.rightCoordinate && segment.rightCoordinate != other.leftCoordinate else {
            return nil
        }

        ///
        /// Check whether the two segments intersect.
        /// The two segments will intersect if and only if the signs of the isLeft function are non-zero and are different for both segments.
        /// This means one segment cannot be completely on one side of the other.
        ///
        /// TODO: We will need to separate out the = 0 cases below because these imply the segments fall on the same line.
        ///
        var leftSign  = isLeft(p0: segment.leftCoordinate, p1: segment.rightCoordinate, p2: other.leftCoordinate)
        var rightSign = isLeft(p0: segment.leftCoordinate, p1: segment.rightCoordinate, p2: other.rightCoordinate)
        if leftSign * rightSign >= 0 {
            return nil
        }

        leftSign  = isLeft(p0: other.leftCoordinate, p1: other.rightCoordinate, p2: segment.leftCoordinate)
        rightSign = isLeft(p0: other.leftCoordinate, p1: other.rightCoordinate, p2: segment.rightCoordinate)
        if leftSign * rightSign >= 0 {
            return nil
        }

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
            return nil
        }

        let x = numx / den
        let y = numy / den

        return IntersectionEvent(coordinate: try CoordinateType(array: [x, y]))
    }
}
