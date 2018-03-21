//: [Previous](@previous)

import GeoFeatures
import GeoFeaturesPlaygroundSupport

//: Readers and Writers

do {
    try WKTReader<Coordinate2D>().read(string: "POLYGON ((0 0, 0 90, 90 90, 90 0, 0 0))")
} catch {
    print(error)
}

let writer2D = WKTWriter<Coordinate2D>()

writer2D.write(Point<Coordinate2D>(coordinate: (x: 24.0, y: 12.0)))

writer2D.write(LineString<Coordinate2D>(elements: [(x: 24.0, y: 12.0), (1.0, 1.0), (2.0, 2.0)]))
