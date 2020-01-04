struct StackChallenges {
    static func playground() {
        var stack = Stack<Int>()
        for i in 1...4 { stack.push(i) }
        
        print(stack)
        
        if let popped = stack.pop() {
            assert(popped == 4)
            print("Popped: \(popped)")
        }
    }
    
    static func challenge1() {
        var list = LinkedList<Int>()
        for i in 1...5 { list.append(i) }
        
        // My solution: destructive! No need to destroy the linked list in the process
        
        func reversePrint<T>(list: inout LinkedList<T>) {
            var stack = Stack<T>()
            // 1 -> 2 -> 3 -> 4 -> becomes [1, 2, 3, 4, 5]
            
            // Iterate through the linked list by popping the front value and pushing that value onto the stack
            while let poppedFromList = list.pop() {
                stack.push(poppedFromList)
            }
            
            // Iterate through the stack, printing the popped value
            while let poppedFromStack = stack.pop() {
                print(poppedFromStack)
            }
        }
        
//        reversePrint(list: &list)
        
        func theirReversePrint<T>(list: inout LinkedList<T>) {
            var stack = Stack<T>()
            
            var current = list.head
            
            while let _current = current {
                stack.push(_current.value)
                current = current?.next
            }
            
            while let popped = stack.pop() {
                print("\(popped)")
            }
        }
        
        theirReversePrint(list: &list)
    }
    
    enum ParenthesisState: Int {
        case countIncreasing
        case countDecreasing
    }
    
    static func challenge2() {
        
        // My solution
        func isBalanced(_ input: String) -> Bool {
            // Iterate through the input string and push parenthesis into a stack
            var stack = Stack<Int>()
            for char in input {
                if char == "(" {
                    stack.push(-1)
                } else if char == ")" {
                    stack.push(1)
                }
            }
            
            // We'll start from the end of the string checking the parenthesis since they have to reflect properly to be balanced. i.e. if an array is balanced in one direction, then the reversed array is also balanced
            
            // Start in a state of count increasing and a count of zero
            var state = ParenthesisState.countIncreasing
            var count = 0
            
            // Loop through the stack
            while let increment = stack.pop() {
                if (state == .countIncreasing && count == 0 && increment == -1) ||
                    (state == .countDecreasing && count > 0 && increment == 1) {
                    return false
                }
                
                if increment == 1 {
                    state = .countIncreasing
                } else if increment == -1 {
                    state = .countDecreasing
                }
                
                count += increment
            }
            
            // Otherwise, just make sure the count is zero at the end
            
            return count == 0
        }
        
        let testString1 = "h((e))llo(world)()"
        let testString2 = "(hello world"
        
        print("Test string 1 is \(isBalanced(testString1) ? "balanced" : "not balanced")")
        print("Test string 2 is \(isBalanced(testString2) ? "balanced" : "not balanced")")
        
        func theirIsBalanced(_ input: String) -> Bool {
            var stack = Stack<Character>()
            for char in input {
                if char == "(" {
                    stack.push(char)
                } else if char == ")" {
                    if stack.isEmpty {
                        return false
                    } else {
                        stack.pop()
                    }
                }
            }
            
            return stack.isEmpty
        }
        
        print("Test string 1 is \(isBalanced(testString1) ? "balanced" : "not balanced")")
        print("Test string 2 is \(isBalanced(testString2) ? "balanced" : "not balanced")")
    }
}
