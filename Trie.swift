import Foundation

struct Node<T: Hashable> {
    var children: [T : Node<T>] = [:]
    
    var isLeaf: Bool {
        children.isEmpty
    }
    
    mutating func addChild(withKey key: T) {
        guard children[key] == nil else {  return   }
        children[key] = Node()
    }
    
    func hasChild(withKey key: T) -> Bool {
        children[key] != nil
    }
}

struct Trie<T: Hashable> {
    public var root = Node<T>()
    
    mutating func addContent(of content: some Collection<T>) {
       var iter = content.makeIterator()
       addCotentHelper(&root, &iter)
        
        func addCotentHelper(_ node: inout Node<T>, _ iter: inout some IteratorProtocol<T>) {
            guard let key = iter.next() else { return }
            node.addChild(withKey: key)
            addCotentHelper(&node.children[key]!, &iter)
        }
    }
    
   

    private func containsPrefix(of content: some Collection<T>, at root: Node<T>) -> Bool {
        guard let first = content.first else { return true }
        
        if root.hasChild(withKey: first) {
            return containsPrefix(of: content.dropFirst(), at: root.children[first]!)
        }
        return false
    }
    
    public func hasContent(of word: some Collection<T>) -> Bool {
        return hasContentHelper(of: word, at: root)
        
        func hasContentHelper(of word: some Collection<T>, at root: Node<T>) -> Bool {
            guard !word.isEmpty else { return true }
            
            guard root.isLeaf == false else {
                return false
            }
            
            if containsPrefix(of: word, at: root) {
                return  true
            }
            
            return root.children.values.contains(where: { child in hasContentHelper(of: word, at: child) })
        }
    }
    
    func printTrie() {
        printTrieHelper(node: root, indent: 1)
        
        func printTrieHelper(node: Node<T>, indent: Int) {
            let leading_indent = "| "
            let last_indent = "|-"
            for (k, v) in node.children {
                print(
                    String(
                        repeating: leading_indent,
                        count: indent - 1) + last_indent,
                    terminator: "")
                print(k, terminator: "\n")
                printTrieHelper(node: v, indent: indent + 1)
            }
        }
    }
}
