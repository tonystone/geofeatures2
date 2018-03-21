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
/// Simple Array of tubles used as elements
let coordinates2d: [(x: Double, y: Double)]            = [(0, 0), (0, 7), (4, 2), (2, 0), (0, 0)]
let coordinates3d: [(x: Double, y: Double, z: Double)] = [(0, 0, 0), (0, 7, 0), (4, 2, 0), (2, 0, 0), (0, 0, 0)]

/// LinearRing created with simple tuble array
LinearRing<Coordinate2D>(elements: coordinates2d)

LinearRing<Coordinate3D>(elements: coordinates3d)

let geometry1: Geometry = LineString<Coordinate3D>(elements: [(x: 0, y: 0, z: 0), (0, 7, 0), (4, 2, 0), (2, 0, 0), (0, 0, 0)])

if let linearType = geometry1 as? Curve {
    linearType.length()
} else {
    print("Can't convert")
}

/// Create a Polygon with a simple array of tuples and an array of innerRings
let polygon1 = Polygon<Coordinate2D>(outerRing: [(x: 0.0, y: 0.0), (x: 0.0, y: 7.0), (x: 4, y: 2), (x: 2, y: 0), (x: 0, y: 0)])

/// Create a Polygon with a tuple simaler to WKT with the syntax ([tuples], [[tuples]])
let polygon2 = Polygon<Coordinate2D>(rings: ([(x: 0, y: 0), (0, 7), (4, 2), (2, 0), (0, 0)], []))
let polygon3 = Polygon<Coordinate2D>(rings: ([(x: 0, y: 0), (0, 7), (4, 2), (2, 0), (0, 0)], [[(0.5, 0.5), (0.5, 6.5), (3.5, 1.5), (1.5, 0.5), (0.5, 0.5)]]))

/// Geoemetry arrays can be constructed and used to create rthe collection types
var geometryArray: [Geometry] = [Point<Coordinate2D>(coordinate: (1, 1)), Polygon<Coordinate2D>()]
var pointArray:    [Geometry] = [Point<Coordinate2D>(coordinate: (1, 1)), Point<Coordinate2D>(coordinate: (2, 2))]

var geometryCollection1 = GeometryCollection(elements: geometryArray)
var geometryCollection2 = GeometryCollection(elements: pointArray)

/// let multiPoint = MultiPoint(pointArray)

///  Iterate over a collection type
for geometry in geometryCollection1 {
    print(geometry)
}

Point<Coordinate2D>(coordinate: (1, 1)).isEmpty()
Polygon<Coordinate3DM>().isEmpty()
Polygon<Coordinate2D>(rings: ([(x: 0, y: 0), (0, 7), (4, 2), (2, 0), (0, 0)], [])).isEmpty()
LineString<Coordinate2D>().isEmpty()
LineString<Coordinate3D>(elements: [(x: 0, y: 0, z: 0), (0, 7, 0), (4, 2, 0), (2, 0, 0), (0, 0, 0)]).isEmpty()

GeometryCollection().isEmpty()
GeometryCollection(elements: [Point<Coordinate2D>(coordinate: (1, 1))] as [Geometry]).isEmpty()

GeometryCollection(elements: [Point<Coordinate2D>(coordinate: (1, 1))] as [Geometry])

/// Comparison of points
let pointsMatch1 = Point<Coordinate2D>(coordinate: (1.4, 2.3)) == Point<Coordinate2D>(coordinate: (1.4, 2.3))

let pointsMatch2 = Point<Coordinate2D>(coordinate: (1, 1)) == Point<Coordinate2D>(coordinate: (1.4, 2.3))
