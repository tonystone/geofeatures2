//
//  Segment.swift
//  Pods
//
//  Created by Tony Stone on 11/22/16.
//
//

import Swift
import Foundation

///
/// Low level type to represent a segment of a line used in geometric computations.
///
internal class Segment<CoordinateType: Coordinate & CopyConstructable> {

    internal var c1: CoordinateType
    internal var c2: CoordinateType

    init(c1: CoordinateType, c2: CoordinateType) {
        self.c1 = c1
        self.c2 = c2
    }
}

///
/// Segment is Equatable so it can be added to a b-tree and searched.
///
extension Segment: Equatable /* where CoordinateType: Equatable */ {}

internal func == <CoordinateType: Coordinate & CopyConstructable>(lhs: Segment<CoordinateType>, rhs: Segment<CoordinateType>) -> Bool {
    return false
}
