struct AVLTree<Element: Comparable> {

    private(set) var root: AVLNode<Element>?

    init() {}

    mutating func insert(value: Element) {
        root = insert(at: root, value: value)
    }

    private func insert(at node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
        guard let node = node else { return AVLNode(value: value) }
        
        if value < node.value {
            node.left = insert(at: node.left, value: value)
        } else {
            node.right = insert(at: node.right, value: value)
        }
        
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        
        return balancedNode
    }

    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.right!
        node.right = pivot.left
        pivot.left = node

        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1

        return pivot
    }

    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.left!
        node.left = pivot.right
        pivot.right = node

        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1

        return pivot
    }
    
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let right = node.right else { return node }
        node.right = rightRotate(right)
        return leftRotate(node)
    }
    
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let left = node.left else { return node }
        node.left = leftRotate(left)
        return rightRotate(node)
    }
    
    private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        switch node.balanceFactor {
        case 2:
            if let left = node.left, left.balanceFactor == -1 {
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2:
            if let right = node.right, right.balanceFactor == 1 {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        default:
            return node
        }
    }

    func contains(_ value: Element) -> Bool {
        var current = root

        while let node = current {
            if node.value == value {
                return true
            }

            if value < node.value {
                current = node.left
            } else {
                current = node.right
            }
        }

        return false
    }

    mutating func remove(_ value: Element) {
        root = remove(from: root, value: value)
    }

    private func remove(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
        guard let node = node else { return nil }

        if node.value == value {

            if node.left == nil && node.right == nil {
                return nil
            } else if node.left == nil {
                return node.right
            } else if node.right == nil {
                return node.left
            } else {
                node.value = node.right!.min.value
                node.right = remove(from: node.right, value: node.value)
            }

        } else if value < node.value {
            node.left = remove(from: node.left, value: value)
        } else {
            node.right = remove(from: node.right, value: value)
        }

        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }
}

extension AVLTree: CustomStringConvertible {

    var description: String {
        guard let root = root else { return "Empty Tree" }
        return String(describing: root)
    }
}

private extension AVLNode {

    var min: AVLNode {
        return left?.min ?? self
    }
}

