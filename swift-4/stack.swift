class Stack<T> {

    private class Node {
        var value: T
        var next: Node?

        init(value: T) {
            self.value = value
            self.next = nil
        }
    }

    private var currentFirst: Node?

    init(_ elements: [T]? = nil) {
        if let arr = elements {
            self.pushAll(arr)
        } else {
            self.currentFirst = nil
        }
    }

    /// Assign new node to stack
    /// - Parameter node: node to insert
    private func assignNewNode(_ node: Node) {
        node.next = currentFirst
        currentFirst = node
    }

    /// Puts new element on the stack
    /// - Parameter element: value to put
    func push(_ element: T) {
        let newNode = Node(value: element)
        assignNewNode(newNode)
    }

    /// Removes value from stack's top
    /// - Returns: Popped value or nil if stack is empty
    func pop() -> T? {
        guard let last = currentFirst else {
            return nil
        }

        currentFirst = last.next

        return last.value
    }

    /// Iterate over the stack easier
    /// - Parameter fn: function to execute
    private func forEachInStack(fn: (_ node: Node) -> Void) {
        var ptrNode = currentFirst

        while ptrNode != nil {
            if let n = ptrNode {
                fn(n)
                ptrNode = n.next
            }
        }
    }

    /// Get amount of elements in stack
    /// - Returns: stack's size
    func size() -> Int {
        var count = 0

        forEachInStack { _ in
            count += 1
        }

        return count
    }

    /// Prints stack contents from top to end
    func printStackContents() {
        forEachInStack { node in
            print(node.value)
        }
    }

    /// Pushes all elements of list in the stack
    /// - Parameter elements: list with elements
    func pushAll(_ elements: [T]) {
        elements.forEach { element in
            assignNewNode(Node(value: element))
        }
    }
}

let s = Stack<Int>()

if s.pop() == nil {
    print("WE WANT THIS WE NEED THIS")
}

s.push(34)

assert(s.size() == 1)

s.printStackContents()

_ = s.pop()
assert(s.size() == 0)
