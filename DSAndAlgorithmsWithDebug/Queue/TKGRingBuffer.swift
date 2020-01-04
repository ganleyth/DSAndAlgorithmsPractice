struct TKGRingBuffer<T> {
    private var array: [T?]
    private var readIndex = 0
    private var writeIndex = 0
    
    init(count: Int) {
        array = Array<T?>(repeating: nil, count: count)
    }
    
    var spaceReservedForReading: Int {
        return writeIndex - readIndex
    }
    
    var isEmpty: Bool {
        return spaceReservedForReading == 0
    }
    
    var spaceAvailableForWriting: Int {
        return array.count - spaceReservedForReading
    }
    
    var isFull: Bool {
        return spaceAvailableForWriting == 0
    }
    
    var first: T? {
        return isEmpty ? nil : array[readIndex % array.count]
    }
    
    mutating func write(_ element: T) -> Bool {
        guard !isFull else { return false }
        
        array[writeIndex % array.count] = element
        writeIndex += 1
        return true
    }
    
    mutating func read() -> T? {
        guard !isEmpty else { return nil }
        
        let element = array[readIndex % array.count]
        readIndex += 1
        return element
    }
}

extension TKGRingBuffer: CustomStringConvertible {
    var description: String {
        return String(describing: array)
    }
}
