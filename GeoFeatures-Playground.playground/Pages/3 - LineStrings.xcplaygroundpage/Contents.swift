//: [Previous](@previous)

import GeoFeatures
import GeoFeaturesPlaygroundSupport

//: Closed LineString
let closedLineString = LineString<Coordinate2D>(elements: [(x: 100.00, y: 200.00), (200.00, 200.00), (200.00, 100.00), (100.00, 100.00), (100.00, 200.00)])

//: Open LineString
let openLineString = LineString<Coordinate2D>(elements: [(x: 100.00, y: 200.00), (100.00, 200.00), (150.00, 100.00), (125.00, 100.00)])

//: Usage Scenarios

var lineString1 = LineString<Coordinate2D>()
lineString1.append((1.001, 1.001))
lineString1.append((20.001, 20.001))
lineString1.append((1060.001, 1060.001))

/// lineString1.append((3.003, 3.003, 3.003))  // Error:

lineString1.length()

let fixedPrecision = FixedPrecision(scale: 100)

let lineString = LineString<Coordinate2D>(elements: lineString1, precision: fixedPrecision)

var lineString2 = LineString<Coordinate2D>(elements: [(x: 1.001, y: 1.001), (20.001, 20.001), (30.001, 30.001)], precision: fixedPrecision)

lineString == lineString2

lineString2.length()
lineString1 == lineString2
LineString(elements: lineString1, precision:  fixedPrecision) == lineString2    // Change linestring 1 precision by copying it

lineString2.append((4.001, 4.001))
lineString2.append((5.001, 5.001))

var lineString3 = LineString<Coordinate3DM>()
lineString3.append((0.0, 300.0, 0.0, 0.0))
lineString3.insert((0.0, 200.0, 0.0, 0.0), at: 0)
lineString3.insert((0.0, 100.0, 0.0, 0.0), at: 0)
lineString3.insert((0.0, 0.0, 0.0, 0.0), at: 0)

lineString3.length()

lineString1 == lineString1
lineString1 == lineString2
lineString1 == lineString3
