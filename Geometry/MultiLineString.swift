//===--- GeometryCollection.swift.gyb -------------------------------------*- swift -*-===//
//
// NOTE: This file was auto generated by gyb from file GeometryCollection.swift.gyb.
//
// Do NOT edit this file directly as it will be regenerated automatically when needed.
//

/*
 *   MultiLineString.swift
 *
 *   Copyright 2016 Tony Stone
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 *   Created by Tony Stone on 2/14/16.
 */
import Swift

/**
    MultiLineString
 
    A MultiLineString is a collection of some number of LineString objects.
 
    All the elements in a MultiLineString shall be in the same Spatial Reference System. This is also the Spatial Reference System for the MultiLineString.
 */
public struct MultiLineString : GeometryType {
    
    public let dimension: Int
    public let precision: Precision
    public let coordinateReferenceSystem: CoordinateReferenceSystem = defaultCoordinateReferenceSystem

    private var elements = ContiguousArray<LineString>()
}

// MARK:  GeometryCollectionType conformance

extension MultiLineString : GeometryCollectionType {
    
    /**
     MultiLineString is empty constructable
     */
    public init () {
        self.dimension = 0
        self.precision = defaultPrecision
    }
    
    /**
     MultiLineString can be constructed from any SequenceType as long as it has an
     Element type equal the LineString Element.
     */
    public init<C : SequenceType where C.Generator.Element == LineString>(elements: C) {
        
        var minDimension: Int = 3
        var generator         = elements.generate()
        
        while let element = generator.next() {
            minDimension = min(minDimension, element.dimension)
            
            self.elements.append(element)
        }
        self.dimension = minDimension
        self.precision = defaultPrecision
    }
    
    /**
     MultiLineString can be constructed from any CollectionType including Array as
     long as it has an Element type equal the LineString Element and the Distance
     is an Int type.
     */
    public init<C : CollectionType where C.Generator.Element == LineString, C.Index.Distance == Int>(elements: C) {
        
        self.elements.reserveCapacity(elements.count)
        
        var minDimension: Int = 3
        var generator         = elements.generate()
        
        while let element = generator.next() {
            minDimension = min(minDimension, element.dimension)
            
            self.elements.append(element)
        }
        self.dimension = minDimension
        self.precision = defaultPrecision
    }
    
    /**
        - Returns: The number of LineString objects.
     */
    public var count: Int {
        get { return self.elements.count }
    }

    /**
        - Returns: The current minimum capacity.
     */
    public var capacity: Int {
        get { return self.elements.capacity }
    }

    /**
        Reserve enough space to store `minimumCapacity` elements.
     
        - Postcondition: `capacity >= minimumCapacity` and the array has mutable contiguous storage.
     */
    public mutating func reserveCapacity(minimumCapacity: Int) {
        self.elements.reserveCapacity(minimumCapacity)
    }

    /**
        Append `newElement` to this MultiLineString.
     */
    public mutating func append(newElement: LineString) {
        self.elements.append(newElement)
    }

    /**
        Append the elements of `newElements` to this MultiLineString.
     */
    public mutating func appendContentsOf<S : SequenceType where S.Generator.Element == LineString>(newElements: S) {
        self.elements.appendContentsOf(newElements)
    }

    /**
        Append the elements of `newElements` to this MultiLineString.
     */
    public mutating func appendContentsOf<C : CollectionType where C.Generator.Element == LineString>(newElements: C) {
        self.elements.appendContentsOf(newElements)
    }

    /**
        Remove an element from the end of this MultiLineString.
     
        - Requires: `count > 0`.
     */
    public mutating func removeLast() -> LineString {
        return self.elements.removeLast()
    }

    /**
        Insert `newElement` at index `i` of this MultiLineString.
     
        - Requires: `i <= count`.
     */
    public mutating func insert(newElement: LineString, atIndex i: Int) {
        self.elements.insert(newElement, atIndex: i)
    }

    /**
        Remove and return the element at index `i` of this MultiLineString.
     */
    public mutating func removeAtIndex(index: Int) -> LineString {
        return self.elements.removeAtIndex(index)
    }

    /**
        Remove all elements of this MultiLineString.
     
        - Postcondition: `capacity == 0` iff `keepCapacity` is `false`.
     */
    public mutating func removeAll(keepCapacity keepCapacity: Bool = true) {
        self.elements.removeAll(keepCapacity: keepCapacity)
    }
}

// MARK: CollectionType conformance

extension MultiLineString {
    
    /**
        Always zero, which is the index of the first element when non-empty.
     */
    public var startIndex : Int { return self.elements.startIndex }

    /**
        A "past-the-end" element index; the successor of the last valid subscript argument.
     */
    public var endIndex   : Int { return self.elements.endIndex }
    
    public subscript(position : Int) -> LineString {
        get         { return self.elements[position] }
        set (value) { self.elements[position] = value }
    }
    
    public subscript(range: Range<Int>) -> ArraySlice<LineString> {
        get         { return self.elements[range] }
        set (value) { self.elements[range] = value }
    }
    
    public func generate() -> IndexingGenerator<ContiguousArray<LineString>> {
        return self.elements.generate()
    }
}

// MARK: CustomStringConvertible & CustomDebugStringConvertible protocol conformance

extension MultiLineString : CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description : String {
        return "\(self.dynamicType)(\(self.elements.description))"
    }
    
    public var debugDescription : String {
        return self.description
    }
}
