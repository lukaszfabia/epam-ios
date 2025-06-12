1. Q: Diff betweent `let` and `var`?

A: `let` keyword tells about immutability of var and `var` keyword let to reassign to variable.

2. Q: Is it necessary to annotate type?

A: We don't need to write the type only if variable has a initial value, then swift compiler uses type interfernce in other way we get a compiler error. Good to know that compiler cant cast the var e.g x=1 y=.1 z=x+y (error) Int + Double.

3. Q: Array, Set, Dict usage and main diffs?

A:

- Array/List: is ordered data strucure, can has duplicated values

- Set: is unordered data strucure, can has unique values

- Dict: data structure which has a key-value, mostly used in json objects

4. Diff String and Char, strings mutability?

It depends from mutability modificator, if we have string declared with let and can't make str concat.
String is a phrase and chat is like a letter, string is like a [char]

5. while vs do-while (reaped while)

while chat cond as a first, do-while (users input) checks cond after instructions in body

6. Overloading?

cond: the same name of func, and various types

```swift
func add(lhs: Double, rhs: Double) -> Double {
    return lhs + rhs
}

func add(lhs: Int, rhs: Int) -> Int {
    return lhs + rhs
}
```
