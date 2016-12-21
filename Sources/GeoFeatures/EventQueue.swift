///
///  EventQueue.swift
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
///  Created by Tony Stone on 12/4/16.
///
import Swift

///
/// In order to allow for a `LeftEvent`, `RightEvent` and
/// `IntersectionEvent` with the same Coordinate value to be
/// stored the types order is considered in the comparison.
///
/// These defines determine the final sort order when the
/// Coordinate values are equal.
///
/// `LeftEvent`s come before `RightEvent`s which come before
/// `IntersectionEvent`s in the sort order.
///
fileprivate enum EventTypeOrder: Int {
    case right = 1
    case left  = 2
    case intersection = 3
}

///
/// Left `Event` type.
///
/// - Parameter CoordinateType: The coordinate type that is stored in this `'Event` type.
///
internal class LeftEvent<CoordinateType: Coordinate & CopyConstructable>: Event<CoordinateType> {

    ///
    /// rightEvent will contain the right edge event that makes up
    /// the start (left) and end (right) coordinates in a segment.
    ///
    public internal(set) var rightEvent: RightEvent<CoordinateType>

    public init(coordinate: CoordinateType, rightEvent: RightEvent<CoordinateType>) {

        self.rightEvent = rightEvent

        super.init(coordinate: coordinate)

        rightEvent.leftEvent = self
    }

    fileprivate override var order: Int { return EventTypeOrder.left.rawValue }
}

///
/// Right `Event` type.
///
/// - Parameter CoordinateType: The coordinate type that is stored in this `'Event` type.
///
internal class RightEvent<CoordinateType: Coordinate & CopyConstructable>: Event<CoordinateType> {

    ///
    /// leftEvent will contain the left edge event that makes up
    /// the start (left) and end (right) coordinates in a segment.
    ///
    public internal(set) weak var leftEvent: Event<CoordinateType>? = nil

    public override init(coordinate: CoordinateType) {
        super.init(coordinate: coordinate)
    }

    fileprivate override var order: Int { return EventTypeOrder.right.rawValue }
}

///
/// Intersection `Event` type.
///
/// - Parameter CoordinateType: The coordinate type that is stored in this `'Event` type.
///
internal class IntersectionEvent<CoordinateType: Coordinate & CopyConstructable>: Event<CoordinateType> {

    public override init(coordinate: CoordinateType) {
        super.init(coordinate: coordinate)
    }
}

///
/// Sudo abstract base class implemented by Event types
///
/// - Parameter CoordinateType: The coordinate type that is stored in this `'Event` type.
///
internal class Event<CoordinateType: Coordinate & CopyConstructable> {

    ///
    /// The coordinate for this event.
    ///
    public internal(set) var coordinate: CoordinateType

    ///
    /// This is an abstract class so this method can only be called from a super class.
    ///
    fileprivate init(coordinate: CoordinateType) {
        self.coordinate = coordinate
    }

    fileprivate var order: Int { return EventTypeOrder.intersection.rawValue }
}

///
/// `Event` types must be comparable so they can be sorted or stored in the proper
///  order and that order is determined by the `==` and `<` below.
///
extension Event: Comparable {}

internal func == <CoordinateType: Coordinate & CopyConstructable>(lhs: Event<CoordinateType>, rhs: Event<CoordinateType>) -> Bool {
    return lhs.coordinate == rhs.coordinate && lhs.order == rhs.order
}

internal func < <CoordinateType: Coordinate & CopyConstructable>(lhs: Event<CoordinateType>, rhs: Event<CoordinateType>) -> Bool {
    ///
    /// if p and q are two event points then we
    /// have p ≺ q if and only if py > qy holds
    /// or py = qy and px < qx holds.
    ///
    if lhs.coordinate.y > rhs.coordinate.y {
        return true
    }

    if lhs.coordinate.y == rhs.coordinate.y {
        if lhs.coordinate.x == rhs.coordinate.x {

            return lhs.order < rhs.order

        } else if lhs.coordinate.x < rhs.coordinate.x {

            return true
        }
    }
    return false
}

///
/// An `EventQueue` is an ordered queue for Coordinate `Event`s.  `Event`s are inserted into the queue in sorted order and pulled off the queue from the min value to max value order.
///
/// - Parameter CoordinateType: The coordinate type that is stored in the `'Event` types stored in this `EventQueue`.
///
internal class EventQueue<CoordinateType: Coordinate & CopyConstructable> {

    public typealias EventType = Event<CoordinateType>

    private var events = AVLTree<EventType>()

    ///
    /// Initialize a new instance of `EventQueue` with a collection of `CoordinateType`.
    ///
    /// - Parameter coordinates: Any Swift.Collection including Array as long as it has an Element type equal the `CoordinateType`.
    ///
    public init<C: Swift.Collection>(coordinates: C)
            where C.Iterator.Element == CoordinateType {

        ///
        /// Iterate over all the coordinates
        /// creating events that represent left
        /// and right edges of the segment.
        ///
        var iterator = coordinates.makeIterator()

        /// Get the first left edge coordinate
        if var leftCoordinate = iterator.next() {

            while let rightCoordinate = iterator.next() {

                let rightEvent = RightEvent(coordinate: rightCoordinate)
                let leftEvent  = LeftEvent (coordinate: leftCoordinate, rightEvent: rightEvent)

                self.events.insert(value: leftEvent)
                self.events.insert(value: rightEvent)

                /// old right becomes new left
                leftCoordinate = rightCoordinate
            }
        }
    }

    ///
    /// Insert a new `Event`
    ///
    /// - Parameter event: The `Event` to insert into the queue.
    ///
    public func insert(event: EventType) {
        self.events.insert(value: event)
    }

    ///
    /// Delete an `Event` from the queue
    ///
    /// - Parameter event: The `Event` to delete from the queue.
    ///
    public func delete(event: EventType) {
        self.events.delete(value: event)
    }

    ///
    /// Remove the next `Event` from the queue and return it.
    ///
    /// - Returns: returns the next `Event` on the queue
    ///
    public func next() -> EventType? {

        let next = self.events.min()

        if let value = next?.value {
            self.events.delete(value: value)

            return value
        }
        return nil
    }
}
