struct Stack<Element> {
    private var storage: [Element] = []
    init() {}
    
    init(elements: [Element]) {
        storage = elements
    }
    
    init(arrayLiteral elements: Element...) {
        storage = elements
    }
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        return storage.popLast()
    }
    
    func peek() -> Element? {
        return storage.last
    }
    
    var isEmpty: Bool {
        return storage.isEmpty
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        let topDivider = "------- top --------\n"
        let bottomDivider = "\n------------------"
        
        let stackElements = storage.map({ "\($0)" }).reversed().joined(separator: "\n")
        
        return topDivider + stackElements + bottomDivider
    }
}
