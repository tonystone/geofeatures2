//: [Previous](@previous)

import GeoFeatures


let point = Point([1.0, 2.0, 3.0, 2.0])

point.simplify(tolerance: 1.0)


let lineString = LineString([[100, 100], [100, 100], [150, 100], [200, 100]])

let simplifiedLineString = lineString.simplify(tolerance: 1.0)

type(of: simplifiedLineString)


