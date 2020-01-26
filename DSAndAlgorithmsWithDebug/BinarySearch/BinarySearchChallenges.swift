class BinarySearchChallenges {
    
    static func challenge1() {
        
        func binarySearch<Elements: RandomAccessCollection>(for element: Elements.Element, in collection: Elements, in range: Range<Elements.Index>? = nil) -> Elements.Index? where Elements.Element: Comparable {
            
            let range = range ?? collection.startIndex..<collection.endIndex
            guard range.lowerBound < range.upperBound else { return nil }
            
            let size = collection.distance(from: range.lowerBound, to: range.upperBound)
            let middle = collection.index(range.lowerBound, offsetBy: size / 2)
            
            if collection[middle] == element {
                return middle
            } else if element > collection[middle] {
                return binarySearch(for: element, in: collection, in: collection.index(after: middle)..<range.upperBound)
            } else {
                return binarySearch(for: element, in: collection, in: range.lowerBound..<middle)
            }
        }
    }
    
    static func challenge2() {
        
        func findRange<Elements: RandomAccessCollection>(of element: Elements.Element, in collection: Elements, in range: Range<Elements.Index>? = nil) -> Range<Elements.Index>? where Elements.Element: Comparable {
            
            let range = range ?? collection.startIndex..<collection.endIndex
            guard range.lowerBound < range.upperBound else { return nil }
            
            let size = collection.distance(from: range.lowerBound, to: range.upperBound)
            
            let middleIndex = collection.index(range.lowerBound, offsetBy: size/2)
            
            if collection[middleIndex] == element {
                var lowerBound = middleIndex
                var upperBound = middleIndex
                
                while collection[lowerBound] == element && lowerBound > collection.startIndex {
                    let testLowerBound = collection.index(before: lowerBound)
                    if collection[testLowerBound] == element {
                        lowerBound = testLowerBound
                    } else {
                        break
                    }
                }
                
                while collection[upperBound] == element && upperBound < collection.index(before: collection.endIndex) {
                    let testUpperBound = collection.index(after: upperBound)
                    if collection[testUpperBound] == element {
                        upperBound = testUpperBound
                    } else {
                        break
                    }
                }
                
                return lowerBound..<collection.index(after: upperBound)
            } else if element < collection[middleIndex] {
                return findRange(of: element, in: collection, in: range.lowerBound..<middleIndex)
            } else {
                return findRange(of: element, in: collection, in: collection.index(after: middleIndex)..<range.upperBound)
            }
        }
        
        let array = [1, 2, 2, 3, 3, 3, 4, 4, 5, 5]
        print(findRange(of: 3, in: array))
    }
}
