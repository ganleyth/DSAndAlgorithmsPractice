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
}
