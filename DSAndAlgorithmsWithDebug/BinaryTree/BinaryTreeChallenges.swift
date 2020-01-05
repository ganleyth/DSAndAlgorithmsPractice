class BinaryTreeChallenges {
    
    static func playground() {
        let tree: BinaryNode<Int> = {
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
        
        tree.traverseInOrder(visit: { print($0) })
    }
}
