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

/// LineString

let lineString1 = LineString([[100, 100], [100, 100]])
lineString1.simplify(tolerance: 1.0)

let lineString2 = LineString([[100, 100], [100, 100], [100, 100]])
lineString2.simplify(tolerance: 1.0)

let lineString3 = LineString([[100, 100], [100, 100], [100, 100], [100, 100]])
lineString3.simplify(tolerance: 1.0)

let lineString4 = LineString([[100, 100], [100, 100], [150, 150], [200, 200], [200, 200]])
lineString4.simplify(tolerance: 1.0)

let lineString5 = LineString([[100, 100], [100, 100], [150, 150], [200, 150], [200, 150]])
lineString5.simplify(tolerance: 1.0)

let lineString6 = LineString([[100, 100], [100, 100], [200, 200], [300, 300], [300, 300], [400, 300], [500, 300], [600, 300], [600, 300], [600, 400], [600, 600], [600, 800]])
lineString6.simplify(tolerance: 1.0)

let lineString7 = LineString([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]])
lineString7.simplify(tolerance: 1.0)

let lineString8 = LineString([[100, 100], [200, 200], [200, 200], [100, 100]])
lineString8.simplify(tolerance: 1.0)

let lineString9 = LineString([[100, 100], [200, 200], [200, 200], [100, 100], [100, 100], [200, 200]])
lineString9.simplify(tolerance: 1.0)

let lineString10 = LineString([[100, 100], [300, 300], [200, 200], [500, 500]])
lineString10.simplify(tolerance: 1.0)

let lineString11 = LineString([[0, 1], [1, 1], [2, 2], [0, 0], [1, 1], [5, 1]])
lineString11.simplify(tolerance: 1.0)

let lineString12 = LineString([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100], [100, 100], [100, 200], [200, 200], [200, 100], [100, 100]])
lineString12.simplify(tolerance: 1.0)

let lineString13 = LineString([[0, 0], [0, 10], [20, 10], [20, 0], [8, 0], [8, 4], [12, 4], [12, 0], [0, 0], [0, 10], [20, 10], [20, 0], [0, 0], [0, 10]])
lineString13.simplify(tolerance: 1.0)

let simplifiedLineString = lineString1.simplify(tolerance: 1.0)
type(of: simplifiedLineString)
