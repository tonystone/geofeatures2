//: [Previous](@previous)

import Foundation
import GeoFeatures2


//// drawing tests
let poly1 = Polygon<Coordinate2D>(rings: ([(50,50), (70,30), (90,50)],[]))
let poly2 = Polygon<Coordinate2D>(rings: ([(50,50), (170,230), (490,150), (90,60), (40,550)],[]))

poly1.drawBezierPath(poly1)
poly2.drawBezierPath(poly2)
