class BSTChallenges {
    
    static let tree: BinarySearchTree<Int> = {
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
        print(tree)
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

        print("Is valid: \(checkForValidChildren(tree.root, isValidSoFar: true))")
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
