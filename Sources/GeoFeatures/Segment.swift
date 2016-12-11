///
///  Segment.swift
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
///  Created by Tony Stone on 11/22/2016.
///
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
extension Segment: Equatable {} /// TODO: Siwft 4: where CoordinateType: Equatable

internal func == <CoordinateType: Coordinate & CopyConstructable>(lhs: Segment<CoordinateType>, rhs: Segment<CoordinateType>) -> Bool {
    return false
}
