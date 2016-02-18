/*
 *   Polygon+GeometryType.swift
 *
 *   Copyright 2016 Tony Stone
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 *   Created by Tony Stone on 2/15/16.
 */
import Swift

extension Polygon /* GeometryType conformance */ {

    public func isEmpty() -> Bool {
        return self.outerRing.count == 0
    }

    public func equals(other: GeometryType) -> Bool {
        if let other = other as? Polygon {
            return self.outerRing.equals(other.outerRing) && self.innerRings.elementsEqual(other.innerRings, isEquivalent: { (lhs: LinearRing, rhs: LinearRing) -> Bool in
                return lhs.equals(rhs)
            })
        }
        return false
    }

    // TODO: Must be implenented.  Here just to test protocol
    public func union(other: GeometryType) -> GeometryType {
        return Polygon()
    }
}
