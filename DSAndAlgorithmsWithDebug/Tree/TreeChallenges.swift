struct TreeChallenges {
    static func makeBeverageTree() -> TreeNode<String> {
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
    
    static func playground() {
        let tree = makeBeverageTree()
        tree.forEachLevelOrder(visit: { print($0.value) })
    }
    
    static func challenge1() {
        
        // My solution
        func printByLevel<T>(_ head: TreeNode<T>) {
            // Need a queue that's goign to store the nodes that need a \n before printing
            var queue = QueueArray<TreeNode<T>>()
            
            // For the head node, look at the chilren and store the first node in the queue
            guard var firstChild = head.children.first else { return } // If no first child, then there's no 2nd level
            queue.enqueue(firstChild)
            
            // Loop on the first nodes of the children until there are no more and store those in the queue
            while let nextFirstChild = firstChild.children.first {
                queue.enqueue(nextFirstChild)
                firstChild = nextFirstChild
            }
            
            // Traverse the tree in level order, printing each node's value. Also compare each node to the front of the queue and if it's a match, dequeue and print \n
            var levelString = ""
            head.forEachLevelOrder { (node) in
                if let frontOfQueue = queue.peek, frontOfQueue === node {
                    print(levelString)
                    queue.dequeue()
                    levelString = ""
                }
                levelString += "\(node.value)   "
            }
            print(levelString)
        }
        
        // their solution
        func theirPrintByLevel<T>(_ head: TreeNode<T>) {
            var queue = QueueArray<TreeNode<T>>()
            var nodesLeftInCurrentLevel = 0
            queue.enqueue(head)
            
            while !queue.isEmpty {
                nodesLeftInCurrentLevel = queue.count
                
                while nodesLeftInCurrentLevel > 0 {
                    guard let node = queue.dequeue() else { break }
                    print("\(node.value) ", terminator: "")
                    node.children.forEach({ queue.enqueue($0) })
                    nodesLeftInCurrentLevel -= 1
                }
                print()
            }
        }
        
        let tree = makeBeverageTree()
        theirPrintByLevel(tree)
    }
}
