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
    fileprivate(set) var root: NodeType? = nil

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
        return self.insert(value: value, node: self.root)
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
    fileprivate func insert(value: ValueType, node root: NodeType?) -> NodeType {

        guard let node = root else {
            let newNode = NodeType(value: value)
            self.root = newNode

            return newNode
        }

        if value < node.value {
            if node.left != nil {
                return self.insert(value: value, node: node.left)
            } else {
                let newNode = NodeType(value: value, parent: node)
                node.left = newNode

                self.balance(from: root)

                return newNode
            }
        } else if value > node.value {
            if node.right != nil {
                return self.insert(value: value, node: node.right)
            } else {
                let newNode = NodeType(value: value, parent: node)
                node.right = newNode

                self.balance(from: root)

                return newNode
            }
        }
        ///
        /// If equal the value is already in the tree
        /// and we ignore it returning the node we are at
        return node
    }

    ///
    /// Remove the node from the tree
    ///
    @inline(__always)
    fileprivate func remove(node: NodeType) {

        /// This is a leaf node so we can just remove it
        if node.left == nil && node.right == nil {

            if let parent = node.parent {
                if let left = parent.left, left === node {              /// We are the left node of our parent
                    parent.left = nil
                } else if let right = parent.right, right === node {    /// We are the right node of our parent
                    parent.right = nil
                }

                self.balance(from: node.parent)

            } else {
                /// This is the root node with no children so simply remove it.
                self.root = nil
            }

        } else {
            /// In this case we are an inner node.
            if let predecessor = self.previous(node: node) {

                /// Replace this node with the replacement found
                node.value = predecessor.value

                /// Now remove the old one.
                self.remove(node: predecessor)

            } else if let successor = self.next(node: node) {

                /// Replace this node with the replacement found
                node.value = successor.value

                /// Now remove the old one.
                self.remove(node: successor)
            }
        }
    }

    ///
    /// Search for a specific value in the tree.
    ///
    /// - Returns: The node containing the value if found, nil otherwise.
    ///
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
    fileprivate func balance(from root: NodeType?) {

        if let node = root {

            // Determine which node this was before potentially modifying it
            let isRoot = node === self.root
            let isLeft = node === node.parent?.left

            /// Also get its parent
            let parent = node.parent

            var subtree: NodeType? = nil

            ///
            /// Determine how to rotate the nodes if an imbalance is present.
            ///
            if node.balanceFactor > 1 {                    /// Right Heavy

                if node.right?.balanceFactor ?? 0 < 0 {    /// Right subtree is Left heavy

                    subtree = self.rightLeftRotate(node: node)
                } else {

                    subtree = self.leftRotate(node: node)
                }
            } else if node.balanceFactor < -1 {             /// Left Heavy

                if node.left?.balanceFactor ?? 0 > 0 {     /// Left subtree is Right heavy

                    subtree = self.leftRightRotate(node: node)
                } else {

                    subtree = self.rightRotate(node: node)
                }
            } else {
                self.balance(from: node.parent)

                return
            }

            if isRoot {
                subtree?.parent = nil
                self.root = subtree
            } else if isLeft {
                parent?.left = subtree
            } else {
                parent?.right = subtree
            }

            self.balance(from: subtree?.parent)
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
    fileprivate func leftRotate(node a: NodeType) -> NodeType? {

        var newRoot: NodeType? = nil

        if let b = a.right, b.right != nil {

            a.right = b.left    /// A's right becomes B's left
            b.left  = a         /// B's left becomes A

            newRoot = b
        }
        assert(newRoot != nil)

        return newRoot
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
    fileprivate func rightRotate(node c: NodeType) -> NodeType? {

        var newRoot: NodeType? = nil

        if let b = c.left, b.left != nil {

            c.left  = b.right  /// C's left becomes B's right
            b.right = c        /// B's right becomes C

            newRoot = b
        }
        assert(newRoot != nil)

        return newRoot
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
    fileprivate func leftRightRotate(node c: NodeType) -> NodeType? {

        var newRoot: NodeType? = nil

        if let a = c.left, let b = a.right {

            /// Left rotation
            a.right = b.left
            b.left = a
            c.left = b

            /// Right rotation
            c.left = b.right
            b.right = c

            newRoot = b
        }
        assert(newRoot != nil)

        return newRoot
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
    fileprivate func rightLeftRotate(node a: NodeType) -> NodeType? {

        var newRoot: NodeType? = nil

        if let c = a.right, let b = c.left {

            /// Right rotate
            c.left = b.right
            b.right = c
            a.right = b

            /// Left rotate
            a.right = b.left
            b.left = a

            newRoot = b
        }
        assert(newRoot != nil)

        return newRoot
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
    fileprivate(set) var value: ValueType

    /// Left subtree
    var left:  NodeType? {
        willSet {
            assert(newValue !== self)

            newValue?.parent = self     /// Maintain the parent link.
        }
    }

    /// Right subtree
    var right: NodeType? {
        willSet {
            assert(newValue !== self)

            newValue?.parent = self     /// Maintain the parent link.
        }
    }

    /// This nodes parent
    weak fileprivate var parent: NodeType? {
        willSet {
            assert(newValue !== self)
        }
    }

    ///
    /// Get height of this subtree.
    ///
    /// Height of a subtree is the number of nodes on the longest path from the root to a leaf.
    ///
    var height: Int {
        return 1 + Swift.max(self.left?.height ?? 0, self.right?.height ?? 0)
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
        return abs((self.right?.height ?? 0) - (self.left?.height ?? 0)) <= 1 && (self.left?.balanced ?? true) && (self.right?.balanced ?? true)
    }
}
