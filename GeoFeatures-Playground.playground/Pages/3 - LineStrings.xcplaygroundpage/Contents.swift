//: [Previous](@previous)

import GeoFeatures
import GeoFeaturesPlaygroundSupport

//: Open LineString
let left = LineString([[100, 100], [100, 200], [200, 200]])
//: Open LineString
let right = LineString([[200, 100], [100, 100]])
//: Closed LineString
let box = left + right
