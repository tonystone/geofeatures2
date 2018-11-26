//: [Previous](@previous)

import GeoFeatures

/// Point

let point = Point([1.0, 2.0, 3.0, 2.0])
point.simplify(tolerance: 1.0)

/// MultiPoint

let multipoint1 = MultiPoint([])
multipoint1.simplify(tolerance: 1.0)

let multipoint2 = MultiPoint([Point([0.0, 0.0])])
multipoint2.simplify(tolerance: 1.0)

let multipoint3 = MultiPoint([Point([0.0, 0.0]), Point([0.0, 0.0])])
multipoint3.simplify(tolerance: 1.0)

let multipoint4 = MultiPoint([Point([0.0, 0.0]), Point([0.0, 1.0]), Point([0.0, 0.0]), Point([0.0, 1.0]), Point([0.0, 1.0]), Point([2.0, 1.0])])
multipoint4.simplify(tolerance: 1.0)


//let lineString = LineString([[100, 100], [100, 100], [150, 100], [200, 100]])
//
//let simplifiedLineString = lineString.simplify(tolerance: 1.0)
//
//type(of: simplifiedLineString)


