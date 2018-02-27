///
/// LinuxMain.swift
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

#if os(Linux) || os(FreeBSD)
   @testable import GeoFeaturesTests

   XCTMain([
         testCase(MultiPolygonSurfaceCoordinate2DFixedPrecisionCartesianTests.allTests),
         testCase(PolygonCoordinate2DFloatingPrecisionCartesianTests.allTests),
         testCase(PolygonCoordinate2DFixedPrecisionCartesianTests.allTests),
         testCase(WKTWriterCoordinate2DTests.allTests),
         testCase(WKTWriterCoordinate2DMTests.allTests),
         testCase(WKTWriterCoordinate3DTests.allTests),
         testCase(WKTWriterCoordinate3DMTests.allTests),
         testCase(GeographicTests.allTests),
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
         testCase(CartesianTests.allTests),
         testCase(FloatingPrecisionTests.allTests),
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
#endif
