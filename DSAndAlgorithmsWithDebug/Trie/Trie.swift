class Trie<CollectionType: Collection> where CollectionType.Element: Hashable {
    typealias Node = TrieNode<CollectionType.Element>
    private let root = Node(key: nil, parent: nil)
    init() {}
    
    func insert(_ collection: CollectionType) {
        var current = root
        
        for element in collection {
            if current.children[element] == nil {
                current.children[element] = Node(key: element, parent: current)
            }
            current = current.children[element]!
        }
        
        current.isTerminating = true
    }
    
    func contains(_ collection: CollectionType) -> Bool {
        var current = root
        
        for element in collection {
            if let node = current.children[element] {
                current = node
            } else {
                return false
            }
        }
        
        return current.isTerminating
    }
}
