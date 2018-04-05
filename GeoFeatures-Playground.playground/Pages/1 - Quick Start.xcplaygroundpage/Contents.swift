import Swift
import GeoFeatures
import GeoFeaturesPlaygroundSupport

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
LinearRing([[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]])

LinearRing([[0, 0, 0], [0, 7, 0], [4, 2, 0], [2, 0, 0], [0, 0, 0]])

let geometry1: Geometry = LineString([[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]])

if let linearType = geometry1 as? Curve {
    linearType.length()
} else {
    print("Can't convert")
}

/// Create a Polygon with a simple array of tuples and an array of innerRings
let polygon1 = Polygon([[0.0, 0.0], [0.0, 7.0], [4, 2], [2, 0], [0, 0]])

/// Create a Polygon with a tuple similar to WKT with the syntax ([tuples], [[tuples]])
let polygon2 = Polygon([[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]])
let polygon3 = Polygon([[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]], innerRings: [[[0.5, 0.5], [0.5, 6.5], [3.5, 1.5], [1.5, 0.5], [0.5, 0.5]]])

/// Geoemetry arrays can be constructed and used to create rthe collection types
var geometryArray: [Geometry] = [Point([1, 1]), Polygon()]
var pointArray:    [Geometry] = [Point([1, 1]), Point([2, 2])]

var geometryCollection1 = GeometryCollection(geometryArray)
var geometryCollection2 = GeometryCollection(pointArray)

///  Iterate over a collection type
for geometry in geometryCollection1 {
    print(geometry)
}

Point([1, 1]).isEmpty()
Polygon().isEmpty()
Polygon([[0, 0], [0, 7], [4, 2], [2, 0], [0, 0]]).isEmpty()
LineString().isEmpty()
LineString([[0, 0, 0], [0, 7, 0], [4, 2, 0], [2, 0, 0], [0, 0, 0]]).isEmpty()

GeometryCollection().isEmpty()
GeometryCollection([Point([1, 1]), LineString([[0, 0, 0], [0, 7, 0], [4, 2, 0], [2, 0, 0], [0, 0, 0]])])

GeometryCollection([Point([1, 1])])

/// Comparison of points
let pointsMatch1 = Point([1.4, 2.3]) == Point([1.4, 2.3])

let pointsMatch2 = Point([1, 1]) == Point([1.4, 2.3])

//: Readers and Writers

do {
    try WKTReader().read(string: "LINESTRING (0 0, 0 90, 90 90, 90 0, 0 0)")
} catch {
   print(error)
}

let writer = WKTWriter()

do {
    try writer.write(Point([24.0, 12.0]))

    try writer.write(LineString([[24.0, 12.0], [1.0, 1.0], [2.0, 2.0]]))
} catch {
    print(error)
}
