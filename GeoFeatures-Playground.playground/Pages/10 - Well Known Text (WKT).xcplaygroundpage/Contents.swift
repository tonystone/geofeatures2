//: [Previous](@previous)

import GeoFeatures
import GeoFeaturesPlaygroundSupport

//: Readers and Writers


try WKTReader().read(string: "POLYGON ((0 0, 0 90, 90 90, 90 0, 0 0))")


let writer2D = WKTWriter()

try writer2D.write(Point([24.0, 12.0]))

try writer2D.write(LineString([[24.0, 12.0], [1.0, 1.0], [2.0, 2.0]]))
