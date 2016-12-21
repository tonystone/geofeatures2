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
internal class SweepLineIntersector<CoordinateType: Coordinate & CopyConstructable>: Intersector {

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
