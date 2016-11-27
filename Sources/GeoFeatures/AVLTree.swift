///
///  AVLTree.swift
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
///  Created by Tony Stone on 11/25/2016.
///
import Swift

#if os(Linux) || os(FreeBSD)
    import Glibc
#else
    import Darwin
#endif

///
/// Generic implementation of an self-balancing AVL Tree structure
///
/// - complexity: Lookup, insertion, and deletion all take O(log n) time in both the average and worst cases, where n is the number of nodes in the tree prior to the operation
///
internal class AVLTree<ValueType: Comparable>: ExpressibleByArrayLiteral {

    typealias NodeType = AVLTreeNode<ValueType>

    ///
    /// The root of the tree if it has any nodes
    ///
    private(set) var root: NodeType? = nil

    ///
    /// Construct an instance with an Array of ValueTypes
    ///
    public required convenience init(arrayLiteral values: ValueType...) {
        self.init()

        for value in values {
            self.insert(value: value)
        }
        print(self)
    }

    internal var height: Int {
        return self.root?.height ?? 0
    }

    internal var balanced: Bool {
        guard let root = self.root else {
            return true
        }
        return root.balanced
    }

    ///
    /// Insert a value into the tree
    ///
    /// - Parameter value: The value to insert into the tree.
    ///
    /// - Returns: The new NodeType that was inserted.
    ///
    @discardableResult
    public func insert(value: ValueType) -> NodeType {

        return self.insert(value: value, node: &self.root)
    }

    ///
    /// Remove the value from the tree
    ///
    /// - Parameter value: The value to remove from the tree.
    ///
    public func remove(value: ValueType) -> Void {
        if let node = self.find(value: value) {
            self.remove(node: node)
        }
    }

    public func find(value: ValueType) -> NodeType? {
        return self.find(value: value, start: self.root)
    }

    ///
    /// Returns in-order successor (next) of the given node
    ///
    /// In-order successor of a node is the next node in the in-order traversal of the tree. For the last node in a tree, in-order successor will be nil.
    ///
    /// ```
    ///  AVLTree : 3 5 7 10 17 15
    ///  next of 7 is 10
    ///  next of 10 is 15
    ///
    /// ```
    ///
    public func next(node: NodeType) -> NodeType? {

        /// If the node has a right child then its in-order successor will be the left most node in the right subtree.
        if var subNode = node.right {
            while let left = subNode.left {
                subNode = left
            }
            return subNode
        }

        ///
        /// If the node doesnt have a right child then its in-order successor will be one of its ancestors,
        /// using parent link keep traveling up till you get the node which is the left child of its parent.
        ///
        var child = node
        var next  = child.parent            /// Start with the parent of the existing node, if nil this is the root node and there will not be a predecessor so return nil

        while let parent = next,            /// While there is a parent
                  child === parent.right {  /// and the child is the Right node.

            child = parent                  /// If so, make the new child the parent of the current node
            next  = child.parent            /// The new parent becomes the new child's parent
        }
        return next
    }

    ///
    /// Returns in-order predecessor (previous) of the given node
    ///
    public func previous(node: NodeType) -> NodeType? {

        /// If the node is a left node then its in-order predecessor will be the right most node of the left subtree.
        if var subNode = node.left {
            while let right = subNode.right {
                subNode = right
            }
            return subNode
        }

        ///
        /// If the node doesnt have a left child then its in-order predecessor will be one of its ancestors,
        /// using parent link keep traveling up till you get the node which is the right child of its parent.
        ///
        var child = node
        var next  = child.parent            /// Start with the parent of the existing node, if nil this is the root node and there will not be a predecessor so return nil

        while let parent = next,            /// While there is a parent
                  child === parent.left {   /// and the child is the left node

            child = parent                  /// If so, make the new child the parent of the current node
            next  = child.parent            /// The new parent becomes the new child's parent
        }
        return next
    }

    ///
    /// Insert this node in the proper place in the tree ensuring it's balanced
    ///
    @discardableResult
    private func insert(value: ValueType, node root: inout NodeType?) -> NodeType {

        guard let node = root else {
            let newNode = NodeType(value: value)
            root = newNode

            return newNode
        }

        if value < node.value {
            if node.left != nil {
                let newNode = self.insert(value: value, node: &node.left)

                // Note: we check balance and re-balance on ascent of recursion.
                self.balance(from: &root)

                return newNode
            } else {
                let newNode = NodeType(value: value, parent: node)
                node.left = newNode

                return newNode
            }
        } else {
            if node.right != nil {
                let newNode = self.insert(value: value, node: &node.right)

                // Note: we check balance and re-balance on ascent of recursion.
                self.balance(from: &root)

                return newNode
            } else {
                let newNode = NodeType(value: value, parent: node)
                node.right = newNode

                return newNode
            }
        }
    }

    private func remove(node: NodeType) {

//        if node.left == nil && node.right == nil {
//
//            if let parent = node.parent {
//                if let left = parent.left, left === node {
//                    parent.left = nil
//                } else if let right = parent.right, right === node {
//                    parent.right = nil
//                }
//                self.balance(from: &node)
//            } else {
//                self.root = nil
//            }
//        } else {
//
//        }
    }

    private func find(value: ValueType, start node: NodeType?) -> NodeType? {
        guard let node = node else {
            return nil
        }

        if value == node.value {
            return node
        } else if value < node.value {
            return find(value: value, start: node.left)
        } else {
            return find(value: value, start: node.right)
        }
    }
}

///
/// Tree Balance
///
fileprivate extension AVLTree {

    ///
    /// Balance the tree from the node given.
    ///
    fileprivate func balance(from root: inout NodeType?) {

        if let node = root {
            ///
            /// Determine how to rotate the nodes if an imbalance is present.
            ///
            switch node.heightDistribution {

            case .leftHeavy:

                if node.left?.heightDistribution ?? .equal == .leftHeavy {      /// When a node is inserted in the left subtree of the left subtree. The tree then needs a right rotation.
                    self.rightRotate(node: &root)
                } else {
                    self.leftRightRotate(node: &root)                           /// When a node in inserted into the right subtree of the left subtree.  The tree needs a left right rotation.
                }
                break

            case .rightHeavy:

                if node.right?.heightDistribution ?? .equal == .rightHeavy {    /// When a node is inserted into the right subtree of the right subtree, then we perform a single left rotation
                    self.leftRotate(node: &root)
                } else {
                    self.rightLeftRotate(node: &root)                           /// When a node in inserted into the left subtree of the right subtree.  The tree needs a left right rotation.
                }
                break

            case .equal:
                break   /// Ignore equals
            }
        }
    }

    ///
    /// Rotate the node tree left if there is a right node otherwise do nothing.
    ///
    /// - Parameter from: the node to start the rotation at.
    ///
    /// - Returns: The new root node for this section of the tree.
    ///
    @discardableResult
    fileprivate func leftRotate(node root: inout NodeType?) {

        if let oldRoot = root {
            root = oldRoot.right    /// set the new root
            root?.left = oldRoot    /// Make the old root the left-subtree of the new root
            oldRoot.right = nil     /// Clear the old roots right node
        }
    }

    ///
    /// Rotate the node tree left if there is a left node otherwise do nothing.
    ///
    /// - Parameter from: the node to start the rotation at.
    ///
    @discardableResult
    fileprivate func rightRotate(node root: inout NodeType?) {

        if let oldRoot = root {
            root = oldRoot.left    /// set the new root
            root?.right = oldRoot  /// Make the old root the left-subtree of the new root
            oldRoot.left = nil     /// Clear the old roots right node
        }
    }

    ///
    /// Rotate the node tree left-right (2 rotations) if there is a left node otherwise do nothing.
    ///
    /// - Parameter from: the node to start the rotation at.
    ///
    @discardableResult
    fileprivate func leftRightRotate(node root: inout NodeType?) {

        if let node = root {
            self.leftRotate(node: &(node.left))  /// Rotate the left node left
            self.rightRotate(node: &root)        /// Rotate the from node right
        }
    }

    ///
    /// Rotate the node tree right-left (2 rotations) if there is a right node otherwise do nothing.
    ///
    /// - Parameter from: the node to start the rotation at.
    ///
    @discardableResult
    fileprivate func rightLeftRotate(node root: inout NodeType?) {

        if let node = root {
            self.rightRotate(node: &(node.right))   /// Rotate the right node right
            self.leftRotate (node: &root)           /// rotate the from node left
        }
    }
}

internal enum HeightDistribution {
    case leftHeavy, equal, rightHeavy
}

///
/// Node structure use to store the values of the AVL Tree.
///
internal class AVLTreeNode<ValueType: Comparable> {

    typealias NodeType = AVLTreeNode<ValueType>

    let value: ValueType
    var left:  NodeType?
    var right: NodeType?

    weak fileprivate var parent: NodeType?

    init(value: ValueType, parent: NodeType? = nil, left: NodeType? = nil, right: NodeType? = nil) {
        self.value  = value
        self.parent = parent
        self.left   = left
        self.right  = right

        self.left?.parent = self
        self.right?.parent = self
    }

    ///
    /// Get height of this node.
    ///
    var height: Int {
        return  1 + Swift.max(self.left?.height ?? 0, self.right?.height ?? 0)
    }

    ///
    /// Get the heightDistribution of the left and right subtrees.
    ///
    var heightDistribution: HeightDistribution {

        ///
        /// Positive = leftHeavy
        /// Negative = rightHeavy
        ///
        let variance  = (self.left?.height ?? 0) - (self.right?.height ?? 0)

        if variance > 0 {
            return .leftHeavy
        } else if variance < 0 {
            return .rightHeavy
        }
        return .equal
    }

    ///
    /// Check to see if the subtree starting at this node is height balanced.
    ///
    /// - Returns: true if this subtree is balanced for height
    ///
    var balanced: Bool {
        return  abs((self.left?.height ?? 0) - (self.right?.height ?? 0)) <= 1 &&
                self.left?.balanced ?? true && self.right?.balanced ?? true
    }
}
