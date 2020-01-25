class Trie<CollectionType: Collection & Hashable> where CollectionType.Element: Hashable {
    typealias Node = TrieNode<CollectionType.Element>
    let root = Node(key: nil, parent: nil)
    private(set) var collections: Set<CollectionType> = []
    
    var count: Int {
        return collections.count
    }
    
    var isEmpty: Bool {
        return count == 0
    }
    
    init() {}
    
    func insert(_ collection: CollectionType) {
        var current = root
        
        for element in collection {
            if current.children[element] == nil {
                current.children[element] = Node(key: element, parent: current)
            }
            current = current.children[element]!
        }
        
        if current.isTerminating {
            return
        } else {
            current.isTerminating = true
            collections.insert(collection)
        }
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

    func remove(_ collection: CollectionType) {
        var current = root
        for element in collection {
            guard let child = current.children[element] else {
                return
            }
            current = child
        }
        guard current.isTerminating else { return }

        current.isTerminating = false
        collections.remove(collection)
        while let parent = current.parent, current.children.isEmpty && !current.isTerminating {
            parent.children[current.key!] = nil
            current = parent
        }
    }
}

extension Trie where CollectionType: RangeReplaceableCollection {
    func collections(startingWith prefix: CollectionType) -> [CollectionType] {
        var current = root
        for element in prefix {
            guard let child = current.children[element] else { return [] }
            current = child
        }

        return collections(startingWith: prefix, after: current)
    }

    private func collections(startingWith prefix: CollectionType, after node: Node) -> [CollectionType] {
        var results: [CollectionType] = []

        if node.isTerminating {
            results.append(prefix)
        }

        for child in node.children.values {
            var prefix = prefix
            prefix.append(child.key!)
            results.append(contentsOf: collections(startingWith: prefix, after: child))
        }

        return results
    }
}

// My challenge 1 solution
extension Trie where CollectionType: RangeReplaceableCollection {
    
//    var allCollections: [CollectionType] {
//        // Starting with the root node, for every child, see if it's a terminating node and if so, add to the collections array
//        return fetchAllCollections(from: root, currentPrefix: "")
//    }
    
    func fetchAllCollections(from: Node?, currentPrefix: CollectionType) -> [CollectionType] {
        guard let from = from else { return [] }
        
        var result = [CollectionType]()
        
        var newPrefix = currentPrefix
        if let key = from.key {
            newPrefix.append(key)
        }
        
        if from.isTerminating {
            result.append(newPrefix)
        }
        
        // Recursively check the children of the from node to get their collections
        for child in from.children.values {
            result += fetchAllCollections(from: child, currentPrefix: newPrefix)
        }
        
        return result
    }
}
