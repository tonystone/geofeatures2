///
///  EventQueue.swift
///
///  
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
///  Created by Tony Stone on 12/4/16.
///
import Swift

///
/// Implementation of an EventQueue
///
internal class Event<CoordinateType: Coordinate & CopyConstructable>: Comparable {

    ///
    /// Left Edge will contain the left edge event that makes up
    /// the start and end coordinates in a segment.  If left
    /// edge is nil, this is the first coordinate in the geometry.
    ///
    /// If neither left or right edge is set, this is an intersection
    /// event.
    ///
    public internal(set) var leftEdge: Event<CoordinateType>?   = nil
    ///
    /// Right edge will contain the right edge event that makes up
    /// the start (left) and end (right) coordinates in a segment.
    /// If right is nil, this is the last coordinate in the geometry.
    ///
    /// If neither left or right edge is set, this is an intersection
    /// event.
    ///
    public internal(set) weak var rightEdge: Event<CoordinateType>?  = nil

    ///
    /// The coordinate for this event.
    ///
    public internal(set) var coordinate: CoordinateType

    init(coordinate: CoordinateType) {
        self.coordinate = coordinate
    }
}
internal func == <CoordinateType: Coordinate & CopyConstructable>(rhs: Event<CoordinateType>, lhs: Event<CoordinateType>) -> Bool {
    return rhs.coordinate == lhs.coordinate
}
internal func < <CoordinateType: Coordinate & CopyConstructable>(rhs: Event<CoordinateType>, lhs: Event<CoordinateType>) -> Bool {
    ///
    /// if p and q are two event points then we
    /// have p ≺ q if and only if py > qy holds
    /// or py = qy and px < qx holds.
    ///
    if rhs.coordinate.y > lhs.coordinate.y {
        return true
    }
    return rhs.coordinate.y == lhs.coordinate.y && rhs.coordinate.x < lhs.coordinate.x
}

///
/// A queue for Coordinate events.
///
internal class EventQueue<CoordinateType: Coordinate & CopyConstructable> {

    public typealias EventType = Event<CoordinateType>

    private var events = AVLTree<EventType>()
    private var nextNode: AVLTree<EventType>.NodeType? = nil

    public init<C: Swift.Collection>(coordinates: C)
            where C.Iterator.Element == CoordinateType {

        ///
        /// Iterate over all the coordinates
        /// creating events that represent left
        /// and right edges of the segment.
        ///
        var iterator = coordinates.makeIterator()

        /// Get the first left edge coordinate
        if let leftCoordinate = iterator.next() {

            /// Create an event from it
            var leftEvent = EventType(coordinate: leftCoordinate)
            self.events.insert(value: leftEvent)

            while let rightCoordinate = iterator.next() {
                let rightEvent = EventType(coordinate: rightCoordinate)

                /// Set the edge pointers
                leftEvent.rightEdge = rightEvent
                rightEvent.leftEdge = leftEvent

                /// old right becomes new left
                leftEvent = rightEvent

                self.events.insert(value: rightEvent)
            }
        }
    }

    ///
    /// Insert a new Event
    ///
    public func insert(event: EventType) {
        self.events.insert(value: event)
    }
    ///
    /// Returns the next event on the queue
    ///
    public func next() -> EventType? {

        if let next = self.nextNode {

            self.nextNode = self.events.next(node: next)

            return next.value
        }
        return nil
    }
}
