public struct LinkedList<T> {
    public var head: Node<T>?
    public var tail: Node<T>?

    public init() {}

    public var isEmpty: Bool {
        return head == nil
    }

    public mutating func push(_ value: T) {
        copyNodes()
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }

    public mutating func append(_ value: T) {
        copyNodes()
        guard !isEmpty else { push(value); return }
        tail?.next = Node(value: value)
        tail = tail?.next
    }

    public func node(at index: Int) -> Node<T>? {
        var currentNode = head
        var currentIndex = 0

        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }

        return currentNode
    }

    @discardableResult
    public mutating func insert(_ value: T, after node: Node<T>) -> Node<T> {
        copyNodes()
        if tail === node {
            append(value)
            return tail!
        }

        node.next = Node(value: value, next: node.next)
        return node.next!
    }

    @discardableResult
    public mutating func pop() -> T? {
        copyNodes()
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }

    @discardableResult
    public mutating func removeLast() -> T? {
        copyNodes()
        guard let head = head else { return nil }

        guard head.next != nil else {
            return pop()
        }

        var prev = head
        var current = head

        while let next = current.next {
            prev = current
            current = next
        }

        prev.next = nil
        tail = prev
        return current.value
    }

    @discardableResult
    public mutating func remove(after node: Node<T>) -> T? {
        copyNodes()
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }

    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head),
            var oldNode = head else { return }

        head = Node(value: oldNode.value)
        var newNode = head

        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next

            oldNode = nextOldNode
        }

        tail = newNode
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty List"
        }
        return String(describing: head)
    }
}

public class Node<T> {
    public var value: T
    public var next: Node?

    public init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {

    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next) + " "
    }
}

// MARK: - Conforming to Collection Protocol
extension LinkedList: Collection {
    public struct Index: Comparable {
        public var node: Node<T>?

        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }

        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }

            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains(where: { $0 === rhs.node })
        }
    }

    public var startIndex: Index {
        return Index(node: head)
    }

    public var endIndex: Index {
        return Index(node: tail?.next)
    }

    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }

    public subscript(position: Index) -> T {
        return position.node!.value
    }
}

