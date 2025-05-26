import Foundation // for date


enum LibraryError: Error {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed

    // my errors 
    case duplicatedBook
}

protocol Borrowable {

    /// Optional Date for when the item was borrowed.
    var borrowDate: Date? { set get }

    /// Optional Date for when the item should be returned.
    var returnDate: Date? { set get }

    /// Boolean indicating if the item is currently borrowed.
    var isBorrowed: Bool { set get }

    /// handles item return processes, resetting dates and status.
    mutating func checkIn() -> Void

    mutating func borrow() -> Void
}


extension Borrowable {
    ///Method to check if the item is overdue based on returnDate.
    func isOverdue() -> Bool {
        // must be borrowed 
        guard let _ = borrowDate else {
            return false 
        }

        // must have return date
        guard let returnDate = returnDate else {
            return false
        }

        let currDate = Date()

        return currDate > returnDate
    }

    mutating func checkIn() -> Void {
        self.borrowDate = nil
        self.returnDate = nil
        self.isBorrowed = false
    }

    mutating func borrow() -> Void {
        self.isBorrowed = true
        self.borrowDate = Date()
        self.returnDate = Date().addingTimeInterval(60 * 60 * 24 * 7) // 7d  
    }
}


class Author {
    private let lastName: String
    private let firstName: String

    var fullName: String {
        return "\(firstName) \(lastName)"
    }

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

class Item {
    //generator for unique IDs
    private static var idGenerator: Int = 0
    static func getNewID() -> Int {
        idGenerator += 1
        return idGenerator
    }

    var ID: Int
    var title: String
    var author: Author

    init(title: String, author: Author) {
        self.ID = Item.getNewID()
        self.title = title
        self.author = author
    }

    var description: String {
        return "ID: \(ID) title: \(title) author: \(author.fullName)"
    }
}

class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool

    override init(title: String, author: Author) {
        self.isBorrowed = false
        super.init(title: title, author: author)
    }


    var state: String {
        return isBorrowed ? "Borrowed" : "Available"
    }
}

// for testing
class Movie: Item {
}


class Library {
    private var books: [Int: Item]

    init() {
        self.books = [:]
    }

    func addItem(_ item: Item) {
        self.books[item.ID] = item
    }

    func addBook(_ book: Book) throws {
        let hasBook = self.books.contains { (key: Int, _: Item) in
            return book.ID == key
        }

        guard !hasBook else {
            throw LibraryError.duplicatedBook
        }

        self.books[book.ID] = book
        print("Book has been assigned!")
    }


    func borrowItem(by id: Int) throws -> Item {
        guard let item = self.books[id] else {
            throw LibraryError.itemNotFound
        }

        guard var bookToBorrow = (item as? Borrowable) else {
            throw LibraryError.itemNotBorrowable
        }
        

        if bookToBorrow.isBorrowed {
            throw LibraryError.alreadyBorrowed
        }

        bookToBorrow.borrow()
        
        print("Book borrowed successfully!")
        return item
    }
}


let lib = Library()

let author = Author(firstName: "Lukasz", lastName: "Fabia")
let michel = Author(firstName: "Michel", lastName: "Houellebecq")

let goodBook = Book(title: "Extension du domaine de la lutte", author: michel)

let book = Book(title: "ABC", author: author)

let movie = Movie(title: "Rambo", author: author)// not borrowable

lib.addItem(movie)

do { 
    try lib.addBook(book)
} catch LibraryError.duplicatedBook {
    print("Book already exists in the library.")
} catch {
    print("Unknown: \(error)")
}

do {
    let item = try lib.borrowItem(by: book.ID) as! Book

    print(item.description)
    print(item.state)


    // let _ = try lib.borrowItem(by: movie.ID) 
    // let _ = try lib.borrowItem(by: book.ID)
    // let _ = try lib.borrowItem(by: goodBook.ID) 
} catch LibraryError.itemNotFound {
    print("Not found in the library.")
} catch LibraryError.itemNotBorrowable {
    print("Item is not borrowable.")
} catch LibraryError.alreadyBorrowed {
    print("Book is already borrowed.")
} catch {
    print("Unknown: \(error)")
}


