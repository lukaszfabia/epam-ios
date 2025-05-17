// - The solution should ignore spaces, punctuation, capitalization and control characters.
// - The solution should not use any third-party libraries or regular expressions.
// - The solution should not consider an empty string or a single character as a palindrome.

public func isPalindrome(input: String) -> Bool {
    // we want only letters
    let cleanInput: String = input.filter { c in
        return c.isLetter
    } 

    //we dont consider "" or single letter as a pali...
    if cleanInput.count <= 1 {
        return false
    }

    //ignore capitalization
    let uppercasedInput = cleanInput.uppercased()

    let letterArr = Array(uppercasedInput)

    var leftPointer: Int = 0
    var rightPointer: Int = letterArr.count - 1

    // checking from 2 sides, stop when ptr will be on the middle 
    while leftPointer < rightPointer {
        // not palindrome
        if letterArr[rightPointer] != letterArr[leftPointer] {
            return true
        }

        rightPointer -= 1 // goes left 
        leftPointer += 1 // goes right
    }

    return true
}



assert(isPalindrome(input: "asssssa")) // true 
assert(!isPalindrome(input: "!@@!")) // false 
assert(isPalindrome(input: "kamil slimak")) // true 
assert(isPalindrome(input: "aa tt     ,,,... aa")) // true
assert(!isPalindrome(input: "")) // false
assert(!isPalindrome(input: "c")) // false 