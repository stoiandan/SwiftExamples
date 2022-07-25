import Foundation

struct Trie<T: Hashable> {
    private var root = Node<T>()
    
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
        var node = root
        for key in content {
            guard let next = node.children[key] else {
                return false
            }
            node = next
        }
        return true
    }
    
    public func hasContent(of word: some Collection<T>) -> Bool {
        return hasContentHelper(of: word, at: root)
        
        func hasContentHelper(of word: some Collection<T>, at root: Node<T>) -> Bool {
            if containsPrefix(of: word, at: root) {
                return  true
            }
            
            return root.children.values.contains { child in hasContentHelper(of: word, at: child) }
        }
    }
    
    func debugPrint() {
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
    
    private class Node<T: Hashable> {
        var children: [T : Node] = [:]
        
         func addChild(withKey key: T) -> Node {
            if let child =  children[key] {
                return child
            }
            let newChild = Node()
            children[key] = newChild
            return newChild
        }
    }
}

