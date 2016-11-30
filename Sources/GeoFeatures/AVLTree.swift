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

    ///
    /// The current height of this tree
    ///
    internal var height: Int {
        return self.root?.height ?? 0
    }

    ///
    /// Check to see if the tree is height balanced.
    ///
    /// - Returns: true if this tree is balanced for height
    ///
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
        if let node = self.search(value: value) {
            self.remove(node: node)
        }

    }

    ///
    /// Search for a value within the tree
    ///
    /// - Parameter value: The value to search for in the tree.
    ///
    public func search(value: ValueType) -> NodeType? {
        return self.search(value: value, start: self.root)
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
        var next  = child.parent           /// Start with the parent of the existing node, if nil this is the root node and there will not be a predecessor so return nil

        while let parent = next,            /// While there is a parent
                  child === parent.right {  /// and the child is the right node.

            child = parent                  /// If so, make the new child the parent of the current node
            next  = parent.parent           /// The new parent becomes the new child's parent
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

        while let parent = next,
                  child === parent.left {  /// and the child is the left node

            child = parent                  /// If so, make the new child the parent of the current node
            next  = parent.parent           /// The new parent becomes the new child's parent
        }
        return next
    }
}

///
/// Fileprivate private implementation
///
fileprivate extension AVLTree {

    ///
    /// Insert this node in the proper place in the tree ensuring it's balanced
    ///
    @inline(__always)
    @discardableResult
    fileprivate func insert(value: ValueType, node root: inout NodeType?) -> NodeType {

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

    ///
    /// Remove the node from the tree
    ///
    @inline(__always)
    fileprivate func remove(node: NodeType) {

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

    @inline(__always)
    fileprivate func search(value: ValueType, start node: NodeType?) -> NodeType? {
        guard let node = node else {
            return nil
        }

        if value == node.value {
            return node
        } else if value < node.value {
            return search(value: value, start: node.left)
        } else {
            return search(value: value, start: node.right)
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
    @inline(__always)
    fileprivate func balance(from root: inout NodeType?) {

        if let node = root {
            ///
            /// Determine how to rotate the nodes if an imbalance is present.
            ///
            if node.balanceFactor > 1 {                    /// Right Heavy

                if node.right?.balanceFactor ?? 0 < 0 {    /// Right subtree is Left heavy

                    self.rightLeftRotate(node: &root)
                } else {

                    self.leftRotate(node: &root)
                }
            } else if node.balanceFactor < -1 {             /// Left Heavy

                if node.left?.balanceFactor ?? 0 > 0 {     /// Left subtree is Right heavy

                    self.leftRightRotate(node: &root)
                } else {

                    self.rightRotate(node: &root)
                }
            }
        }
    }

    ///
    /// Rotate the node tree left if there is a right node otherwise do nothing.
    ///
    /// - Parameter root: the node to start the rotation at (A right heavy minimum height 2 subtree
    ///
    /// - Returns: The new root node for this section of the tree.
    ///
    /// Example Input:
    /// ```
    ///  (A)
    ///     \   (right)
    ///     (B)
    ///       \   (right)
    ///       (C)
    /// ```
    /// Output:
    /// ```
    ///
    ///     (B)
    ///     /  \
    ///  (A)    (C)
    /// ```
    ///
    @inline(__always)
    @discardableResult
    fileprivate func leftRotate(node root: inout NodeType?) {

        if let a = root, let b = a.right, b.right != nil {

            a.right = b.left    /// A's right becomes B's left
            b.left  = a         /// B's left becomes A

            /// Note: if this is the root node the parent will never be set by it's
            ///       parent (because it does not have one) so you must nil the parent
            ///       before assigning it to the root pointer
            b.parent = nil
            root = b            /// Assign B as the new root
        }
    }

    ///
    /// Rotate the node tree left if there is a left node otherwise do nothing.
    ///
    /// - Parameter from: the node to start the rotation at.
    ///
    /// Example Input:
    /// ```
    ///      (C)
    ///     /    (left)
    ///    (B)
    ///   /    (left)
    /// (A)
    /// ```
    /// Output:
    /// ```
    ///
    ///     (B)
    ///     /  \
    ///  (A)    (C)
    /// ```
    ///
    @inline(__always)
    @discardableResult
    fileprivate func rightRotate(node root: inout NodeType?) {

        if let c = root, let b = c.left, b.left != nil {

            c.left  = b.right  /// C's left becomes B's right
            b.right = c        /// B's right becomes C

            /// Note: if this is the root node the parent will never be set by it's
            ///       parent (because it does not have one) so you must nil the parent
            ///       before assigning it to the root pointer
            b.parent = nil
            root = b           /// Assign B as the new root
        }
    }

    ///
    /// Rotate the node tree left-right (2 rotations) if there is a left node otherwise do nothing.
    ///
    /// - Parameter from: the node to start the rotation at.
    ///
    /// Example Input:
    /// ```
    ///     (C)
    ///    /    (left)
    ///  (A)
    ///    \    (right)
    ///     (B)
    /// ```
    /// Output:
    /// ```
    ///
    ///     (B)
    ///     /  \
    ///  (A)    (C)
    /// ```
    ///
    @inline(__always)
    @discardableResult
    fileprivate func leftRightRotate(node root: inout NodeType?) {

        if let c = root, let a = c.left, let b = a.right {

            /// Left rotation
            a.right = b.left
            b.left = a
            c.left = b

            /// Right rotation
            c.left = b.right
            b.right = c

            /// Note: if this is the root node the parent will never be set by it's
            ///       parent (because it does not have one) so you must nil the parent
            ///       before assigning it to the root pointer
            b.parent = nil
            root = b
        }
    }

    ///
    /// Rotate the node tree right-left (2 rotations) if there is a right node otherwise do nothing.
    ///
    /// - Parameter from: the node to start the rotation at.
    ///
    /// Example Input:
    /// ```
    /// (A)
    ///    \   (right)
    ///    (C)
    ///   /    (left)
    /// (B)
    /// ```
    /// Output:
    /// ```
    ///
    ///     (B)
    ///     /  \
    ///  (A)    (C)
    /// ```
    ///
    @inline(__always)
    @discardableResult
    fileprivate func rightLeftRotate(node root: inout NodeType?) {

        if let a = root, let c = a.right, let b = c.left {

            /// Right rotate
            c.left = b.right
            b.right = c
            a.right = b

            /// Left rotate
            a.right = b.left
            b.left = a

            /// Note: if this is the root node the parent will never be set by it's
            ///       parent (because it does not have one) so you must nil the parent
            ///       before assigning it to the root pointer
            b.parent = nil
            root = b
        }
    }
}

///
/// Node structure use to store the values of the AVL Tree.
///
internal class AVLTreeNode<ValueType: Comparable> {

    typealias NodeType = AVLTreeNode<ValueType>

    init(value: ValueType, parent: NodeType? = nil) {
        self.value  = value
        self.parent = parent
        self.left   = nil
        self.right  = nil

        self.left?.parent = self
        self.right?.parent = self
    }

    ///
    /// The stored value given by the user.
    ///
    let value: ValueType

    /// Left subtree
    var left:  NodeType? {
        willSet {
            newValue?.parent = self     /// Maintain the parent link.
        }
    }

    /// Right subtree
    var right: NodeType? {
        willSet {
            newValue?.parent = self     /// Maintain the parent link.
        }
    }

    /// This nodes parent
    weak fileprivate var parent: NodeType?

    ///
    /// Get height of this subtree.
    ///
    /// Height of a subtree is the number of nodes on the longest path from the root to a leaf.
    ///
    var height: Int {
        return  1 + Swift.max(self.left?.height ?? 0, self.right?.height ?? 0)
    }

    ///
    /// Positive (+) = Right Heavy
    /// Negative (-) = Left Heavy
    /// Zero     (0) = Equal
    ///
    var balanceFactor: Int {
        return (self.right?.height ?? 0) - (self.left?.height ?? 0)
    }

    ///
    /// Check to see if the subtree starting at this node is height balanced.
    ///
    /// - Returns: true if this subtree is balanced for height
    ///
    var balanced: Bool {
        return  abs(self.balanceFactor) <= 1 &&
                self.left?.balanced ?? true && self.right?.balanced ?? true
    }
}
