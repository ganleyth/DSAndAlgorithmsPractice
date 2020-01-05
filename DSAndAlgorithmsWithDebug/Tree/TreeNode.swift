class TreeNode<T> {
    var value: T
    var children: [TreeNode] = []

    init(value: T) {
        self.value = value
    }

    func add(_ child: TreeNode) {
        children.append(child)
    }

    func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach { (child) in
            child.forEachDepthFirst(visit: visit)
        }
    }
    
    func forEachLevelOrder(visit: (TreeNode) -> Void) {
        // Perform the function on the initial node that's passed in
        visit(self)
        
        // The queue is going to stay alive until all nodes are visited because we'll enqueue items as we're dequeueing and checking for that node's children. But order will be maintained and nodes on the same level will have been enqueued first.
        var queue = QueueArray<TreeNode>()
        
        // Give the queue some contents
        children.forEach({ queue.enqueue($0) })
        
        // Start the loop
        while let node = queue.dequeue() {
            visit(node)
            // Enqueueing here ensures that left nodes go first at the next level
            node.children.forEach({ queue.enqueue($0) })
        }
    }
}

extension TreeNode where T: Equatable {
    
    func search(for value: T) -> TreeNode? {
        var node: TreeNode?
        self.forEachDepthFirst { (_node) in
            if _node.value == value {
                node = _node
            }
        }
        return node
    }
}
