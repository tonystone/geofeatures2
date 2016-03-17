/*
 *   LinearRing.swift
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

/*
    NOTE: This file was auto generated by gyb from file CoordinateCollection.swift.gyb using the following command.

        ~/gyb --line-directive '' -DSelf=LinearRing  -o LinearRing.swift CoordinateCollection.swift.gyb

    Do NOT edit this file directly as it will be regenerated automatically when needed.
*/

/**
    LinearRing
 
    A LinearRing is a Curve with linear interpolation between Coordinates. Each consecutive pair of
    Coordinates defines a Line segment.
 */
public struct LinearRing<Element : protocol<Coordinate, TupleConvertable>> : Geometry {

    public let precision: Precision
    public let coordinateReferenceSystem: CoordinateReferenceSystem
    
    public init(coordinateReferenceSystem: CoordinateReferenceSystem) {
        self.init(coordinateReferenceSystem: coordinateReferenceSystem, precision: defaultPrecision)
    }
    
    public init(precision: Precision) {
        self.init(coordinateReferenceSystem: defaultCoordinateReferenceSystem, precision: precision)
    }
    
    public init(coordinateReferenceSystem: CoordinateReferenceSystem, precision: Precision) {
        self.precision = precision
        self.coordinateReferenceSystem = coordinateReferenceSystem
        
        storage = CollectionBuffer<Element>.create(8) { _ in 0 } as! CollectionBuffer<Element>
    }

    internal var storage: CollectionBuffer<Element>
}

extension LinearRing {
    
    @inline(__always)
    private mutating func _ensureUniquelyReferenced() {
        if !isUniquelyReferencedNonObjC(&storage) {
            storage = storage.clone()
        }
    }

    @inline(__always)
    private mutating func _resizeIfNeeded() {
        if storage.allocatedElementCount == count {
            storage = storage.resize(count * 2)
        }
    }
}

// MARK: Collection conformance

extension LinearRing : Collection  {
    
    /**
        LinearRings are empty constructable
     */
    public init() {
        self.init(coordinateReferenceSystem: defaultCoordinateReferenceSystem, precision: defaultPrecision)
    }
    
    /**
        LinearRing can be constructed from any SequenceType as long as it has an
        Element type equal the Coordinate type specified in Element.
     */
    public init<S : SequenceType where S.Generator.Element == Element>(elements: S, coordinateReferenceSystem: CoordinateReferenceSystem = defaultCoordinateReferenceSystem, precision: Precision = defaultPrecision) {
        
        self.init(coordinateReferenceSystem: coordinateReferenceSystem, precision: precision)
        
        var generator = elements.generate()
        
        while let coordinate = generator.next() {
            self.append(coordinate)
        }
    }
    
    /**
        LinearRing can be constructed from any CollectionType including Array as
        long as it has an Element type equal the Coordinate type specified in Element 
        and the Distance is an Int type.
     */
    public init<C : CollectionType where C.Generator.Element == Element>(elements: C, coordinateReferenceSystem: CoordinateReferenceSystem = defaultCoordinateReferenceSystem, precision: Precision = defaultPrecision) {
        
        self.init(coordinateReferenceSystem: coordinateReferenceSystem, precision: precision)
        
        self.reserveCapacity(numericCast(elements.count))
        
        var generator = elements.generate()
        
        while let coordinate = generator.next() {
            self.append(coordinate)
        }
    }
    
    /**
        - Returns: The number of Coordinate3D objects.
     */
    public var count: Int {
        get { return self.storage.value }
    }
    
    /**
        - Returns: The current minimum capacity.
     */
    public var capacity: Int {
        get { return self.storage.allocatedElementCount }
    }
    
    /**
        Reserve enough space to store `minimumCapacity` elements.
     
        - Postcondition: `capacity >= minimumCapacity` and the array has mutable contiguous storage.
     */
    public mutating func reserveCapacity(minimumCapacity: Int) {
        
        if storage.allocatedElementCount < minimumCapacity {
            
            _ensureUniquelyReferenced()
            
            let newSize = max(storage.allocatedElementCount * 2, minimumCapacity)
            
            storage = storage.resize(newSize)
        }
    }
    
    /**
        Reserve enough space to store `minimumCapacity` elements.
     
        - Postcondition: `capacity >= minimumCapacity` and the array has mutable contiguous storage.
     */
    public mutating func append(newElement: Element) {
        var convertedCoordinate = newElement
        
        precision.convert(&convertedCoordinate)
        
        _ensureUniquelyReferenced()
        _resizeIfNeeded()
        
        storage.withUnsafeMutablePointers { (value, elements)->Void in
            
            (elements + value.memory).initialize(convertedCoordinate)
            value.memory += 1
        }
    }

    /**
        Append the elements of `newElements` to this LinearRing.
     */
    public mutating func append<S : SequenceType where S.Generator.Element == Element>(contentsOf newElements: S) {
        
        var generator = newElements.generate()
        
        while let coordinate = generator.next() {
            self.append(coordinate)
        }
    }
    
    /**
        Append the elements of `newElements` to this LinearRing.
     */
    public mutating func append<C : CollectionType where C.Generator.Element == Element>(contentsOf newElements: C) {
        
        self.reserveCapacity(numericCast(newElements.count))
        
        var generator = newElements.generate()
        
        while let coordinate = generator.next() {
            self.append(coordinate)
        }
    }
    
    /**
        Insert `newElement` at index `i` of this LinearRing.
     
        - Requires: `i <= count`.
     */
    public mutating func insert(newElement: Element, atIndex index: Int) {
        guard ((index >= 0) && (index < storage.value)) else { preconditionFailure("Index out of range.") }

        var convertedCoordinate = newElement
        
        precision.convert(&convertedCoordinate)
        
        _ensureUniquelyReferenced()
        _resizeIfNeeded()
        
        storage.withUnsafeMutablePointers { (count, elements)->Void in
            var m = count.memory
            
            count.memory = count.memory &+ 1
            
            // Move the other elements
            while  m >= index {
                (elements + (m &+ 1)).moveAssignFrom((elements + m), count: 1)
                m = m &- 1
            }
            (elements + index).initialize(convertedCoordinate)
        }
    }
    
    /**
        Remove and return the element at index `i` of this LinearRing.
     */
    public mutating func remove(at index: Int) -> Element {
        guard ((index >= 0) && (index < storage.value)) else { preconditionFailure("Index out of range.") }

        return storage.withUnsafeMutablePointers { (count, elements)-> Element in
            
            let result = elements[index]
            
            var m = index &+ 1
            
            // Move the other elements
            while  m <  count.memory {
                (elements + (m &- 1)).moveAssignFrom((elements + m), count: 1)
                m = m &+ 1
            }
            count.memory = count.memory &- 1
            
            return result
        }
    }

    /**
        Remove an element from the end of this LinearRing.
     
        - Requires: `count > 0`.
     */
    public mutating func removeLast() -> Element {
        guard count > 0 else { preconditionFailure("can't removeLast from an empty LinearRing.") }

        return storage.withUnsafeMutablePointers { (count, elements)-> Element in

            let index = count.memory
            
            // No need to check for overflow in `i - 1` because `i` is known to be positive.
            let result = elements[index &- 1]
            
            count.memory = count.memory &- 1
            
            return result
        }
    }

    /**
        Remove all elements of this LinearRing.
     
        - Postcondition: `capacity == 0` iff `keepCapacity` is `false`.
     */
    public mutating func removeAll(keepCapacity keepCapacity: Bool = false) {
        
        if keepCapacity {
        
            storage.withUnsafeMutablePointers { (count, elements)-> Void in
                count.memory = 0
            }
        } else {
            storage = CollectionBuffer<Element>.create(0) { _ in 0 } as! CollectionBuffer<Element>
        }
    }
}

/**
    TupleConvertable extensions
 
    Coordinates that are TupleConvertable allow initialization via an ordinary Swift tuple.
 */
extension LinearRing where Element : TupleConvertable {
    
    /**
        LinearRing can be constructed from any SequenceType if it's Elements are tuples that match
        Self.Element's TupleType.  
     
        ----
     
        - seealso: TupleConvertable.
     */
    public init<S : SequenceType where S.Generator.Element == Element.TupleType>(elements: S, coordinateReferenceSystem: CoordinateReferenceSystem = defaultCoordinateReferenceSystem, precision: Precision = defaultPrecision) {
        
        self.init(coordinateReferenceSystem: coordinateReferenceSystem, precision: precision)
        
        var generator = elements.generate()
        
        while let coordinate = generator.next() {
            self.append(coordinate)
        }
    }
    
    /**
        LinearRing can be constructed from any CollectionType if it's Elements are tuples that match
        Self.Element's TupleType.  
     
        ----
     
        - seealso: TupleConvertable.
     */
    public init<C : CollectionType where C.Generator.Element == Element.TupleType, C.Index.Distance == Int>(elements: C, coordinateReferenceSystem: CoordinateReferenceSystem = defaultCoordinateReferenceSystem, precision: Precision = defaultPrecision) {
        
        self.init(coordinateReferenceSystem: coordinateReferenceSystem, precision: precision)
        
        self.storage.resize(elements.count)
        
        var generator = elements.generate()
        
        while let coordinate = generator.next() {
            self.append(coordinate)
        }
    }
    
    /**
        Reserve enough space to store `minimumCapacity` elements.
     
        - Postcondition: `capacity >= minimumCapacity` and the array has mutable contiguous storage.
     */
    public mutating func append(newElement: Element.TupleType) {
        self.append(Element(tuple: newElement))
    }
    
    /**
        Append the elements of `newElements` to this LinearRing.
     */
    public mutating func appendContentsOf<S : SequenceType where S.Generator.Element == Element.TupleType>(newElements: S) {
        
        var generator = newElements.generate()
        
        while let coordinate = generator.next() {
            self.append(Element(tuple: coordinate))
        }
    }
    
    /**
        Append the elements of `newElements` to this LinearRing.
     */
    public mutating func appendContentsOf<C : CollectionType where C.Generator.Element == Element.TupleType>(newElements: C) {
        
        _ensureUniquelyReferenced()
        
        self.reserveCapacity(numericCast(newElements.count) + storage.value)
        
        var generator = newElements.generate()
        
        while let coordinate = generator.next() {
            self.append(Element(tuple: coordinate))
        }
    }
    
    /**
        Insert `newElement` at index `i` of this LinearRing.
     
        - Requires: `i <= count`.
     */
    public mutating func insert(newElement: Element.TupleType, atIndex i: Int) {
        self.insert(Element(tuple: newElement), atIndex: i)
    }
}


// MARK: CollectionType conformance

extension LinearRing : CollectionType, /* MutableCollectionType, */ _DestructorSafeContainer {
    
    /**
        Always zero, which is the index of the first element when non-empty.
     */
    public var startIndex : Int { return 0 }
    
    /**
        A "past-the-end" element index; the successor of the last valid subscript argument.
     */
    public var endIndex  : Int { return storage.value }
    
    public subscript(index : Int) -> Element {
        
        get {
            guard ((index >= 0) && (index < storage.value)) else { preconditionFailure("Index out of range.") }
            
            return storage.withUnsafeMutablePointerToElements { $0[index] }
        }
        
        set (newValue) {
            guard ((index >= 0) && (index < storage.value)) else { preconditionFailure("Index out of range.") }

            _ensureUniquelyReferenced()
            
            var convertedCoordinate = newValue
            
            precision.convert(&convertedCoordinate)
            
            storage.withUnsafeMutablePointerToElements { elements->Void in
                elements[index] = convertedCoordinate
            }
        }
    }
}

// MARK: CustomStringConvertible & CustomDebugStringConvertible Conformance

extension LinearRing : CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description : String {
        return "\(self.dynamicType)(\(self.flatMap { String($0) }.joinWithSeparator(", ")))"
    }
    
    public var debugDescription : String {
        return self.description
    }
}

