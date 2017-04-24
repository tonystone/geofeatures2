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
/// Implementation of a SweepLine structure
///
internal class SweepLineIntersector<CoordinateType: Coordinate & CopyConstructable>: Intersector {

    fileprivate typealias SegmentType = SweepLineSegment<CoordinateType>

    public func intersects(coordinates: [CoordinateType]) -> Bool {
        return false
    }

    public func intersections(coordinates: [CoordinateType]) -> [CoordinateType] {

        ///
        /// Create an EventQueue from the coordinates which will be sorted  by increasing x and y
        ///
        var events = EventQueue<CoordinateType>(coordinates: coordinates)

        ///
        /// The SweepLine will keep track of our position
        ///
        var sweepLine = SweepLine<CoordinateType>()

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

                /// Add it to the `SweepLine`
                let segment = sweepLine.insert(event: event)

                ///
                /// If the  event segment intersects with the segment above or below the event,
                /// add the new intersection event to the event queue.
                ///
                if let intersectionEvent = self.intersection(segment: segment, other: segment.above) {
                    events.insert(event: intersectionEvent)
                }
                if let intersectionEvent = self.intersection(segment: segment, other: segment.below) {
                    events.insert(event: intersectionEvent)
                }

            } else if let event = event as? RightEvent {

                ///
                /// Find the segment in the Sweepline based on the LeftEvent of this RightEvent
                ///
                if let segment = sweepLine.search(event: event) {

                    ///
                    /// Check for intersection between above and below segments
                    /// and add an intersection Event if they intersect
                    ///
                    if let intersectionEvent = self.intersection(segment: segment.above, other: segment.below) {
                        events.insert(event: intersectionEvent)
                    }

                    /// Delete segment event from the sweepline
                    sweepLine.delete(segment: segment)
                }
            } else if let event = event as? IntersectionEvent {

                /// Add the events coordinate to the intersection list results
                intersections.append(event.coordinate)

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

    fileprivate func intersection(segment: SegmentType?, other: SegmentType?) -> IntersectionEvent<CoordinateType>? {

        ///
        /// There is no intersection if one of the values is nil
        ///
        guard let segment = segment, let other = other else {
            return nil
        }

        return nil
    }
}

///
/// Low level type to represent a segment of a line used in computation of the Sweepline
///
fileprivate class SweepLineSegment<CoordinateType: Coordinate & CopyConstructable>: Segment<CoordinateType> {

    public var above: SweepLineSegment<CoordinateType>? = nil
    public var below: SweepLineSegment<CoordinateType>? = nil

    init(leftEvent: LeftEvent<CoordinateType>) {
        super.init(left: leftEvent.coordinate, right: leftEvent.rightEvent.coordinate)
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
/// SweepLine Implementation
///
fileprivate class SweepLine<CoordinateType: Coordinate & CopyConstructable> {

    private let segments: AVLTree<SweepLineSegment<CoordinateType>> = AVLTree()

    public func insert(event: LeftEvent<CoordinateType>) ->SweepLineSegment<CoordinateType> {
        ///
        /// Create a segment from the left and right edges of this event
        ///
        let segment = SweepLineSegment(leftEvent: event)

        let node = segments.insert(value: segment)

        ///
        /// Maintain the current above and below segment links
        /// for all three segments involved, the current segment
        /// we just created and the above and below segments
        /// which the current segment will be placed in the
        /// middle of.
        ///
        segment.above = segments.previous(node: node)?.value
        segment.above?.below = segment

        segment.below = segments.next(node: node)?.value
        segment.below?.above = segment

        return segment
    }

    public func search(event: RightEvent<CoordinateType>) -> SweepLineSegment<CoordinateType>? {
        return nil
    }

    public func delete(segment: SweepLineSegment<CoordinateType>) {}
}
