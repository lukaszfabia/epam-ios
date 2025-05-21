// - Only parentheses () are considered; other brackets or characters should be ignored.
// - The input string might contain multiple lines.
// - For example, "(())" is balanced, but "(()" is not.

public func isBalancedParentheses(input: String) -> Bool {
    var stack: [String.Element] = []

    for char in input  {
        // live filtering
        if char == ")" || char == "(" {
            if char == "(" {
                stack.append(char)
            } 
            // if is closing
            // then we should have last opening
            else if stack.last == "(" {
                _=stack.popLast()
            }

            else {
                return false
            }
        }
    }
    
    return stack.isEmpty
}

assert(!isBalancedParentheses(input: ")()("))
assert(!isBalancedParentheses(input: "(()"))
assert(isBalancedParentheses(input: "()()"))
assert(isBalancedParentheses(input: "(()())"))
assert(!isBalancedParentheses(input: "())("))
assert(!isBalancedParentheses(input: ")("))
assert(!isBalancedParentheses(input: "2+2*(5+2))"))
assert(isBalancedParentheses(input: "((()))"))
assert(!isBalancedParentheses(input: "((()))))"))
assert(isBalancedParentheses(input: ""))
assert(!isBalancedParentheses(input: "(d)asa)"))
assert(!isBalancedParentheses(input: ")()("))
assert(!isBalancedParentheses(input: "(((as)asa(sas)asa(sa"))


let bigstr = """
(((())))(((()))))))())(
"""
assert(!isBalancedParentheses(input: bigstr))

let bigstr1 = """
(
    (
        (
        ()()(())
        )
    )
)
""" 
assert(isBalancedParentheses(input: bigstr1))

let weirdStr = """
(
)
(
)
(
)
"""
assert(isBalancedParentheses(input: weirdStr))



