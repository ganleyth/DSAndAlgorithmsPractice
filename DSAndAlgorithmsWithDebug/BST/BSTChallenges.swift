class BSTChallenges {
    
    static let tree1: BinarySearchTree<Int> = {
        var tree = BinarySearchTree<Int>()
        tree.insert(value: 3)
        tree.insert(value: 1)
        tree.insert(value: 4)
        tree.insert(value: 0)
        tree.insert(value: 2)
        tree.insert(value: 5)
        return tree
    }()

    static let tree2: BinarySearchTree<Int> = {
        var tree = BinarySearchTree<Int>()
        tree.insert(value: 3)
        tree.insert(value: 1)
        tree.insert(value: 4)
        tree.insert(value: 0)
        tree.insert(value: 2)
        tree.insert(value: 5)
        return tree
    }()

    static func playground() {
        print(tree1)
    }

    static func challenge1() {

        func checkForValidChildren<T: Comparable>(_ node: BinaryNode<T>?, isValidSoFar: Bool) -> Bool {
            guard let node = node else { return isValidSoFar }
            var isValid = isValidSoFar

            if let left = node.left {
                isValid = isValid && (left.value < node.value)
                isValid = isValid && checkForValidChildren(left, isValidSoFar: isValid)
            }

            if let right = node.right {
                isValid = isValid && (right.value >= node.value)
                isValid = isValid && checkForValidChildren(right, isValidSoFar: isValid)
            }

            return isValid
        }

        print("Is valid: \(checkForValidChildren(tree1.root, isValidSoFar: true))")
    }

    static func challenge2() {
        print((tree1 == tree2) ? "Equal" : "Not Equal")
    }

    static func challenge3() {
        print((tree1.hasSameElements(as: tree2)) ? "Same" : "Not the same")
    }
}

// Their solution to challenge 1
extension BinaryNode where Element: Comparable {
    var isBinarySearchTree: Bool {
        return isBST(self, min: nil, max: nil)
    }

    func isBST(_ node: BinaryNode?, min: Element?, max: Element?) -> Bool {
        guard let node = node else { return true }

        if let min = min, node.value <= min { return false }
        if let max = max, node.value > max { return false }

        return isBST(node.left, min: min, max: node.value) && isBST(node.right, min: node.value, max: max)
    }
}

// My solution for challenge 2

extension BinarySearchTree: Equatable {
    static func ==(lhs: BinarySearchTree, rhs: BinarySearchTree) -> Bool {
        // Ideas:
        // 1. Create 2 arrays, traverse the tree in order and add all values, plus nils, to that array. Do that for each array. See if the array is equal.
        // 2. Two equal nodes have the same value and their two children have the same values

        return areTwoNodesAndChildrenEqual(lhs.root, node2: rhs.root)
    }

    private static func areTwoNodesAndChildrenEqual(_ node1: BinaryNode<Element>?, node2: BinaryNode<Element>?) -> Bool {
        if let node1 = node1, let node2 = node2 {
            // Do the most work here

            if node1.value != node2.value { return false }

            return areTwoNodesAndChildrenEqual(node1.left, node2: node2.left) && areTwoNodesAndChildrenEqual(node1.right, node2: node2.right)
        } else if node1 == nil && node2 == nil {
            return true
        } else {
            // One is nil and the other is non-nil
            return false
        }
    }
}

// Their solution for challenge 3
extension BinarySearchTree where Element: Hashable {

    func contains(_ otherTree: BinarySearchTree<Element>) -> Bool {
        var set = Set<Element>()
        root?.traverseInOrder(visit: { set.insert($0) })

        var containsOtherTree = true
        otherTree.root?.traverseInOrder(visit: {
            if !set.contains($0) {
                containsOtherTree = false
            }
        })

        return containsOtherTree
    }
}
