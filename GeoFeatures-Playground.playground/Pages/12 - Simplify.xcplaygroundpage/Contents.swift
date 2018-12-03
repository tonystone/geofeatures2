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

/// LinearRing

let linearRing1 = LinearRing([])
linearRing1.simplify(tolerance: 1.0)

let linearRing2 = LinearRing([[100, 100]])
linearRing2.simplify(tolerance: 1.0)

let linearRing3 = LinearRing([[100, 100], [100, 100]])
linearRing3.simplify(tolerance: 1.0)

let linearRing4 = LinearRing([[100, 100], [100, 100], [100, 100]])
linearRing4.simplify(tolerance: 1.0)

let linearRing5 = LinearRing([[100, 100], [100, 100], [100, 100], [100, 100]])
linearRing5.simplify(tolerance: 1.0)

let linearRing6 = LinearRing([[100, 100], [100, 100], [150, 150], [200, 200], [200, 200], [100, 100]])
linearRing6.simplify(tolerance: 1.0)

let linearRing7 = LinearRing([[100, 100], [100, 100], [150, 150], [200, 150], [200, 150], [100, 100]])
linearRing7.simplify(tolerance: 1.0)

let linearRing8 = LinearRing([[100, 100], [100, 100], [200, 200], [300, 300], [300, 300], [400, 300], [500, 300], [600, 300], [600, 300], [600, 400], [600, 600], [600, 800], [100, 100]])
linearRing8.simplify(tolerance: 1.0)

let linearRing9 = LinearRing([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]])
linearRing9.simplify(tolerance: 1.0)

let linearRing10 = LinearRing([[100, 100], [200, 200], [200, 200], [100, 100]])
linearRing10.simplify(tolerance: 1.0)

let linearRing11 = LinearRing([[100, 100], [200, 200], [200, 200], [100, 100], [100, 100], [200, 200], [200, 200], [100, 100]])
linearRing11.simplify(tolerance: 1.0)

let linearRing12 = LinearRing([[100, 100], [300, 300], [200, 200], [500, 500], [100, 100]])
linearRing12.simplify(tolerance: 1.0)

let linearRing13 = LinearRing([[0, 1], [1, 1], [2, 2], [0, 0], [1, 1], [5, 1], [0, 1]])
linearRing13.simplify(tolerance: 1.0)

let linearRing14 = LinearRing([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100], [100, 100], [100, 200], [200, 200], [200, 100], [100, 100]])
linearRing14.simplify(tolerance: 1.0)

let linearRing15 = LinearRing([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100], [100, 100], [200, 100], [200, 200], [100, 200], [100, 100]])
linearRing15.simplify(tolerance: 1.0)

let linearRing16 = LinearRing([[0, 0], [0, 10], [20, 10], [20, 0], [8, 0], [8, 4], [12, 4], [12, 0], [0, 0], [0, 10], [20, 10], [20, 0], [0, 0], [0, 10], [0, 0]])
linearRing16.simplify(tolerance: 1.0)

/// MultiLineString

//let multiLineString1 = MultiLineString([LineString([[100, 100], [100, 100]]), LineString([[200, 200], [200, 200]])])
//multiLineString1.simplify(tolerance: 1.0)
