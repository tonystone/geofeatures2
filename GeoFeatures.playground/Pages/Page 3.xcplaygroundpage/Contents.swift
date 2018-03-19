//: [Previous](@previous)

import Foundation

@testable import GeoFeatures

var matrix = IntersectionMatrix(arrayLiteral: [
    [.empty, .zero,  .one],
    [.two,   .empty, .zero],
    [.one,   .two,   .empty]
    ])

matrix.transposed()
