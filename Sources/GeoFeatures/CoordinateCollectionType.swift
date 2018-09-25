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

enum Orientation: Int { case collinear = 0, clockwise, counterclockwise }

///
/// A collection of `Coordinate`s.
///
/// This is the main internal type which represents lines, rings and points.
///
public protocol CoordinateCollectionType: MutableCollection where Element == Coordinate, Index == Int {}

///
/// Extension for all `CoordinateCollectionType` that are also a `Geometry` & `Curve` type.
///
/// - Remarks: This covers `LineString` and `LinearRing`.
///
public extension CoordinateCollectionType where Self: Geometry & Curve {

    ///
    /// The spatial dimension of `self`.
    ///
    /// - Returns: .one if non-empty, or .empty otherwise.
    ///
    /// - SeeAlso: Dimension
    ///
    public var dimension: Dimension {
        return self.isEmpty() ? .empty : .one
    }

    ///
    /// - Returns: true if this Geometry is an empty Geometry.
    ///
    public func isEmpty() -> Bool {
        return self.isEmpty
    }

    ///
    /// - Returns: the closure of the combinatorial boundary of this Geometry instance.
    ///
    /// - Note: The boundary of a LineString if empty is the empty MultiPoint. If not empty it is the first and last point.
    ///
    public func boundary() -> Geometry {

        var boundary = MultiPoint(precision: self.precision, coordinateSystem: self.coordinateSystem)

        if !self.isClosed() && self.count >= 2 {

            /// Note: direct subscripts protected by self.count >= 2 above.
            boundary.append(Point(self[0], precision: self.precision, coordinateSystem: self.coordinateSystem))
            boundary.append(Point(self[self.endIndex - 1], precision: self.precision, coordinateSystem: self.coordinateSystem))
        }
        return boundary
    }

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

///
/// Extension for all `CoordinateCollectionType`'s.
///
/// - Remarks: This covers `LineString`, `LinearRing`, and `Point`.
///
internal extension CoordinateCollectionType {}
