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
}
