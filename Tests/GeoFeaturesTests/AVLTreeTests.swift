///
///  AVLTreeTests.swift
///
///  Copyright (c) 2016 Tony Stone
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
///  Created by Tony Stone on 11/26/2016.
///
import XCTest
@testable import GeoFeatures

class AVLTreeTests: XCTestCase {

    let tree: AVLTree<Int> = [1, 5, 8, 7, 10, 15, 20, 17, 25]

    func testHeight() {
        let input = tree
        let expected = 2

        XCTAssertEqual(input.height, expected)
    }

    func testBalanced9NodeTree() {
        let input = tree
        let expected = true

        XCTAssertEqual(input.balanced, expected)
    }

    func testBalanced1NodeTree() {
        let input: AVLTree<Int> = [1]
        let expected = true

        XCTAssertEqual(input.balanced, expected)
    }

    func testBalanced2NodeTree() {
        let input: AVLTree<Int> = [1, 5]
        let expected = true

        XCTAssertEqual(input.balanced, expected)
    }

    func testBalanced3NodeRightHeavyTree() {
        let input: AVLTree<Int> = [1, 5, 8]
        let expected = true

        XCTAssertEqual(input.balanced, expected)
    }

    func testHeight3NodeRightHeavyTree() {
        let input: AVLTree<Int> = [1, 5, 8]
        let expected = 2

        XCTAssertEqual(input.height, expected)
    }

    func testBalanced3NodeLeftHeavyTree() {
        let input: AVLTree<Int> = [8, 5, 1]
        let expected = true

        XCTAssertEqual(input.balanced, expected)
    }

    func testHeight3NodeLeftHeavyTree() {
        let input: AVLTree<Int> = [8, 5, 1]
        let expected = 2

        XCTAssertEqual(input.height, expected)
    }

    func testBalanced3NodeLeftRightHeavyTree() {
        let input: AVLTree<Int> = [8, 1, 5]
        let expected = true

        XCTAssertEqual(input.balanced, expected)
    }

    func testHeight3NodeLeftRightHeavyTree() {
        let input: AVLTree<Int> = [8, 1, 5]
        let expected = 2

        XCTAssertEqual(input.height, expected)
    }

    func testBalanced3NodeOrderedTree() {
        let input: AVLTree<Int> = [5, 1, 8]
        let expected = true

        XCTAssertEqual(input.balanced, expected)
    }

    func testInsertNonExisting30() {
        let input = 30
        let expected = 30

        tree.insert(value: input)

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }

    func testInsertExisting8() {
        let input = 8
        let expected = 8

        tree.insert(value: input)

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }

    func testRemoveNonExisting30() {
        let input = 30
        let expected: Int? = nil

        tree.remove(value: input)

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }

    func testRemoveExisting8() {
        let input = 8
        let expected: Int? = nil

        tree.remove(value: input)

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }

    func testFindExisting1() {
        let input = 1
        let expected = 1

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }

    func testFindExisting8() {
        let input = 8
        let expected = 8

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }

    func testFindExisting25() {
        let input = 25
        let expected = 25

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }

    func testFindNonExisting0() {
        let input = 0
        let expected: Int? = nil

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }

    func testFindNonExisting30() {
        let input = 30
        let expected: Int? = nil

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }

    func testNextOf1() {
        let input = tree.find(value: 1)
        let expected = 5

        if let input = input {
            XCTAssertEqual(tree.next(node: input)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(tree).")
        }
    }

    func testNextOf8() {
        let input = tree.find(value: 8)
        let expected = 10

        if let input = input {
            XCTAssertEqual(tree.next(node: input)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(tree).")
        }
    }

    func testNextOf15() {
        let input = tree.find(value: 15)
        let expected = 17

        if let input = input {
            XCTAssertEqual(tree.next(node: input)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(tree).")
        }
    }

    func testPreviousOf1() {
        let input = tree.find(value: 1)
        let expected: Int? = nil

        if let input = input {
            XCTAssertEqual(tree.next(node: input)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(tree).")
        }
    }

    func testPreviousOf8() {
        let input = tree.find(value: 8)
        let expected = 7

        if let input = input {
            XCTAssertEqual(tree.next(node: input)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(tree).")
        }
    }

    func testPreviousOf15() {
        let input = tree.find(value: 15)
        let expected = 10

        if let input = input {
            XCTAssertEqual(tree.next(node: input)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(tree).")
        }
    }
}
