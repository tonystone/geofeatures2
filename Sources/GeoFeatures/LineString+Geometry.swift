///
///  LineString+Geometry.swift
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
/// Note: See `CoordinateCollectionType` for func implementations not present here.
///
extension LineString {

    ///
    /// - Returns: true if this geometric object meets the following constraints:
    ///            • A linestring must have either 0 or 2 or more coordinates.
    ///            • Consecutive coordinates may be equal.
    ///            • The line segments in the line may intersect each other (in other words, the linestring may "curl back" on itself and self-intersect).
    ///            • If the number of coordinates is greater than 0, there must be at least two different coordinates.
    ///
    public func valid() -> Bool {
        guard self.count != 1 else {
            return false
        }

        if self.count == 0 {
            return true
        }

        let coordinate1 = self[0]
        for index in 1..<self.count {
            let coordinate2 = self[index]
            if coordinate1 != coordinate2 {
                return true
            }
        }
        return false
    }
}
