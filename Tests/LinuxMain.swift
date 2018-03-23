
/// build-tools: auto-generated

#if os(Linux) || os(FreeBSD)

import XCTest

@testable import GeoFeaturesTests
@testable import GeoFeaturesQuartzTests
@testable import GeoFeaturesMapKitTests
@testable import GeoFeaturesPlaygroundSupportTests

XCTMain([
   testCase(MultiPolygonSurfaceCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(PolygonCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(PolygonCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(WKTWriterCoordinate2DTests.allTests),
   testCase(WKTWriterCoordinate2DMTests.allTests),
   testCase(WKTWriterCoordinate3DTests.allTests),
   testCase(WKTWriterCoordinate3DMTests.allTests),
   testCase(GeometryCollectionGeometryFloatingPrecisionCartesianTests.allTests),
   testCase(GeometryCollectionGeometryFixedPrecisionCartesianTests.allTests),
   testCase(GeometryCollectionCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(AVLTreeTests.allTests),
   testCase(GeoJSONReaderCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(GeoJSONReaderCoordinate3DMFixedPrecisionCartesianTests.allTests),
   testCase(GeoJSONReaderInternal.allTests),
   testCase(Coordinate2DTests.allTests),
   testCase(LineStringCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(LineStringCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(LineStringCoordinate3DFixedPrecisionCartesianTests.allTests),
   testCase(LineStringCoordinate3DMFixedPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate3DFixedPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate3DMFixedPrecisionCartesianTests.allTests),
   testCase(TokenizerTests.allTests),
   testCase(WKTReaderCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(WKTReaderCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(WKTReaderCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(WKTReaderCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiLineStringCurveCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiLineStringCurveCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(LinearRingCurveCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingCurveCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPolygonCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(FixedPrecisionTests.allTests),
   testCase(PolygonSurfaceCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(PolygonGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(PolygonGeometryCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(PolygonGeometryCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(PolygonGeometryCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(PolygonGeometryCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(PolygonGeometryCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(PolygonGeometryCoordinate3DFixedPrecisionCartesianTests.allTests),
   testCase(PolygonGeometryCoordinate3DMFixedPrecisionCartesianTests.allTests),
   testCase(IntersectionMatrixTests.allTests),
   testCase(FloatingPrecisionTests.allTests),
   testCase(CoordinateSystemCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate3DFixedPrecisionCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate3DMFixedPrecisionCartesianTests.allTests),
   testCase(LineStringCurveCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringCurveCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingSurfaceCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingSurfaceCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(Coordinate3DMTests.allTests),
   testCase(PointGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(PointGeometryCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(PointGeometryCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(PointGeometryCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(PointGeometryCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(PointGeometryCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(PointGeometryCoordinate3DFixedPrecisionCartesianTests.allTests),
   testCase(PointGeometryCoordinate3DMFixedPrecisionCartesianTests.allTests),
   testCase(MultiPointCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(MultiPointCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(MultiPointCoordinate3DFixedPrecisionCartesianTests.allTests),
   testCase(MultiPointCoordinate3DMFixedPrecisionCartesianTests.allTests),
   testCase(Coordinate3DTests.allTests),
   testCase(MultiPolygonGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPolygonGeometryCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPolygonGeometryCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPolygonGeometryCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPolygonGeometryCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(MultiPolygonGeometryCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(MultiPolygonGeometryCoordinate3DFixedPrecisionCartesianTests.allTests),
   testCase(MultiPolygonGeometryCoordinate3DMFixedPrecisionCartesianTests.allTests),
   testCase(Coordinate2DMTests.allTests),
   testCase(MultiLineStringCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiLineStringCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiLineStringCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(MultiLineStringCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(CoordinateSystemGeographicTests.allTests),
   testCase(LinearRingGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingGeometryCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingGeometryCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingGeometryCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingGeometryCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(LinearRingGeometryCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(LinearRingGeometryCoordinate3DFixedPrecisionCartesianTests.allTests),
   testCase(LinearRingGeometryCoordinate3DMFixedPrecisionCartesianTests.allTests),
   testCase(MultiLineStringGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiLineStringGeometryCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiLineStringGeometryCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiLineStringGeometryCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiLineStringGeometryCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(MultiLineStringGeometryCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(MultiLineStringGeometryCoordinate3DFixedPrecisionCartesianTests.allTests),
   testCase(MultiLineStringGeometryCoordinate3DMFixedPrecisionCartesianTests.allTests),
   testCase(LineStringGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringGeometryCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringGeometryCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringGeometryCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringGeometryCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(LineStringGeometryCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(LineStringGeometryCoordinate3DFixedPrecisionCartesianTests.allTests),
   testCase(LineStringGeometryCoordinate3DMFixedPrecisionCartesianTests.allTests),
   testCase(PointCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(PointCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(PointCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(PointCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(PointCoordinate2DFixedPrecisionCartesianTests.allTests),
   testCase(PointCoordinate2DMFixedPrecisionCartesianTests.allTests),
   testCase(PointCoordinate3DFixedPrecisionCartesianTests.allTests),
   testCase(PointCoordinate3DMFixedPrecisionCartesianTests.allTests)
])

extension MultiPolygonSurfaceCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPolygonSurfaceCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testAreaEmpty", testAreaEmpty),
                ("testAreaWith2SamePolygons", testAreaWith2SamePolygons),
                ("testAreaWith2DifferentPolygons", testAreaWith2DifferentPolygons)
           ]
   }
}

extension PolygonCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PolygonCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitNoArg", testInitNoArg),
                ("testInitWithNoArgDefaults", testInitWithNoArgDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithRings", testInitWithRings),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testDescriptionEmpty", testDescriptionEmpty),
                ("testOperatorEqualGeometryPolygon", testOperatorEqualGeometryPolygon),
                ("testOperatorEqualPolygonGeometry", testOperatorEqualPolygonGeometry)
           ]
   }
}

extension PolygonCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (PolygonCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitNoArg", testInitNoArg),
                ("testInitWithNoArgDefaults", testInitWithNoArgDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithRings", testInitWithRings),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testOperatorEqualWithGeometryAndPolygon", testOperatorEqualWithGeometryAndPolygon),
                ("testOperatorEqualWithPolygonAndGeometry", testOperatorEqualWithPolygonAndGeometry)
           ]
   }
}

extension WKTWriterCoordinate2DTests {
   static var allTests: [(String, (WKTWriterCoordinate2DTests) -> () throws -> Void)] {
      return [
                ("testWriteUnsupportedGeometry", testWriteUnsupportedGeometry),
                ("testWritePoint", testWritePoint),
                ("testWriteLineStringEmpty", testWriteLineStringEmpty),
                ("testWriteLineStringsinglePoint", testWriteLineStringsinglePoint),
                ("testWriteLineStringmultiplePoints", testWriteLineStringmultiplePoints),
                ("testWriteLinearRingEmpty", testWriteLinearRingEmpty),
                ("testWriteLinearRing", testWriteLinearRing),
                ("testWritePolygonEmpty", testWritePolygonEmpty),
                ("testWritePolygon", testWritePolygon),
                ("testWritePolygonZeroInnerRings", testWritePolygonZeroInnerRings),
                ("testWriteMultiPointEmpty", testWriteMultiPointEmpty),
                ("testWriteMultiPointSinglePoint", testWriteMultiPointSinglePoint),
                ("testWriteMultiPointTwoPoints", testWriteMultiPointTwoPoints),
                ("testWriteMultiLineStringEmpty", testWriteMultiLineStringEmpty),
                ("testWriteMultiLineStringSingleLineString", testWriteMultiLineStringSingleLineString),
                ("testWriteMultiLineStringMultipleLineString", testWriteMultiLineStringMultipleLineString),
                ("testWriteMultiPolygonEmpty", testWriteMultiPolygonEmpty),
                ("testWriteMultiPolygon", testWriteMultiPolygon),
                ("testWriteGeometryCollection", testWriteGeometryCollection)
           ]
   }
}

extension WKTWriterCoordinate2DMTests {
   static var allTests: [(String, (WKTWriterCoordinate2DMTests) -> () throws -> Void)] {
      return [
                ("testWritePoint", testWritePoint),
                ("testWriteLineStringEmpty", testWriteLineStringEmpty),
                ("testWriteLineStringsinglePoint", testWriteLineStringsinglePoint),
                ("testWriteLineStringmultiplePoints", testWriteLineStringmultiplePoints),
                ("testWriteLinearRingEmpty", testWriteLinearRingEmpty),
                ("testWriteLinearRing", testWriteLinearRing),
                ("testWritePolygonEmpty", testWritePolygonEmpty),
                ("testWritePolygon", testWritePolygon),
                ("testWritePolygonZeroInnerRings", testWritePolygonZeroInnerRings),
                ("testWriteMultiPointEmpty", testWriteMultiPointEmpty),
                ("testWriteMultiPointSinglePoint", testWriteMultiPointSinglePoint),
                ("testWriteMultiPointTwoPoints", testWriteMultiPointTwoPoints),
                ("testWriteMultiLineStringEmpty", testWriteMultiLineStringEmpty),
                ("testWriteMultiLineStringSingleLineString", testWriteMultiLineStringSingleLineString),
                ("testWriteMultiLineStringMultipleLineString", testWriteMultiLineStringMultipleLineString),
                ("testWriteMultiPolygonEmpty", testWriteMultiPolygonEmpty),
                ("testWriteMultiPolygon", testWriteMultiPolygon)
           ]
   }
}

extension WKTWriterCoordinate3DTests {
   static var allTests: [(String, (WKTWriterCoordinate3DTests) -> () throws -> Void)] {
      return [
                ("testWritePoint", testWritePoint),
                ("testWriteLineStringEmpty", testWriteLineStringEmpty),
                ("testWriteLineStringsinglePoint", testWriteLineStringsinglePoint),
                ("testWriteLineStringmultiplePoints", testWriteLineStringmultiplePoints),
                ("testWriteLinearRingEmpty", testWriteLinearRingEmpty),
                ("testWriteLinearRing", testWriteLinearRing),
                ("testWritePolygonEmpty", testWritePolygonEmpty),
                ("testWritePolygon", testWritePolygon),
                ("testWritePolygonZeroInnerRings", testWritePolygonZeroInnerRings),
                ("testWriteMultiPointEmpty", testWriteMultiPointEmpty),
                ("testWriteMultiPointSinglePoint", testWriteMultiPointSinglePoint),
                ("testWriteMultiPointTwoPoints", testWriteMultiPointTwoPoints),
                ("testWriteMultiLineStringEmpty", testWriteMultiLineStringEmpty),
                ("testWriteMultiLineStringSingleLineString", testWriteMultiLineStringSingleLineString),
                ("testWriteMultiLineStringMultipleLineString", testWriteMultiLineStringMultipleLineString),
                ("testWriteMultiPolygonEmpty", testWriteMultiPolygonEmpty),
                ("testWriteMultiPolygon", testWriteMultiPolygon)
           ]
   }
}

extension WKTWriterCoordinate3DMTests {
   static var allTests: [(String, (WKTWriterCoordinate3DMTests) -> () throws -> Void)] {
      return [
                ("testWritePoint", testWritePoint),
                ("testWriteLineStringEmpty", testWriteLineStringEmpty),
                ("testWriteLineStringsinglePoint", testWriteLineStringsinglePoint),
                ("testWriteLineStringmultiplePoints", testWriteLineStringmultiplePoints),
                ("testWriteLinearRingEmpty", testWriteLinearRingEmpty),
                ("testWriteLinearRing", testWriteLinearRing),
                ("testWritePolygonEmpty", testWritePolygonEmpty),
                ("testWritePolygon", testWritePolygon),
                ("testWritePolygonZeroInnerRings", testWritePolygonZeroInnerRings),
                ("testWriteMultiPointEmpty", testWriteMultiPointEmpty),
                ("testWriteMultiPointSinglePoint", testWriteMultiPointSinglePoint),
                ("testWriteMultiPointTwoPoints", testWriteMultiPointTwoPoints),
                ("testWriteMultiLineStringEmpty", testWriteMultiLineStringEmpty),
                ("testWriteMultiLineStringSingleLineString", testWriteMultiLineStringSingleLineString),
                ("testWriteMultiLineStringMultipleLineString", testWriteMultiLineStringMultipleLineString),
                ("testWriteMultiPolygonEmpty", testWriteMultiPolygonEmpty),
                ("testWriteMultiPolygon", testWriteMultiPolygon)
           ]
   }
}

extension GeometryCollectionGeometryFloatingPrecisionCartesianTests {
   static var allTests: [(String, (GeometryCollectionGeometryFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionWithHomogeneousPoint", testDimensionWithHomogeneousPoint),
                ("testDimensionWithHomogeneousLineString", testDimensionWithHomogeneousLineString),
                ("testDimensionWithHomogeneousPolygon", testDimensionWithHomogeneousPolygon),
                ("testDimensionWithNonHomogeneousPointPolygon", testDimensionWithNonHomogeneousPointPolygon),
                ("testDimensionWithNonHomogeneousPointLineString", testDimensionWithNonHomogeneousPointLineString),
                ("testBoundary", testBoundary),
                ("testEqualTrue", testEqualTrue),
                ("testEqualWithSameTypesFalse", testEqualWithSameTypesFalse),
                ("testEqualWithDifferentTypesFalse", testEqualWithDifferentTypesFalse)
           ]
   }
}

extension GeometryCollectionGeometryFixedPrecisionCartesianTests {
   static var allTests: [(String, (GeometryCollectionGeometryFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionWithHomogeneousPoint", testDimensionWithHomogeneousPoint),
                ("testDimensionWithHomogeneousLineString", testDimensionWithHomogeneousLineString),
                ("testDimensionWithHomogeneousPolygon", testDimensionWithHomogeneousPolygon),
                ("testDimensionWithNonHomogeneousPointPolygon", testDimensionWithNonHomogeneousPointPolygon),
                ("testDimensionWithNonHomogeneousPointLineString", testDimensionWithNonHomogeneousPointLineString)
           ]
   }
}

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
                ("testAppendContentsOf", testAppendContentsOf),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension AVLTreeTests {
   static var allTests: [(String, (AVLTreeTests) -> () throws -> Void)] {
      return [
                ("testLeftRotation", testLeftRotation),
                ("testRightRotation", testRightRotation),
                ("testLeftRightRotation", testLeftRightRotation),
                ("testRightLeftRotation", testRightLeftRotation),
                ("testHeightEmptyTree", testHeightEmptyTree),
                ("testHeight", testHeight),
                ("testBalancedEmptyTree", testBalancedEmptyTree),
                ("testBalanced9NodeTree", testBalanced9NodeTree),
                ("testBalanced1NodeTree", testBalanced1NodeTree),
                ("testBalanced2NodeTree", testBalanced2NodeTree),
                ("testBalanced3NodeRightHeavyTree", testBalanced3NodeRightHeavyTree),
                ("testHeight3NodeRightHeavyTree", testHeight3NodeRightHeavyTree),
                ("testBalanced3NodeLeftHeavyTree", testBalanced3NodeLeftHeavyTree),
                ("testHeight3NodeLeftHeavyTree", testHeight3NodeLeftHeavyTree),
                ("testBalanced3NodeLeftRightHeavyTree", testBalanced3NodeLeftRightHeavyTree),
                ("testHeight3NodeLeftRightHeavyTree", testHeight3NodeLeftRightHeavyTree),
                ("testBalanced3NodeOrderedTree", testBalanced3NodeOrderedTree),
                ("testInsertNonExisting30", testInsertNonExisting30),
                ("testInsertLeftA", testInsertLeftA),
                ("testInsertLeftnegative1", testInsertLeftnegative1),
                ("testInsertExisting8", testInsertExisting8),
                ("testDeleteNonExisting30", testDeleteNonExisting30),
                ("testDeleteRoot1NodeTree", testDeleteRoot1NodeTree),
                ("testDeleteRoot3NodeTree", testDeleteRoot3NodeTree),
                ("testDeleteExisting1", testDeleteExisting1),
                ("testDeleteExisting5", testDeleteExisting5),
                ("testDeleteExisting7", testDeleteExisting7),
                ("testDeleteExisting8", testDeleteExisting8),
                ("testDeleteExisting10", testDeleteExisting10),
                ("testDeleteExistingLeafNodesForceReBalance", testDeleteExistingLeafNodesForceReBalance),
                ("testDeleteExistingLeafNodesNoReBalance", testDeleteExistingLeafNodesNoReBalance),
                ("testDeleteExistingInnerNodes", testDeleteExistingInnerNodes),
                ("testDeleteExistingSingleLeftNode", testDeleteExistingSingleLeftNode),
                ("testDeleteExistingAllBut3", testDeleteExistingAllBut3),
                ("testDeleteExistingAllBut1", testDeleteExistingAllBut1),
                ("testDeleteExistingAll", testDeleteExistingAll),
                ("testSearchExisting1", testSearchExisting1),
                ("testSearchExisting8", testSearchExisting8),
                ("testSearchExisting25", testSearchExisting25),
                ("testSearchNonExisting0", testSearchNonExisting0),
                ("testSearchNonExisting30", testSearchNonExisting30),
                ("testNextOf1", testNextOf1),
                ("testNextOf7", testNextOf7),
                ("testNextOf8", testNextOf8),
                ("testNextOf10", testNextOf10),
                ("testNextOf15", testNextOf15),
                ("testNextOf25", testNextOf25),
                ("testPreviousOf1", testPreviousOf1),
                ("testPreviousOf8", testPreviousOf8),
                ("testPreviousOf10", testPreviousOf10),
                ("testPreviousOf15", testPreviousOf15),
                ("testPreviousOf17", testPreviousOf17),
                ("testSearchPerformance", testSearchPerformance),
                ("testInsertPerformance", testInsertPerformance),
                ("testDeletePerformance", testDeletePerformance),
                ("testInsertDeleteBestTimePerformance", testInsertDeleteBestTimePerformance),
                ("testInsertDeleteWorstTimePerformance", testInsertDeleteWorstTimePerformance)
           ]
   }
}

extension GeoJSONReaderCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (GeoJSONReaderCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testReadWithInvalidJSON", testReadWithInvalidJSON),
                ("testReadWithInvalidRoot", testReadWithInvalidRoot),
                ("testReadWithMissingTypeAttribute", testReadWithMissingTypeAttribute),
                ("testReadWithUnsupportedType", testReadWithUnsupportedType),
                ("testReadWithMissingCoordinates", testReadWithMissingCoordinates),
                ("testReadWithInvalidCoordinateStructure", testReadWithInvalidCoordinateStructure),
                ("testReadWithInvalidNumberOfCoordinates", testReadWithInvalidNumberOfCoordinates),
                ("testReadWithMissingGeometries", testReadWithMissingGeometries),
                ("testReadWithInvalidGeometriesStructure", testReadWithInvalidGeometriesStructure),
                ("testReadWithValidPoint", testReadWithValidPoint),
                ("testReadWithValidLineString", testReadWithValidLineString),
                ("testReadWithValidPolygon", testReadWithValidPolygon),
                ("testReadWithValidMultiPoint", testReadWithValidMultiPoint),
                ("testReadWithValidMultiLineString", testReadWithValidMultiLineString),
                ("testReadWithValidMultiPolygon", testReadWithValidMultiPolygon),
                ("testReadWithValidGeometryCollection", testReadWithValidGeometryCollection)
           ]
   }
}

extension GeoJSONReaderCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (GeoJSONReaderCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testReadWithInvalidNumberOfCoordinates", testReadWithInvalidNumberOfCoordinates),
                ("testReadWithValidPoint", testReadWithValidPoint),
                ("testReadWithValidLineString", testReadWithValidLineString),
                ("testReadWithValidPolygon", testReadWithValidPolygon),
                ("testReadWithValidMultiPoint", testReadWithValidMultiPoint),
                ("testReadWithValidMultiLineString", testReadWithValidMultiLineString),
                ("testReadWithValidMultiPolygon", testReadWithValidMultiPolygon),
                ("testReadWithValidGeometryCollection", testReadWithValidGeometryCollection)
           ]
   }
}

extension GeoJSONReaderInternal {
   static var allTests: [(String, (GeoJSONReaderInternal) -> () throws -> Void)] {
      return [
                ("testCoordinateWithDouble", testCoordinateWithDouble),
                ("testCoordinateWithNSNumber", testCoordinateWithNSNumber),
                ("testCoordinateWithInt", testCoordinateWithInt),
                ("testCoordinateWithFloat", testCoordinateWithFloat),
                ("testCoordinateWithString", testCoordinateWithString),
                ("testCoordinateWithInvalidString", testCoordinateWithInvalidString),
                ("testCoordinatesWithInvalidStructure", testCoordinatesWithInvalidStructure)
           ]
   }
}

extension Coordinate2DTests {
   static var allTests: [(String, (Coordinate2DTests) -> () throws -> Void)] {
      return [
                ("testInitWithXY", testInitWithXY),
                ("testX", testX),
                ("testY", testY),
                ("testInitWithTuple", testInitWithTuple),
                ("testTuple", testTuple),
                ("testInit_Array", testInit_Array),
                ("testInit_Array_Invalid", testInit_Array_Invalid),
                ("testInitCopy", testInitCopy),
                ("testInitCopyWithFixedPrecision", testInitCopyWithFixedPrecision),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testEqual", testEqual),
                ("testNotEqual", testNotEqual),
                ("testHashValueWithZero", testHashValueWithZero),
                ("testHashValueWithPositiveValue", testHashValueWithPositiveValue)
           ]
   }
}

extension LineStringCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LineStringCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LineStringCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LineStringCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LineStringCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LineStringCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LineStringCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LineStringCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LineStringCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (LineStringCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LineStringCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (LineStringCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LineStringCoordinate3DFixedPrecisionCartesianTests {
   static var allTests: [(String, (LineStringCoordinate3DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LineStringCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (LineStringCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate3DFixedPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate3DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testAppendContentsOfCoordinates", testAppendContentsOfCoordinates),
                ("testAppendContentsOfWithTuples", testAppendContentsOfWithTuples),
                ("testInsertCoordinate", testInsertCoordinate),
                ("testInsertTuple", testInsertTuple),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension TokenizerTests {
   static var allTests: [(String, (TokenizerTests) -> () throws -> Void)] {
      return [
                ("testExpectSingleWhiteSpaceTrue", testExpectSingleWhiteSpaceTrue),
                ("testExpectSingleWhiteSpaceFalse", testExpectSingleWhiteSpaceFalse),
                ("testMatchSingleWhiteSpaceTrue", testMatchSingleWhiteSpaceTrue),
                ("testMatchSingleWhiteSpaceFalse", testMatchSingleWhiteSpaceFalse),
                ("testMatchNewLineTrue", testMatchNewLineTrue),
                ("testMatchNewLineFalse", testMatchNewLineFalse),
                ("testMatchUnicodeGlobeTrue", testMatchUnicodeGlobeTrue),
                ("testMatchUnicodeGlobeFalse", testMatchUnicodeGlobeFalse),
                ("testMatchUnicodeFlagTrue", testMatchUnicodeFlagTrue),
                ("testMatchUnicodeFlagFalse", testMatchUnicodeFlagFalse),
                ("testMatchUnicodeEPlusAccent", testMatchUnicodeEPlusAccent),
                ("testMatchUnicodeEPlusAccentFalse", testMatchUnicodeEPlusAccentFalse),
                ("testMatchUnicodeEWithAccent", testMatchUnicodeEWithAccent),
                ("testMatchUnicodeEWithAccentFalse", testMatchUnicodeEWithAccentFalse),
                ("testColumnParens", testColumnParens),
                ("testColumnUnicodeGlobes", testColumnUnicodeGlobes),
                ("testColumnUnicodeEPlusAccent", testColumnUnicodeEPlusAccent),
                ("testColumnUnicodeEWithAccent", testColumnUnicodeEWithAccent),
                ("testColumnUnicodeEPlusAccentCanonical", testColumnUnicodeEPlusAccentCanonical),
                ("testLine", testLine),
                ("testMatchString", testMatchString)
           ]
   }
}

extension WKTReaderCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (WKTReaderCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testReadPointFloatValid", testReadPointFloatValid),
                ("testReadUsingUTF8Data", testReadUsingUTF8Data),
                ("testReadUsingUnicodeData", testReadUsingUnicodeData),
                ("testReadDataNotConvertableUsingUTF8", testReadDataNotConvertableUsingUTF8),
                ("testReadInvalidNumberOfCoordinates", testReadInvalidNumberOfCoordinates),
                ("testReadInvalidGeometry", testReadInvalidGeometry),
                ("testReadPointIntValid", testReadPointIntValid),
                ("testReadPointValidExponentUpperCase", testReadPointValidExponentUpperCase),
                ("testReadPointValidExponentLowerCase", testReadPointValidExponentLowerCase),
                ("testReadPointInvalidCoordinateNoSpace", testReadPointInvalidCoordinateNoSpace),
                ("testReadPointInvalidCoordinateX", testReadPointInvalidCoordinateX),
                ("testReadPointInvalidCoordinateY", testReadPointInvalidCoordinateY),
                ("testReadPointInvalidWhiteSpace", testReadPointInvalidWhiteSpace),
                ("testReadPointInvalidMissingLeftParen", testReadPointInvalidMissingLeftParen),
                ("testReadPointInvalidMissingRightParen", testReadPointInvalidMissingRightParen),
                ("testReadLineStringValid", testReadLineStringValid),
                ("testReadLineStringValidEmpty", testReadLineStringValidEmpty),
                ("testReadLineStringInvalidWhiteSpace", testReadLineStringInvalidWhiteSpace),
                ("testReadLineStringInvalidDoubleSapceAfterComma", testReadLineStringInvalidDoubleSapceAfterComma),
                ("testReadLineStringInvalidMissingLeftParen", testReadLineStringInvalidMissingLeftParen),
                ("testReadLineStringInvalidMissingRightParen", testReadLineStringInvalidMissingRightParen),
                ("testReadLinearRingValid", testReadLinearRingValid),
                ("testReadLinearRingValidEmpty", testReadLinearRingValidEmpty),
                ("testReadLinearRingInvalidWhiteSpace", testReadLinearRingInvalidWhiteSpace),
                ("testReadLinearRingInvalidDoubleSapceAfterComma", testReadLinearRingInvalidDoubleSapceAfterComma),
                ("testReadLinearRingInvalidMissingLeftParen", testReadLinearRingInvalidMissingLeftParen),
                ("testReadLinearRingInvalidMissingRightParen", testReadLinearRingInvalidMissingRightParen),
                ("testReadMultiPointValid", testReadMultiPointValid),
                ("testReadMultiPointValidEmpty", testReadMultiPointValidEmpty),
                ("testReadMultiPointInvalidWhiteSpace", testReadMultiPointInvalidWhiteSpace),
                ("testReadMultiPointInvalidDoubleSapceAfterComma", testReadMultiPointInvalidDoubleSapceAfterComma),
                ("testReadMultiPointInvalidMissingLeftParen", testReadMultiPointInvalidMissingLeftParen),
                ("testReadMultiPointInvalidMissingRightParen", testReadMultiPointInvalidMissingRightParen),
                ("testReadMultiLineStringValid", testReadMultiLineStringValid),
                ("testReadMultiLineStringValidEmpty", testReadMultiLineStringValidEmpty),
                ("testReadMultiLineStringInvalidWhiteSpace", testReadMultiLineStringInvalidWhiteSpace),
                ("testReadMultiLineStringInvalidDoubleSapceAfterComma", testReadMultiLineStringInvalidDoubleSapceAfterComma),
                ("testReadMultiLineStringInvalidMissingLeftParen", testReadMultiLineStringInvalidMissingLeftParen),
                ("testReadMultiLineStringInvalidMissingRightParen", testReadMultiLineStringInvalidMissingRightParen),
                ("testReadPolygonZeroInnerRingsValid", testReadPolygonZeroInnerRingsValid),
                ("testReadPolygonSingleOuterRingValid", testReadPolygonSingleOuterRingValid),
                ("testReadPolygonMultipleInnerRingsValid", testReadPolygonMultipleInnerRingsValid),
                ("testReadPolygonMultipleInnerRingsInvalidMissingComma", testReadPolygonMultipleInnerRingsInvalidMissingComma),
                ("testReadPolygonMultipleInnerRingsInvalidExtraWhiteSpaceInnerRing", testReadPolygonMultipleInnerRingsInvalidExtraWhiteSpaceInnerRing),
                ("testReadPolygonValidEmpty", testReadPolygonValidEmpty),
                ("testReadPolygonInvalidWhiteSpace", testReadPolygonInvalidWhiteSpace),
                ("testReadPolygonInvalidDoubleSapceAfterComma", testReadPolygonInvalidDoubleSapceAfterComma),
                ("testReadPolygonInvalidMissingLeftParen", testReadPolygonInvalidMissingLeftParen),
                ("testReadPolygonInvalidMissingRightParen", testReadPolygonInvalidMissingRightParen),
                ("testReadMultiPolygonValid", testReadMultiPolygonValid),
                ("testReadMultiPolygonValidEmpty", testReadMultiPolygonValidEmpty),
                ("testReadMultiPolygonInvalidWhiteSpace", testReadMultiPolygonInvalidWhiteSpace),
                ("testReadMultiPolygonInvalidDoubleSapceAfterComma", testReadMultiPolygonInvalidDoubleSapceAfterComma),
                ("testReadMultiPolygonInvalidMissingLeftParen", testReadMultiPolygonInvalidMissingLeftParen),
                ("testReadMultiPolygonInvalidMissingRightParen", testReadMultiPolygonInvalidMissingRightParen),
                ("testReadGeometryCollectionValid", testReadGeometryCollectionValid),
                ("testReadGeometryCollectionValidEmpty", testReadGeometryCollectionValidEmpty),
                ("testReadGeometryCollectionInvalidWhiteSpace", testReadGeometryCollectionInvalidWhiteSpace),
                ("testReadGeometryCollectionInvalidDoubleSapceAfterComma", testReadGeometryCollectionInvalidDoubleSapceAfterComma),
                ("testReadGeometryCollectionInvalidMissingLeftParen", testReadGeometryCollectionInvalidMissingLeftParen),
                ("testReadGeometryCollectionInvalidMissingRightParen", testReadGeometryCollectionInvalidMissingRightParen),
                ("testReadPerformancePolygonCalifornia", testReadPerformancePolygonCalifornia)
           ]
   }
}

extension WKTReaderCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (WKTReaderCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testReadPointValid", testReadPointValid),
                ("testReadPointInvalidCoordinateM", testReadPointInvalidCoordinateM),
                ("testReadPointInvalidCoordinateMissingM", testReadPointInvalidCoordinateMissingM),
                ("testReadPointInvalidCoordinateNoSpaceAfterM", testReadPointInvalidCoordinateNoSpaceAfterM),
                ("testReadPointInvalidCoordinateNoSpaceBeforeM", testReadPointInvalidCoordinateNoSpaceBeforeM),
                ("testReadInvalidNumberOfCoordinates", testReadInvalidNumberOfCoordinates),
                ("testReadGeometryCollectionValid", testReadGeometryCollectionValid),
                ("testReadGeometryCollectionInvalidElementNoM", testReadGeometryCollectionInvalidElementNoM)
           ]
   }
}

extension WKTReaderCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (WKTReaderCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testReadPointValid", testReadPointValid),
                ("testReadPointInvalidCoordinateZ", testReadPointInvalidCoordinateZ),
                ("testReadPointInvalidCoordinateMissingZ", testReadPointInvalidCoordinateMissingZ),
                ("testReadPointInvalidCoordinateNoSpaceAfterZ", testReadPointInvalidCoordinateNoSpaceAfterZ),
                ("testReadPointInvalidCoordinateNoSpaceBeforeZ", testReadPointInvalidCoordinateNoSpaceBeforeZ),
                ("testReadGeometryCollectionValid", testReadGeometryCollectionValid),
                ("testReadGeometryCollectionInvalidElementNoZ", testReadGeometryCollectionInvalidElementNoZ)
           ]
   }
}

extension WKTReaderCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (WKTReaderCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testReadPointValid", testReadPointValid),
                ("testReadPointInvalidCoordinateM", testReadPointInvalidCoordinateM),
                ("testReadPointInvalidCoordinateMissingM", testReadPointInvalidCoordinateMissingM),
                ("testReadPointInvalidCoordinateNoSpaceAfterM", testReadPointInvalidCoordinateNoSpaceAfterM),
                ("testReadPointInvalidCoordinateNoSpaceBeforeM", testReadPointInvalidCoordinateNoSpaceBeforeM),
                ("testReadGeometryCollectionValid", testReadGeometryCollectionValid),
                ("testReadGeometryCollectionInvalidElementNoZ", testReadGeometryCollectionInvalidElementNoZ),
                ("testReadGeometryCollectionInvalidElementNoM", testReadGeometryCollectionInvalidElementNoM)
           ]
   }
}

extension MultiLineStringCurveCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringCurveCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testIsClosedClosed", testIsClosedClosed),
                ("testIsClosedOpen", testIsClosedOpen),
                ("testIsClosedEmpty", testIsClosedEmpty),
                ("testLength", testLength)
           ]
   }
}

extension MultiLineStringCurveCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringCurveCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testIsClosedClosed", testIsClosedClosed),
                ("testIsClosedOpen", testIsClosedOpen),
                ("testIsClosedEmpty", testIsClosedEmpty),
                ("testLength", testLength)
           ]
   }
}

extension LinearRingCurveCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingCurveCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testLengthTest1", testLengthTest1),
                ("testLengthTest2", testLengthTest2),
                ("testLengthTest3", testLengthTest3),
                ("testLengthTest4", testLengthTest4),
                ("testLengthPerformance", testLengthPerformance),
                ("testIsClosedClosed", testIsClosedClosed),
                ("testIsClosedOpen", testIsClosedOpen),
                ("testIsClosedEmpty", testIsClosedEmpty)
           ]
   }
}

extension LinearRingCurveCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingCurveCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testPerformanceLength", testPerformanceLength)
           ]
   }
}

extension MultiPolygonCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPolygonCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension FixedPrecisionTests {
   static var allTests: [(String, (FixedPrecisionTests) -> () throws -> Void)] {
      return [
                ("testConvertWithScale10Lower", testConvertWithScale10Lower),
                ("testConvertWithScale10Middle", testConvertWithScale10Middle),
                ("testConvertWithScale10Upper", testConvertWithScale10Upper),
                ("testConvertWithScale10Lower2", testConvertWithScale10Lower2),
                ("testConvertWithScale10Middle2", testConvertWithScale10Middle2),
                ("testConvertWithScale10Upper2", testConvertWithScale10Upper2),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse),
                ("testEqualFalseWithDifferentType", testEqualFalseWithDifferentType)
           ]
   }
}

extension PolygonSurfaceCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (PolygonSurfaceCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testAreaEmpty", testAreaEmpty),
                ("testAreaWithTriangle", testAreaWithTriangle),
                ("testAreaWithRegularQuadrilateral", testAreaWithRegularQuadrilateral),
                ("testAreaWithSimplePolygon1", testAreaWithSimplePolygon1),
                ("testAreaWithSimplePolygon2", testAreaWithSimplePolygon2),
                ("testAreaWithSimplePolygon3", testAreaWithSimplePolygon3),
                ("testAreaWithSimplePolygonWithHole", testAreaWithSimplePolygonWithHole),
                ("testAreaWithPentagon", testAreaWithPentagon),
                ("testAreaWithRegularPentagon", testAreaWithRegularPentagon),
                ("testAreaWithRegularDecagon", testAreaWithRegularDecagon),
                ("testAreaWithTetrakaidecagon", testAreaWithTetrakaidecagon),
                ("testAreaWithRegularQuadrilateralCrossingOrigin", testAreaWithRegularQuadrilateralCrossingOrigin),
                ("testPerformanceAreaQuadrilateral", testPerformanceAreaQuadrilateral)
           ]
   }
}

extension PolygonGeometryCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PolygonGeometryCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundaryWithOuterRing", testBoundaryWithOuterRing),
                ("testBoundaryWithOuterRingAnd1InnerRing", testBoundaryWithOuterRingAnd1InnerRing),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension PolygonGeometryCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PolygonGeometryCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension PolygonGeometryCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PolygonGeometryCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension PolygonGeometryCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PolygonGeometryCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension PolygonGeometryCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (PolygonGeometryCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension PolygonGeometryCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (PolygonGeometryCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension PolygonGeometryCoordinate3DFixedPrecisionCartesianTests {
   static var allTests: [(String, (PolygonGeometryCoordinate3DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension PolygonGeometryCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (PolygonGeometryCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension IntersectionMatrixTests {
   static var allTests: [(String, (IntersectionMatrixTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testMakeIterator", testMakeIterator),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testMatchesTrue", testMatchesTrue),
                ("testMatchesFalse", testMatchesFalse),
                ("testMatchesMatchT", testMatchesMatchT),
                ("testMatchesMatchF", testMatchesMatchF),
                ("testMatchesMatch0", testMatchesMatch0),
                ("testMatchesMatch1", testMatchesMatch1),
                ("testMatchesMatch2", testMatchesMatch2),
                ("testMatchesNoMatchT", testMatchesNoMatchT),
                ("testMatchesNoMatchF", testMatchesNoMatchF),
                ("testMatchesNoMatch0", testMatchesNoMatch0),
                ("testMatchesNoMatch1", testMatchesNoMatch1),
                ("testMatchesNoMatch2", testMatchesNoMatch2),
                ("testMatchesNoMatchInvalidChar", testMatchesNoMatchInvalidChar),
                ("testMatchesNoMatchPatternToShort", testMatchesNoMatchPatternToShort),
                ("testDescription", testDescription),
                ("testEqual", testEqual),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension FloatingPrecisionTests {
   static var allTests: [(String, (FloatingPrecisionTests) -> () throws -> Void)] {
      return [
                ("testConvertEqual", testConvertEqual),
                ("testConvertNotEqual1", testConvertNotEqual1),
                ("testConvertNotEqual2", testConvertNotEqual2),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalseWithDifferentType", testEqualFalseWithDifferentType)
           ]
   }
}

extension CoordinateSystemCartesianTests {
   static var allTests: [(String, (CoordinateSystemCartesianTests) -> () throws -> Void)] {
      return [
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
           ]
   }
}

extension MultiPointGeometryCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate3DFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate3DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension MultiPointGeometryCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension LineStringCurveCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LineStringCurveCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testLengthTest1", testLengthTest1),
                ("testLengthTest2", testLengthTest2),
                ("testLengthTest3", testLengthTest3),
                ("testLengthTest4", testLengthTest4),
                ("testLengthPerformance", testLengthPerformance),
                ("testIsClosedClosed", testIsClosedClosed),
                ("testIsClosedOpen", testIsClosedOpen),
                ("testIsClosedEmpty", testIsClosedEmpty)
           ]
   }
}

extension LineStringCurveCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LineStringCurveCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testPerformanceLength", testPerformanceLength)
           ]
   }
}

extension LinearRingSurfaceCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingSurfaceCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testAreaEmpty", testAreaEmpty),
                ("testAreaWithTriangle", testAreaWithTriangle),
                ("testAreaWithRegularQuadrilateral", testAreaWithRegularQuadrilateral),
                ("testAreaWithSimplePolygon1", testAreaWithSimplePolygon1),
                ("testAreaWithSimplePolygon2", testAreaWithSimplePolygon2),
                ("testAreaWithSimplePolygon3", testAreaWithSimplePolygon3),
                ("testAreaWithSimplePolygon4", testAreaWithSimplePolygon4),
                ("testAreaWithPentagon", testAreaWithPentagon),
                ("testAreaWithRegularPentagon", testAreaWithRegularPentagon),
                ("testAreaWithRegularDecagon", testAreaWithRegularDecagon),
                ("testAreaWithTetrakaidecagon", testAreaWithTetrakaidecagon),
                ("testAreaWithQuadrilateralCrossingOrigin", testAreaWithQuadrilateralCrossingOrigin),
                ("testPerformanceAreaRegularQuadrilateral", testPerformanceAreaRegularQuadrilateral)
           ]
   }
}

extension LinearRingSurfaceCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingSurfaceCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testAreaEmpty", testAreaEmpty),
                ("testAreaWithTriangle", testAreaWithTriangle),
                ("testAreaWithRegularQuadrilateral", testAreaWithRegularQuadrilateral),
                ("testAreaWithSimplePolygon1", testAreaWithSimplePolygon1),
                ("testAreaWithSimplePolygon2", testAreaWithSimplePolygon2),
                ("testAreaWithSimplePolygon3", testAreaWithSimplePolygon3),
                ("testAreaWithSimplePolygon4", testAreaWithSimplePolygon4),
                ("testAreaWithPentagon", testAreaWithPentagon),
                ("testAreaWithRegularPentagon", testAreaWithRegularPentagon),
                ("testAreaWithRegularDecagon", testAreaWithRegularDecagon),
                ("testAreaWithTetrakaidecagon", testAreaWithTetrakaidecagon),
                ("testAreaQWithuadrilateralCrossingOrigin", testAreaQWithuadrilateralCrossingOrigin),
                ("testPerformanceAreaRegularQuadrilateral", testPerformanceAreaRegularQuadrilateral)
           ]
   }
}

extension Coordinate3DMTests {
   static var allTests: [(String, (Coordinate3DMTests) -> () throws -> Void)] {
      return [
                ("testInitWithXYZM", testInitWithXYZM),
                ("testX", testX),
                ("testY", testY),
                ("testZ", testZ),
                ("testM", testM),
                ("testInitWithTuple", testInitWithTuple),
                ("testTuple", testTuple),
                ("testInit_Array", testInit_Array),
                ("testInit_Array_Invalid", testInit_Array_Invalid),
                ("testInitCopy", testInitCopy),
                ("testInitCopyWithFixedPrecision", testInitCopyWithFixedPrecision),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testEqual", testEqual),
                ("testNotEqual", testNotEqual),
                ("testHashWithValueZero", testHashWithValueZero),
                ("testHashValueWithPositiveValue", testHashValueWithPositiveValue)
           ]
   }
}

extension PointGeometryCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension PointGeometryCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension PointGeometryCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension PointGeometryCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension PointGeometryCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension PointGeometryCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension PointGeometryCoordinate3DFixedPrecisionCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate3DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension PointGeometryCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension MultiPointCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiPointCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiPointCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiPointCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiPointCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiPointCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiPointCoordinate3DFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointCoordinate3DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiPointCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension Coordinate3DTests {
   static var allTests: [(String, (Coordinate3DTests) -> () throws -> Void)] {
      return [
                ("testInitXYZ", testInitXYZ),
                ("testX", testX),
                ("testY", testY),
                ("testZ", testZ),
                ("testInitWithTuple", testInitWithTuple),
                ("testTuple", testTuple),
                ("testInit_Array", testInit_Array),
                ("testInit_Array_Invalid", testInit_Array_Invalid),
                ("testInitCopy", testInitCopy),
                ("testInitCopyWithFixedPrecision", testInitCopyWithFixedPrecision),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testEqual", testEqual),
                ("testNotEqual", testNotEqual),
                ("testHashValueWithZero", testHashValueWithZero),
                ("testHashValueWithPositiveValue", testHashValueWithPositiveValue)
           ]
   }
}

extension MultiPolygonGeometryCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPolygonGeometryCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundaryWithSinglePolygonNoInnerRings", testBoundaryWithSinglePolygonNoInnerRings),
                ("testBoundaryWithSinglePolygonInnerRings", testBoundaryWithSinglePolygonInnerRings),
                ("testBoundaryWithMultiplePolygons", testBoundaryWithMultiplePolygons),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testEqualTrue", testEqualTrue),
                ("testEqualWithSameTypesFalse", testEqualWithSameTypesFalse),
                ("testEqualWithDifferentTypesFalse", testEqualWithDifferentTypesFalse)
           ]
   }
}

extension MultiPolygonGeometryCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPolygonGeometryCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiPolygonGeometryCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPolygonGeometryCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiPolygonGeometryCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPolygonGeometryCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiPolygonGeometryCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPolygonGeometryCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiPolygonGeometryCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPolygonGeometryCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiPolygonGeometryCoordinate3DFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPolygonGeometryCoordinate3DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiPolygonGeometryCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiPolygonGeometryCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension Coordinate2DMTests {
   static var allTests: [(String, (Coordinate2DMTests) -> () throws -> Void)] {
      return [
                ("testInitWithXYM", testInitWithXYM),
                ("testX", testX),
                ("testY", testY),
                ("testM", testM),
                ("testInitWithTuple", testInitWithTuple),
                ("testTuple", testTuple),
                ("testInit_Array", testInit_Array),
                ("testInit_Array_Invalid", testInit_Array_Invalid),
                ("testInitCopy", testInitCopy),
                ("testInitCopyWithFixedPrecision", testInitCopyWithFixedPrecision),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testEqual", testEqual),
                ("testNotEqual", testNotEqual),
                ("testHashValueWithZero", testHashValueWithZero),
                ("testHashValueWithPositiveValue", testHashValueWithPositiveValue)
           ]
   }
}

extension MultiLineStringCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiLineStringCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiLineStringCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiLineStringCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithTuple", testInitWithTuple),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testAppend", testAppend),
                ("testAppendContentsOf", testAppendContentsOf),
                ("testInsert2ExistingElements", testInsert2ExistingElements),
                ("testInsert1ExistingElements", testInsert1ExistingElements),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension CoordinateSystemGeographicTests {
   static var allTests: [(String, (CoordinateSystemGeographicTests) -> () throws -> Void)] {
      return [
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
           ]
   }
}

extension LinearRingGeometryCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingGeometryCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundaryWith1ElementInvalid", testBoundaryWith1ElementInvalid),
                ("testBoundaryWith2Element", testBoundaryWith2Element),
                ("testBoundaryWith3ElementOpen", testBoundaryWith3ElementOpen),
                ("testBoundaryWith4ElementClosed", testBoundaryWith4ElementClosed),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension LinearRingGeometryCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingGeometryCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LinearRingGeometryCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingGeometryCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LinearRingGeometryCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingGeometryCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LinearRingGeometryCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingGeometryCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LinearRingGeometryCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingGeometryCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LinearRingGeometryCoordinate3DFixedPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingGeometryCoordinate3DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LinearRingGeometryCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (LinearRingGeometryCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiLineStringGeometryCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringGeometryCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundaryWith1ElementInvalid", testBoundaryWith1ElementInvalid),
                ("testBoundaryWith2Element", testBoundaryWith2Element),
                ("testBoundaryWith3ElementOpen", testBoundaryWith3ElementOpen),
                ("testBoundaryWith4ElementClosed", testBoundaryWith4ElementClosed),
                ("testBoundaryWith2EqualPoints", testBoundaryWith2EqualPoints),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testBoundaryWithOGCMultiCurveA", testBoundaryWithOGCMultiCurveA),
                ("testBoundaryWithOGCMultiCurveB", testBoundaryWithOGCMultiCurveB),
                ("testBoundaryWithOGCMultiCurveC", testBoundaryWithOGCMultiCurveC),
                ("testBoundaryWithOddIntersection", testBoundaryWithOddIntersection),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension MultiLineStringGeometryCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringGeometryCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiLineStringGeometryCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringGeometryCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiLineStringGeometryCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringGeometryCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiLineStringGeometryCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringGeometryCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiLineStringGeometryCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringGeometryCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiLineStringGeometryCoordinate3DFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringGeometryCoordinate3DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension MultiLineStringGeometryCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringGeometryCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LineStringGeometryCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LineStringGeometryCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testBoundaryWith1ElementInvalid", testBoundaryWith1ElementInvalid),
                ("testBoundaryWith2Element", testBoundaryWith2Element),
                ("testBoundaryWith3ElementOpen", testBoundaryWith3ElementOpen),
                ("testBoundaryWith4ElementClosed", testBoundaryWith4ElementClosed),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension LineStringGeometryCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LineStringGeometryCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LineStringGeometryCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LineStringGeometryCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LineStringGeometryCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LineStringGeometryCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LineStringGeometryCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (LineStringGeometryCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LineStringGeometryCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (LineStringGeometryCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LineStringGeometryCoordinate3DFixedPrecisionCartesianTests {
   static var allTests: [(String, (LineStringGeometryCoordinate3DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension LineStringGeometryCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (LineStringGeometryCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension)
           ]
   }
}

extension PointCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
           ]
   }
}

extension PointCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
           ]
   }
}

extension PointCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
           ]
   }
}

extension PointCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
           ]
   }
}

extension PointCoordinate2DFixedPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate2DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit)
           ]
   }
}

extension PointCoordinate2DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate2DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit)
           ]
   }
}

extension PointCoordinate3DFixedPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate3DFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit)
           ]
   }
}

extension PointCoordinate3DMFixedPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate3DMFixedPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit)
           ]
   }
}

#endif
