//: [Previous](@previous)

import Swift
import GeoFeatures

//: Usage Scenarios

var lineString1 = LineString(precision: FixedPrecision(scale: 10))
lineString1.append([1.001, 1.001])
lineString1.append([2.001, 2.001])
lineString1.append([3.001, 3.001])

lineString1.length()

let fixedPrecision = FixedPrecision(scale: 100)

let lineString = LineString([[1.001, 1.001], [2.001, 2.001], [3.001, 3.001]], precision: fixedPrecision)

var lineString2 = LineString([[1.001, 1.001], [2.001, 2.001], [3.001, 3.001]], precision: fixedPrecision)

lineString == lineString2

lineString2.length()
lineString1 == lineString2

lineString2.append([4.001, 4.001])
lineString2.append([5.001, 5.001])

var lineString3 = LineString()
lineString3.append([0.0, 3.0, 8.0, 18.0])
lineString3.insert([0.0, 2.0, 5.0, 7.0], at: 0)
lineString3.insert([0.0, 1.0, 0.0, 1.0], at: 0)
lineString3.insert([0.0, 1.0, 2.0, 3.0], at: 0)

lineString3.length()

lineString1 == lineString1
lineString1 == lineString2
lineString1 == lineString3

let multiLineString = MultiLineString([lineString1, lineString2, lineString3])

MultiLineString(multiLineString)

/// Create a Polygon with a tuple simaler to WKT with the syntax ([tuples], [[tuples]])
Polygon([[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]])
Polygon([[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]], innerRings: [[[0.5, 0.5], [1.5, 0.5], [3.5, 1.5], [0.5, 6.5], [0.5, 0.5]]])

Polygon([
    [[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]],
    [[0.5, 0.5], [1.5, 0.5], [3.5, 1.5], [0.5, 6.5], [0.5, 0.5]]
    ])

Polygon([
    LinearRing([[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]]),
    LinearRing([[0.5, 0.5], [1.5, 0.5], [3.5, 1.5], [0.5, 6.5], [0.5, 0.5]])
    ])

Polygon(LinearRing([[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]]))

Point([1.0, 2.0])
Point([1.0, 2.0, 3.0, 4.0])

LinearRing([[1.00, -1.00], [-1.00, -1.00], [-1.00, 1.00], [1.00, 1.00], [1.00, -1.00]]).area()
Polygon([[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]], innerRings: [[[0.5, 0.5], [1.5, 0.5], [3.5, 1.5], [0.5, 6.5], [0.5, 0.5]]]).area()

let array = Polygon(LinearRing([[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]])).map({ Array($0) })
print(array)
