func bubbleSort<Element>(_ array: inout [Element]) where Element: Comparable {
    guard array.count >= 2 else {
        return
    }

    for end in (1..<array.count).reversed() {
        var swapped = false

        for current in 0..<end {
            if array[current] > array[current + 1] {
                array.swapAt(current, current + 1)
                swapped = true
            }
        }

        if !swapped {
            return
        }
    }
}

func bubbleSort2<T>(_ collection: inout T) where T: MutableCollection, T.Element: Comparable {
    guard collection.count >= 2 else { return }
    
    for end in collection.indices.reversed() {
        var swapped = false
        var current = collection.startIndex
        
        while current < end {
            let next = collection.index(after: current)
            if collection[current] > collection[next] {
                collection.swapAt(current, next)
                swapped = true
            }
            current = next
        }
        
        if !swapped {
            return
        }
    }
}

func selectionSort<Element>(_ array: inout [Element]) where Element: Comparable {
    guard array.count >= 2 else {
        return
    }
    
    for current in 0..<(array.count - 1) {
        var lowest = current
        
        for other in (current + 1)..<array.count {
            if array[lowest] > array[other] {
                lowest = other
            }
        }
        
        if lowest != current {
            array.swapAt(lowest, current)
        }
    }
}

func selectionSort2<T>(_ collection: inout T) where T: BidirectionalCollection & MutableCollection, T.Element: Comparable {
    guard collection.count >= 2 else { return }

    for current in collection.indices {
        var lowest = current
        var other = collection.index(after: current)
        while other < collection.endIndex {
            if collection[lowest] > collection[other] {
                lowest = other
            }
            other = collection.index(after: other)
        }
        if lowest != current {
            collection.swapAt(lowest, current)
        }
    }
}

func insertionSort<Element>(_ array: inout [Element]) where Element: Comparable {
    guard array.count >= 2 else { return }
    
    for current in 1..<array.count {
        for shifting in (1...current).reversed() {
            if array[shifting] < array[shifting - 1] {
                array.swapAt(shifting, shifting - 1)
            } else {
                break
            }
        }
    }
}

func insertionSort2<T>(_ collection: inout T) where T: MutableCollection & BidirectionalCollection, T.Element: Comparable {

    guard collection.count >= 2 else { return }

    var current = collection.index(after: collection.startIndex)
    while current < collection.endIndex {
        var other = collection.index(before: current)
        while other > collection.startIndex, collection[other] > collection[current] {
            other = collection.index(before: other)
        }

        collection.swapAt(current, collection.index(after: other))

        current = collection.index(after: current)
    }
}
