///
///  GeoFeatures+PathRepresentableTests.sqift
///
/// Copyright (c) Tony Stone, All rights reserved.
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
/// Created by Tony Stone on 3/16/18.
///
import XCTest
import GeoFeatures

@testable import GeoFeaturesQuartz

// MARK: - Point

class PointPathRepresentableTests: XCTestCase {

    func testPath() {
        let input = Point([3.0, 3.0])

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 3, y: 3))
            path.closeSubpath()
            return path
        }()

        XCTAssertEqual(input.path(), expected)
    }

    func testPathWithTansform() {
        let input = (Point([3.0, 3.0]), transform: CGAffineTransform.identity.translatedBy(x: 2.0, y: 2.0))

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 5, y: 5))
            path.closeSubpath()
            return path
        }()

        XCTAssertEqual(input.0.path(transform: input.transform), expected)
    }
}

// MARK: - LineString

class LineStringPathRepresentableTests: XCTestCase {

    func testPathWithOpenLineString() {
        let input = LineString([[100, 100], [100, 200], [200, 200]])

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 100, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 200))
            path.addLine(to: CGPoint(x: 200, y: 200))
            return path
        }()

        XCTAssertEqual(input.path(), expected)
    }

    func testPathWithClosedLineString() {
        let input = LineString([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]])

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 100, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 200))
            path.addLine(to: CGPoint(x: 200, y: 200))
            path.addLine(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 100))
            path.closeSubpath()
            return path
        }()

        XCTAssertEqual(input.path(), expected)
    }

    func testPathWithOpenLineStringPathAndTansform() {
        let input = (LineString([[100, 100], [100, 200], [200, 200]]), transform: CGAffineTransform.identity.translatedBy(x: 2.0, y: 2.0))

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 102, y: 102))
            path.addLine(to: CGPoint(x: 102, y: 202))
            path.addLine(to: CGPoint(x: 202, y: 202))
            return path
        }()

        XCTAssertEqual(input.0.path(transform: input.transform), expected)
    }

    func testPathWithClosedLineStringPathAndTansform() {
        let input = (LineString([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]]), transform: CGAffineTransform.identity.translatedBy(x: 2.0, y: 2.0))

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 102, y: 102))
            path.addLine(to: CGPoint(x: 102, y: 202))
            path.addLine(to: CGPoint(x: 202, y: 202))
            path.addLine(to: CGPoint(x: 202, y: 102))
            path.addLine(to: CGPoint(x: 102, y: 102))
            path.closeSubpath()
            return path
        }()

        XCTAssertEqual(input.0.path(transform: input.transform), expected)
    }
}

// MARK: - LinearRing

class LinearRingPathRepresentableTests: XCTestCase {

    func testPathWithOpenLinearRing() {
        let input = LinearRing([[100, 100], [100, 200], [200, 200]])

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 100, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 200))
            path.addLine(to: CGPoint(x: 200, y: 200))
            return path
        }()

        XCTAssertEqual(input.path(), expected)
    }

    func testPathWithClosedLinearRing() {
        let input = LinearRing([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]])

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 100, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 200))
            path.addLine(to: CGPoint(x: 200, y: 200))
            path.addLine(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 100))
            path.closeSubpath()
            return path
        }()

        XCTAssertEqual(input.path(), expected)
    }

    func testPathWithOpenLinearRingPathAndTansform() {
        let input = (LinearRing([[100, 100], [100, 200], [200, 200]]), transform: CGAffineTransform.identity.translatedBy(x: 2.0, y: 2.0))

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 102, y: 102))
            path.addLine(to: CGPoint(x: 102, y: 202))
            path.addLine(to: CGPoint(x: 202, y: 202))
            return path
        }()

        XCTAssertEqual(input.0.path(transform: input.transform), expected)
    }

    func testPathWithClosedLinearRingPathAndTansform() {
        let input = (LinearRing([[100, 100], [100, 200], [200, 200], [200, 100], [100, 100]]), transform: CGAffineTransform.identity.translatedBy(x: 2.0, y: 2.0))

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 102, y: 102))
            path.addLine(to: CGPoint(x: 102, y: 202))
            path.addLine(to: CGPoint(x: 202, y: 202))
            path.addLine(to: CGPoint(x: 202, y: 102))
            path.addLine(to: CGPoint(x: 102, y: 102))
            path.closeSubpath()
            return path
        }()

        XCTAssertEqual(input.0.path(transform: input.transform), expected)
    }
}

// MARK: - Polygon

class PolygonPathRepresentableTests: XCTestCase {

    func testPath() {
        let input = Polygon([[[0, 0], [60, 144], [120, 0], [0, 0]], [[40, 25], [80, 25], [60, 80], [40, 25]]])

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 60, y: 144))
            path.addLine(to: CGPoint(x: 120, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.closeSubpath()
            path.move(to: CGPoint(x: 40, y: 25))
            path.addLine(to: CGPoint(x: 80, y: 25))
            path.addLine(to: CGPoint(x: 60, y: 80))
            path.addLine(to: CGPoint(x: 40, y: 25))
            path.closeSubpath()
            return path
        }()

        XCTAssertEqual(input.path(), expected)
    }


    func testPathWithTansform() {
        let input = (Polygon([[[0, 0], [60, 144], [120, 0], [0, 0]], [[40, 25], [80, 25], [60, 80], [40, 25]]]), transform: CGAffineTransform.identity.translatedBy(x: 2.0, y: 2.0))

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 2, y: 2))
            path.addLine(to: CGPoint(x: 62, y: 146))
            path.addLine(to: CGPoint(x: 122, y: 2))
            path.addLine(to: CGPoint(x: 2, y: 2))
            path.closeSubpath()
            path.move(to: CGPoint(x: 42, y: 27))
            path.addLine(to: CGPoint(x: 82, y: 27))
            path.addLine(to: CGPoint(x: 62, y: 82))
            path.addLine(to: CGPoint(x: 42, y: 27))
            path.closeSubpath()
            return path
        }()

        XCTAssertEqual(input.0.path(transform: input.transform), expected)
    }
}

// MARK: - MultiPoint

class MultiPointPathRepresentableTests: XCTestCase {

    func testPath() {
        let input = MultiPoint([[2.0, 2.0], [3.0, 3.0]])

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 2, y: 2))
            path.closeSubpath()
            path.move(to: CGPoint(x: 3, y: 3))
            path.closeSubpath()
            return path
        }()

        XCTAssertEqual(input.path(), expected)
    }

    func testPathWithTansform() {
        let input = (MultiPoint([[2.0, 2.0], [3.0, 3.0]]), transform: CGAffineTransform.identity.translatedBy(x: 2.0, y: 2.0))

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 4, y: 4))
            path.closeSubpath()
            path.move(to: CGPoint(x: 5, y: 5))
            path.closeSubpath()
            return path
        }()

        XCTAssertEqual(input.0.path(transform: input.transform), expected)
    }
}

// MARK: - MultiLineString

class MultiLineStringPathRepresentableTests: XCTestCase {

    func testPath() {
        let input = MultiLineString([[[100.00, 200.00], [150.00, 100.00], [125.00, 100.00]], [[200.00, 200.00], [250.00, 100.00], [225.00, 100.00]]])

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 100, y: 200))
            path.addLine(to: CGPoint(x: 150, y: 100))
            path.addLine(to: CGPoint(x: 125, y: 100))
            path.move(to: CGPoint(x: 200, y: 200))
            path.addLine(to: CGPoint(x: 250, y: 100))
            path.addLine(to: CGPoint(x: 225, y: 100))
            return path
        }()

        XCTAssertEqual(input.path(), expected)
    }

    func testPathWithTansform() {
        let input = (MultiLineString([[[100.00, 200.00],  [150.00, 100.00], [125.00, 100.00]], [[200.00, 200.00], [250.00, 100.00], [225.00, 100.00]]]), transform: CGAffineTransform.identity.translatedBy(x: 2.0, y: 2.0))

        let expected = { () -> CGPath in
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 102, y: 202))
            path.addLine(to: CGPoint(x: 152, y: 102))
            path.addLine(to: CGPoint(x: 127, y: 102))
            path.move(to: CGPoint(x: 202, y: 202))
            path.addLine(to: CGPoint(x: 252, y: 102))
            path.addLine(to: CGPoint(x: 227, y: 102))
            return path
        }()

        XCTAssertEqual(input.0.path(transform: input.transform), expected)
    }
}

// MARK: - MultiPolygon

class MultiPolygonPathRepresentableTests: XCTestCase {

    func testPath() {
        let input = MultiPolygon([Polygon([[[0, 0], [60, 144], [120, 0], [0, 0]], [[40, 25], [80, 25], [60, 80], [40, 25]]]), Polygon([[[130, 0], [190, 144], [260, 0], [130, 0]], [[170, 25], [210, 25], [190, 80], [170, 25]]])])

        let expected = { () -> CGPath in
            let path = CGMutablePath()

            /// Poly 1
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 60, y: 144))
            path.addLine(to: CGPoint(x: 120, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.closeSubpath()
            path.move(to: CGPoint(x: 40, y: 25))
            path.addLine(to: CGPoint(x: 80, y: 25))
            path.addLine(to: CGPoint(x: 60, y: 80))
            path.addLine(to: CGPoint(x: 40, y: 25))
            path.closeSubpath()

            /// Poly 2
            path.move(to: CGPoint(x: 130, y: 0))
            path.addLine(to: CGPoint(x: 190, y: 144))
            path.addLine(to: CGPoint(x: 260, y: 0))
            path.addLine(to: CGPoint(x: 130, y: 0))
            path.closeSubpath()
            path.move(to: CGPoint(x: 170, y: 25))
            path.addLine(to: CGPoint(x: 210, y: 25))
            path.addLine(to: CGPoint(x: 190, y: 80))
            path.addLine(to: CGPoint(x: 170, y: 25))
            path.closeSubpath()

            return path
        }()

        XCTAssertEqual(input.path(), expected)
    }

    func testPathWithTansform() {
        let input = (MultiPolygon([Polygon([[[0, 0], [60, 144], [120, 0], [0, 0]], [[40, 25], [80, 25], [60, 80], [40, 25]]]), Polygon([[[130, 0], [190, 144], [260, 0], [130, 0]], [[170, 25], [210, 25], [190, 80], [170, 25]]])]), transform: CGAffineTransform.identity.translatedBy(x: 2.0, y: 2.0))

        let expected = { () -> CGPath in
            let path = CGMutablePath()

            /// Poly 1
            path.move(to: CGPoint(x: 2, y: 2))
            path.addLine(to: CGPoint(x: 62, y: 146))
            path.addLine(to: CGPoint(x: 122, y: 2))
            path.addLine(to: CGPoint(x: 2, y: 2))
            path.closeSubpath()
            path.move(to: CGPoint(x: 42, y: 27))
            path.addLine(to: CGPoint(x: 82, y: 27))
            path.addLine(to: CGPoint(x: 62, y: 82))
            path.addLine(to: CGPoint(x: 42, y: 27))
            path.closeSubpath()

            /// Poly 2
            path.move(to: CGPoint(x: 132, y: 2))
            path.addLine(to: CGPoint(x: 192, y: 146))
            path.addLine(to: CGPoint(x: 262, y: 2))
            path.addLine(to: CGPoint(x: 132, y: 2))
            path.closeSubpath()
            path.move(to: CGPoint(x: 172, y: 27))
            path.addLine(to: CGPoint(x: 212, y: 27))
            path.addLine(to: CGPoint(x: 192, y: 82))
            path.addLine(to: CGPoint(x: 172, y: 27))
            path.closeSubpath()

            return path
        }()

        XCTAssertEqual(input.0.path(transform: input.transform), expected)
    }
}

// MARK: - GeometryCollection

class GeometryCollectionPathRepresentableTests: XCTestCase {

    func testPath() {
        let input = GeometryCollection([LineString([[3, 3], [60, 60], [120, 3]]), MultiPoint([[3, 3], [60, 60], [120, 3]])])

        let expected = { () -> CGPath in
            let path = CGMutablePath()

            /// LineString 1
            path.move(to: CGPoint(x: 3, y: 3))
            path.addLine(to: CGPoint(x: 60, y: 60))
            path.addLine(to: CGPoint(x: 120, y: 3))

            /// MultiPoint
            path.move(to: CGPoint(x: 3, y: 3))
            path.closeSubpath()
            path.move(to: CGPoint(x: 60, y: 60))
            path.closeSubpath()
            path.move(to: CGPoint(x: 120, y: 3))
            path.closeSubpath()

            return path
        }()

        XCTAssertEqual(input.path(), expected)
    }

    func testPathWithTansform() {
        let input = (GeometryCollection([LineString([[3, 3], [60, 60], [120, 3]]), MultiPoint([[3, 3], [60, 60], [120, 3]])]), transform: CGAffineTransform.identity.translatedBy(x: 2.0, y: 2.0))

        let expected = { () -> CGPath in
            let path = CGMutablePath()

            /// LineString 1
            path.move(to: CGPoint(x: 5, y: 5))
            path.addLine(to: CGPoint(x: 62, y: 62))
            path.addLine(to: CGPoint(x: 122, y: 5))

            /// MultiPoint
            path.move(to: CGPoint(x: 5, y: 5))
            path.closeSubpath()
            path.move(to: CGPoint(x: 62, y: 62))
            path.closeSubpath()
            path.move(to: CGPoint(x: 122, y: 5))
            path.closeSubpath()

            return path
        }()

        XCTAssertEqual(input.0.path(transform: input.transform), expected)
    }
}
