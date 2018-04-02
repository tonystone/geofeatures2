///
///  CoordinateCollectionType.swift
///
///  Copyright (c) 2018 Tony Stone
///
///   Licensed under the Apache License, Version 2.0 (the "License");
///   you may not use this file except in compliance with the License.
///   You may obtain a copy of the License at
///
///   http://www.apache.org/licenses/LICENSE-2.0
///
///   Unless required by applicable law or agreed to in writing, software
///   distributed under the License is distributed on an "AS IS" BASIS,
///   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///   See the License for the specific language governing permissions and
///   limitations under the License.
///
///  Created by Tony Stone on 3/28/18.
///
import Foundation

///
/// A collection of `Coordinate`s.
///
/// This is the main internal type which represents lines, rings and points.
///
public protocol CoordinateCollectionType: MutableCollection where Element == Coordinate, Index == Int {}

///
/// Common functions that `CoordinateCollectionType`s offer.
///
extension CoordinateCollectionType {

    internal func axes() -> [Coordinate.Axis] {
        var axes: [Coordinate.Axis] = [.x, .y]     /// Min axes is the .x and .y Axis since a Coordinate must have at least those.
        var z = false
        var m = false

        for i in self.startIndex..<self.endIndex {
            if self[i].z != nil { z = true }
            if self[i].m != nil { m = true }
        }
        if z { axes.append(.z) }
        if m { axes.append(.m) }

        return axes
    }
}

