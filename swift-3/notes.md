**Optionals**
What are optionals? - nilable types
How do you define an optional variable? - with "?"
What are the ways to unwrap an optional? - use guard, if with let
How does optional chaining work and why is it beneficial? - if we call optional prop, subscript, with out getting an error
What is the difference between optional binding and forced unwrapping? - the main diff is that to force unwrap we use only ! and we cant controll errors and optional binding uses if, guard statements or event switch case

Can you do multiple optional bindings in a single line? If so, how? - yeah, we can just use comma to unwrap next props

```swift
if let a = obj.a, b = obj.b {
    ///code
} else {
    /// code
}

```

What is implicitly unwrapped optional? - it is an optional that is defined with "!" and it is used when we are sure that the value will be set before we use it, so we can use it without unwrapping

What should you be cautious of when using forced unwrapping? - we should be cautious that if the value is nil, it will cause a runtime error and crash the app

**Extensions**
What is extension and what benefits does it provide? - they can extend implementation of class or struct, we can use it to provide def impl of protocol

How do you define an extension? - with extension keyword and provide class that you want to extend

What can be added to a type using an extension? Can we add stored properties? - we can add computed properties, methods, initializers, subscripts, and nested types, but we cannot add stored properties

How do protocol extensions differ from regular extensions? - usage of extension in protocols is mainly to provide default impl

Can extensions declare an entity with a higher access level than the type itself? - no, we cannot declare an entity with a higher access level than the type itself

Can you override methods of a class in its extension? - no, we cannot override methods of a class in its extension, we can only add new methods or properties

Can we add something to types we don't own? - yes, we can add something to types we don't own, but we cannot add stored properties, we can only add computed properties, methods, initializers, subscripts, and nested types

Protocols
What is a protocol? How do you define a protocol? Benefits of using it? - protocol is like a interface in other langs, the provide strict contract it means, when class implements the protocol it has every method in class, to define use protocol keyword and then provide methods, benefits? for example we can easliy create mock classes during testing, switch the impl in diff situations when we inject somewhere, fun fact there is pattern that uses empty protocol as a tag

What can we declare in the protocol and how? -

```swift
protocol IProtocol {
    getByID(id: Int) -> Person
    ///....
}
```

Can protocol inherit another protocol? yes

Can structures, classes, and enumerations conform to protocols? yes

How many protocols can type implement? as many as you want to

Can protocols have a default implementation? yea using extension

What are associated types? - use them as a placeholder, when you dont have class yet

```swift
protocol Test {
    associatedtype Person
    var name: Person { get set }

    func test() -> Void
}


struct TestStruct: Test {
    typealias Person = String
    var name: String

    func test() {
        print("Testing with name: \(name)")
    }
}
```

**Error handling**
How do you typically handle errors in iOS apps? - with do catch statement

Why is error handling important? - easy to debug, avoiding runtime erorrs

What is a do-catch statement? - used to catch errors

What does the 'throws' keyword do? - means that function can throw an error

What is the Result type and how is it used? - used to represent a value that can be either success or failure, it has two cases: success and failure more elegant way to handle errors.

Type casting

Can you explain the difference between 'as', 'as?', and 'as!'?
as - upcasting
as? - optional downcasting
as! - forced downcasting

What is the purpose of the 'is' keyword? - it is used to check if an object is of a certain type instanceof from java?
What should you be cautious of when using force casting ('as!')? - you should be cautious that if the object is not of the type you are casting to, it will cause a runtime error and crash the app

Why is type casting important when working with different data types? - it allows us to work with different data types and convert them to the type we need, it is important when we work with protocols, generics, and inheritance

**Nested types**

What are nested types and its benefits? code is more organized and modular, it allows us to group related types together, making the code more readable and maintainable.

How do you declare a nested type within a class or structure? just define class in a class, struct, or enum

How do you access a nested type within its enclosing type in Swift? from outside? - dot notation its like accessing to static prop in class exmaple `SomeClass.SomeNestedType`

Can nested types be extended, and if so, how? - yes, we can extend nested types just like we extend regular types, we use extension keyword and provide the nested type name

Subscripts
What are subscripts and what are the benefits of its usage? define a shortcut to access elements in a colletion in class

How can you define a subscript? with subscript keyword and provide parameters and return type

What types of parameters can subscripts accept? Can they take multiple parameters? - subscripts can accept any type of parameters, including multiple parameters, but they must be defined with a single parameter list

Can subscripts return multiple values? - it returns only one value, but its any value

Higher order functions
What are the advantages of using higher-order functions? - allow you to avoid loops or boilerplate code, they are more stable

What is the map function and what does it do? we can transform each elem in collection

Explain the difference between flatMap and compactMap. - flat map is used to remove sub-collections in colletion and reduces it into flatten list, compactMap acts like a map but removes nil values from the result

How can you use reduce to aggregate array elements into a single computed result? - we must define start value and then in a closure we must define accumulator and curr value, last thing we must define operation that will reduce the array elements into a single value

Functions filter(_:), contains(where:), forEach(_:), sort(by:), first(where:), last(where:)

- filter(\_:): returns a new array containing elements that satisfy the given predicate.
- contains(where:): checks if any element in the collection satisfies the given predicate.
- forEach(\_:): executes a closure for each element in the collection.
- sort(by:): sorts the elements of the collection based on the provided closure.
- first(where:): returns the first element that satisfies the given predicate, or nil if no such element exists.
- last(where:): returns the last element that satisfies the given predicate, or nil if no such element exists.
