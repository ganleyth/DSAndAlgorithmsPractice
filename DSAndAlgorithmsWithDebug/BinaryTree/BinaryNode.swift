class BinaryNode<Element> {
    var value: Element
    var left: BinaryNode?
    var right: BinaryNode?
    
    init(value: Element) {
        self.value = value
    }
    
    func traverseInOrder(visit: (Element) -> Void) {
        left?.traverseInOrder(visit: visit)
        visit(value)
        right?.traverseInOrder(visit: visit)
    }
    
    func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        left?.traversePreOrder(visit: visit)
        right?.traversePreOrder(visit: visit)
    }
    
    func traversePostOrder(visit: (Element) -> Void) {
        left?.traversePostOrder(visit: visit)
        right?.traversePostOrder(visit: visit)
        visit(value)
    }
}

extension BinaryNode: CustomStringConvertible {

  public var description: String {
    return diagram(for: self)
  }
  
  private func diagram(for node: BinaryNode?,
                       _ top: String = "",
                       _ root: String = "",
                       _ bottom: String = "") -> String {
    guard let node = node else {
      return root + "nil\n"
    }
    if node.left == nil && node.right == nil {
      return root + "\(node.value)\n"
    }
    return diagram(for: node.right,
                   top + " ", top + "┌──", top + "│ ")
         + root + "\(node.value)\n"
         + diagram(for: node.left,
                   bottom + "│ ", bottom + "└──", bottom + " ")
  }
}
