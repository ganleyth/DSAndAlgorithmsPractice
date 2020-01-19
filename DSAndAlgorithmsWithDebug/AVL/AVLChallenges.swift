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
    
    static func challenge1() {
        // The number of leaf nodes follows 2^n, where n is the height of the tree. So a tree of height 3 will have 8 leaf nodes.
    }
    
    static func challenge2() {
        // The number of nodes follows 2^n + 2^n-1 + 2^n-h,... for h <= n. For height 3, the number of nodes is 15
    }
}
