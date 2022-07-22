import Foundation

struct InfiniteSequence: Sequence, IteratorProtocol {
    var from: Int
    
    mutating func next() -> Int? {
        defer { from += 1 }
        return from
    }
}

var from10 = InfiniteSequence(from: 10)

for num in from10 {
    print(num) // prints 10,11,12...
}

var from12 = InfiniteSequence(from: 12)

for num in from10 {
    print(num) // prints 12,13,14...
}
