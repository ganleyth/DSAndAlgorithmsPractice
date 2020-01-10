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

    static let tree2: BinaryNode<Int> = {
        let fifteen = BinaryNode(value: 15)
        let ten = BinaryNode(value: 10)
        let twentyFive = BinaryNode(value: 25)
        let five = BinaryNode(value: 5)
        let twelve = BinaryNode(value: 12)
        let seventeen = BinaryNode(value: 17)

        fifteen.left = ten
        ten.left = five
        ten.right = twelve
        fifteen.right = twentyFive
        twentyFive.left = seventeen

        return fifteen
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

    static func challenge2() {
        func serialize<T>(_ node: BinaryNode<T>) -> [T?] {

            // Need something similar to pre-order traversing

            // If a node's child is nil, then instead of doing nothing with the node, add nil to the array

            // It's ok to process the closure on a nil child, but the recursion must end if the current node is nil
            var array = [T?]()

            func customPreOrderTraverse(_ node: BinaryNode<T>?) {
                if let node = node {
                    array.append(node.value)
                    customPreOrderTraverse(node.left)
                    customPreOrderTraverse(node.right)
                } else {
                    array.append(nil)
                }
            }

            customPreOrderTraverse(node)
            return array
        }

        func traversePreOrder<T>(_ node: BinaryNode<T>, visit: (T?) -> Void) {
            visit(node.value)
            if let leftChild = node.left {
                traversePreOrder(leftChild, visit: visit)
            } else {
                visit(nil)
            }
            if let rightChild = node.right {
                traversePreOrder(rightChild, visit: visit)
            } else {
                visit(nil)
            }
        }

        func deserialize<T>(_ array: [T?]) -> BinaryNode<T>? {
            // Need a stack to store the nodes that still need their rhs built out

            // First item goes onto the stack

            // Next item, if non-nil, goes to the left of the first item in the stack and then is pushed onto the stack

            // Next item, if nil, goes to left of the top item in the stack and the item after that, regardless of value goes to the right of the top value in the stack. If it's non-nil, push it onto the stack

            // Once I find a leaf, pop the top of the stack and indicate that the next value goes to the right of the top value in the stack
            var array = array
            guard let head = array.first, let unwrappedHead = head else { return nil }
            array.removeFirst()

            let headNode = BinaryNode(value: unwrappedHead)

            var stack = Stack<BinaryNode<T>>()
            stack.push(headNode)

            var addNextAsRightChild = false
            while let first = array.first {
                guard let topOfStack = stack.peek() else { break }

                array.removeFirst()
                if let nonNilValue = first {
                    let node = BinaryNode(value: nonNilValue)
                    addNextAsRightChild ? { topOfStack.right = node }() : { topOfStack.left = node }()
                    stack.push(node)
                } else {
                    if let second = array.first {
                        array.removeFirst()
                        if let unwrappedSecond = second {
                            let secondNode = BinaryNode(value: unwrappedSecond)
                            topOfStack.right = secondNode
                            stack.push(secondNode)
                        } else {
                            // Leaf detected
                            stack.pop()
                            while let _topOfStack = stack.peek(), _topOfStack.right != nil {
                                stack.pop()
                            }
                            addNextAsRightChild = true
                        }
                    }
                }
            }

            return headNode
        }

        func theirDeserialize<T>(_ array: inout [T?]) -> BinaryNode<T>? {
            guard let value = array.removeFirst() else { return nil }
            let node = BinaryNode(value: value)
            node.left = theirDeserialize(&array)
            node.right = theirDeserialize(&array)
            return node
        }

        let serialized = serialize(tree2)
        let deserialized = deserialize(serialized)

        print(String(describing: deserialized!))
        print(String(describing: tree2))
    }
}
