class TrieChallenges {
    
    static func playground() {
        let trie = Trie<String>()
        trie.insert("cute")
        trie.insert("cut")

//        print("\n*** Before removing ***")
//        assert(trie.contains("cut"))
//        print("cut is in the trie")
//        assert(trie.contains("cute"))
//        print("cute is in the trie")
//
//        print("\n*** After removing cut ***")
//        trie.remove("cut")
//        assert(!trie.contains("cut"))
//        assert(trie.contains("cute"))
        print("cute is still in the trie")
        
        print(trie.fetchAllCollections(from: trie.root, currentPrefix: ""))
    }
}
