struct LinkedListChallenges {
    
    static func challenge1() {
        var challenge1List = LinkedList<Int>()
        for i in 1...5 {
            challenge1List.append(i)
        }

        //func printInReverse<T>(_ list: LinkedList<T>) {
        //    var nodes = [T]()
        //    var nextNode = list.head
        //    while nextNode != nil {
        //        nodes.append(nextNode!.value)
        //        nextNode = nextNode?.next
        //    }
        //
        //    while !nodes.isEmpty {
        //        let lastNode = nodes.popLast()!
        //        print(lastNode)
        //    }
        //}

        //printInReverse(challenge1List)

        // Their solution
        func printInReverse<T>(node: Node<T>?) {
            guard let node = node else { return }
            printInReverse(node: node.next)
            print(node.value)
        }

        func printInReverse<T>(list: LinkedList<T>) {
            printInReverse(node: list.head)
        }

        //printInReverse(challenge1List)
    }
    
    static func challenge2() {
        var challenge2List = LinkedList<Int>()
        for i in 1...4 {
            challenge2List.append(i)
        }

        // My solution - Runner technique
        func findMiddleNode<T>(of list: LinkedList<T>) -> Node<T>? {
            // Two iterators - 1 at 1x speed and 1 at 2x speed
            var singleSpeedPointerNode = list.head
            var doubleSpeedPointerNode = list.head
            
            // As iterating through, once the 2x speed iterator reaches the end,
            // the 1x speed iterator is pointing to the middle node
            while let nextDoubleSpeedPointerNode = doubleSpeedPointerNode?.next {
                singleSpeedPointerNode = singleSpeedPointerNode?.next
                doubleSpeedPointerNode = nextDoubleSpeedPointerNode.next
            }
            
            return singleSpeedPointerNode
        }

        //let middleNode = findMiddleNode(of: challenge2List)!
        //print(middleNode.value)

        // Their solution is equivalent
    }
    
    static func challenge3() {
        var challenge3List = LinkedList<Int>()
        for i in 1...3 {
            challenge3List.append(i)
        }
        
        print("Before: \(challenge3List)")
        challenge3List.reverse()
        print("After: \(challenge3List)")
    }
    
    static func challenge4() {
        let list1: LinkedList<Int> = {
            var list = LinkedList<Int>()
            list.push(5)
            list.push(3)
            list.push(1)
            return list
        }()
        
        let list2: LinkedList<Int> = {
            var list = LinkedList<Int>()
            list.push(6)
            list.push(4)
            list.push(2)
            return list
        }()
        
        // My solution. O(n) in time, which is to be expected, but it's also O(n) in memory
        func merge<T: Comparable>(list1: LinkedList<T>, list2: LinkedList<T>) -> LinkedList<T> {
            // Create a temp array
            // Create a temp list
            var tempArray = [Node<T>]()
            var tempList = LinkedList<T>()
            
            var keepGoing = true
            var list1Current = list1.head
            var list2Current = list2.head
            while keepGoing {
                // Compare the head values for each list and append the lowest to the temp array
                switch (list1Current, list2Current) {
                case let (.some(_list1Current), .some(_list2Current)):
                    if _list1Current.value <= _list2Current.value {
                        tempArray.append(_list1Current)
                        list1Current = _list1Current.next
                    } else {
                        tempArray.append(_list2Current)
                        list2Current = _list2Current.next
                    }
                // When only one list has values left, append those values to the array
                case (.some(let _list1Current), nil):
                    tempArray.append(_list1Current)
                    list1Current = _list1Current.next
                case (nil, .some(let _list2Current)):
                    tempArray.append(_list2Current)
                    list2Current = _list2Current.next
                case (nil, nil):
                    keepGoing = false
                }
            }
            
            // After going through the two lists, popLast on the array and push that value into a new list
            while let nextLesserValue = tempArray.popLast() {
                tempList.push(nextLesserValue.value)
            }
            
            return tempList
        }
        
        func pushGreaterValue<T: Comparable>(node1: Node<T>?, node2: Node<T>?, list: inout LinkedList<T>) {
            // Base case
            guard node1 != nil || node2 != nil else { return }
            
            // Recursion
            pushGreaterValue(node1: node1?.next, node2: node2?.next, list: &list)
            
            // Push into list
            switch (node1, node2) {
            case let (.some(_node1), .some(_node2)):
                if _node1.value >= _node2.value {
                    list.push(_node1.value)
                } else {
                    list.push(_node2.value)
                }
            case (.some(let _node1), nil):
                list.push(_node1.value)
            case (nil, .some(let _node2)):
                list.push(_node2.value)
            case (nil, nil):
                fatalError("Something's broken")
            }
        }
        
        func recursiveMerge<T: Comparable>(list1: LinkedList<T>, list2: LinkedList<T>) -> LinkedList<T> {
            guard let list1Head = list1.head else { return list2 }
            guard let list2Head = list2.head else { return list1 }
            
            var newList = LinkedList<T>()
            pushGreaterValue(node1: list1Head, node2: list2Head, list: &newList)
            
            return newList
        }
        
        print(recursiveMerge(list1: list1, list2: list2))
    }
}

// MARK: - Challenge 3

// My solution
//extension LinkedList {
//
//    mutating func reverse() {
//        guard let head = head else { return } // do nothing, it's empty
//
//        // pass in head to start the recursion
//        reverse(node: head)
//        head.next = nil
//        self.head = tail
//        tail = head
//    }
//
//    mutating private func reverse(node: Node<T>) {
//        // base case
//        guard let next = node.next else { return }
//
//        // recursion
//        reverse(node: next)
//
//        // action
//        next.next = node
//    }
//}

// Their solution
extension LinkedList {
//    mutating func reverse() {
//        var tempList = LinkedList<T>()
//        for value in self {
//            tempList.push(value)
//        }
//        self.head = tempList.head
//    }
    
    mutating func reverse() {
        // Set tail to the old head
        tail = head
        
        // For each node, reference current and next. Set next.next to current
        // Create a next next reference to remember what node comes after the one i'm reversing
        var current = head
        var next = head?.next
        var nextNext = head?.next?.next
        
        while next != nil {
            next?.next = current
            current = next
            next = nextNext
            nextNext = next?.next
        }
        
        // For the head node, set next to nil
        head?.next = nil
        
        // Set head to the old tail
        head = current
    }
}
