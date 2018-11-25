///
///  GeometryCollectionType.swift
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
///  Created by Tony Stone on 4/2/18.
///
import Foundation

///
/// GeometryCollectionTypes marker protocol
///
public protocol GeometryCollectionType: MutableCollection where Index == Int {

    ///
    /// simplify will simplify a geometry to its simplest form, the simplest sequence of points or coordinates, that will describe that geometry.  In essence, this function will remove duplication and intermediate coordinates that do not contribute to the overall definition.
    ///
    func simplify(tolerance: Double) -> Self
}

///
/// `Geometry`'s which also inherits from `GeometryCollectionType` with any element type.
///
/// - Remarks: This covers `Polygon`, `MultiPoint`, `MultiLineString`, `MultiPolygon`, and `GeometryCollection`.
///
extension Geometry where Self: GeometryCollectionType {

    ///
    /// - Returns: true if this Geometry is an empty Geometry.
    ///
    public func isEmpty() -> Bool {
        return self.isEmpty
    }

    public func simplify(tolerance: Double) -> Self {
        return self
    }
}

///
/// `Geometry`'s which also inherits from `GeometryCollectionType` with an `Element` that inherits from `Geometry`.
///
/// - Remarks: This covers `Polygon`, `MultiPoint`, `MultiLineString`, and `MultiPolygon`.
///
extension Geometry where Self: GeometryCollectionType, Self.Element: Geometry {

    public func bounds() -> Bounds? {

        let bounds = self.compactMap { $0.bounds() }

        guard bounds.count > 0
            else { return nil }

        return bounds.reduce(bounds[0], { $0.expand(other: $1) })
    }
}

///
/// `Geometry`'s which also inherits from `GeometryCollectionType` with an `Element` that is exactly equal to `Geometry`.
///
/// - Remarks: This covers `GeometryCollection` only.
///
extension Geometry where Self: GeometryCollectionType, Self.Element == Geometry  {


    public func bounds() -> Bounds? {

        let bounds = self.compactMap { $0.bounds() }

        guard bounds.count > 0
            else { return nil }

        return bounds.reduce(bounds[0], { $0.expand(other: $1) })
    }
}
