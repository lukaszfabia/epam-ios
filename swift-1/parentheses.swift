// - Only parentheses () are considered; other brackets or characters should be ignored.
// - The input string might contain multiple lines.
// - For example, "(())" is balanced, but "(()" is not.


// (()) -> balanced
// ()()
// (())(((())))
// )( -> nie jest valid

public func isBalancedParentheses(input: String) -> Bool {
    // Only parentheses ()
    let cleanInput = input.filter { c in
        return c == "(" || c == ")"
    }

    // every '(' must be close by ')', len of str must be even
    if cleanInput.count % 2 != 0 {
        return false
    }

    var stack: [String.Element] = []

    for char in cleanInput  {
        // we track only opening
        if char == "(" {
            stack.append(char)
        } 
        // if is closing
        // then we should have last opening
        else if stack.last == "(" {
            _=stack.popLast()
        }
        // [(,(] ->
        else {
            return false
        }
    }
    
    return stack.count == 0 // stack must be empty
}

assert(!isBalancedParentheses(input: "(()"))
assert(isBalancedParentheses(input: "()()"))
assert(!isBalancedParentheses(input: "())("))
assert(!isBalancedParentheses(input: ")("))
assert(!isBalancedParentheses(input: "2+2*(5+2))"))
assert(isBalancedParentheses(input: "((()))"))
assert(!isBalancedParentheses(input: "((()))))"))

let bigstr = """
(((())))(((()))))))())(
"""
assert(!isBalancedParentheses(input: bigstr))


