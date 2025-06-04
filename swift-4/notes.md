Questions for Self-Control
Generics
What are generics in Swift and why are they useful?
How do you define a generic function in Swift?
Can you create a generic class or struct in Swift? How would you declare it?
What are type constraints in generics? How do you use them?
How do you apply generics with collections like Array or Dictionary?
What is the difference between Any and AnyObject in the context of generics?
How does Swift’s associatedtype relate to generics and protocols?
Can generics be used with protocols? If so, how?
What are some real-world use cases where generics are especially beneficial?

Opaque and Boxed Protocol Types
What are opaque types in Swift? How are they declared?
How do opaque types differ from generics?
What does the some keyword represent in Swift?
What is a boxed type?
How do you work with boxed protocol types in Swift?
When would you use an opaque return type instead of a generic return type?
What are the benefits of using opaque types for abstraction?
How do you handle type erasure when working with boxed types?
Can you create your own custom opaque or boxed type in Swift? If so, how?

Automatic Reference Counting (ARC)
What is Automatic Reference Counting (ARC) in Swift? How does it work?
What is the difference between strong, weak, and unowned references?
How does ARC manage memory and prevent memory leaks?
What is a strong reference cycle (retain cycle), and how do you avoid it?
How do weak and unowned references differ in terms of memory management?
What happens when an object is deallocated in ARC?
How does ARC handle closures? How can it lead to memory cycles?
How do you break a retain cycle in closures?
What are some real-world scenarios where understanding ARC is crucial in iOS development?

Memory Safety
What is memory safety in Swift and why is it important?
How does Swift ensure memory safety at compile time?
What is the rule of exclusive access to memory and how does it prevent unsafe memory access?
What happens if a variable is accessed simultaneously for reading and writing?
How does Swift handle inout parameters in terms of memory safety?
What is the difference between private and fileprivate memory access?
Can you access the same variable in two different places in your code at the same time?
What are UnsafePointer and related types, and when should you use them?
How can you work with pointers and unsafe code in Swift safely?
Why is memory safety particularly important in mobile applications?

Access Control
What are access control levels in Swift?
What is the default access level if none is specified?
How do you define the private, fileprivate, internal, public, and open access levels?
How does the public access level differ from the open access level?
Can you override methods of a public class in another module?
How do access control rules apply to extensions?
Can an extension declare a higher access level than the type itself?
Why should you use the private access level in your code?
When would you use fileprivate over private?
How does access control help in building modular and secure applications?
