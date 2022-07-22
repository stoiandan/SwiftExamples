import Foundation

struct InfiniteSequence: Sequence, IteratorProtocol {
    var from: Int
    
    mutating func next() -> Int? {
        // check for overflow
        guard from < Int.max else {  return nil    }
        
        // defer blocks always gets called, after the function finishes executin 
        defer { from += 1 }
        return from
    }
}

var from10 = InfiniteSequence(from: 10)

for num in from10 {
    print(num) // prints 10,11,12...
}

var from12 = InfiniteSequence(from: 12)

for num in from12 {
    print(num) // prints 12,13,14...
}
