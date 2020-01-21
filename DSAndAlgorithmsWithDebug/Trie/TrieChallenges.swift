class TrieChallenges {
    
    static func playground() {
        let trie = Trie<String>()
        trie.insert("cute")
        if trie.contains("cute") {
            print("cute is in the trie")
        }
    }
}
