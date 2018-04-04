///
///  Geometry+GeometryCollectionType.swift
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
/// `GeometryCollectionType`'s which also inherits from `Geometry` with an `Element` that inherits from `Geometry`.
///
extension Geometry where Self: GeometryCollectionType, Self.Element: Geometry {

    public func bounds() -> Bounds? {

        let bounds = self.flatMap { $0.bounds() }

        guard bounds.count > 0
                else { return nil }

        return bounds.reduce(bounds[0], { $0.expand(other: $1) })
    }
}

///
/// `GeometryCollectionType`s who are also a `Geometry` type.
///
extension Geometry where Self: GeometryCollectionType, Self.Element == Geometry  {

    public func bounds() -> Bounds? {

        let bounds = self.flatMap { $0.bounds() }

        guard bounds.count > 0
                else { return nil }

        return bounds.reduce(bounds[0], { $0.expand(other: $1) })
    }
}