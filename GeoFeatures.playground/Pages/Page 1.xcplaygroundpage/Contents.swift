import Swift
import GeoFeatures

let fixedPrecision1 = FixedPrecision(scale: 10)
let fixedPrecision2 = FixedPrecision(scale: 10)
let fixedPrecision3 = FixedPrecision(scale: 100)
let fixedPrecision4 = FixedPrecision(scale: 31)

let floatingPrecision1 = FloatingPrecision()
let floatingPrecision2 = FloatingPrecision()

let fixedEqual1 = fixedPrecision1 == fixedPrecision2
let fixedEqual2 = fixedPrecision1 == fixedPrecision3

floatingPrecision1 == floatingPrecision2
fixedPrecision1 == floatingPrecision1
fixedPrecision4 == floatingPrecision1

//: ## Usage scenarios

/// LinearRing created with simple tuble array
LinearRing(coordinates: [[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]])

LinearRing(coordinates: [[0, 0, 0], [0, 7, 0], [4, 2, 0], [2, 0, 0], [0, 0, 0]])

let geometry1: Geometry = LineString(coordinates: [[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]])

if let linearType = geometry1 as? Curve {
    linearType.length()
} else {
    print("Can't convert")
}

/// Create a Polygon with a simple array of tuples and an array of innerRings
let polygon1 = Polygon(outerRing: [[0.0, 0.0], [0.0, 7.0], [4, 2], [2, 0], [0, 0]], innerRings: [])

/// Create a Polygon with a tuple similar to WKT with the syntax ([tuples], [[tuples]])
let polygon2 = Polygon(outerRing: [[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]], innerRings: [])
let polygon3 = Polygon(outerRing: [[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]], innerRings: [[[0.5, 0.5], [0.5, 6.5], [3.5, 1.5], [1.5, 0.5], [0.5, 0.5]]])

/// Geoemetry arrays can be constructed and used to create rthe collection types
var geometryArray: [Geometry] = [Point(coordinate: [1, 1]), Polygon()]
var pointArray:    [Geometry] = [Point(coordinate: [1, 1]), Point(coordinate: [2, 2])]

var geometryCollection1 = GeometryCollection(elements: geometryArray)
var geometryCollection2 = GeometryCollection(elements: pointArray)

///  Iterate over a collection type
for geometry in geometryCollection1 {
    print(geometry)
}

Point(coordinate: [1, 1]).isEmpty()
Polygon().isEmpty()
Polygon(outerRing: [[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]], innerRings: []).isEmpty()
LineString().isEmpty()
LineString(coordinates: [[0, 0, 0], [0, 7, 0], [4, 2, 0], [2, 0, 0], [0, 0, 0]]).isEmpty()

GeometryCollection().isEmpty()
GeometryCollection(elements: [Point(coordinate: [1, 1])] as [Geometry]).isEmpty()

/// Comparison of points
let pointsMatch1 = Point(coordinate: [1.4, 2.3]) == Point(coordinate: [1.4, 2.3])

let pointsMatch2 = Point(coordinate: [1, 1]) == Point(coordinate: [1.4, 2.3])

//: Readers and Writers

do {
    try WKTReader().read(string: "LINESTRING (0 0, 0 90, 90 90, 90 0, 0 0)")
} catch {
   print(error)
}

let writer = WKTWriter()

do {
    try writer.write(Point(coordinate: [24.0, 12.0]))

    try writer.write(LineString(coordinates: [[24.0, 12.0], [1.0, 1.0], [2.0, 2.0]]))
} catch {
    print(error)
}
