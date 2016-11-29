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

    func testLeftRotation() {
        let input: AVLTree<String> = ["A", "B", "C"]
        let expected = true

        XCTAssertEqual(input.balanced && input.height == 2, expected)
    }

    func testRightRotation() {
        let input: AVLTree<String> = ["C", "B", "A"]
        let expected = true

        XCTAssertEqual(input.balanced && input.height == 2, expected)
    }

    func testLeftRightRotation() {
        let input: AVLTree<String> = ["C", "A", "B"]
        let expected = true

        XCTAssertEqual(input.balanced && input.height == 2, expected)
    }

    func testRightLeftRotation() {
        let input: AVLTree<String> = ["A", "C", "B"]
        let expected = true

        XCTAssertEqual(input.balanced && input.height == 2, expected)
    }

    func testHeightEmptyTree() {
        let input = AVLTree<Int>()
        let expected = 0

        XCTAssertEqual(input.height, expected)
    }

    func testHeight() {
        let input: AVLTree<Int> = [1, 5, 8, 7, 10, 15, 20, 17, 25]
        let expected = 4

        XCTAssertEqual(input.height, expected)
    }

    func testBalancedEmptyTree() {
        let input = AVLTree<Int>()
        let expected = true

        XCTAssertEqual(input.balanced, expected)
    }

    func testBalanced9NodeTree() {
        let input: AVLTree<Int> = [1, 5, 8, 7, 10, 15, 20, 17, 25]
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
        let tree: AVLTree<Int> = [1, 5, 8, 7, 10, 15, 20, 17, 25]
        let input = 30
        let expected = 30

        tree.insert(value: input)

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }

    func testInsertExisting8() {
        let tree: AVLTree<Int> = [1, 5, 8, 7, 10, 15, 20, 17, 25]
        let input = 8
        let expected = 8

        tree.insert(value: input)

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }

    func testRemoveNonExisting30() {
        let tree: AVLTree<Int> = [1, 5, 8, 7, 10, 15, 20, 17, 25]
        let input = 30
        let expected: Int? = nil

        tree.remove(value: input)

        XCTAssertEqual(tree.find(value: input)?.value, expected)
    }
//
//    func testRemoveExisting8() {
//        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 8)
//        let expected: Int? = nil
//
//        input.tree.remove(value: input.value)
//
//        XCTAssertEqual(input.tree.find(value: input.value)?.value, expected)
//    }

    func testFindExisting1() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 1)
        let expected = 1

        XCTAssertEqual(input.tree.find(value: input.value)?.value, expected)
    }

    func testFindExisting8() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 8)
        let expected = 8

        XCTAssertEqual(input.tree.find(value: input.value)?.value, expected)
    }

    func testFindExisting25() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 25)
        let expected = 25

        XCTAssertEqual(input.tree.find(value: input.value)?.value, expected)
    }

    func testFindNonExisting0() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 0)
        let expected: Int? = nil

        XCTAssertEqual(input.tree.find(value: input.value)?.value, expected)
    }

    func testFindNonExisting30() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 30)
        let expected: Int? = nil

        XCTAssertEqual(input.tree.find(value: input.value)?.value, expected)
    }

    func testNextOf1() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 1)
        let expected = 5

        if let node = input.tree.find(value: input.value) {
            XCTAssertEqual(input.tree.next(node: node)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(input.tree).")
        }
    }

    func testNextOf8() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 8)
        let expected = 10

        if let node = input.tree.find(value: input.value) {
            XCTAssertEqual(input.tree.next(node: node)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(input.tree).")
        }
    }

    func testNextOf15_1() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 15)
        let expected = 17

        if let node = input.tree.find(value: input.value) {
            XCTAssertEqual(input.tree.next(node: node)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(input.tree).")
        }
    }

    func testNextOf25() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 25)
        let expected: Int? = nil

        if let node = input.tree.find(value: input.value) {
            XCTAssertEqual(input.tree.next(node: node)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(input.tree).")
        }
    }

    func testNextOf15() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 2, 3, 4, 6, 7, 9, 13, 15, 17, 18, 20), value: 15)
        let expected = 17

        if let node = input.tree.find(value: input.value) {
            XCTAssertEqual(input.tree.next(node: node)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(input.tree).")
        }
    }

    func testPreviousOf1() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 1)
        let expected: Int? = nil

        if let node = input.tree.find(value: input.value) {
            XCTAssertEqual(input.tree.previous(node: node)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(input.tree).")
        }
    }

    func testPreviousOf8() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 8)
        let expected = 7

        if let node = input.tree.find(value: input.value) {
            XCTAssertEqual(input.tree.previous(node: node)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(input.tree).")
        }
    }

    func testPreviousOf15() {
        let input = (tree: AVLTree<Int>(arrayLiteral: 1, 5, 8, 7, 10, 15, 20, 17, 25), value: 15)
        let expected = 10

        if let node = input.tree.find(value: input.value) {
            XCTAssertEqual(input.tree.previous(node: node)?.value, expected)
        } else {
            XCTFail("Expected value '\(expected)' not found in tree \(input.tree).")
        }
    }
}
