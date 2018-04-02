//: [Previous](@previous)

import GeoFeatures

let precision = FixedPrecision(scale: 10)

var polygon = Polygon([[[0, 0], [60, 144], [120, 0], [0, 0]]], precision: precision)
polygon.bounds()
polygon.area()

polygon.insert([[40.01, 25.01], [180, 125.25], [60, 80], [40, 25]], at: 0)
polygon.bounds()
polygon.area()

