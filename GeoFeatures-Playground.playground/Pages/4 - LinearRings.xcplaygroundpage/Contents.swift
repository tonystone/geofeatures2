//: [Previous](@previous)

import GeoFeatures
import GeoFeaturesPlaygroundSupport

//: Closed LinearRing
let closedLinearRing = LinearRing<Coordinate2D>(elements: [(x: 100.00, y: 200.00), (200.00, 200.00), (200.00, 100.00), (100.00, 100.00), (100.00, 200.00)])
//: Area of a closed LinearRing
closedLinearRing.area()

//: Open LinearRing (invalid)
let openLinearRing = LinearRing<Coordinate2D>(elements: [(x: 100.00, y: 200.00), (100.00, 200.00), (150.00, 100.00), (125.00, 100.00)])
//: Area of an open LinearRing should always be zero
openLinearRing.area()
