//
//  Coordinate.swift
//  Pods
//
//  Created by Tony Stone on 2/21/16.
//
//

import Swift

/**
    Coordinate (2 dimensional protocol)
 
    Implenented by all Coordinate structs.
*/
public protocol Coordinate  {
    var x: Double { get set }
    var y: Double { get set }
}

/**
    3D
 
    Implenented if this Coordinate has z value.
*/
public protocol ThreeDimensional {
    var z: Double { get set }
}

/**
    Measured
 
    Implenented if this Coordinate has m value.
*/
public protocol Measured {
    var m: Double { get set }
}

/**
    Internal private
*/
public protocol _CoordinateConstructable {
    typealias TupleType
    
    var tuple: TupleType { get set }
    
    init(other: Self)
    init(tuple: TupleType)
    
    func ==(lhs: Self, rhs: Self) -> Bool
}