func add(lhs: Double, rhs: Double) -> Double {
    return lhs + rhs
}

func add(lhs: Int, rhs: Int) -> Int {
    return lhs + rhs
}


let x = 1
let y = 0.5

print(add(lhs: x, rhs: x))


var arr = [1,23,3,4,51]

let p = arr.sorted() {$0 < $1}

print(p)

let newarr = arr.map { elem in
    return elem * 2 - 1
}


print(newarr)