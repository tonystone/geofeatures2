///
///  MultiPolygon+Surface.swift
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
///  Created by Tony Stone on 3/29/2016.
///
import Swift

///
/// `Surface` protocol implementation.
///
extension MultiPolygon {

    ///
    /// Calculates the area of this `MultiPolygon`
    ///
    ///  - Returns: The area of this `MultiPolygon`.   The area may be the sum of positive and negative numbers, depending on the orientations of the polygon rings.
    ///
    public func area() -> Double {
        var area: Double = 0.0

        if self.count > 0 {

            for index in 0..<self.count {
                area += self[index].area()
            }
        }
        return self.precision.convert(area)
    }
}
