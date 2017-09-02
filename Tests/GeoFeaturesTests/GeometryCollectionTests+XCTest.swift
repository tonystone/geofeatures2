///
/// GeometryCollectionTests+XCTest.swift
///
/// Copyright 2016 Tony Stone
///
///  Licensed under the Apache License, Version 2.0 (the "License");
///  you may not use this file except in compliance with the License.
///  You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///  Unless required by applicable law or agreed to in writing, software
///  distributed under the License is distributed on an "AS IS" BASIS,
///  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  See the License for the specific language governing permissions and
///  limitations under the License.
///
///  Created by Tony Stone on 5/4/16.
///
import XCTest

///
/// NOTE: This file was auto generated by file process_test_files.rb.
///
/// Do NOT edit this file directly as it will be regenerated automatically when needed.
///

extension GeometryCollectionCoordinate2DFloatingPrecisionCartesianTests {

   static var allTests: [(String, (GeometryCollectionCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testReserveCapacity", testReserveCapacity),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testRemove", testRemove),
                ("testRemoveLast", testRemoveLast),
                ("testRemoveAll", testRemoveAll),
                ("testRemoveAllKeepCapacity", testRemoveAllKeepCapacity),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount),
                ("testEnsureUniquelyReferenced", testEnsureUniquelyReferenced),
                ("testResizeIfNeeded", testResizeIfNeeded)
           ]
   }
}
