///
///  Geometry+CoordinateCollectionType.swift
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
///  Created by Tony Stone on 4/3/18.
///

import Foundation

///
/// When the `CoordinateCollectionType` is also a `Geometry` type.
///
extension Geometry where Self: CoordinateCollectionType {

    public func bounds() -> Bounds? {

        var iterator = self.makeIterator()

        guard let first = iterator.next()
                else { return nil }

        var minX = first.x, maxX = first.x
        var minY = first.y, maxY = first.y

        while let next = iterator.next() {

            minX = Swift.min(minX, next.x)
            maxX = Swift.max(maxX, next.x)

            minY = Swift.min(minY, next.y)
            maxY = Swift.max(maxY, next.y)
        }
        return Bounds(min: (x: minX, y: minY), max: (x: maxX, y: maxY))
    }
}