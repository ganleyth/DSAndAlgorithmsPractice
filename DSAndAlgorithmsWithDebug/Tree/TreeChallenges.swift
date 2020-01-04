struct TreeChallenges {
    static func playground() {
        func makeBeverageTree() -> TreeNode<String> {
            let tree = TreeNode(value: "Beverages")
            
            let hot = TreeNode(value: "Hot")
            let cold = TreeNode(value: "Cold")
            
            let tea = TreeNode(value: "tea")
            let coffee = TreeNode(value: "coffee")
            let chocolate = TreeNode(value: "chocolate")
            
            let blackTea = TreeNode(value: "black")
            let greenTea = TreeNode(value: "green")
            let chaiTea = TreeNode(value: "chai")
            
            let soda = TreeNode(value: "soda")
            let milk = TreeNode(value: "milk")
            
            let gingerAle = TreeNode(value: "ginger ale")
            let bitterLemon = TreeNode(value: "bitter  lemon")
            
            tree.add(hot)
            tree.add(cold)
            
            hot.add(tea)
            hot.add(coffee)
            hot.add(chocolate)
            
            cold.add(soda)
            cold.add(milk)
            
            tea.add(blackTea)
            tea.add(greenTea)
            tea.add(chaiTea)
            
            soda.add(gingerAle)
            soda.add(bitterLemon)

            return tree
        }

        let tree = makeBeverageTree()
        tree.forEachDepthFirst(visit: { print($0.value) })
    }
}
