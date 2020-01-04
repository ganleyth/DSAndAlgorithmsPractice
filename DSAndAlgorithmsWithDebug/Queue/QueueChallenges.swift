struct QueueChallenges {
    static func playground() {
        var queue = QueueTKGRingBuffer<String>(count: 5)
        queue.enqueue("Tom")
        queue.enqueue("Tanya")
        queue.enqueue("Buster")
        print(queue)
        queue.dequeue()
        print(queue)
        print("\(queue.peek!)")
    }
    
    static func challenge2() {
        func reversed<T>(queue: QueueArray<T>) -> QueueArray<T> {
            // Create a copy of the input queue
            var returnQueue = queue
            
            // Create a stack to be used for reversing the order
            var stack = Stack<T>()
            
            // Dequeue the copy's contents into the stack and then enqueue from the stack
            while let element = returnQueue.dequeue() {
                stack.push(element)
            }
            while let element = stack.pop() {
                returnQueue.enqueue(element)
            }
            
            return returnQueue
        }
        
        func reverse<T>(from: inout QueueArray<T>, to: inout QueueArray<T>) {
            // base case
            guard let first = from.dequeue() else { return }
            
            // recursion
            reverse(from: &from, to: &to)
            
            // action
            to.enqueue(first)
        }
        
        func reversedRecursive<T>(queue: QueueArray<T>) -> QueueArray<T> {
            var from = queue
            var to = QueueArray<T>()
            reverse(from: &from, to: &to)
            
            return to
        }
        
        var queue = QueueArray<Int>()
        for i in 1...5 { queue.enqueue(i) }
        print(reversedRecursive(queue: queue))
    }
}
