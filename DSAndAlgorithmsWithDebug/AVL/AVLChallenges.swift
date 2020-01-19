class AVLChallenges {

    static func playground() {
        var tree = AVLTree<Int>()
        for i in 0...15 {
            tree.insert(value: i)
        }
        
        tree.remove(3)
        tree.remove(4)
        tree.remove(2)
        tree.remove(5)
        
        print(tree)
    }
}
