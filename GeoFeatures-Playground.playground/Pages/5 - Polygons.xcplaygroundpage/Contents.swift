//: [Previous](@previous)

import GeoFeatures
import GeoFeaturesPlaygroundSupport

/// Create a Polygon with a tuple simaler to WKT with the syntax ([tuples], [[tuples]])
Polygon([[0, 0], [100, 107], [140, 102], [102, 0], [102, 50], [0, 0]])

//: Correctly Wound Polygon
Polygon([[[0, 0], [60, 144], [120, 0], [0, 0]], [[40, 25], [80, 25], [60, 80], [40, 25]]])

//: Incorrectly Wound Polygon
Polygon([[[0, 0], [60, 144], [120, 0], [0, 0]], [[40, 25], [60, 80], [80, 25], [40, 25]]])
