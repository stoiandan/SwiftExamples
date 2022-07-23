import Foundation

// This example demonstrates how, often in the standanrd library, some types can get
// automatic conformance to differnet Protocols (like a type that implements IteratorProtocol can automatically conform to Sequenece (still need to explictily write 'Type : Sequence') without any other aditional code )
// This is done by implementing a default implementation

// Nameable represents a type that can be named, that has a name
protocol Nameable {
    var name: String { get }
}


// Greetable represents a type that knows how to be greeted
protocol Greetable {
    func greet()
}


// Person is Nameable, has a name
struct Person: Nameable {
    let name: String
}

// We can now tell the compiler to attach a default behaviour
// for every type that is Nameable and also wished to be Greetable

// Because we know that the the type conforming to Greetable (Self, notice the capital S) is itself Nameble
// we can make use of any behaviour defined in the Nameable protocol.
// This means we can use name, since name is defined in Nameable
extension Greetable where Self: Nameable {
    // greet is now a default implementation for Nameable types that also wish to be Greetable
    func greet() {
        print("Hello \(self.name)!")
    }
}

// now all we need to do is to explictily say that Person also wished to be Greetable, and that's it!
extension Person: Greetable {
    
}

// example
let mike = Person(name: "Mike")

//Hello Mike!
mike.greet()
