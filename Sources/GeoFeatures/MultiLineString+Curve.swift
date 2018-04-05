///
///  MultiLineString+Curve.swift
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
///  Created by Tony Stone on 5/30/2016.
///
import Swift

#if os(Linux) || os(FreeBSD)
    import Glibc
#else
    import Darwin
#endif

extension MultiLineString: Curve {

    ///
    /// - Returns: True if all sub-self are closed (begin and end coordinates are equal)
    ///
    public func isClosed() -> Bool {

        if self.count == 0 {
            return false
        }

        for i in 0..<self.count {
            if !self[i].isClosed() {
                return false
            }
        }
        return true
    }

    ///
    /// - Returns: The length of this Curve calculated using the sum of the length of the sub-self.
    ///
    public func length() -> Double {

        var length: Double = 0.0

        if self.count > 0 {

            for i in 0..<self.count {
                length += self[i].length()
            }
        }
        return self.precision.convert(length)
    }
}
