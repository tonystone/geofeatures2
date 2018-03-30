//: [Previous](@previous)

import Swift
import GeoFeatures

//: Usage Scenarios

var lineString1 = LineString()
lineString1.append([1.001, 1.001])
lineString1.append([2.001, 2.001])
lineString1.append([3.001, 3.001])

/// lineString1.append((3.003, 3.003, 3.003))  // Error:

lineString1.length()

let fixedPrecision = FixedPrecision(scale: 100)

let lineString = LineString(coordinates: [[1.001, 1.001], [2.001, 2.001], [3.001, 3.001]], precision: fixedPrecision)

var lineString2 = LineString(coordinates: [[1.001, 1.001], [2.001, 2.001], [3.001, 3.001]], precision: fixedPrecision)

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

let multiLineString = MultiLineString(elements: [lineString1, lineString2, lineString3])

MultiLineString(elements: multiLineString)

/// Create a Polygon with a tuple simaler to WKT with the syntax ([tuples], [[tuples]])
Polygon(outerRing: [[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]], innerRings: [])
Polygon(outerRing: [[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]], innerRings: [[[0.5, 0.5], [1.5, 0.5], [3.5, 1.5], [0.5, 6.5], [0.5, 0.5]]])
Polygon(outerRing: LinearRing(coordinates: [[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]]), innerRings: [])

Point(coordinate: [1.0, 2.0])
Point(coordinate: [1.0, 2.0, 3.0, 4.0])

LinearRing(coordinates: [[1.00, -1.00], [-1.00, -1.00], [-1.00, 1.00], [1.00, 1.00], [1.00, -1.00]]).area()
Polygon(outerRing: [[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]], innerRings: [[[0.5, 0.5], [1.5, 0.5], [3.5, 1.5], [0.5, 6.5], [0.5, 0.5]]]).area()
