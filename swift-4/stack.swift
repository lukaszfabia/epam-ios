class Stack<T> {

    enum StackErrors: Error {
        case stackIsEmpty
    }

    private class Node {
        var value: T
        var next: Node?

        init(value: T) {
            self.value = value
            self.next = nil
        }
    }

    private var currentFirst: Node?

    init() {
        self.currentFirst = nil
    }

    func push(_ element: T) {
        let newNode = Node(value: element)
        newNode.next = currentFirst
        currentFirst = newNode
    }

    func pop() throws -> T {
        guard let last = currentFirst  else {
            throw StackErrors.stackIsEmpty
        } 

        currentFirst = last.next

        return last.value
    }

    private func forEachInStack(fn: (_ node: Node?) -> Void) {
        var ptrNode = currentFirst
        
        while ptrNode != nil {
            fn(ptrNode)
            ptrNode = ptrNode?.next
        }
    }

    func size() -> Int {
        var count = 0

        forEachInStack { _ in
            count += 1
        }

        return count
    }

    func printStackContents() -> Void {
        forEachInStack { node in 
            if let val = node?.value {
                print(val)
            }
        }
    }
}


let s = Stack<Int>()


s.push(5)

s.push(1211)

s.printStackContents()

do {
    let popped = try s.pop()
    assert(popped == 1211)
} catch  {
    print()
}

s.printStackContents()

do {
    _ = try s.pop()
    _ = try s.pop()

    assert(s.size() == 0)
    s.printStackContents()
} catch  {
    print("We want to get error")
}