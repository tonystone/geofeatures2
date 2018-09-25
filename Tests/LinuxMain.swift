
/// build-tools: auto-generated

#if os(Linux) || os(FreeBSD)

import XCTest

@testable import GeoFeaturesTests

XCTMain([
   testCase(MultiPolygonSurfaceCoordinate2DFixedCartesianTests.allTests),
   testCase(PolygonCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(PolygonCoordinate2DFixedCartesianTests.allTests),
   testCase(WKTWriterCoordinate2DTests.allTests),
   testCase(WKTWriterCoordinate2DMTests.allTests),
   testCase(WKTWriterCoordinate3DTests.allTests),
   testCase(WKTWriterCoordinate3DMTests.allTests),
   testCase(FixedTests.allTests),
   testCase(GeoJSONWriterCoordinate2DTests.allTests),
   testCase(GeoJSONWriterCoordinate2DMTests.allTests),
   testCase(GeoJSONWriterCoordinate3DTests.allTests),
   testCase(GeoJSONWriterCoordinate3DMTests.allTests),
   testCase(GeometryCollectionGeometryTests.allTests),
   testCase(GeometryCollectionCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(GeoJSONReaderCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(GeoJSONReaderCoordinate3DMFixedCartesianTests.allTests),
   testCase(GeoJSONReaderInternal.allTests),
   testCase(Coordinate2DTests.allTests),
   testCase(LineStringCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringCoordinate2DFixedCartesianTests.allTests),
   testCase(LineStringCoordinate2DMFixedCartesianTests.allTests),
   testCase(LineStringCoordinate3DFixedCartesianTests.allTests),
   testCase(LineStringCoordinate3DMFixedCartesianTests.allTests),
   testCase(LinearRingCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingCoordinate2DFixedCartesianTests.allTests),
   testCase(LinearRingCoordinate2DMFixedCartesianTests.allTests),
   testCase(LinearRingCoordinate3DFixedCartesianTests.allTests),
   testCase(LinearRingCoordinate3DMFixedCartesianTests.allTests),
   testCase(TokenizerTests.allTests),
   testCase(WKTReaderCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(WKTReaderCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(WKTReaderCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(WKTReaderCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(BoundsTests.allTests),
   testCase(MultiLineStringCurveCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiLineStringCurveCoordinate2DFixedCartesianTests.allTests),
   testCase(LinearRingCurveCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPolygonCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(PolygonSurfaceCoordinate2DFixedCartesianTests.allTests),
   testCase(PolygonGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(IntersectionMatrixTests.allTests),
   testCase(CoordinateSystemCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate2DFixedCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate2DMFixedCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate3DFixedCartesianTests.allTests),
   testCase(MultiPointGeometryCoordinate3DMFixedCartesianTests.allTests),
   testCase(IntersectionMatrixHelperTests.allTests),
   testCase(LineStringCurveCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringCurveCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingSurfaceCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LinearRingSurfaceCoordinate2DFixedCartesianTests.allTests),
   testCase(Coordinate3DMTests.allTests),
   testCase(PointGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(PointGeometryCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(PointGeometryCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(PointGeometryCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(PointGeometryCoordinate2DFixedCartesianTests.allTests),
   testCase(PointGeometryCoordinate2DMFixedCartesianTests.allTests),
   testCase(PointGeometryCoordinate3DFixedCartesianTests.allTests),
   testCase(PointGeometryCoordinate3DMFixedCartesianTests.allTests),
   testCase(FloatingTests.allTests),
   testCase(MultiPointCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiPointCoordinate2DFixedCartesianTests.allTests),
   testCase(Coordinate3DTests.allTests),
   testCase(MultiPolygonGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(Coordinate2DMTests.allTests),
   testCase(MultiLineStringCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiLineStringCoordinate2DFixedCartesianTests.allTests),
   testCase(CoordinateSystemGeographicTests.allTests),
   testCase(LinearRingGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(MultiLineStringGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(LineStringGeometryCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(PointCoordinate2DFloatingPrecisionCartesianTests.allTests),
   testCase(PointCoordinate2DMFloatingPrecisionCartesianTests.allTests),
   testCase(PointCoordinate3DFloatingPrecisionCartesianTests.allTests),
   testCase(PointCoordinate3DMFloatingPrecisionCartesianTests.allTests),
   testCase(PointCoordinate2DFixedCartesianTests.allTests),
   testCase(PointCoordinate2DMFixedCartesianTests.allTests),
   testCase(PointCoordinate3DFixedCartesianTests.allTests),
   testCase(PointCoordinate3DMFixedCartesianTests.allTests)
])

extension MultiPolygonSurfaceCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (MultiPolygonSurfaceCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
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
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testDescriptionEmpty", testDescriptionEmpty),
                ("testOperatorEqualGeometryPolygon", testOperatorEqualGeometryPolygon),
                ("testOperatorEqualPolygonGeometry", testOperatorEqualPolygonGeometry)
           ]
   }
}

extension PolygonCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (PolygonCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitNoArg", testInitNoArg),
                ("testInitWithNoArgDefaults", testInitWithNoArgDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithRings", testInitWithRings),
                ("testInitArrayLiteral", testInitArrayLiteral),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
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

extension FixedTests {
   static var allTests: [(String, (FixedTests) -> () throws -> Void)] {
      return [
                ("testConvertWithScale10Lower", testConvertWithScale10Lower),
                ("testConvertWithScale10Middle", testConvertWithScale10Middle),
                ("testConvertWithScale10Upper", testConvertWithScale10Upper),
                ("testConvertWithScale10Lower2", testConvertWithScale10Lower2),
                ("testConvertWithScale10Middle2", testConvertWithScale10Middle2),
                ("testConvertWithScale10Upper2", testConvertWithScale10Upper2),
                ("testConvertOptionalWithScale10Lower", testConvertOptionalWithScale10Lower),
                ("testConvertOptionalWithNil", testConvertOptionalWithNil),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse),
                ("testEqualFalseWithDifferentType", testEqualFalseWithDifferentType)
           ]
   }
}

extension GeoJSONWriterCoordinate2DTests {
   static var allTests: [(String, (GeoJSONWriterCoordinate2DTests) -> () throws -> Void)] {
      return [
                ("testWriteUnsupportedGeometry", testWriteUnsupportedGeometry),
                ("testWritePoint", testWritePoint),
                ("testWriteLineString", testWriteLineString),
                ("testWriteLinearRing", testWriteLinearRing),
                ("testWritePolygon", testWritePolygon),
                ("testWriteMultiPoint", testWriteMultiPoint),
                ("testWriteMultiLineString", testWriteMultiLineString),
                ("testWriteMultiPolygon", testWriteMultiPolygon),
                ("testWriteGeometryCollection", testWriteGeometryCollection)
           ]
   }
}

extension GeoJSONWriterCoordinate2DMTests {
   static var allTests: [(String, (GeoJSONWriterCoordinate2DMTests) -> () throws -> Void)] {
      return [
                ("testWriteUnsupportedGeometry", testWriteUnsupportedGeometry),
                ("testWriteInvalidNumberOfCoordinates", testWriteInvalidNumberOfCoordinates),
                ("testWritePoint", testWritePoint),
                ("testWriteLineString", testWriteLineString),
                ("testWriteLinearRing", testWriteLinearRing),
                ("testWritePolygon", testWritePolygon),
                ("testWriteMultiPoint", testWriteMultiPoint),
                ("testWriteMultiLineString", testWriteMultiLineString),
                ("testWriteMultiPolygon", testWriteMultiPolygon),
                ("testWriteGeometryCollection", testWriteGeometryCollection)
           ]
   }
}

extension GeoJSONWriterCoordinate3DTests {
   static var allTests: [(String, (GeoJSONWriterCoordinate3DTests) -> () throws -> Void)] {
      return [
                ("testWriteUnsupportedGeometry", testWriteUnsupportedGeometry),
                ("testWriteInvalidNumberOfCoordinates", testWriteInvalidNumberOfCoordinates),
                ("testWritePoint", testWritePoint),
                ("testWriteLineString", testWriteLineString),
                ("testWriteLinearRing", testWriteLinearRing),
                ("testWritePolygon", testWritePolygon),
                ("testWriteMultiPoint", testWriteMultiPoint),
                ("testWriteMultiLineString", testWriteMultiLineString),
                ("testWriteMultiPolygon", testWriteMultiPolygon),
                ("testWriteGeometryCollection", testWriteGeometryCollection)
           ]
   }
}

extension GeoJSONWriterCoordinate3DMTests {
   static var allTests: [(String, (GeoJSONWriterCoordinate3DMTests) -> () throws -> Void)] {
      return [
                ("testWriteUnsupportedGeometry", testWriteUnsupportedGeometry),
                ("testWriteInvalidNumberOfCoordinates", testWriteInvalidNumberOfCoordinates),
                ("testWritePoint", testWritePoint),
                ("testWriteLineString", testWriteLineString),
                ("testWriteLinearRing", testWriteLinearRing),
                ("testWritePolygon", testWritePolygon),
                ("testWriteMultiPoint", testWriteMultiPoint),
                ("testWriteMultiLineString", testWriteMultiLineString),
                ("testWriteMultiPolygon", testWriteMultiPolygon),
                ("testWriteGeometryCollection", testWriteGeometryCollection)
           ]
   }
}

extension GeometryCollectionGeometryTests {
   static var allTests: [(String, (GeometryCollectionGeometryTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionWithHomogeneousPoint", testDimensionWithHomogeneousPoint),
                ("testDimensionWithHomogeneousLineString", testDimensionWithHomogeneousLineString),
                ("testDimensionWithHomogeneousLineStringEmpty", testDimensionWithHomogeneousLineStringEmpty),
                ("testDimensionWithHomogeneousPolygon", testDimensionWithHomogeneousPolygon),
                ("testDimensionWithHomogeneousPolygonEmpty", testDimensionWithHomogeneousPolygonEmpty),
                ("testDimensionWithNonHomogeneousPointPolygon", testDimensionWithNonHomogeneousPointPolygon),
                ("testDimensionWithNonHomogeneousPointPolygonEmpty", testDimensionWithNonHomogeneousPointPolygonEmpty),
                ("testDimensionWithNonHomogeneousPointLineString", testDimensionWithNonHomogeneousPointLineString),
                ("testDimensionWithNonHomogeneousPointLineStringEmpty", testDimensionWithNonHomogeneousPointLineStringEmpty),
                ("testBoundary", testBoundary),
                ("testBoundsEmpty", testBoundsEmpty),
                ("testBoundsWithElements", testBoundsWithElements),
                ("testEqualTrue", testEqualTrue),
                ("testEqualWithSameTypesFalse", testEqualWithSameTypesFalse),
                ("testEqualWithDifferentTypesFalse", testEqualWithDifferentTypesFalse)
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
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
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

extension GeoJSONReaderCoordinate3DMFixedCartesianTests {
   static var allTests: [(String, (GeoJSONReaderCoordinate3DMFixedCartesianTests) -> () throws -> Void)] {
      return [
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
                ("testCoordinateWithInvalidString", testCoordinateWithInvalidString),
                ("testCoordinatesWithInvalidStructure", testCoordinatesWithInvalidStructure)
           ]
   }
}

extension Coordinate2DTests {
   static var allTests: [(String, (Coordinate2DTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testInitWithDictionaryLiteral", testInitWithDictionaryLiteral),
                ("testInitWithDictionaryLiteralIncorrectElements", testInitWithDictionaryLiteralIncorrectElements),
                ("testInitCopy", testInitCopy),
                ("testX", testX),
                ("testY", testY),
                ("testZ", testZ),
                ("testM", testM),
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
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
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
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
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
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
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
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LineStringCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (LineStringCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LineStringCoordinate2DMFixedCartesianTests {
   static var allTests: [(String, (LineStringCoordinate2DMFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LineStringCoordinate3DFixedCartesianTests {
   static var allTests: [(String, (LineStringCoordinate3DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LineStringCoordinate3DMFixedCartesianTests {
   static var allTests: [(String, (LineStringCoordinate3DMFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
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
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
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
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
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
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
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
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate2DMFixedCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate2DMFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate3DFixedCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate3DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension LinearRingCoordinate3DMFixedCartesianTests {
   static var allTests: [(String, (LinearRingCoordinate3DMFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitConverting", testInitConverting),
                ("testInitCopy", testInitCopy),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
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

extension BoundsTests {
   static var allTests: [(String, (BoundsTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testInitWithCoordinate", testInitWithCoordinate),
                ("testMin", testMin),
                ("testMax", testMax),
                ("testMidWithOriginZero", testMidWithOriginZero),
                ("testMidWithOriginNegative", testMidWithOriginNegative),
                ("testExpand", testExpand),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
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

extension MultiLineStringCurveCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (MultiLineStringCurveCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
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

extension MultiPolygonCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPolygonCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension PolygonSurfaceCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (PolygonSurfaceCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
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
                ("testDimensionEmpty", testDimensionEmpty),
                ("testBoundaryWithOuterRing", testBoundaryWithOuterRing),
                ("testBoundaryWithOuterRingAnd1InnerRing", testBoundaryWithOuterRingAnd1InnerRing),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testBoundsEmpty", testBoundsEmpty),
                ("testBounds", testBounds),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
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
                ("testDimensionEmpty", testDimensionEmpty),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionEmpty", testDimensionEmpty),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionEmpty", testDimensionEmpty),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionEmpty", testDimensionEmpty),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionEmpty", testDimensionEmpty),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate2DMFixedCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate2DMFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionEmpty", testDimensionEmpty),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty)
           ]
   }
}

extension MultiPointGeometryCoordinate3DFixedCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate3DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionEmpty", testDimensionEmpty),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension MultiPointGeometryCoordinate3DMFixedCartesianTests {
   static var allTests: [(String, (MultiPointGeometryCoordinate3DMFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionEmpty", testDimensionEmpty),
                ("testBoundary", testBoundary),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension IntersectionMatrixHelperTests {
   static var allTests: [(String, (IntersectionMatrixHelperTests) -> () throws -> Void)] {
      return [
                ("testPoint_Point_noIntersection", testPoint_Point_noIntersection),
                ("testPoint_Point_identicalPoints", testPoint_Point_identicalPoints),
                ("testPoint_MultiPoint_noIntersection", testPoint_MultiPoint_noIntersection),
                ("testPoint_MultiPoint_firstProperSubsetOfSecond", testPoint_MultiPoint_firstProperSubsetOfSecond),
                ("testPoint_MultiPoint_firstImproperSubsetOfSecond", testPoint_MultiPoint_firstImproperSubsetOfSecond),
                ("testPoint_LineString_noIntersection", testPoint_LineString_noIntersection),
                ("testPoint_LineString_firstSubsetOfSecondInterior", testPoint_LineString_firstSubsetOfSecondInterior),
                ("testPoint_LineString_firstSubsetOfSecondBoundary", testPoint_LineString_firstSubsetOfSecondBoundary),
                ("testPoint_LinearRing_noIntersection", testPoint_LinearRing_noIntersection),
                ("testPoint_LinearRing_firstSubsetOfSecondInterior", testPoint_LinearRing_firstSubsetOfSecondInterior),
                ("testPoint_MultiLineString_noIntersection", testPoint_MultiLineString_noIntersection),
                ("testPoint_MultiLineString_firstSubsetOfSecondInterior", testPoint_MultiLineString_firstSubsetOfSecondInterior),
                ("testPoint_MultiLineString_firstSubsetOfSecondBoundary", testPoint_MultiLineString_firstSubsetOfSecondBoundary),
                ("testPoint_Polygon_outerRingOnly_noIntersection", testPoint_Polygon_outerRingOnly_noIntersection),
                ("testPoint_Polygon_outerRingAndInnerRing_outsideMainRing_noIntersection", testPoint_Polygon_outerRingAndInnerRing_outsideMainRing_noIntersection),
                ("testPoint_Polygon_outerRingAndInnerRing_insideInnerRing_noIntersection", testPoint_Polygon_outerRingAndInnerRing_insideInnerRing_noIntersection),
                ("testPoint_Polygon_outerRingOnly_intersectsBoundary", testPoint_Polygon_outerRingOnly_intersectsBoundary),
                ("testPoint_Polygon_outerRingAndInnerRing_intersectsOuterBoundary", testPoint_Polygon_outerRingAndInnerRing_intersectsOuterBoundary),
                ("testPoint_Polygon_outerRingAndInnerRing_intersectsInnerBoundary", testPoint_Polygon_outerRingAndInnerRing_intersectsInnerBoundary),
                ("testPoint_Polygon_outerRingOnly_intersectsInterior", testPoint_Polygon_outerRingOnly_intersectsInterior),
                ("testPoint_Polygon_outerRingAndInnerRing_intersectsInterior", testPoint_Polygon_outerRingAndInnerRing_intersectsInterior),
                ("testPoint_MultiPolygon_outerRingsOnly_noIntersection", testPoint_MultiPolygon_outerRingsOnly_noIntersection),
                ("testPoint_MultiPolygon_outerRingAndInnerRings_outsideMainRings_noIntersection", testPoint_MultiPolygon_outerRingAndInnerRings_outsideMainRings_noIntersection),
                ("testPoint_MultiPolygon_outerRingAndInnerRing_insideInnerRing_noIntersection", testPoint_MultiPolygon_outerRingAndInnerRing_insideInnerRing_noIntersection),
                ("testPoint_MultiPolygon_outerRingOnly_intersectsBoundary", testPoint_MultiPolygon_outerRingOnly_intersectsBoundary),
                ("testPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterBoundary", testPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterBoundary),
                ("testPoint_MultiPolygon_outerRingAndInnerRing_intersectsInnerBoundary", testPoint_MultiPolygon_outerRingAndInnerRing_intersectsInnerBoundary),
                ("testPoint_MultiPolygon_outerRingOnly_intersectsInterior", testPoint_MultiPolygon_outerRingOnly_intersectsInterior),
                ("testPoint_MultiPolygon_outerRingAndInnerRing_intersectsInterior", testPoint_MultiPolygon_outerRingAndInnerRing_intersectsInterior),
                ("testMultiPoint_Point_noIntersection", testMultiPoint_Point_noIntersection),
                ("testMultiPoint_Point_secondProperSubsetOfFirst", testMultiPoint_Point_secondProperSubsetOfFirst),
                ("testMultiPoint_Point_secondImproperSubsetOfFirst", testMultiPoint_Point_secondImproperSubsetOfFirst),
                ("testMultiPoint_MultiPoint_noIntersection", testMultiPoint_MultiPoint_noIntersection),
                ("testMultiPoint_MultiPoint_firstIntersectsSecondButNotSubset", testMultiPoint_MultiPoint_firstIntersectsSecondButNotSubset),
                ("testMultiPoint_MultiPoint_firstProperSubsetOfSecond", testMultiPoint_MultiPoint_firstProperSubsetOfSecond),
                ("testMultiPoint_MultiPoint_secondProperSubsetOfFirst", testMultiPoint_MultiPoint_secondProperSubsetOfFirst),
                ("testMultiPoint_MultiPoint_firstImproperSubsetOfSecond", testMultiPoint_MultiPoint_firstImproperSubsetOfSecond),
                ("testMultiPoint_LineString_noIntersection", testMultiPoint_LineString_noIntersection),
                ("testMultiPoint_LineString_firstSubsetOfSecondInterior", testMultiPoint_LineString_firstSubsetOfSecondInterior),
                ("testMultiPoint_LineString_firstProperSubsetOfSecondBoundary", testMultiPoint_LineString_firstProperSubsetOfSecondBoundary),
                ("testMultiPoint_LineString_firstImproperSubsetOfSecondBoundary", testMultiPoint_LineString_firstImproperSubsetOfSecondBoundary),
                ("testMultiPoint_LineString_firstTouchesSecondInteriorAndBoundary", testMultiPoint_LineString_firstTouchesSecondInteriorAndBoundary),
                ("testMultiPoint_LineString_firstTouchesSecondInteriorAndCoversBoundary", testMultiPoint_LineString_firstTouchesSecondInteriorAndCoversBoundary),
                ("testMultiPoint_LineString_firstTouchesSecondInteriorAndExterior", testMultiPoint_LineString_firstTouchesSecondInteriorAndExterior),
                ("testMultiPoint_LineString_firstTouchesSecondBoundaryAndExterior", testMultiPoint_LineString_firstTouchesSecondBoundaryAndExterior),
                ("testMultiPoint_LineString_firstCoversSecondBoundaryAndTouchesExterior", testMultiPoint_LineString_firstCoversSecondBoundaryAndTouchesExterior),
                ("testMultiPoint_LineString_firstTouchesSecondInteriorAndBoundaryAndExterior", testMultiPoint_LineString_firstTouchesSecondInteriorAndBoundaryAndExterior),
                ("testMultiPoint_LineString_firstTouchesSecondInteriorAndExteriorAndCoversBoundary", testMultiPoint_LineString_firstTouchesSecondInteriorAndExteriorAndCoversBoundary),
                ("testMultiPoint_LinearRing_noIntersection", testMultiPoint_LinearRing_noIntersection),
                ("testMultiPoint_LinearRing_firstSubsetOfSecondInterior", testMultiPoint_LinearRing_firstSubsetOfSecondInterior),
                ("testMultiPoint_LinearRing_firstTouchesSecondInteriorAndExterior", testMultiPoint_LinearRing_firstTouchesSecondInteriorAndExterior),
                ("testMultiPoint_MultiLineString_noIntersection", testMultiPoint_MultiLineString_noIntersection),
                ("testMultiPoint_MultiLineString_firstSubsetOfSecondInterior", testMultiPoint_MultiLineString_firstSubsetOfSecondInterior),
                ("testMultiPoint_MultiLineString_firstProperSubsetOfSecondBoundary", testMultiPoint_MultiLineString_firstProperSubsetOfSecondBoundary),
                ("testMultiPoint_MultiLineString_firstImproperSubsetOfSecondBoundary", testMultiPoint_MultiLineString_firstImproperSubsetOfSecondBoundary),
                ("testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndBoundary", testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndBoundary),
                ("testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndCoversBoundary", testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndCoversBoundary),
                ("testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndExterior", testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndExterior),
                ("testMultiPoint_MultiLineString_firstTouchesSecondBoundaryAndExterior", testMultiPoint_MultiLineString_firstTouchesSecondBoundaryAndExterior),
                ("testMultiPoint_MultiLineString_firstCoversSecondBoundaryAndTouchesExterior", testMultiPoint_MultiLineString_firstCoversSecondBoundaryAndTouchesExterior),
                ("testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndBoundaryAndExterior", testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndBoundaryAndExterior),
                ("testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndExteriorAndCoversBoundary", testMultiPoint_MultiLineString_firstTouchesSecondInteriorAndExteriorAndCoversBoundary),
                ("testMultiPoint_Polygon_outerRingOnly_noIntersection", testMultiPoint_Polygon_outerRingOnly_noIntersection),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_outsideMainRing_noIntersection", testMultiPoint_Polygon_outerRingAndInnerRing_outsideMainRing_noIntersection),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_insideInnerRing_noIntersection", testMultiPoint_Polygon_outerRingAndInnerRing_insideInnerRing_noIntersection),
                ("testMultiPoint_Polygon_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection", testMultiPoint_Polygon_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection),
                ("testMultiPoint_Polygon_outerRingOnly_intersectsBoundaryOnly", testMultiPoint_Polygon_outerRingOnly_intersectsBoundaryOnly),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsOuterBoundaryOnly", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsOuterBoundaryOnly),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInnerBoundaryOnly", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInnerBoundaryOnly),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries),
                ("testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries", testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries),
                ("testMultiPoint_Polygon_outerRingOnly_intersectsInteriorOnly", testMultiPoint_Polygon_outerRingOnly_intersectsInteriorOnly),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorOnly", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorOnly),
                ("testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorOnly", testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorOnly),
                ("testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndBoundary", testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndBoundary),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries),
                ("testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries", testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries),
                ("testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndExterior", testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndExterior),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing),
                ("testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings", testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings),
                ("testMultiPoint_Polygon_outerRingOnly_intersectsBoundaryAndExterior", testMultiPoint_Polygon_outerRingOnly_intersectsBoundaryAndExterior),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing),
                ("testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings", testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings),
                ("testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndBoundaryAndExterior", testMultiPoint_Polygon_outerRingOnly_intersectsInteriorAndBoundaryAndExterior),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing),
                ("testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing", testMultiPoint_Polygon_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing),
                ("testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings", testMultiPoint_Polygon_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings),
                ("testMultiPoint_MultiPolygon_outerRingOnly_noIntersection", testMultiPoint_MultiPolygon_outerRingOnly_noIntersection),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_outsideMainRing_noIntersection", testMultiPoint_MultiPolygon_outerRingAndInnerRing_outsideMainRing_noIntersection),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_insideInnerRing_noIntersection", testMultiPoint_MultiPolygon_outerRingAndInnerRing_insideInnerRing_noIntersection),
                ("testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection", testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection),
                ("testMultiPoint_MultiPolygon_outerRingOnly_intersectsBoundaryOnly", testMultiPoint_MultiPolygon_outerRingOnly_intersectsBoundaryOnly),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterBoundaryOnly", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterBoundaryOnly),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInnerBoundaryOnly", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInnerBoundaryOnly),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries),
                ("testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries", testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries),
                ("testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorOnly", testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorOnly),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorOnly", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorOnly),
                ("testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorOnly", testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorOnly),
                ("testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndBoundary", testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndBoundary),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries),
                ("testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries", testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries),
                ("testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndExterior", testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndExterior),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing),
                ("testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings", testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings),
                ("testMultiPoint_MultiPolygon_outerRingOnly_intersectsBoundaryAndExterior", testMultiPoint_MultiPolygon_outerRingOnly_intersectsBoundaryAndExterior),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing),
                ("testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings", testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings),
                ("testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndBoundaryAndExterior", testMultiPoint_MultiPolygon_outerRingOnly_intersectsInteriorAndBoundaryAndExterior),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing),
                ("testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing", testMultiPoint_MultiPolygon_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing),
                ("testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings", testMultiPoint_MultiPolygon_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings),
                ("testLineString_Point_noIntersection", testLineString_Point_noIntersection),
                ("testLineString_Point_firstSubsetOfSecondInterior", testLineString_Point_firstSubsetOfSecondInterior),
                ("testLineString_Point_firstSubsetOfSecondBoundary", testLineString_Point_firstSubsetOfSecondBoundary),
                ("testLineString_MultiPoint_noIntersection", testLineString_MultiPoint_noIntersection),
                ("testLineString_MultiPoint_firstSubsetOfSecondInterior", testLineString_MultiPoint_firstSubsetOfSecondInterior),
                ("testLineString_MultiPoint_firstProperSubsetOfSecondBoundary", testLineString_MultiPoint_firstProperSubsetOfSecondBoundary),
                ("testLineString_MultiPoint_firstImproperSubsetOfSecondBoundary", testLineString_MultiPoint_firstImproperSubsetOfSecondBoundary),
                ("testLineString_MultiPoint_firstTouchesSecondInteriorAndBoundary", testLineString_MultiPoint_firstTouchesSecondInteriorAndBoundary),
                ("testLineString_MultiPoint_firstTouchesSecondInteriorAndCoversBoundary", testLineString_MultiPoint_firstTouchesSecondInteriorAndCoversBoundary),
                ("testLineString_MultiPoint_firstTouchesSecondInteriorAndExterior", testLineString_MultiPoint_firstTouchesSecondInteriorAndExterior),
                ("testLineString_MultiPoint_firstTouchesSecondBoundaryAndExterior", testLineString_MultiPoint_firstTouchesSecondBoundaryAndExterior),
                ("testLineString_MultiPoint_firstCoversSecondBoundaryAndTouchesExterior", testLineString_MultiPoint_firstCoversSecondBoundaryAndTouchesExterior),
                ("testLineString_MultiPoint_firstTouchesSecondInteriorAndBoundaryAndExterior", testLineString_MultiPoint_firstTouchesSecondInteriorAndBoundaryAndExterior),
                ("testLineString_MultiPoint_firstTouchesSecondInteriorAndExteriorAndCoversBoundary", testLineString_MultiPoint_firstTouchesSecondInteriorAndExteriorAndCoversBoundary),
                ("testLineString_LineString_noIntersection", testLineString_LineString_noIntersection),
                ("testLineString_LineString_interiorsIntersectAtOnePointFirstSegments", testLineString_LineString_interiorsIntersectAtOnePointFirstSegments),
                ("testLineString_LineString_interiorsIntersectAtOnePointSecondSegments", testLineString_LineString_interiorsIntersectAtOnePointSecondSegments),
                ("testLineString_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross", testLineString_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross),
                ("testLineString_LineString_interiorsIntersectAtTwoPointsBothSegments", testLineString_LineString_interiorsIntersectAtTwoPointsBothSegments),
                ("testLineString_LineString_firstInteriorIntersectsSecondBoundary", testLineString_LineString_firstInteriorIntersectsSecondBoundary),
                ("testLineString_LineString_firstInteriorIntersectsSecondBoundary_FirstBoundaryPoint", testLineString_LineString_firstInteriorIntersectsSecondBoundary_FirstBoundaryPoint),
                ("testLineString_LineString_firstInteriorIntersectsSecondBoundary_SecondBoundaryPoint", testLineString_LineString_firstInteriorIntersectsSecondBoundary_SecondBoundaryPoint),
                ("testLineString_LineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints", testLineString_LineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints),
                ("testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings", testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings),
                ("testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesFirstBoundaryPoint", testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesFirstBoundaryPoint),
                ("testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesSecondBoundaryPoint", testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesSecondBoundaryPoint),
                ("testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint", testLineString_LineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint),
                ("testLineString_LineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap", testLineString_LineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap),
                ("testLineString_LineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap", testLineString_LineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap),
                ("testLineString_LineString_secondProperSubsetOfFirst", testLineString_LineString_secondProperSubsetOfFirst),
                ("testLineString_LinearRing_noIntersection", testLineString_LinearRing_noIntersection),
                ("testLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment", testLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment),
                ("testLineString_LinearRing_interiorsIntersectAtOnePointSecondSegments", testLineString_LinearRing_interiorsIntersectAtOnePointSecondSegments),
                ("testLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross", testLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross),
                ("testLineString_LinearRing_interiorsIntersectAtTwoPointsBothSegments", testLineString_LinearRing_interiorsIntersectAtTwoPointsBothSegments),
                ("testLineString_LinearRing_firstInteriorIntersectsSecondInteriorAtSegmentEndpoint", testLineString_LinearRing_firstInteriorIntersectsSecondInteriorAtSegmentEndpoint),
                ("testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_FirstBoundaryPoint", testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_FirstBoundaryPoint),
                ("testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_SecondBoundaryPoint", testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_SecondBoundaryPoint),
                ("testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_BothBoundaryPoints", testLineString_LinearRing_firstBoundaryIntersectsSecondInterior_BothBoundaryPoints),
                ("testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing", testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing),
                ("testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing2", testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing2),
                ("testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing3", testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing3),
                ("testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing4", testLineString_LinearRing_firstInteriorDoesNotIntersectSecondExterior_LineStringSubsetOfLinearRing4),
                ("testLineString_MultiLineString_noIntersection", testLineString_MultiLineString_noIntersection),
                ("testLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString", testLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString),
                ("testLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString", testLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString),
                ("testLineString_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString", testLineString_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString),
                ("testLineString_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString", testLineString_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString),
                ("testLineString_MultiLineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross", testLineString_MultiLineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross),
                ("testLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings", testLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings),
                ("testLineString_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString1", testLineString_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString1),
                ("testLineString_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString2", testLineString_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString2),
                ("testLineString_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString1", testLineString_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString1),
                ("testLineString_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString2", testLineString_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString2),
                ("testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_FirstLineString", testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_FirstLineString),
                ("testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_SecondLineString", testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_SecondLineString),
                ("testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_AllBoundaryPoints", testLineString_MultiLineString_firstInteriorIntersectsSecondBoundary_AllBoundaryPoints),
                ("testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings_FirstLineString", testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings_FirstLineString),
                ("testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings_SecondLineString", testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_IdenticalLineStrings_SecondLineString),
                ("testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesFirstBoundaryPointOfSecondLineString", testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesFirstBoundaryPointOfSecondLineString),
                ("testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesSecondBoundaryPointOfFirstLineString", testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesSecondBoundaryPointOfFirstLineString),
                ("testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint_FirstLineString", testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint_FirstLineString),
                ("testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint_SecondLineString", testLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_FirstSubsetOfSecondAndTouchesNeitherBoundaryPoint_SecondLineString),
                ("testLineString_MultiLineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap_FirstLineString", testLineString_MultiLineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap_FirstLineString),
                ("testLineString_MultiLineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap_SecondLineString", testLineString_MultiLineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap_SecondLineString),
                ("testLineString_MultiLineString_secondProperSubsetOfFirst", testLineString_MultiLineString_secondProperSubsetOfFirst),
                ("testLineString_Polygon_noIntersection", testLineString_Polygon_noIntersection),
                ("testLineString_Polygon_withHole_noIntersection_lineStringOutsideMainPolygon", testLineString_Polygon_withHole_noIntersection_lineStringOutsideMainPolygon),
                ("testLineString_Polygon_withHole_noIntersection_lineStringInsideHole", testLineString_Polygon_withHole_noIntersection_lineStringInsideHole),
                ("testLineString_Polygon_interiorsIntersect_lineStringFirstSegment", testLineString_Polygon_interiorsIntersect_lineStringFirstSegment),
                ("testLineString_Polygon_interiorsIntersect_lineStringSecondSegment", testLineString_Polygon_interiorsIntersect_lineStringSecondSegment),
                ("testLineString_Polygon_interiorIntersectsBoundaryAtOnePoint_lineStringFirstSegment_doNotCross", testLineString_Polygon_interiorIntersectsBoundaryAtOnePoint_lineStringFirstSegment_doNotCross),
                ("testLineString_Polygon_interiorIntersectsBoundaryAtOnePoint_lineStringInsideHole_doNotCross", testLineString_Polygon_interiorIntersectsBoundaryAtOnePoint_lineStringInsideHole_doNotCross),
                ("testLineString_Polygon_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringOutsideMainLinearRing", testLineString_Polygon_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringOutsideMainLinearRing),
                ("testLineString_Polygon_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringOutsideMainLinearRing", testLineString_Polygon_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringOutsideMainLinearRing),
                ("testLineString_Polygon_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringInsideHole", testLineString_Polygon_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringInsideHole),
                ("testLineString_Polygon_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringInsideHole", testLineString_Polygon_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringInsideHole),
                ("testLineString_Polygon_intersectsPolygonBoundaryInteriorExterior", testLineString_Polygon_intersectsPolygonBoundaryInteriorExterior),
                ("testLineString_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole", testLineString_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole),
                ("testLineString_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes", testLineString_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes),
                ("testLineString_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole", testLineString_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole),
                ("testLineString_MultiPolygon_noIntersection", testLineString_MultiPolygon_noIntersection),
                ("testLineString_MultiPolygon_withHoles_noIntersection_lineStringOutsideMainPolygon", testLineString_MultiPolygon_withHoles_noIntersection_lineStringOutsideMainPolygon),
                ("testLineString_MultiPolygon_withHoles_noIntersection_lineStringInsideHole", testLineString_MultiPolygon_withHoles_noIntersection_lineStringInsideHole),
                ("testLineString_MultiPolygon_interiorsIntersect_firstPolygon", testLineString_MultiPolygon_interiorsIntersect_firstPolygon),
                ("testLineString_MultiPolygon_interiorsIntersect_firstPolygon_withHole", testLineString_MultiPolygon_interiorsIntersect_firstPolygon_withHole),
                ("testLineString_MultiPolygon_interiorsIntersect_secondPolygon", testLineString_MultiPolygon_interiorsIntersect_secondPolygon),
                ("testLineString_MultiPolygon_interiorsIntersect_secondPolygon_withHole", testLineString_MultiPolygon_interiorsIntersect_secondPolygon_withHole),
                ("testLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles", testLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles),
                ("testLineString_MultiPolygon_boundariesIntersect_firstPolygon_withHoles", testLineString_MultiPolygon_boundariesIntersect_firstPolygon_withHoles),
                ("testLineString_MultiPolygon_boundariesIntersect_secondPolygon_withHoles", testLineString_MultiPolygon_boundariesIntersect_secondPolygon_withHoles),
                ("testLineString_MultiPolygon_boundariesIntersect_bothPolygons_withHoles", testLineString_MultiPolygon_boundariesIntersect_bothPolygons_withHoles),
                ("testLineString_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles", testLineString_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testLineString_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles", testLineString_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testLineString_MultiPolygon_interiorsIntersectAndBoundariesIntersect_withHoles", testLineString_MultiPolygon_interiorsIntersectAndBoundariesIntersect_withHoles),
                ("testLineString_MultiPolygon_boundaryIntersectsInteriorAndBoundary_withHoles", testLineString_MultiPolygon_boundaryIntersectsInteriorAndBoundary_withHoles),
                ("testLinearRing_Point_noIntersection", testLinearRing_Point_noIntersection),
                ("testLinearRing_Point_secondSubsetOfFirstInterior_firstSegment", testLinearRing_Point_secondSubsetOfFirstInterior_firstSegment),
                ("testLinearRing_Point_secondSubsetOfFirstInterior_lastSegment", testLinearRing_Point_secondSubsetOfFirstInterior_lastSegment),
                ("testLinearRing_MultiPoint_noIntersection", testLinearRing_MultiPoint_noIntersection),
                ("testLinearRing_MultiPoint_secondSubsetOfFirstInterior", testLinearRing_MultiPoint_secondSubsetOfFirstInterior),
                ("testLinearRing_MultiPoint_secondTouchesFirstInteriorAndExterior", testLinearRing_MultiPoint_secondTouchesFirstInteriorAndExterior),
                ("testLinearRing_LineString_noIntersection", testLinearRing_LineString_noIntersection),
                ("testLinearRing_LineString_interiorsIntersectAtOnePointLineStringFirstSegment", testLinearRing_LineString_interiorsIntersectAtOnePointLineStringFirstSegment),
                ("testLinearRing_LineString_interiorsIntersectAtOnePointSecondSegments", testLinearRing_LineString_interiorsIntersectAtOnePointSecondSegments),
                ("testLinearRing_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross", testLinearRing_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross),
                ("testLinearRing_LineString_interiorsIntersectAtTwoPointsBothSegments", testLinearRing_LineString_interiorsIntersectAtTwoPointsBothSegments),
                ("testLinearRing_LineString_firstInteriorIntersectsSecondInteriorAtMultipleSegmentEndpoints", testLinearRing_LineString_firstInteriorIntersectsSecondInteriorAtMultipleSegmentEndpoints),
                ("testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_FirstBoundaryPoint", testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_FirstBoundaryPoint),
                ("testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_SecondBoundaryPoint", testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_SecondBoundaryPoint),
                ("testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_BothBoundaryPoints", testLinearRing_LineString_secondBoundaryIntersectsFirstInterior_BothBoundaryPoints),
                ("testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing", testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing),
                ("testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing2", testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing2),
                ("testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing3", testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing3),
                ("testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing4", testLinearRing_LineString_secondInteriorDoesNotIntersectFirstExterior_LineStringSubsetOfLinearRing4),
                ("testLinearRing_LineString_geometriesShareSingleLineSegment_lineStringBoundaryDoesNotTouch", testLinearRing_LineString_geometriesShareSingleLineSegment_lineStringBoundaryDoesNotTouch),
                ("testLinearRing_LineString_geometriesShareSingleLineSegment_lineStringBoundaryTouchesAtPoint", testLinearRing_LineString_geometriesShareSingleLineSegment_lineStringBoundaryTouchesAtPoint),
                ("testLinearRing_LinearRing_noIntersection", testLinearRing_LinearRing_noIntersection),
                ("testLinearRing_LinearRing_noIntersection_firstInsideSecond", testLinearRing_LinearRing_noIntersection_firstInsideSecond),
                ("testLinearRing_LinearRing_noIntersection_secondInsideFirst", testLinearRing_LinearRing_noIntersection_secondInsideFirst),
                ("testLinearRing_LinearRing_interiorsIntersectAtTwoPoints", testLinearRing_LinearRing_interiorsIntersectAtTwoPoints),
                ("testLinearRing_LinearRing_interiorsIntersectAtTwoPoints_DoNotCross", testLinearRing_LinearRing_interiorsIntersectAtTwoPoints_DoNotCross),
                ("testLinearRing_LinearRing_firstInteriorIntersectsSecondInteriorAtThreeSegmentEndpoints", testLinearRing_LinearRing_firstInteriorIntersectsSecondInteriorAtThreeSegmentEndpoints),
                ("testLinearRing_LinearRing_linearRingsMatch_samePointOrder", testLinearRing_LinearRing_linearRingsMatch_samePointOrder),
                ("testLinearRing_LinearRing_linearRingsMatch_differentPointOrder", testLinearRing_LinearRing_linearRingsMatch_differentPointOrder),
                ("testLinearRing_LinearRing_oneSegmentShared", testLinearRing_LinearRing_oneSegmentShared),
                ("testLinearRing_MultiLineString_noIntersection", testLinearRing_MultiLineString_noIntersection),
                ("testLinearRing_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString", testLinearRing_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString),
                ("testLinearRing_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString", testLinearRing_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString),
                ("testLinearRing_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString", testLinearRing_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString),
                ("testLinearRing_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString", testLinearRing_MultiLineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString),
                ("testLinearRing_MultiLineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross", testLinearRing_MultiLineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross),
                ("testLinearRing_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings", testLinearRing_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings),
                ("testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString1", testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString1),
                ("testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString2", testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundaryFirstLineString2),
                ("testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString1", testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString1),
                ("testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString2", testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundarySecondLineString2),
                ("testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_FirstLineString", testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_FirstLineString),
                ("testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_SecondLineString", testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_BothBoundaryPoints_SecondLineString),
                ("testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_AllBoundaryPoints", testLinearRing_MultiLineString_firstInteriorIntersectsSecondBoundary_AllBoundaryPoints),
                ("testLinearRing_MultiLineString_firstLineStringInteriorDoesNotIntersectLinearRingExterior", testLinearRing_MultiLineString_firstLineStringInteriorDoesNotIntersectLinearRingExterior),
                ("testLinearRing_MultiLineString_secondLineStringInteriorDoesNotIntersectLinearRingExterior", testLinearRing_MultiLineString_secondLineStringInteriorDoesNotIntersectLinearRingExterior),
                ("testLinearRing_MultiLineString_neitherLineStringInteriorIntersectsLinearRingExterior", testLinearRing_MultiLineString_neitherLineStringInteriorIntersectsLinearRingExterior),
                ("testLinearRing_MultiLineString_secondTouchesFirstInteriorAtLineSegmentAndPoint", testLinearRing_MultiLineString_secondTouchesFirstInteriorAtLineSegmentAndPoint),
                ("testLinearRing_MultiLineString_firstLineStringInsideLinearRing_secondLineStringBoundaryTouchesLinearRing", testLinearRing_MultiLineString_firstLineStringInsideLinearRing_secondLineStringBoundaryTouchesLinearRing),
                ("testLinearRing_MultiLineString_secondLineStringInsideLinearRing_firstLineStringBoundaryTouchesLinearRing", testLinearRing_MultiLineString_secondLineStringInsideLinearRing_firstLineStringBoundaryTouchesLinearRing),
                ("testLinearRing_MultiLineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap_FirstLineString", testLinearRing_MultiLineString_firstIntersectsFirstBoundaryPointOfSecondAndInteriorsOverlap_FirstLineString),
                ("testLinearRing_MultiLineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap_SecondLineString", testLinearRing_MultiLineString_firstIntersectsSecondBoundaryPointOfSecondAndInteriorsOverlap_SecondLineString),
                ("testLinearRing_MultiLineString_secondProperSubsetOfFirst", testLinearRing_MultiLineString_secondProperSubsetOfFirst),
                ("testLinearRing_MultiLineString_secondMostlyProperSubsetOfFirstButOneLineStringBoundaryPointNotIncluded", testLinearRing_MultiLineString_secondMostlyProperSubsetOfFirstButOneLineStringBoundaryPointNotIncluded),
                ("testLinearRing_Polygon_noIntersection", testLinearRing_Polygon_noIntersection),
                ("testLinearRing_Polygon_withHole_noIntersection_linearRingOutsideMainPolygon", testLinearRing_Polygon_withHole_noIntersection_linearRingOutsideMainPolygon),
                ("testLinearRing_Polygon_withHole_noIntersection_linearRingInsideHole", testLinearRing_Polygon_withHole_noIntersection_linearRingInsideHole),
                ("testLinearRing_Polygon_interiorsExteriorsIntersect1", testLinearRing_Polygon_interiorsExteriorsIntersect1),
                ("testLinearRing_Polygon_interiorsExteriorsIntersect2", testLinearRing_Polygon_interiorsExteriorsIntersect2),
                ("testLinearRing_Polygon_interiorIntersectsBoundaryAtOnePoint_linearRingFirstSegment_doNotCross", testLinearRing_Polygon_interiorIntersectsBoundaryAtOnePoint_linearRingFirstSegment_doNotCross),
                ("testLinearRing_Polygon_interiorIntersectsBoundaryAtOnePoint_linearRingInsideHole_doNotCross", testLinearRing_Polygon_interiorIntersectsBoundaryAtOnePoint_linearRingInsideHole_doNotCross),
                ("testLinearRing_Polygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingOutsideMainLinearRing", testLinearRing_Polygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingOutsideMainLinearRing),
                ("testLinearRing_Polygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingInsideHole", testLinearRing_Polygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingInsideHole),
                ("testLinearRing_Polygon_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingOutsideMainLinearRing", testLinearRing_Polygon_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingOutsideMainLinearRing),
                ("testLinearRing_Polygon_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingInsideHole", testLinearRing_Polygon_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingInsideHole),
                ("testLinearRing_Polygon_intersectsPolygonBoundaryInteriorExterior", testLinearRing_Polygon_intersectsPolygonBoundaryInteriorExterior),
                ("testLinearRing_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole", testLinearRing_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole),
                ("testLinearRing_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes", testLinearRing_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes),
                ("testLinearRing_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole", testLinearRing_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole),
                ("testLinearRing_MultiPolygon_noIntersection", testLinearRing_MultiPolygon_noIntersection),
                ("testLinearRing_MultiPolygon_withHoles_noIntersection_linearRingOutsideMainPolygon", testLinearRing_MultiPolygon_withHoles_noIntersection_linearRingOutsideMainPolygon),
                ("testLinearRing_MultiPolygon_withHoles_noIntersection_linearRingInsideHole", testLinearRing_MultiPolygon_withHoles_noIntersection_linearRingInsideHole),
                ("testLinearRing_MultiPolygon_withHoles_noIntersection_multiPolygonInsideLinearRing", testLinearRing_MultiPolygon_withHoles_noIntersection_multiPolygonInsideLinearRing),
                ("testLinearRing_MultiPolygon_interiorsIntersect_firstPolygon", testLinearRing_MultiPolygon_interiorsIntersect_firstPolygon),
                ("testLinearRing_MultiPolygon_interiorsIntersect_firstPolygon_withHole", testLinearRing_MultiPolygon_interiorsIntersect_firstPolygon_withHole),
                ("testLinearRing_MultiPolygon_interiorsIntersect_secondPolygon", testLinearRing_MultiPolygon_interiorsIntersect_secondPolygon),
                ("testLinearRing_MultiPolygon_interiorsIntersect_secondPolygon_withHole", testLinearRing_MultiPolygon_interiorsIntersect_secondPolygon_withHole),
                ("testLinearRing_MultiPolygon_interiorsIntersect_bothPolygons_withHoles", testLinearRing_MultiPolygon_interiorsIntersect_bothPolygons_withHoles),
                ("testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles", testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles),
                ("testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles", testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles),
                ("testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles", testLinearRing_MultiPolygon_interiorIntersectsBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles),
                ("testLinearRing_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles", testLinearRing_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testLinearRing_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles", testLinearRing_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testLinearRing_MultiPolygon_interiorIntersectsInteriorAndBoundary_withHoles", testLinearRing_MultiPolygon_interiorIntersectsInteriorAndBoundary_withHoles),
                ("testMultiLineString_Point_noIntersection", testMultiLineString_Point_noIntersection),
                ("testMultiLineString_Point_secondSubsetOfFirstInterior", testMultiLineString_Point_secondSubsetOfFirstInterior),
                ("testMultiLineString_Point_secondSubsetOfFirstBoundary", testMultiLineString_Point_secondSubsetOfFirstBoundary),
                ("testMultiLineString_MultiPoint_noIntersection", testMultiLineString_MultiPoint_noIntersection),
                ("testMultiLineString_MultiPoint_secondSubsetOfFirstInterior", testMultiLineString_MultiPoint_secondSubsetOfFirstInterior),
                ("testMultiLineString_MultiPoint_secondProperSubsetOfFirstBoundary", testMultiLineString_MultiPoint_secondProperSubsetOfFirstBoundary),
                ("testMultiLineString_MultiPoint_secondImproperSubsetOfFirstBoundary", testMultiLineString_MultiPoint_secondImproperSubsetOfFirstBoundary),
                ("testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndBoundary", testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndBoundary),
                ("testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndCoversBoundary", testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndCoversBoundary),
                ("testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndExterior", testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndExterior),
                ("testMultiLineString_MultiPoint_secondTouchesFirstBoundaryAndExterior", testMultiLineString_MultiPoint_secondTouchesFirstBoundaryAndExterior),
                ("testMultiLineString_MultiPoint_secondCoversFirstBoundaryAndTouchesExterior", testMultiLineString_MultiPoint_secondCoversFirstBoundaryAndTouchesExterior),
                ("testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndBoundaryAndExterior", testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndBoundaryAndExterior),
                ("testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndExteriorAndCoversBoundary", testMultiLineString_MultiPoint_secondTouchesFirstInteriorAndExteriorAndCoversBoundary),
                ("testMultiLineString_LineString_noIntersection", testMultiLineString_LineString_noIntersection),
                ("testMultiLineString_LineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString", testMultiLineString_LineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString),
                ("testMultiLineString_LineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString", testMultiLineString_LineString_interiorsIntersectAtOnePointFirstSegmentsSecondLineString),
                ("testMultiLineString_LineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString", testMultiLineString_LineString_interiorsIntersectAtOnePointSecondSegmentsFirstLineString),
                ("testMultiLineString_LineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString", testMultiLineString_LineString_interiorsIntersectAtOnePointSecondSegmentsSecondLineString),
                ("testMultiLineString_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross", testMultiLineString_LineString_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross),
                ("testMultiLineString_LineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings", testMultiLineString_LineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings),
                ("testMultiLineString_LineString_secondInteriorIntersectsFirstBoundaryFirstLineString1", testMultiLineString_LineString_secondInteriorIntersectsFirstBoundaryFirstLineString1),
                ("testMultiLineString_LineString_secondInteriorIntersectsFirstBoundaryFirstLineString2", testMultiLineString_LineString_secondInteriorIntersectsFirstBoundaryFirstLineString2),
                ("testMultiLineString_LineString_secondInteriorIntersectsFirstBoundarySecondLineString1", testMultiLineString_LineString_secondInteriorIntersectsFirstBoundarySecondLineString1),
                ("testMultiLineString_LineString_secondInteriorIntersectsFirstBoundarySecondLineString2", testMultiLineString_LineString_secondInteriorIntersectsFirstBoundarySecondLineString2),
                ("testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString", testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString),
                ("testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString", testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString),
                ("testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints", testMultiLineString_LineString_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints),
                ("testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_FirstLineString", testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_FirstLineString),
                ("testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_SecondLineString", testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_SecondLineString),
                ("testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesFirstBoundaryPointOfSecondLineString", testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesFirstBoundaryPointOfSecondLineString),
                ("testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesSecondBoundaryPointOfFirstLineString", testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesSecondBoundaryPointOfFirstLineString),
                ("testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesNeitherBoundaryPoint_FirstLineString", testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesNeitherBoundaryPoint_FirstLineString),
                ("testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesNeitherBoundaryPoint_SecondLineString", testMultiLineString_LineString_secondInteriorDoesNotIntersectFirstExterior_SecondSubsetOfFirstAndTouchesNeitherBoundaryPoint_SecondLineString),
                ("testMultiLineString_LineString_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineString", testMultiLineString_LineString_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineString),
                ("testMultiLineString_LineString_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineString", testMultiLineString_LineString_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineString),
                ("testMultiLineString_LineString_firstProperSubsetOfSecond", testMultiLineString_LineString_firstProperSubsetOfSecond),
                ("testMultiLineString_LinearRing_noIntersection", testMultiLineString_LinearRing_noIntersection),
                ("testMultiLineString_LinearRing_interiorsIntersectAtOnePointFirstSegmentsFirstLineString", testMultiLineString_LinearRing_interiorsIntersectAtOnePointFirstSegmentsFirstLineString),
                ("testMultiLineString_LinearRing_interiorsIntersectAtOnePointFirstSegmentsSecondLineString", testMultiLineString_LinearRing_interiorsIntersectAtOnePointFirstSegmentsSecondLineString),
                ("testMultiLineString_LinearRing_interiorsIntersectAtOnePointSecondSegmentsFirstLineString", testMultiLineString_LinearRing_interiorsIntersectAtOnePointSecondSegmentsFirstLineString),
                ("testMultiLineString_LinearRing_interiorsIntersectAtOnePointSecondSegmentsSecondLineString", testMultiLineString_LinearRing_interiorsIntersectAtOnePointSecondSegmentsSecondLineString),
                ("testMultiLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross", testMultiLineString_LinearRing_interiorsIntersectAtOnePointLineStringFirstSegment_DoNotCross),
                ("testMultiLineString_LinearRing_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings", testMultiLineString_LinearRing_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings),
                ("testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundaryFirstLineString1", testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundaryFirstLineString1),
                ("testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundaryFirstLineString2", testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundaryFirstLineString2),
                ("testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundarySecondLineString1", testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundarySecondLineString1),
                ("testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundarySecondLineString2", testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundarySecondLineString2),
                ("testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString", testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString),
                ("testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString", testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString),
                ("testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints", testMultiLineString_LinearRing_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints),
                ("testMultiLineString_LinearRing_firstLineStringInteriorDoesNotIntersectLinearRingExterior", testMultiLineString_LinearRing_firstLineStringInteriorDoesNotIntersectLinearRingExterior),
                ("testMultiLineString_LinearRing_secondLineStringInteriorDoesNotIntersectLinearRingExterior", testMultiLineString_LinearRing_secondLineStringInteriorDoesNotIntersectLinearRingExterior),
                ("testMultiLineString_LinearRing_neitherLineStringInteriorIntersectsLinearRingExterior", testMultiLineString_LinearRing_neitherLineStringInteriorIntersectsLinearRingExterior),
                ("testMultiLineString_LinearRing_firstTouchesSecondInteriorAtLineSegmentAndPoint", testMultiLineString_LinearRing_firstTouchesSecondInteriorAtLineSegmentAndPoint),
                ("testMultiLineString_LinearRing_firstLineStringInsideLinearRing_secondLineStringBoundaryTouchesLinearRing", testMultiLineString_LinearRing_firstLineStringInsideLinearRing_secondLineStringBoundaryTouchesLinearRing),
                ("testMultiLineString_LinearRing_secondLineStringInsideLinearRing_firstLineStringBoundaryTouchesLinearRing", testMultiLineString_LinearRing_secondLineStringInsideLinearRing_firstLineStringBoundaryTouchesLinearRing),
                ("testMultiLineString_LinearRing_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineString", testMultiLineString_LinearRing_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineString),
                ("testMultiLineString_LinearRing_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineString", testMultiLineString_LinearRing_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineString),
                ("testMultiLineString_LinearRing_firstProperSubsetOfSecond", testMultiLineString_LinearRing_firstProperSubsetOfSecond),
                ("testMultiLineString_LinearRing_firstMostlyProperSubsetOfSecondButOneLineStringBoundaryPointNotIncluded", testMultiLineString_LinearRing_firstMostlyProperSubsetOfSecondButOneLineStringBoundaryPointNotIncluded),
                ("testMultiLineString_MultiLineString_noIntersection", testMultiLineString_MultiLineString_noIntersection),
                ("testMultiLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString", testMultiLineString_MultiLineString_interiorsIntersectAtOnePointFirstSegmentsFirstLineString),
                ("testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint1", testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint1),
                ("testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint2", testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint2),
                ("testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint3", testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint3),
                ("testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint_DoNotCross_firstInteriorEndpointTouchesSecondInteriorPoint", testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint_DoNotCross_firstInteriorEndpointTouchesSecondInteriorPoint),
                ("testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint_DoNotCross_firstInteriorEndpointTouchesSecondInteriorEndpoint", testMultiLineString_MultiLineString_interiorsIntersectAtOnePoint_DoNotCross_firstInteriorEndpointTouchesSecondInteriorEndpoint),
                ("testMultiLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings_interiorPoints", testMultiLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings_interiorPoints),
                ("testMultiLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings_endpoints", testMultiLineString_MultiLineString_interiorsIntersectAtTwoPointDifferentSegmentsDifferentLineStrings_endpoints),
                ("testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundaryFirstLineString1", testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundaryFirstLineString1),
                ("testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundaryFirstLineString2", testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundaryFirstLineString2),
                ("testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundarySecondLineString1", testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundarySecondLineString1),
                ("testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundarySecondLineString2", testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundarySecondLineString2),
                ("testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString", testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_FirstLineString),
                ("testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString", testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_BothBoundaryPoints_SecondLineString),
                ("testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints", testMultiLineString_MultiLineString_secondInteriorIntersectsFirstBoundary_AllBoundaryPoints),
                ("testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_SameOrder", testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_SameOrder),
                ("testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_DifferentOrder", testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_IdenticalLineStrings_DifferentOrder),
                ("testMultiLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_firstSubsetOfSecond", testMultiLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExterior_firstSubsetOfSecond),
                ("testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_secondSubsetOfFirst", testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExterior_secondSubsetOfFirst),
                ("testMultiLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExteriorOrBoundary_firstSubsetOfSecond", testMultiLineString_MultiLineString_firstInteriorDoesNotIntersectSecondExteriorOrBoundary_firstSubsetOfSecond),
                ("testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExteriorOrBoundary_secondSubsetOfFirst", testMultiLineString_MultiLineString_secondInteriorDoesNotIntersectFirstExteriorOrBoundary_secondSubsetOfFirst),
                ("testMultiLineString_MultiLineString_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineStrings", testMultiLineString_MultiLineString_secondIntersectsFirstBoundaryPointOfFirstAndInteriorsOverlap_FirstLineStrings),
                ("testMultiLineString_MultiLineString_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineStrings", testMultiLineString_MultiLineString_secondIntersectsSecondBoundaryPointOfFirstAndInteriorsOverlap_SecondLineStrings),
                ("testMultiLineString_MultiLineString_firstProperSubsetOfSecond", testMultiLineString_MultiLineString_firstProperSubsetOfSecond),
                ("testMultiLineString_MultiLineString_secondProperSubsetOfFirst", testMultiLineString_MultiLineString_secondProperSubsetOfFirst),
                ("testMultiLineString_Polygon_noIntersection", testMultiLineString_Polygon_noIntersection),
                ("testMultiLineString_Polygon_withHole_noIntersection_multiLineStringOutsideMainPolygon", testMultiLineString_Polygon_withHole_noIntersection_multiLineStringOutsideMainPolygon),
                ("testMultiLineString_Polygon_withHole_noIntersection_multiLineStringInsideHole", testMultiLineString_Polygon_withHole_noIntersection_multiLineStringInsideHole),
                ("testMultiLineString_Polygon_withHoles_noIntersection_multiLineStringInsideTwoHoles", testMultiLineString_Polygon_withHoles_noIntersection_multiLineStringInsideTwoHoles),
                ("testMultiLineString_Polygon_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideMainLinearRing", testMultiLineString_Polygon_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideMainLinearRing),
                ("testMultiLineString_Polygon_interiorsIntersect_firstLineString", testMultiLineString_Polygon_interiorsIntersect_firstLineString),
                ("testMultiLineString_Polygon_interiorsIntersect_secondLineString", testMultiLineString_Polygon_interiorsIntersect_secondLineString),
                ("testMultiLineString_Polygon_firstInteriorIntersectsSecondBoundaryAtOnePoint_firstLineString_doNotCross", testMultiLineString_Polygon_firstInteriorIntersectsSecondBoundaryAtOnePoint_firstLineString_doNotCross),
                ("testMultiLineString_Polygon_firstInteriorIntersectsSecondBoundaryAtOnePoint_lineStringInsideHole_doNotCross", testMultiLineString_Polygon_firstInteriorIntersectsSecondBoundaryAtOnePoint_lineStringInsideHole_doNotCross),
                ("testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtOnePoint_doNotCross_multiLineStringOutsideMainLinearRing", testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtOnePoint_doNotCross_multiLineStringOutsideMainLinearRing),
                ("testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtTwoPoints_doNotCross_mulitLineStringOutsideMainLinearRing", testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtTwoPoints_doNotCross_mulitLineStringOutsideMainLinearRing),
                ("testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtThreePoints_doNotCross_mulitLineStringOutsideMainLinearRing", testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtThreePoints_doNotCross_mulitLineStringOutsideMainLinearRing),
                ("testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtFourPoints_doNotCross_mulitLineStringOutsideMainLinearRing", testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtFourPoints_doNotCross_mulitLineStringOutsideMainLinearRing),
                ("testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtOnePoint_doNotCross_multiLineStringInsideHole", testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtOnePoint_doNotCross_multiLineStringInsideHole),
                ("testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtTwoPoints_doNotCross_multiLineStringInsideHole", testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtTwoPoints_doNotCross_multiLineStringInsideHole),
                ("testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtThreePoints_doNotCross_multiLineStringInsideHole", testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtThreePoints_doNotCross_multiLineStringInsideHole),
                ("testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtFourPoints_doNotCross_multiLineStringInsideHole", testMultiLineString_Polygon_firstBoundaryIntersectsSecondBoundaryAtFourPoints_doNotCross_multiLineStringInsideHole),
                ("testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorExterior", testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorExterior),
                ("testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole", testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorAndExteriorInsideHole),
                ("testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes", testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorExterior_multipleTimes),
                ("testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole", testMultiLineString_Polygon_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole),
                ("testMultiLineString_MultiPolygon_noIntersection", testMultiLineString_MultiPolygon_noIntersection),
                ("testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringOutsideMainPolygon", testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringOutsideMainPolygon),
                ("testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideOneHole", testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideOneHole),
                ("testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHoles", testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHoles),
                ("testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHolesInTwoDifferentPolygonsAndOutsideAllPolygons", testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHolesInTwoDifferentPolygonsAndOutsideAllPolygons),
                ("testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideAllPolygons", testMultiLineString_MultiPolygon_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideAllPolygons),
                ("testMultiLineString_MultiPolygon_interiorsIntersect_firstPolygon", testMultiLineString_MultiPolygon_interiorsIntersect_firstPolygon),
                ("testMultiLineString_MultiPolygon_interiorsIntersect_firstPolygon_withHole", testMultiLineString_MultiPolygon_interiorsIntersect_firstPolygon_withHole),
                ("testMultiLineString_MultiPolygon_interiorsIntersect_secondPolygon", testMultiLineString_MultiPolygon_interiorsIntersect_secondPolygon),
                ("testMultiLineString_MultiPolygon_interiorsIntersect_secondPolygon_withHole", testMultiLineString_MultiPolygon_interiorsIntersect_secondPolygon_withHole),
                ("testMultiLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles", testMultiLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles),
                ("testMultiLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles_differentLineStrings", testMultiLineString_MultiPolygon_interiorsIntersect_bothPolygons_withHoles_differentLineStrings),
                ("testMultiLineString_MultiPolygon_boundariesIntersect_firstPolygon_withHoles", testMultiLineString_MultiPolygon_boundariesIntersect_firstPolygon_withHoles),
                ("testMultiLineString_MultiPolygon_boundariesIntersect_secondPolygon_withHoles", testMultiLineString_MultiPolygon_boundariesIntersect_secondPolygon_withHoles),
                ("testMultiLineString_MultiPolygon_boundariesIntersect_bothPolygons_withHoles", testMultiLineString_MultiPolygon_boundariesIntersect_bothPolygons_withHoles),
                ("testMultiLineString_MultiPolygon_boundariesIntersectAtAllFourBoundaryPoints_bothPolygons_withHoles", testMultiLineString_MultiPolygon_boundariesIntersectAtAllFourBoundaryPoints_bothPolygons_withHoles),
                ("testMultiLineString_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles", testMultiLineString_MultiPolygon_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testMultiLineString_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles", testMultiLineString_MultiPolygon_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testMultiLineString_MultiPolygon_interiorsIntersectAndBoundariesIntersect_withHoles", testMultiLineString_MultiPolygon_interiorsIntersectAndBoundariesIntersect_withHoles),
                ("testMultiLineString_MultiPolygon_boundaryIntersectsInteriorAndBoundary_withHoles", testMultiLineString_MultiPolygon_boundaryIntersectsInteriorAndBoundary_withHoles),
                ("testMultiLineString_MultiPolygon_boundaryIntersectsInteriorAndBoundaryAtAllFourBoundaryPoints_withHoles", testMultiLineString_MultiPolygon_boundaryIntersectsInteriorAndBoundaryAtAllFourBoundaryPoints_withHoles),
                ("testPolygon_Point_outerRingOnly_noIntersection", testPolygon_Point_outerRingOnly_noIntersection),
                ("testPolygon_Point_outerRingAndInnerRing_outsideMainRing_noIntersection", testPolygon_Point_outerRingAndInnerRing_outsideMainRing_noIntersection),
                ("testPolygon_Point_outerRingAndInnerRing_insideInnerRing_noIntersection", testPolygon_Point_outerRingAndInnerRing_insideInnerRing_noIntersection),
                ("testPolygon_Point_outerRingOnly_intersectsBoundary", testPolygon_Point_outerRingOnly_intersectsBoundary),
                ("testPolygon_Point_outerRingAndInnerRing_intersectsOuterBoundary", testPolygon_Point_outerRingAndInnerRing_intersectsOuterBoundary),
                ("testPolygon_Point_outerRingAndInnerRing_intersectsInnerBoundary", testPolygon_Point_outerRingAndInnerRing_intersectsInnerBoundary),
                ("testPolygon_Point_outerRingOnly_intersectsInterior", testPolygon_Point_outerRingOnly_intersectsInterior),
                ("testPolygon_Point_outerRingAndInnerRing_intersectsInterior", testPolygon_Point_outerRingAndInnerRing_intersectsInterior),
                ("testPolygon_MultiPoint_outerRingOnly_noIntersection", testPolygon_MultiPoint_outerRingOnly_noIntersection),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_outsideMainRing_noIntersection", testPolygon_MultiPoint_outerRingAndInnerRing_outsideMainRing_noIntersection),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_insideInnerRing_noIntersection", testPolygon_MultiPoint_outerRingAndInnerRing_insideInnerRing_noIntersection),
                ("testPolygon_MultiPoint_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection", testPolygon_MultiPoint_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection),
                ("testPolygon_MultiPoint_outerRingOnly_intersectsBoundaryOnly", testPolygon_MultiPoint_outerRingOnly_intersectsBoundaryOnly),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterBoundaryOnly", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterBoundaryOnly),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInnerBoundaryOnly", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInnerBoundaryOnly),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries),
                ("testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries", testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries),
                ("testPolygon_MultiPoint_outerRingOnly_intersectsInteriorOnly", testPolygon_MultiPoint_outerRingOnly_intersectsInteriorOnly),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorOnly", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorOnly),
                ("testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorOnly", testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorOnly),
                ("testPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundary", testPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundary),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries),
                ("testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries", testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries),
                ("testPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndExterior", testPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndExterior),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing),
                ("testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings", testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings),
                ("testPolygon_MultiPoint_outerRingOnly_intersectsBoundaryAndExterior", testPolygon_MultiPoint_outerRingOnly_intersectsBoundaryAndExterior),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing),
                ("testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings", testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings),
                ("testPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundaryAndExterior", testPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundaryAndExterior),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing),
                ("testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing", testPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing),
                ("testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings", testPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings),
                ("testPolygon_LineString_noIntersection", testPolygon_LineString_noIntersection),
                ("testPolygon_LineString_withHole_noIntersection_lineStringOutsideMainPolygon", testPolygon_LineString_withHole_noIntersection_lineStringOutsideMainPolygon),
                ("testPolygon_LineString_withHole_noIntersection_lineStringInsideHole", testPolygon_LineString_withHole_noIntersection_lineStringInsideHole),
                ("testPolygon_LineString_interiorsIntersect_lineStringFirstSegment", testPolygon_LineString_interiorsIntersect_lineStringFirstSegment),
                ("testPolygon_LineString_interiorsIntersect_lineStringSecondSegment", testPolygon_LineString_interiorsIntersect_lineStringSecondSegment),
                ("testPolygon_LineString_interiorIntersectsBoundaryAtOnePoint_lineStringFirstSegment_doNotCross", testPolygon_LineString_interiorIntersectsBoundaryAtOnePoint_lineStringFirstSegment_doNotCross),
                ("testPolygon_LineString_interiorIntersectsBoundaryAtOnePoint_lineStringInsideHole_doNotCross", testPolygon_LineString_interiorIntersectsBoundaryAtOnePoint_lineStringInsideHole_doNotCross),
                ("testPolygon_LineString_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringOutsideMainLinearRing", testPolygon_LineString_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringOutsideMainLinearRing),
                ("testPolygon_LineString_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringOutsideMainLinearRing", testPolygon_LineString_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringOutsideMainLinearRing),
                ("testPolygon_LineString_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringInsideHole", testPolygon_LineString_boundaryIntersectsBoundaryAtOnePoint_doNotCross_lineStringInsideHole),
                ("testPolygon_LineString_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringInsideHole", testPolygon_LineString_boundaryIntersectsBoundaryAtTwoPoints_doNotCross_lineStringInsideHole),
                ("testPolygon_LineString_intersectsPolygonBoundaryInteriorExterior", testPolygon_LineString_intersectsPolygonBoundaryInteriorExterior),
                ("testPolygon_LineString_intersectsPolygonBoundaryInteriorAndExteriorInsideHole", testPolygon_LineString_intersectsPolygonBoundaryInteriorAndExteriorInsideHole),
                ("testPolygon_LineString_intersectsPolygonBoundaryInteriorExterior_multipleTimes", testPolygon_LineString_intersectsPolygonBoundaryInteriorExterior_multipleTimes),
                ("testPolygon_LineString_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole", testPolygon_LineString_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole),
                ("testPolygon_LinearRing_noIntersection", testPolygon_LinearRing_noIntersection),
                ("testPolygon_LinearRing_withHole_noIntersection_linearRingOutsideMainPolygon", testPolygon_LinearRing_withHole_noIntersection_linearRingOutsideMainPolygon),
                ("testPolygon_LinearRing_withHole_noIntersection_linearRingInsideHole", testPolygon_LinearRing_withHole_noIntersection_linearRingInsideHole),
                ("testPolygon_LinearRing_interiorsExteriorsIntersect1", testPolygon_LinearRing_interiorsExteriorsIntersect1),
                ("testPolygon_LinearRing_interiorsExteriorsIntersect2", testPolygon_LinearRing_interiorsExteriorsIntersect2),
                ("testPolygon_LinearRing_interiorIntersectsBoundaryAtOnePoint_linearRingFirstSegment_doNotCross", testPolygon_LinearRing_interiorIntersectsBoundaryAtOnePoint_linearRingFirstSegment_doNotCross),
                ("testPolygon_LinearRing_interiorIntersectsBoundaryAtOnePoint_linearRingInsideHole_doNotCross", testPolygon_LinearRing_interiorIntersectsBoundaryAtOnePoint_linearRingInsideHole_doNotCross),
                ("testPolygon_LinearRing_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingOutsideMainLinearRing", testPolygon_LinearRing_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingOutsideMainLinearRing),
                ("testPolygon_LinearRing_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingInsideHole", testPolygon_LinearRing_interiorIntersectsBoundaryAtTwoPoints_doNotCross_linearRingInsideHole),
                ("testPolygon_LinearRing_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingOutsideMainLinearRing", testPolygon_LinearRing_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingOutsideMainLinearRing),
                ("testPolygon_LinearRing_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingInsideHole", testPolygon_LinearRing_interiorIntersectsBoundaryAtLineSegment_doNotCross_linearRingInsideHole),
                ("testPolygon_LinearRing_intersectsPolygonBoundaryInteriorExterior", testPolygon_LinearRing_intersectsPolygonBoundaryInteriorExterior),
                ("testPolygon_LinearRing_intersectsPolygonBoundaryInteriorAndExteriorInsideHole", testPolygon_LinearRing_intersectsPolygonBoundaryInteriorAndExteriorInsideHole),
                ("testPolygon_LinearRing_intersectsPolygonBoundaryInteriorExterior_multipleTimes", testPolygon_LinearRing_intersectsPolygonBoundaryInteriorExterior_multipleTimes),
                ("testPolygon_LinearRing_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole", testPolygon_LinearRing_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole),
                ("testPolygon_MultiLineString_noIntersection", testPolygon_MultiLineString_noIntersection),
                ("testPolygon_MultiLineString_withHole_noIntersection_multiLineStringOutsideMainPolygon", testPolygon_MultiLineString_withHole_noIntersection_multiLineStringOutsideMainPolygon),
                ("testPolygon_MultiLineString_withHole_noIntersection_multiLineStringInsideHole", testPolygon_MultiLineString_withHole_noIntersection_multiLineStringInsideHole),
                ("testPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHoles", testPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHoles),
                ("testPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideMainLinearRing", testPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideMainLinearRing),
                ("testPolygon_MultiLineString_interiorsIntersect_firstLineString", testPolygon_MultiLineString_interiorsIntersect_firstLineString),
                ("testPolygon_MultiLineString_interiorsIntersect_secondLineString", testPolygon_MultiLineString_interiorsIntersect_secondLineString),
                ("testPolygon_MultiLineString_secondInteriorIntersectsFirstBoundaryAtOnePoint_firstLineString_doNotCross", testPolygon_MultiLineString_secondInteriorIntersectsFirstBoundaryAtOnePoint_firstLineString_doNotCross),
                ("testPolygon_MultiLineString_secondInteriorIntersectsFirstBoundaryAtOnePoint_lineStringInsideHole_doNotCross", testPolygon_MultiLineString_secondInteriorIntersectsFirstBoundaryAtOnePoint_lineStringInsideHole_doNotCross),
                ("testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtOnePoint_doNotCross_multiLineStringOutsideMainLinearRing", testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtOnePoint_doNotCross_multiLineStringOutsideMainLinearRing),
                ("testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtTwoPoints_doNotCross_mulitLineStringOutsideMainLinearRing", testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtTwoPoints_doNotCross_mulitLineStringOutsideMainLinearRing),
                ("testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtThreePoints_doNotCross_mulitLineStringOutsideMainLinearRing", testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtThreePoints_doNotCross_mulitLineStringOutsideMainLinearRing),
                ("testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtFourPoints_doNotCross_mulitLineStringOutsideMainLinearRing", testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtFourPoints_doNotCross_mulitLineStringOutsideMainLinearRing),
                ("testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtOnePoint_doNotCross_multiLineStringInsideHole", testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtOnePoint_doNotCross_multiLineStringInsideHole),
                ("testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtTwoPoints_doNotCross_multiLineStringInsideHole", testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtTwoPoints_doNotCross_multiLineStringInsideHole),
                ("testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtThreePoints_doNotCross_multiLineStringInsideHole", testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtThreePoints_doNotCross_multiLineStringInsideHole),
                ("testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtFourPoints_doNotCross_multiLineStringInsideHole", testPolygon_MultiLineString_secondBoundaryIntersectsFirstBoundaryAtFourPoints_doNotCross_multiLineStringInsideHole),
                ("testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorExterior", testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorExterior),
                ("testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorAndExteriorInsideHole", testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorAndExteriorInsideHole),
                ("testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorExterior_multipleTimes", testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorExterior_multipleTimes),
                ("testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole", testPolygon_MultiLineString_intersectsPolygonBoundaryInteriorAndExterior_bothInsideAndOutsideHole),
                ("testPolygon_Polgyon_noIntersection", testPolygon_Polgyon_noIntersection),
                ("testPolygon_Polygon_firstWithHole_noIntersection_polygonsOutsideOfEachOther", testPolygon_Polygon_firstWithHole_noIntersection_polygonsOutsideOfEachOther),
                ("testPolygon_Polygon_firstWithHole_noIntersection_secondPolygonInsideHole", testPolygon_Polygon_firstWithHole_noIntersection_secondPolygonInsideHole),
                ("testPolygon_Polygon_bothWithHoles_noIntersection_firstPolygonInsideSecondHole", testPolygon_Polygon_bothWithHoles_noIntersection_firstPolygonInsideSecondHole),
                ("testPolygon_Polygon_secondInsideFirst", testPolygon_Polygon_secondInsideFirst),
                ("testPolygon_Polygon_firstInsideSecond", testPolygon_Polygon_firstInsideSecond),
                ("testPolygon_Polygon_interiorsExteriorsIntersect1", testPolygon_Polygon_interiorsExteriorsIntersect1),
                ("testPolygon_Polygon_interiorsExteriorsIntersect2", testPolygon_Polygon_interiorsExteriorsIntersect2),
                ("testPolygon_Polygon_interiorIntersectsBoundaryAtOnePoint_firstPolygonFirstSegment_doNotCross", testPolygon_Polygon_interiorIntersectsBoundaryAtOnePoint_firstPolygonFirstSegment_doNotCross),
                ("testPolygon_Polygon_secondPolygonIntersectsFirstBoundaryAtOnePointInsideHole_doNotCross", testPolygon_Polygon_secondPolygonIntersectsFirstBoundaryAtOnePointInsideHole_doNotCross),
                ("testPolygon_Polygon_firstPolygonIntersectsSecondBoundaryAtTwoPoints_doNotCross", testPolygon_Polygon_firstPolygonIntersectsSecondBoundaryAtTwoPoints_doNotCross),
                ("testPolygon_Polygon_secondPolygonIntersectsFirstBoundaryAtTwoPoints_doNotCross_secondPolygonInsideHole", testPolygon_Polygon_secondPolygonIntersectsFirstBoundaryAtTwoPoints_doNotCross_secondPolygonInsideHole),
                ("testPolygon_Polygon_boundariesIntersectAtLineSegment_doNotCross", testPolygon_Polygon_boundariesIntersectAtLineSegment_doNotCross),
                ("testPolygon_Polygon_boundariesIntersectsAtLineSegment_doNotCross_secondPolygonInsideHole", testPolygon_Polygon_boundariesIntersectsAtLineSegment_doNotCross_secondPolygonInsideHole),
                ("testPolygon_Polygon_intersectsBoundaryInteriorExterior", testPolygon_Polygon_intersectsBoundaryInteriorExterior),
                ("testPolygon_Polygon_intersectsBoundaryInteriorAndExteriorInsideHole", testPolygon_Polygon_intersectsBoundaryInteriorAndExteriorInsideHole),
                ("testPolygon_Polygon_intersectsBoundaryInteriorExterior_multipleTimes", testPolygon_Polygon_intersectsBoundaryInteriorExterior_multipleTimes),
                ("testPolygon_Polygon_intersectsBoundaryInteriorAndExterior_bothInsideAndOutsideHole", testPolygon_Polygon_intersectsBoundaryInteriorAndExterior_bothInsideAndOutsideHole),
                ("testPolygon_Polygon_identicalPolygons", testPolygon_Polygon_identicalPolygons),
                ("testPolygon_Polygon_identicalPolygons_differentPointOrder", testPolygon_Polygon_identicalPolygons_differentPointOrder),
                ("testPolygon_Polygon_identicalPolygons_withHoles", testPolygon_Polygon_identicalPolygons_withHoles),
                ("testPolygon_Polygon_identicalPolygons_withHoles_differentPointOrder", testPolygon_Polygon_identicalPolygons_withHoles_differentPointOrder),
                ("testPolygon_Polygon_withHoles_secondSameAsFirstButWithOneExtraHole", testPolygon_Polygon_withHoles_secondSameAsFirstButWithOneExtraHole),
                ("testPolygon_Polygon_withHoles_firstSameAsSecondButWithOneExtraHole", testPolygon_Polygon_withHoles_firstSameAsSecondButWithOneExtraHole),
                ("testPolygon_MultiPolygon_noIntersection", testPolygon_MultiPolygon_noIntersection),
                ("testPolygon_MultiPolygon_withHoles_noIntersection_PolygonOutsideMultiPolygon", testPolygon_MultiPolygon_withHoles_noIntersection_PolygonOutsideMultiPolygon),
                ("testPolygon_MultiPolygon_withHoles_noIntersection_polygonInsideHole", testPolygon_MultiPolygon_withHoles_noIntersection_polygonInsideHole),
                ("testPolygon_MultiPolygon_withHoles_noIntersection_multiPolygonInsidePolygonHole", testPolygon_MultiPolygon_withHoles_noIntersection_multiPolygonInsidePolygonHole),
                ("testPolygon_MultiPolygon_interiorsIntersect_firstPolygon", testPolygon_MultiPolygon_interiorsIntersect_firstPolygon),
                ("testPolygon_MultiPolygon_interiorsIntersect_firstPolygon_withHole", testPolygon_MultiPolygon_interiorsIntersect_firstPolygon_withHole),
                ("testPolygon_MultiPolygon_interiorsIntersect_secondPolygon", testPolygon_MultiPolygon_interiorsIntersect_secondPolygon),
                ("testPolygon_MultiPolygon_interiorsIntersect_secondPolygon_withHole", testPolygon_MultiPolygon_interiorsIntersect_secondPolygon_withHole),
                ("testPolygon_MultiPolygon_interiorsIntersect_bothPolygons_withHoles", testPolygon_MultiPolygon_interiorsIntersect_bothPolygons_withHoles),
                ("testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles", testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles),
                ("testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles", testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles),
                ("testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles", testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles),
                ("testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles", testPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testPolygon_MultiPolygon_polygonIntersectsMultiPolygonInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles", testPolygon_MultiPolygon_polygonIntersectsMultiPolygonInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testPolygon_MultiPolygon_polygonIntersectsMultiPolygonInteriorAndBoundary_withHoles", testPolygon_MultiPolygon_polygonIntersectsMultiPolygonInteriorAndBoundary_withHoles),
                ("testMultiPolygon_Point_outerRingsOnly_noIntersection", testMultiPolygon_Point_outerRingsOnly_noIntersection),
                ("testMultiPolygon_Point_outerRingAndInnerRings_outsideMainRings_noIntersection", testMultiPolygon_Point_outerRingAndInnerRings_outsideMainRings_noIntersection),
                ("testMultiPolygon_Point_outerRingAndInnerRing_insideInnerRing_noIntersection", testMultiPolygon_Point_outerRingAndInnerRing_insideInnerRing_noIntersection),
                ("testMultiPolygon_Point_outerRingOnly_intersectsBoundary", testMultiPolygon_Point_outerRingOnly_intersectsBoundary),
                ("testMultiPolygon_Point_outerRingAndInnerRing_intersectsOuterBoundary", testMultiPolygon_Point_outerRingAndInnerRing_intersectsOuterBoundary),
                ("testMultiPolygon_Point_outerRingAndInnerRing_intersectsInnerBoundary", testMultiPolygon_Point_outerRingAndInnerRing_intersectsInnerBoundary),
                ("testMultiPolygon_Point_outerRingOnly_intersectsInterior", testMultiPolygon_Point_outerRingOnly_intersectsInterior),
                ("testMultiPolygon_Point_outerRingAndInnerRing_intersectsInterior", testMultiPolygon_Point_outerRingAndInnerRing_intersectsInterior),
                ("testMultiPolygon_MultiPoint_outerRingOnly_noIntersection", testMultiPolygon_MultiPoint_outerRingOnly_noIntersection),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_outsideMainRing_noIntersection", testMultiPolygon_MultiPoint_outerRingAndInnerRing_outsideMainRing_noIntersection),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_insideInnerRing_noIntersection", testMultiPolygon_MultiPoint_outerRingAndInnerRing_insideInnerRing_noIntersection),
                ("testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection", testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_outsideMainRingAndInsideInnerRings_noIntersection),
                ("testMultiPolygon_MultiPoint_outerRingOnly_intersectsBoundaryOnly", testMultiPolygon_MultiPoint_outerRingOnly_intersectsBoundaryOnly),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterBoundaryOnly", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterBoundaryOnly),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInnerBoundaryOnly", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInnerBoundaryOnly),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsOuterAndInnerBoundaries),
                ("testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries", testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsOuterAndInnerBoundaries),
                ("testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorOnly", testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorOnly),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorOnly", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorOnly),
                ("testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorOnly", testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorOnly),
                ("testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundary", testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundary),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterBoundary),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndInnerBoundary),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndOuterAndInnerBoundaries),
                ("testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries", testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndOuterAndInnerBoundaries),
                ("testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndExterior", testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndExterior),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorOfMainRing),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndExteriorWithinInnerRing),
                ("testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings", testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndExteriorOfMainRingAndWithinInnerRings),
                ("testMultiPolygon_MultiPoint_outerRingOnly_intersectsBoundaryAndExterior", testMultiPolygon_MultiPoint_outerRingOnly_intersectsBoundaryAndExterior),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorOfMainRing),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsBoundaryAndExteriorWithinInnerRing),
                ("testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings", testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsBoundaryAndExteriorOfMainRingAndWithinInnerRings),
                ("testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundaryAndExterior", testMultiPolygon_MultiPoint_outerRingOnly_intersectsInteriorAndBoundaryAndExterior),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndMainBoundaryAndExteriorOfMainRing),
                ("testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing", testMultiPolygon_MultiPoint_outerRingAndInnerRing_intersectsInteriorAndBothMainAndInnerBoundaryAndExteriorWithinInnerRingAndOutsideMainRing),
                ("testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings", testMultiPolygon_MultiPoint_outerRingAndMultipleInnerRings_intersectsInteriorAndInnerBoundariesAndExteriorOfMainRingAndWithinInnerRings),
                ("testMultiPolygon_LineString_noIntersection", testMultiPolygon_LineString_noIntersection),
                ("testMultiPolygon_LineString_withHoles_noIntersection_lineStringOutsideMainPolygon", testMultiPolygon_LineString_withHoles_noIntersection_lineStringOutsideMainPolygon),
                ("testMultiPolygon_LineString_withHoles_noIntersection_lineStringInsideHole", testMultiPolygon_LineString_withHoles_noIntersection_lineStringInsideHole),
                ("testMultiPolygon_LineString_interiorsIntersect_firstPolygon", testMultiPolygon_LineString_interiorsIntersect_firstPolygon),
                ("testMultiPolygon_LineString_interiorsIntersect_firstPolygon_withHole", testMultiPolygon_LineString_interiorsIntersect_firstPolygon_withHole),
                ("testMultiPolygon_LineString_interiorsIntersect_secondPolygon", testMultiPolygon_LineString_interiorsIntersect_secondPolygon),
                ("testMultiPolygon_LineString_interiorsIntersect_secondPolygon_withHole", testMultiPolygon_LineString_interiorsIntersect_secondPolygon_withHole),
                ("testMultiPolygon_LineString_interiorsIntersect_bothPolygons_withHoles", testMultiPolygon_LineString_interiorsIntersect_bothPolygons_withHoles),
                ("testMultiPolygon_LineString_boundariesIntersect_firstPolygon_withHoles", testMultiPolygon_LineString_boundariesIntersect_firstPolygon_withHoles),
                ("testMultiPolygon_LineString_boundariesIntersect_secondPolygon_withHoles", testMultiPolygon_LineString_boundariesIntersect_secondPolygon_withHoles),
                ("testMultiPolygon_LineString_boundariesIntersect_bothPolygons_withHoles", testMultiPolygon_LineString_boundariesIntersect_bothPolygons_withHoles),
                ("testMultiPolygon_LineString_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles", testMultiPolygon_LineString_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testMultiPolygon_LineString_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles", testMultiPolygon_LineString_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testMultiPolygon_LineString_interiorsIntersectAndBoundariesIntersect_withHoles", testMultiPolygon_LineString_interiorsIntersectAndBoundariesIntersect_withHoles),
                ("testMultiPolygon_LineString_boundaryIntersectsInteriorAndBoundary_withHoles", testMultiPolygon_LineString_boundaryIntersectsInteriorAndBoundary_withHoles),
                ("testMultiPolygon_LinearRing_noIntersection", testMultiPolygon_LinearRing_noIntersection),
                ("testMultiPolygon_LinearRing_withHoles_noIntersection_linearRingOutsideMainPolygon", testMultiPolygon_LinearRing_withHoles_noIntersection_linearRingOutsideMainPolygon),
                ("testMultiPolygon_LinearRing_withHoles_noIntersection_linearRingInsideHole", testMultiPolygon_LinearRing_withHoles_noIntersection_linearRingInsideHole),
                ("testMultiPolygon_LinearRing_withHoles_noIntersection_multiPolygonInsideLinearRing", testMultiPolygon_LinearRing_withHoles_noIntersection_multiPolygonInsideLinearRing),
                ("testMultiPolygon_LinearRing_interiorsIntersect_firstPolygon", testMultiPolygon_LinearRing_interiorsIntersect_firstPolygon),
                ("testMultiPolygon_LinearRing_interiorsIntersect_firstPolygon_withHole", testMultiPolygon_LinearRing_interiorsIntersect_firstPolygon_withHole),
                ("testMultiPolygon_LinearRing_interiorsIntersect_secondPolygon", testMultiPolygon_LinearRing_interiorsIntersect_secondPolygon),
                ("testMultiPolygon_LinearRing_interiorsIntersect_secondPolygon_withHole", testMultiPolygon_LinearRing_interiorsIntersect_secondPolygon_withHole),
                ("testMultiPolygon_LinearRing_interiorsIntersect_bothPolygons_withHoles", testMultiPolygon_LinearRing_interiorsIntersect_bothPolygons_withHoles),
                ("testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles", testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles),
                ("testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles", testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles),
                ("testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles", testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles),
                ("testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles", testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles", testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonInteriorAndBoundary_withHoles", testMultiPolygon_LinearRing_interiorIntersectsMultiPolygonInteriorAndBoundary_withHoles),
                ("testMultiPolygon_MultiLineString_noIntersection", testMultiPolygon_MultiLineString_noIntersection),
                ("testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringOutsidePolygons", testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringOutsidePolygons),
                ("testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideOneHole", testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideOneHole),
                ("testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHoles", testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHoles),
                ("testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHolesInTwoDifferentPolygonsAndOutsideAllPolygons", testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHolesInTwoDifferentPolygonsAndOutsideAllPolygons),
                ("testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideAllPolygons", testMultiPolygon_MultiLineString_withHoles_noIntersection_multiLineStringInsideTwoHolesAndOutsideAllPolygons),
                ("testMultiPolygon_MultiLineString_interiorsIntersect_firstPolygon", testMultiPolygon_MultiLineString_interiorsIntersect_firstPolygon),
                ("testMultiPolygon_MultiLineString_interiorsIntersect_firstPolygon_withHole", testMultiPolygon_MultiLineString_interiorsIntersect_firstPolygon_withHole),
                ("testMultiPolygon_MultiLineString_interiorsIntersect_secondPolygon", testMultiPolygon_MultiLineString_interiorsIntersect_secondPolygon),
                ("testMultiPolygon_MultiLineString_interiorsIntersect_secondPolygon_withHole", testMultiPolygon_MultiLineString_interiorsIntersect_secondPolygon_withHole),
                ("testMultiPolygon_MultiLineString_interiorsIntersect_bothPolygons_withHoles", testMultiPolygon_MultiLineString_interiorsIntersect_bothPolygons_withHoles),
                ("testMultiPolygon_MultiLineString_interiorsIntersect_bothPolygons_withHoles_differentLineStrings", testMultiPolygon_MultiLineString_interiorsIntersect_bothPolygons_withHoles_differentLineStrings),
                ("testMultiPolygon_MultiLineString_boundariesIntersect_firstPolygon_withHoles", testMultiPolygon_MultiLineString_boundariesIntersect_firstPolygon_withHoles),
                ("testMultiPolygon_MultiLineString_boundariesIntersect_secondPolygon_withHoles", testMultiPolygon_MultiLineString_boundariesIntersect_secondPolygon_withHoles),
                ("testMultiPolygon_MultiLineString_boundariesIntersect_bothPolygons_withHoles", testMultiPolygon_MultiLineString_boundariesIntersect_bothPolygons_withHoles),
                ("testMultiPolygon_MultiLineString_boundariesIntersectAtAllFourBoundaryPoints_bothPolygons_withHoles", testMultiPolygon_MultiLineString_boundariesIntersectAtAllFourBoundaryPoints_bothPolygons_withHoles),
                ("testMultiPolygon_MultiLineString_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles", testMultiPolygon_MultiLineString_interiorIntersectsBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testMultiPolygon_MultiLineString_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles", testMultiPolygon_MultiLineString_interiorIntersectsInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testMultiPolygon_MultiLineString_interiorsIntersectAndBoundariesIntersect_withHoles", testMultiPolygon_MultiLineString_interiorsIntersectAndBoundariesIntersect_withHoles),
                ("testMultiPolygon_MultiLineString_boundaryIntersectsInteriorAndBoundary_withHoles", testMultiPolygon_MultiLineString_boundaryIntersectsInteriorAndBoundary_withHoles),
                ("testMultiPolygon_MultiLineString_boundaryIntersectsInteriorAndBoundaryAtAllFourBoundaryPoints_withHoles", testMultiPolygon_MultiLineString_boundaryIntersectsInteriorAndBoundaryAtAllFourBoundaryPoints_withHoles),
                ("testMultiPolygon_Polygon_noIntersection", testMultiPolygon_Polygon_noIntersection),
                ("testMultiPolygon_Polygon_withHoles_noIntersection_PolygonOutsideMultiPolygon", testMultiPolygon_Polygon_withHoles_noIntersection_PolygonOutsideMultiPolygon),
                ("testMultiPolygon_Polygon_withHoles_noIntersection_polygonInsideHole", testMultiPolygon_Polygon_withHoles_noIntersection_polygonInsideHole),
                ("testMultiPolygon_Polygon_withHoles_noIntersection_multiPolygonInsidePolygonHole", testMultiPolygon_Polygon_withHoles_noIntersection_multiPolygonInsidePolygonHole),
                ("testMultiPolygon_Polygon_interiorsIntersect_firstPolygon", testMultiPolygon_Polygon_interiorsIntersect_firstPolygon),
                ("testMultiPolygon_Polygon_interiorsIntersect_firstPolygon_withHole", testMultiPolygon_Polygon_interiorsIntersect_firstPolygon_withHole),
                ("testMultiPolygon_Polygon_interiorsIntersect_secondPolygon", testMultiPolygon_Polygon_interiorsIntersect_secondPolygon),
                ("testMultiPolygon_Polygon_interiorsIntersect_secondPolygon_withHole", testMultiPolygon_Polygon_interiorsIntersect_secondPolygon_withHole),
                ("testMultiPolygon_Polygon_interiorsIntersect_bothPolygons_withHoles", testMultiPolygon_Polygon_interiorsIntersect_bothPolygons_withHoles),
                ("testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles", testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_firstPolygon_withHoles),
                ("testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles", testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtOnePoint_doNotCross_secondPolygon_withHoles),
                ("testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles", testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundaryAtTwoPoints_doNotCross_bothPolygons_withHoles),
                ("testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles", testMultiPolygon_Polygon_polygonBoundaryIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testMultiPolygon_Polygon_polygonIntersectsMultiPolygonInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles", testMultiPolygon_Polygon_polygonIntersectsMultiPolygonInteriorAndBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testMultiPolygon_Polygon_polygonIntersectsMultiPolygonInteriorAndBoundary_withHoles", testMultiPolygon_Polygon_polygonIntersectsMultiPolygonInteriorAndBoundary_withHoles),
                ("testMultiPolygon_MultiPolygon_noIntersection", testMultiPolygon_MultiPolygon_noIntersection),
                ("testMultiPolygon_MultiPolygon_withHoles_noIntersection_MultiPolygonsOutsideEachOther", testMultiPolygon_MultiPolygon_withHoles_noIntersection_MultiPolygonsOutsideEachOther),
                ("testMultiPolygon_MultiPolygon_withHoles_noIntersection_polygonInsideHole", testMultiPolygon_MultiPolygon_withHoles_noIntersection_polygonInsideHole),
                ("testMultiPolygon_MultiPolygon_withHoles_noIntersection_multiPolygonInsideOnePolygonHole", testMultiPolygon_MultiPolygon_withHoles_noIntersection_multiPolygonInsideOnePolygonHole),
                ("testMultiPolygon_MultiPolygon_withHoles_noIntersection_multiPolygonInsideTwoPolygonHoles", testMultiPolygon_MultiPolygon_withHoles_noIntersection_multiPolygonInsideTwoPolygonHoles),
                ("testMultiPolygon_MultiPolygon_interiorsIntersect_firstPolygons", testMultiPolygon_MultiPolygon_interiorsIntersect_firstPolygons),
                ("testMultiPolygon_MultiPolygon_interiorsIntersect_firstPolygons_withHoles", testMultiPolygon_MultiPolygon_interiorsIntersect_firstPolygons_withHoles),
                ("testMultiPolygon_MultiPolygon_interiorsIntersect_secondPolygons", testMultiPolygon_MultiPolygon_interiorsIntersect_secondPolygons),
                ("testMultiPolygon_MultiPolygon_interiorsIntersect_secondPolygons_withHoles_boundariesOverlapOnLineSegment", testMultiPolygon_MultiPolygon_interiorsIntersect_secondPolygons_withHoles_boundariesOverlapOnLineSegment),
                ("testMultiPolygon_MultiPolygon_interiorsIntersect_bothPolygons_withHoles_boundariesShareSegment", testMultiPolygon_MultiPolygon_interiorsIntersect_bothPolygons_withHoles_boundariesShareSegment),
                ("testMultiPolygon_MultiPolygon_boundariesIntersectAtOnePoint_doNotCross_firstPolygon_withHoles", testMultiPolygon_MultiPolygon_boundariesIntersectAtOnePoint_doNotCross_firstPolygon_withHoles),
                ("testMultiPolygon_MultiPolygon_boundariesIntersectAtOnePoint_doNotCross_secondPolygon_withHoles", testMultiPolygon_MultiPolygon_boundariesIntersectAtOnePoint_doNotCross_secondPolygon_withHoles),
                ("testMultiPolygon_MultiPolygon_boundariesIntersectAtTwoPoints_doNotCross_bothPolygonsOfFirstMultiPolygonTouched_withHoles", testMultiPolygon_MultiPolygon_boundariesIntersectAtTwoPoints_doNotCross_bothPolygonsOfFirstMultiPolygonTouched_withHoles),
                ("testMultiPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles", testMultiPolygon_MultiPolygon_polygonBoundaryIntersectsMultiPolygonBoundary_bothPolygons_atPointAndLineSegment_withHoles),
                ("testMultiPolygon_MultiPolygon_boundariesIntersectAtInteriorAndBoundary_bothPolygonsOfFirstPolygon_atPointAndLineSegment_withHoles", testMultiPolygon_MultiPolygon_boundariesIntersectAtInteriorAndBoundary_bothPolygonsOfFirstPolygon_atPointAndLineSegment_withHoles),
                ("testMultiPolygon_MultiPolygon_boundariesIntersectAtInteriorAndBoundary_withHoles", testMultiPolygon_MultiPolygon_boundariesIntersectAtInteriorAndBoundary_withHoles)
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

extension LinearRingSurfaceCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (LinearRingSurfaceCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
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
                ("testInitWithArrayLiteral3DM", testInitWithArrayLiteral3DM),
                ("testInitWithDictionaryLiteral3DM", testInitWithDictionaryLiteral3DM),
                ("testInitCopy", testInitCopy),
                ("testX", testX),
                ("testY", testY),
                ("testZ", testZ),
                ("testM", testM),
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
                ("testBounds", testBounds),
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
                ("testBounds", testBounds),
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
                ("testBounds", testBounds),
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
                ("testBounds", testBounds),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension PointGeometryCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testBounds", testBounds),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension PointGeometryCoordinate2DMFixedCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate2DMFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testBounds", testBounds),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension PointGeometryCoordinate3DFixedCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate3DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testBounds", testBounds),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension PointGeometryCoordinate3DMFixedCartesianTests {
   static var allTests: [(String, (PointGeometryCoordinate3DMFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testIsEmpty", testIsEmpty),
                ("testBounds", testBounds),
                ("testEqualsWithIntOneTrue", testEqualsWithIntOneTrue),
                ("testEqualsWithIntOneFalse", testEqualsWithIntOneFalse),
                ("testEqualsWithPointNonPointFalse", testEqualsWithPointNonPointFalse),
                ("testBoundary", testBoundary)
           ]
   }
}

extension FloatingTests {
   static var allTests: [(String, (FloatingTests) -> () throws -> Void)] {
      return [
                ("testConvertEqual", testConvertEqual),
                ("testConvertNotEqual1", testConvertNotEqual1),
                ("testConvertNotEqual2", testConvertNotEqual2),
                ("testConvertOptionalEqual", testConvertOptionalEqual),
                ("testConvertOptionalNotEqual1", testConvertOptionalNotEqual1),
                ("testConvertOptionalNotEqual2", testConvertOptionalNotEqual2),
                ("testConvertOptionalNilEqual", testConvertOptionalNilEqual),
                ("testConvertOptionalNilNotEqual", testConvertOptionalNilNotEqual),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalseWithDifferentType", testEqualFalseWithDifferentType)
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
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiPointCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (MultiPointCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
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
                ("test", test),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testInitWithDictionaryLiteral", testInitWithDictionaryLiteral),
                ("testInitCopy", testInitCopy),
                ("testX", testX),
                ("testY", testY),
                ("testZ", testZ),
                ("testM", testM),
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
                ("testDimensionEmpty", testDimensionEmpty),
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

extension Coordinate2DMTests {
   static var allTests: [(String, (Coordinate2DMTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testInitWithDictionaryLiteral", testInitWithDictionaryLiteral),
                ("testX", testX),
                ("testY", testY),
                ("testZ", testZ),
                ("testM", testM),
                ("testInitCopy", testInitCopy),
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
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
                ("testEquals", testEquals),
                ("testIsEmpty", testIsEmpty),
                ("testIsEmptyFalse", testIsEmptyFalse),
                ("testCount", testCount)
           ]
   }
}

extension MultiLineStringCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (MultiLineStringCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInitWithNoArg", testInitWithNoArg),
                ("testInitWithNoArgAndDefaults", testInitWithNoArgAndDefaults),
                ("testInitWithPrecisionAndCRS", testInitWithPrecisionAndCRS),
                ("testInitWithPrecision", testInitWithPrecision),
                ("testInitWithCRS", testInitWithCRS),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testInitCopy", testInitCopy),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testReplaceSubrangeAppend", testReplaceSubrangeAppend),
                ("testReplaceSubrangeInsert", testReplaceSubrangeInsert),
                ("testReplaceSubrangeReplace", testReplaceSubrangeReplace),
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
                ("testDimensionEmpty", testDimensionEmpty),
                ("testBoundaryWith1ElementInvalid", testBoundaryWith1ElementInvalid),
                ("testBoundaryWith2Element", testBoundaryWith2Element),
                ("testBoundaryWith3ElementOpen", testBoundaryWith3ElementOpen),
                ("testBoundaryWith4ElementClosed", testBoundaryWith4ElementClosed),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testBoundsEmpty", testBoundsEmpty),
                ("testBoundsWithElements", testBoundsWithElements),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension MultiLineStringGeometryCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (MultiLineStringGeometryCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionEmpty", testDimensionEmpty),
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
                ("testBoundsEmpty", testBoundsEmpty),
                ("testBoundsWithElements", testBoundsWithElements),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension LineStringGeometryCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (LineStringGeometryCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testDimension", testDimension),
                ("testDimensionEmpty", testDimensionEmpty),
                ("testBoundaryWith1ElementInvalid", testBoundaryWith1ElementInvalid),
                ("testBoundaryWith2Element", testBoundaryWith2Element),
                ("testBoundaryWith3ElementOpen", testBoundaryWith3ElementOpen),
                ("testBoundaryWith4ElementClosed", testBoundaryWith4ElementClosed),
                ("testBoundaryEmpty", testBoundaryEmpty),
                ("testBoundsEmpty", testBoundsEmpty),
                ("testBoundsWithElements", testBoundsWithElements),
                ("testEqualTrue", testEqualTrue),
                ("testEqualFalse", testEqualFalse)
           ]
   }
}

extension PointCoordinate2DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate2DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testInitWithDictionaryLiteral", testInitWithDictionaryLiteral),
                ("testInitWithDictionaryLiteralIncorrectElements", testInitWithDictionaryLiteralIncorrectElements),
                ("testStartIndex", testStartIndex),
                ("testEndIndex", testEndIndex),
                ("testIndexAfter", testIndexAfter),
                ("testSubscriptGet", testSubscriptGet),
                ("testSubscriptSet", testSubscriptSet),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
           ]
   }
}

extension PointCoordinate2DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate2DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testInitWithArrayLiteral", testInitWithArrayLiteral),
                ("testInitWithDictionaryLiteral", testInitWithDictionaryLiteral),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
           ]
   }
}

extension PointCoordinate3DFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate3DFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testInitWithArrayLiteral3D", testInitWithArrayLiteral3D),
                ("testInitWithDictionaryLiteral3D", testInitWithDictionaryLiteral3D),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
           ]
   }
}

extension PointCoordinate3DMFloatingPrecisionCartesianTests {
   static var allTests: [(String, (PointCoordinate3DMFloatingPrecisionCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit),
                ("testInitWithArrayLiteral3DM", testInitWithArrayLiteral3DM),
                ("testInitWithDictionaryLiteral3DM", testInitWithDictionaryLiteral3DM),
                ("testDescription", testDescription),
                ("testDebugDescription", testDebugDescription)
           ]
   }
}

extension PointCoordinate2DFixedCartesianTests {
   static var allTests: [(String, (PointCoordinate2DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit)
           ]
   }
}

extension PointCoordinate2DMFixedCartesianTests {
   static var allTests: [(String, (PointCoordinate2DMFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit)
           ]
   }
}

extension PointCoordinate3DFixedCartesianTests {
   static var allTests: [(String, (PointCoordinate3DFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit)
           ]
   }
}

extension PointCoordinate3DMFixedCartesianTests {
   static var allTests: [(String, (PointCoordinate3DMFixedCartesianTests) -> () throws -> Void)] {
      return [
                ("testInit", testInit)
           ]
   }
}

#endif
