struct BinarySearchTree<Element: Comparable> {
    
    private(set) var root: BinaryNode<Element>?
    
    init() {}
    
    mutating func insert(value: Element) {
        root = insert(at: root, value: value)
    }
    
    private func insert(at node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        guard let node = node else {
            return BinaryNode(value: value)
        }
        
        if value < node.value {
            node.left = insert(at: node.left, value: value)
        } else {
            node.right = insert(at: node.right, value: value)
        }
        
        return node
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
    
    private func remove(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
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
        
        return node
    }
}

extension BinarySearchTree: CustomStringConvertible {
    
    var description: String {
        guard let root = root else { return "Empty Tree" }
        return String(describing: root)
    }
}

private extension BinaryNode {
    
    var min: BinaryNode {
        return left?.min ?? self
    }
}
