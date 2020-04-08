//: [Previous](@previous)

@testable import GeoFeatures
import GeoFeaturesPlaygroundSupport

let line1 = LineString([[100, 100], [100, 200], [200, 200]])
let line2 = LineString([[200, 100], [100, 100]])
let line3 = LineString([[200, 100], [100, 100]])
let line4 = LineString([[100, 100], [200, 100]])

line2.equals(line3)
line3.equals(line4)

line1.within(line2)
line2.within(line3)
line3.within(line4)

line2.touches(line2)
line2.intersects(line3)

line1.overlaps(line2)
line2.overlaps(line3)


//: [Next](@next)
