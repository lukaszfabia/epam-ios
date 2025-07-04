// 1. Assume you have an array of dictionaries. Each dictionary contains details about books (title, author, year, price, and genre). Use this:

// 2. Define new global variable of type Array<Double> named`discountedPrices` that will include just the prices of the above books with a 10% discount applied. Use `map`/`compactMap` to solve this.

// 3. Define new global variable of type Array<String> named `booksPostedAfter2000` that will include book titles of the books published after the year 2000. Use `filter` to solve this.

// 4. Define new global variable of type Set<String> named `allGenres` that will include all the genres available in the books. Use `flatMap` to solve this.

// 5. Define new global variable of type Int named `totalCost` to find out how much it would cost to purchase one instance of each book. Use `reduce`.

let books: [[String: Any]] = [

    [
        "title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40,
        "genre": ["Programming", "Education"],
    ],

    [
        "title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15,
        "genre": ["Classic", "Drama"],
    ],

    [
        "title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30,
        "genre": ["Fantasy", "Epic"],
    ],

    [
        "title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25,
        "genre": ["Technology", "Non-Fiction"],
    ],

    [
        "title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20,
        "genre": ["Classic", "Drama"],
    ],
    [ // try to crash 1 subtask
        "title": "custom book", "author": "run time crush", "year": 2025,
        "genre": ["Classic", "Drama"],
    ],
    [ // try to crash 2 subtask
        "title": "custom book", "author": "run time crush",
        "genre": ["Classic", "Drama"],
    ],    
    [ // try to crash 2 subtask
        "author": "run time crush", "year": 2025, "price": 20,
        "genre": ["Classic", "Drama"],
    ],
    [ // try to crash 3, 4 subtask
        "author": "", "year": 2025,
    ],
]

let discount = 0.1
let beforeYear = 2000
let defaultTitle = "No title"

let discountedPrices = books.compactMap { elen in
    if let price = elen["price"] as? Int {
        return Double(price) * (1 - discount)
    }
    return nil
}

print(discountedPrices)

let booksPostedAfter2000: [String] =
    books
    .filter { elem in
        if let year = elem["year"] as? Int {
            return year > beforeYear
        }
        return false
    }
    .map { elem in
        return elem["title"] as? String ?? defaultTitle
    }

print(booksPostedAfter2000)

let allGenres: Set<String> = Set(books.flatMap { elem in
    return elem["genre"] as? [String] ?? [] 
})
print(allGenres)

let totalCost = books.reduce(0, { acc, curr in (curr["price"] as? Int ?? 0) + acc })
print(totalCost)
