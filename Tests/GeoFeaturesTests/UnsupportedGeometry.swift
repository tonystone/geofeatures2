///
///  UnsupportedGeometry
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
///  Created by Tony Stone on 12/17/16.
///
import Swift
import GeoFeatures

internal struct UnsupportedGeometry: Geometry {

    let precision: Precision = Floating()

    let coordinateSystem: CoordinateSystem = Cartesian()

    let dimension: GeoFeatures.Dimension = .one

    func isEmpty() -> Bool {
        return true
    }

    func boundary() -> Geometry {
        return GeometryCollection()
    }

    func bounds() -> Bounds? {
        return nil
    }

    func equals(_ other: Geometry) -> Bool { return false }
}
