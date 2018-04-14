
/// build-tools: auto-generated

#if os(Linux) || os(FreeBSD)

import XCTest

@testable import GeoFeaturesTests
@testable import GeoFeaturesQuartzTests
@testable import GeoFeaturesPlaygroundSupportTests

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
   testCase(PointCoordinate3DMFixedCartesianTests.allTests),
   testCase(CGContextGeoFeaturesTests.allTests),
   testCase(PointPathRepresentableTests.allTests),
   testCase(LineStringPathRepresentableTests.allTests),
   testCase(LinearRingPathRepresentableTests.allTests),
   testCase(PolygonPathRepresentableTests.allTests),
   testCase(MultiPointPathRepresentableTests.allTests),
   testCase(MultiLineStringPathRepresentableTests.allTests),
   testCase(MultiPolygonPathRepresentableTests.allTests),
   testCase(GeometryCollectionPathRepresentableTests.allTests)
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

extension CGContextGeoFeaturesTests {
   static var allTests: [(String, (CGContextGeoFeaturesTests) -> () throws -> Void)] {
      return [
                ("testAddPoint", testAddPoint),
                ("testDrawPoint", testDrawPoint),
                ("testAddLineString", testAddLineString),
                ("testDrawLineString", testDrawLineString),
                ("testAddLinearRing", testAddLinearRing),
                ("testDrawLinearRing", testDrawLinearRing),
                ("testAddPolygon", testAddPolygon),
                ("testDrawPolygon", testDrawPolygon),
                ("testAddMultiPoint", testAddMultiPoint),
                ("testDrawMultiPoint", testDrawMultiPoint),
                ("testAddMultiLineString", testAddMultiLineString),
                ("testDrawMultiLineString", testDrawMultiLineString),
                ("testAddMultiPolygon", testAddMultiPolygon),
                ("testDrawMultiPolygon", testDrawMultiPolygon),
                ("testAddGeometryCollection", testAddGeometryCollection),
                ("testDrawGeometryCollection", testDrawGeometryCollection)
           ]
   }
}

extension PointPathRepresentableTests {
   static var allTests: [(String, (PointPathRepresentableTests) -> () throws -> Void)] {
      return [
                ("testPath", testPath),
                ("testPathWithTansform", testPathWithTansform)
           ]
   }
}

extension LineStringPathRepresentableTests {
   static var allTests: [(String, (LineStringPathRepresentableTests) -> () throws -> Void)] {
      return [
                ("testPathWithOpenLineString", testPathWithOpenLineString),
                ("testPathWithClosedLineString", testPathWithClosedLineString),
                ("testPathWithOpenLineStringPathAndTansform", testPathWithOpenLineStringPathAndTansform),
                ("testPathWithClosedLineStringPathAndTansform", testPathWithClosedLineStringPathAndTansform)
           ]
   }
}

extension LinearRingPathRepresentableTests {
   static var allTests: [(String, (LinearRingPathRepresentableTests) -> () throws -> Void)] {
      return [
                ("testPathWithOpenLinearRing", testPathWithOpenLinearRing),
                ("testPathWithClosedLinearRing", testPathWithClosedLinearRing),
                ("testPathWithOpenLinearRingPathAndTansform", testPathWithOpenLinearRingPathAndTansform),
                ("testPathWithClosedLinearRingPathAndTansform", testPathWithClosedLinearRingPathAndTansform)
           ]
   }
}

extension PolygonPathRepresentableTests {
   static var allTests: [(String, (PolygonPathRepresentableTests) -> () throws -> Void)] {
      return [
                ("testPath", testPath),
                ("testPathWithTansform", testPathWithTansform)
           ]
   }
}

extension MultiPointPathRepresentableTests {
   static var allTests: [(String, (MultiPointPathRepresentableTests) -> () throws -> Void)] {
      return [
                ("testPath", testPath),
                ("testPathWithTansform", testPathWithTansform)
           ]
   }
}

extension MultiLineStringPathRepresentableTests {
   static var allTests: [(String, (MultiLineStringPathRepresentableTests) -> () throws -> Void)] {
      return [
                ("testPath", testPath),
                ("testPathWithTansform", testPathWithTansform)
           ]
   }
}

extension MultiPolygonPathRepresentableTests {
   static var allTests: [(String, (MultiPolygonPathRepresentableTests) -> () throws -> Void)] {
      return [
                ("testPath", testPath),
                ("testPathWithTansform", testPathWithTansform)
           ]
   }
}

extension GeometryCollectionPathRepresentableTests {
   static var allTests: [(String, (GeometryCollectionPathRepresentableTests) -> () throws -> Void)] {
      return [
                ("testPath", testPath),
                ("testPathWithTansform", testPathWithTansform)
           ]
   }
}

#endif
