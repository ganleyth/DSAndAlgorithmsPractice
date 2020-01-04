protocol BoardGameManager {
    associatedtype Player
    mutating func nextPlayer() -> Player?
}

struct MonopolyManager: BoardGameManager {
    typealias Player = String
    
    private var queue: QueueTKGRingBuffer<String>
    
    init(players: [String]) {
        queue = QueueTKGRingBuffer<String>(count: players.count)
        
        for player in players {
            queue.enqueue(player)
        }
    }
    
    mutating func nextPlayer() -> String? {
        guard let nextPlayer = queue.dequeue() else { return nil }
        queue.enqueue(nextPlayer)
        
        return nextPlayer
    }
}
