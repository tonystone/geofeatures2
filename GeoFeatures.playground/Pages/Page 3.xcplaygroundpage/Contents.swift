//: [Previous](@previous)

import GeoFeatures

let polygon: Polygon = [[[0, 0], [60, 144], [120, 0], [0, 0]], [[40, 25], [80, 25], [60, 80], [40, 25]]]
polygon.bounds()

Polygon([[0, 0], [0, 90], [90, 90], [90, 0], [0, 0]]).bounds()

let emptyPolygon = Polygon()
emptyPolygon.bounds()


MultiLineString([[[0, 0], [60, 144], [120, 0], [0, 0]], [[40, 25], [80, 25], [60, 80], [40, 25]]]).bounds()

MultiPoint([[0, 0], [60, 144], [120, 0], [0, 0]]).bounds()

var multiPoint: MultiPoint = [[0, 0], [60, 144], [120, 0], [0, 0]]

multiPoint.replaceSubrange(0...0, with: [Point([0, 0])])

let point: Point = [1, 1]

Point([1, 1]).bounds()

LinearRing(other: LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]), precision: Fixed(scale: 10), coordinateSystem: Cartesian())

LinearRing(LinearRing([Coordinate(x: 1.0, y: 1.0), Coordinate(x: 2.0, y: 2.0)]))
