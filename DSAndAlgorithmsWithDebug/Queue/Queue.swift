protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

struct QueueArray<T>: Queue {
    private var array: [T] = []
    init() {}
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var peek: T? {
        return array.first
    }
    
    @discardableResult
    mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    var description: String {
        return String(describing: array)
    }
}

struct QueueLinkedList<T>: Queue {
    private var list = LinkedList<T>()
    init() {}
    
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    var peek: T? {
        return list.head?.value
    }
    
    @discardableResult
    mutating func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
//        guard !isEmpty, let first = list.first else { return nil }
        return list.pop()
    }
}

extension QueueLinkedList: CustomStringConvertible {
    var description: String {
        return String(describing: list)
    }
}

struct QueueRingBuffer<T>: Queue {
    private var buffer: RingBuffer<T>
    
    init(count: Int) {
        buffer = RingBuffer<T>(count: count)
    }
    
    var isEmpty: Bool {
        return buffer.isEmpty
    }
    
    var peek: T? {
        return buffer.first
    }
    
    mutating func enqueue(_ element: T) -> Bool {
        return buffer.write(element)
    }
    
    mutating func dequeue() -> T? {
        return buffer.read()
    }
}

extension QueueRingBuffer: CustomStringConvertible {
    var description: String {
        return buffer.description
    }
}

struct QueueStack<T>: Queue {
    private var leftStack: [T] = []
    private var rightStack: [T] = []
    init() {}
    
    var isEmpty: Bool {
        return rightStack.isEmpty && leftStack.isEmpty
    }
    
    var peek: T? {
        return leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    
    mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        
        return leftStack.popLast()
    }
}

struct QueueTKGRingBuffer<T>: Queue {
    private var buffer: TKGRingBuffer<T>
    
    init(count: Int) {
        buffer = TKGRingBuffer<T>(count: count)
    }
    
    var isEmpty: Bool {
        return buffer.isEmpty
    }
    
    var peek: T? {
        return buffer.first
    }
    
    @discardableResult
    mutating func enqueue(_ element: T) -> Bool {
        return buffer.write(element)
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        return buffer.read()
    }
}

extension QueueTKGRingBuffer: CustomStringConvertible {
    var description: String {
        return String(describing: buffer)
    }
}
