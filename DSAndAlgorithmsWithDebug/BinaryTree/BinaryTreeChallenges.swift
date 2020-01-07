class BinaryTreeChallenges {

    static let tree: BinaryNode<Int> = {
        let zero = BinaryNode(value: 0)
        let one = BinaryNode(value: 1)
        let five = BinaryNode(value: 5)
        let seven = BinaryNode(value: 7)
        let eight = BinaryNode(value: 8)
        let nine = BinaryNode(value: 9)

        seven.left = one
        one.left = zero
        one.right = five
        seven.right = nine
        nine.left = eight

        return seven
    }()
    
    static func playground() {
        tree.traverseInOrder(visit: { print($0) })
    }

    static func challenge1() {
        func height<T>(of node: BinaryNode<T>?) -> Int {
            // Base case
            guard let node = node else { return -1 }

            return 1 + max(height(of: node.left), height(of: node.right))
        }

        print("Height: \(height(of: tree))")
    }
}
