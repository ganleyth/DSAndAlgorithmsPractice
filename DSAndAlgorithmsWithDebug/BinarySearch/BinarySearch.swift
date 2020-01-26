extension RandomAccessCollection where Element: Comparable {
    
    func binarySearch(for element: Element) -> Index? {
        return binarySearch(for: element, inRange: startIndex..<endIndex)
    }
    
    private func binarySearch(for element: Element, inRange range: Range<Index>) -> Index? {
        guard range.lowerBound < range.upperBound else { return nil }
        
        let size = distance(from: range.lowerBound, to: range.upperBound)
        let middle = index(range.lowerBound, offsetBy: size / 2)
        
        if self[middle] == element {
            return middle
        } else if element > self[middle] {
            return binarySearch(for: element, inRange: index(after: middle)..<range.upperBound)
        } else {
            return binarySearch(for: element, inRange: range.lowerBound..<middle)
        }
    }
}
