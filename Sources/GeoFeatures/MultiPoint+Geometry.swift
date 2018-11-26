///
///  MultiPoint+Geometry.swift
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
///  Created by Tony Stone on 2/15/2016.
///
import Swift

///
/// `Geometry` protocol implementation.
///
extension MultiPoint {

    ///
    /// The spatial dimension of `self`.
    ///
    /// - Returns: .zero if non-empty, or .empty otherwise.
    ///
    /// - SeeAlso: Dimension
    ///
    public var dimension: Dimension {
        return self.isEmpty() ? .empty : .zero
    }

    ///
    /// - Returns: the closure of the combinatorial boundary of this Geometry instance.
    ///
    /// - Note: The boundary of a MultiPoint is the empty set.
    ///
    public func boundary() -> Geometry {
        return MultiPoint(precision: self.precision, coordinateSystem: self.coordinateSystem)
    }

    ///
    /// - Returns: true if `self` is equal to the `other`.
    ///
    public func equals(_ other: Geometry) -> Bool {
        if let other = other as? MultiPoint {
            return self.elementsEqual(other)
        }
        return false
    }

    ///
    /// Reduces the geometry to its simplest form, the simplest sequence of points or coordinates,
    /// that is topologically equivalent to the original geometry.  In essence, this function removes
    /// duplication and intermediate coordinates that do not contribute to the overall definition.
    ///
    /// - Returns: the simplified geometry of the same type as the original
    ///
    public func simplify(tolerance: Double) -> MultiPoint {

        guard self.count > 1 else {
            return self
        }

        var resultGeometry = MultiPoint()
        var indexesToIgnoreArray = [Int]()
        for index1 in 0..<self.count {
            if !indexesToIgnoreArray.contains(index1) {
                resultGeometry.append(self[index1])
            } else {
                continue
            }
            for index2 in (index1 + 1)..<self.count {
                let point1 = self[index1]
                let point2 = self[index2]
                if point1 == point2 {
                    indexesToIgnoreArray.append(index2)
                }
            }
        }

        return resultGeometry
    }
}
