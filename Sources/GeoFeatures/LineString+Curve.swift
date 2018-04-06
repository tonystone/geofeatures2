///
///  LineString+Curve.swift
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

#if os(Linux) || os(FreeBSD)
    import Glibc
#else
    import Darwin
#endif

extension LineString: Curve {

    ///
    /// - Returns: True if this curve is closed (begin and end self are equal)
    ///
    public func isClosed() -> Bool {

        if self.count < 2 { return false }

        return self[0] == self[self.count - 1]
    }

    ///
    /// The length of this LinearType calculated using its associated CoordinateSystem.
    ///
    public func length() -> Double {

        var length: Double = 0.0

        if self.count > 0 {

            var c1 = self[0]

            for index in stride(from: 1, to: self.count, by: 1) {

                let c2 = self[index]

                length += sqrt(pow(abs(c1.x - c2.x), 2.0) + pow(abs(c1.y - c2.y), 2.0))
                c1 = c2
            }
        }
        return self.precision.convert(length)
    }
}
