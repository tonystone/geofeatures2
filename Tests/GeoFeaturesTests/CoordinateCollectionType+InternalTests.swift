///
///  CoordinateCollectionType+InternalTests.swift
///
///  Copyright (c) 2018 Tony Stone
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
///  Created by Tony Stone on 12/18/2018.
///
import XCTest
@testable import GeoFeatures

class CoordinateCollectionTypeInternalTests: XCTestCase {

    func testSlopeWithCoordinates_notVertical() {
        let lineString = LineString([[100, 100], [100, 100]])
        let (theSlope, isVertical) = lineString.slope([0.0, 0.0], [1.0, 1.0])
        XCTAssertEqual(theSlope, 1.0, "The slope was expected to be 1.0 but a value of \(theSlope) was found.")
        XCTAssertEqual(isVertical, false, "The slope was expected to be not vertical, but it is vertical.")
    }

    func testSlopeWithCoordinates_vertical() {
        let lineString = LineString([[100, 100], [100, 100]])
        let (theSlope, isVertical) = lineString.slope([1.0, 0.0], [1.0, 1.0])
        XCTAssertEqual(theSlope, 0.0, "The slope was expected to be 0.0 but a value of \(theSlope) was found.")
        XCTAssertEqual(isVertical, true, "The slope was expected to be vertical, but it was not.")
    }

    func testSlopeWithSegment_notVertical() {
        let lineString = LineString([[100, 100], [100, 100]])
        let (theSlope, isVertical) = lineString.slope(Segment(left: [0.0, 0.0], right: [1.0, 1.0]))
        XCTAssertEqual(theSlope, 1.0, "The slope was expected to be 1.0 but a value of \(theSlope) was found.")
        XCTAssertEqual(isVertical, false, "The slope was expected to be not vertical, but it is vertical.")
    }

    func testSlopeWithSegment_vertical() {
        let lineString = LineString([[100, 100], [100, 100]])
        let (theSlope, isVertical) = lineString.slope(Segment(left: [1.0, 0.0], right: [1.0, 1.0]))
        XCTAssertEqual(theSlope, 0.0, "The slope was expected to be 0.0 but a value of \(theSlope) was found.")
        XCTAssertEqual(isVertical, true, "The slope was expected to be vertical, but it was not.")
    }

    func testIntersection_noIntersection() {
        let lineString = LineString([[100, 100], [100, 100]])
        let segment1 = Segment(left: [0.0, 0.0], right: [50.0, 50.0])
        let segment2 = Segment(left: [100.0, 100.0], right: [200.0, 200.0])
        let lineSegmentIntersection = lineString.intersection(segment: segment1, other: segment2, firstCoordinateFirstSegmentBoundary: true, firstCoordinateSecondSegmentBoundary: true)
        XCTAssertEqual(lineSegmentIntersection.segmentsIntersect, false, "Expected no intersection, but the segments did intersect.")
    }

    func testIntersection_interiorsTouchAtPoint() {
        let lineString = LineString([[100, 100], [100, 100]])
        let segment1 = Segment(left: [0.0, 0.0], right: [5.0, 5.0])
        let segment2 = Segment(left: [0.0, 5.0], right: [5.0, 0.0])
        let lineSegmentIntersection = lineString.intersection(segment: segment1, other: segment2)
        XCTAssertEqual(lineSegmentIntersection.interiorsTouchAtPoint, true, "Expected the line segments to touch at a point, but they don't.")
    }

    func testIntersection_firstSubsetOfSecond() {
        let lineString = LineString([[100, 100], [100, 100]])
        let segment1 = Segment(left: [10.0, 10.0], right: [20.0, 20.0])
        let segment2 = Segment(left: [0.0, 0.0], right: [50.0, 50.0])
        let lineSegmentIntersection = lineString.intersection(segment: segment1, other: segment2)
        XCTAssertEqual(lineSegmentIntersection.firstSubsetOfSecond, true, "Expected the first line segment to be a subset of the second segment, but it's not.")
        XCTAssertEqual(lineSegmentIntersection.secondSubsetOfFirst, false, "Expected the second line segment to not be a subset of the first segment, but it is.")
    }

    func testIntersection_secondSubsetOfFirst() {
        let lineString = LineString([[100, 100], [100, 100]])
        let segment1 = Segment(left: [0.0, 0.0], right: [50.0, 50.0])
        let segment2 = Segment(left: [10.0, 10.0], right: [20.0, 20.0])
        let lineSegmentIntersection = lineString.intersection(segment: segment1, other: segment2)
        XCTAssertEqual(lineSegmentIntersection.secondSubsetOfFirst, true, "Expected the second line segment to be a subset of the first segment, but it's not.")
        XCTAssertEqual(lineSegmentIntersection.firstSubsetOfSecond, false, "Expected the first line segment to not be a subset of the second segment, but it is.")
    }

    func testIntersection_lineSegmentsOverlap() {
        let lineString = LineString([[100, 100], [100, 100]])
        let segment1 = Segment(left: [0.0, 0.0], right: [50.0, 50.0])
        let segment2 = Segment(left: [10.0, 10.0], right: [200.0, 200.0])
        let lineSegmentIntersection = lineString.intersection(segment: segment1, other: segment2, firstCoordinateFirstSegmentBoundary: true, firstCoordinateSecondSegmentBoundary: true)
        XCTAssertEqual(lineSegmentIntersection.segmentsIntersect, true, "Expected the second line segment to intersect the first segment, but it did not.")
    }

    func testIntersection_firstBoundariesTouch() {
        let lineString = LineString([[100, 100], [100, 100]])
        let segment1 = Segment(left: [0.0, 0.0], right: [50.0, 50.0])
        let segment2 = Segment(left: [0.0, 0.0], right: [0.0, 20.0])
        let lineSegmentIntersection = lineString.intersection(segment: segment1, other: segment2, secondCoordinateFirstSegmentBoundary: true, firstCoordinateSecondSegmentBoundary: true)
        XCTAssertEqual(lineSegmentIntersection.firstSegmentFirstBoundaryLocation, .onBoundary, "Expected the first segment boundary to intersect the second segment boundary, but it did not.")
        XCTAssertEqual(lineSegmentIntersection.secondSegmentFirstBoundaryLocation, .onBoundary, "Expected the second segment boundary to intersect the first segment boundary, but it did not.")
    }

    func testIntersection_firstSecondBoundariesTouch() {
        let lineString = LineString([[100, 100], [100, 100]])
        let segment1 = Segment(left: [0.0, 0.0], right: [50.0, 50.0])
        let segment2 = Segment(left: [0.0, 50.0], right: [0.0, 0.0])
        let lineSegmentIntersection = lineString.intersection(segment: segment1, other: segment2, firstCoordinateFirstSegmentBoundary: true, secondCoordinateSecondSegmentBoundary: true)
        XCTAssertEqual(lineSegmentIntersection.firstSegmentFirstBoundaryLocation, .onBoundary, "Expected the first segment boundary to intersect the second segment boundary, but it did not.")
        XCTAssertEqual(lineSegmentIntersection.secondSegmentSecondBoundaryLocation, .onBoundary, "Expected the second segment boundary to intersect the first segment boundary, but it did not.")
    }

    func testIntersection_secondFirstBoundariesTouch() {
        let lineString = LineString([[100, 100], [100, 100]])
        let segment1 = Segment(left: [0.0, 40.0], right: [0.0, 50.0])
        let segment2 = Segment(left: [0.0, 50.0], right: [30.0, 50.0])
        let lineSegmentIntersection = lineString.intersection(segment: segment1, other: segment2, secondCoordinateFirstSegmentBoundary: true, firstCoordinateSecondSegmentBoundary: true)
        XCTAssertEqual(lineSegmentIntersection.firstSegmentSecondBoundaryLocation, .onBoundary, "Expected the first segment boundary to intersect the second segment boundary, but it did not.")
        XCTAssertEqual(lineSegmentIntersection.secondSegmentFirstBoundaryLocation, .onBoundary, "Expected the second segment boundary to intersect the first segment boundary, but it did not.")
    }

    func testIntersection_secondBoundariesTouch() {
        let lineString = LineString([[100, 100], [100, 100]])
        let segment1 = Segment(left: [0.0, 80.0], right: [40.0, 40.0])
        let segment2 = Segment(left: [0.0, 0.0], right: [40.0, 40.0])
        let lineSegmentIntersection = lineString.intersection(segment: segment1, other: segment2, secondCoordinateFirstSegmentBoundary: true, firstCoordinateSecondSegmentBoundary: true)
        XCTAssertEqual(lineSegmentIntersection.firstSegmentSecondBoundaryLocation, .onBoundary, "Expected the first segment boundary to intersect the second segment boundary, but it did not.")
        XCTAssertEqual(lineSegmentIntersection.secondSegmentSecondBoundaryLocation, .onBoundary, "Expected the second segment boundary to intersect the first segment boundary, but it did not.")
    }

    func testLineStringSimplify_multipleIntermediatePoints_threeDifferentSlopes() {
        let lineString = LineString([[100, 100], [100, 100], [200, 200], [300, 300], [300, 300], [400, 300], [500, 300], [600, 300], [600, 300], [600, 400], [600, 600], [600, 800]])
        let lineStringResult = lineString.simplify(tolerance: 1.0)

        XCTAssert(lineStringResult.count == 4)
    }

    func testLineStringSimplify_square() {
        let lineString = LineString([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]])
        let lineStringResult = lineString.simplify(tolerance: 1.0)
        
        XCTAssert(lineStringResult.count == 5)
    }

    func testLinearRingSimplify_sixPointsThreeUnique_sameSlope() {
        let linearRing = LinearRing([[100, 100], [100, 100], [150, 150], [200, 200], [200, 200], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)
        
        XCTAssert(linearRingResult.count == 3)
    }

    func testLinearRingSimplify_sixPointsThreeUnique_threeDifferentSlopes() {
        let linearRing = LinearRing([[100, 100], [100, 100], [150, 150], [200, 150], [200, 150], [100, 100]])
        let linearRingResult = linearRing.simplify(tolerance: 1.0)
        
        XCTAssert(linearRingResult.count == 4)
    }
}
