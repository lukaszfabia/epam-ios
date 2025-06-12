import Foundation // for date


enum LibraryError: Error {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed

    case bookAlreadyAdded
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

        let currentDate = Date()

        return currentDate > returnDate
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


class Item {
    let id: String
    let title: String
    let author: String

    init(id: String, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
    }

    var description: String {
        return "ID: \(id) title: \(title) author: \(author)"
    }
}

class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool

    override init(id: String, title: String, author: String) {
        self.isBorrowed = false
        super.init(id: id, title: title, author: author)
    }


    var state: String {
        return isBorrowed ? "Borrowed" : "Available"
    }
}

// for testing
class Movie: Item {
}


class Library {
    private var items: [String: Item] = [:]

    func addItem(_ item: Item) {
        items[item.id] = item
    }

    func addBook(_ book: Book) throws {
        let hasBook = items.contains { (id: String, _: Item) in
            return book.id == id
        }

        guard !hasBook else {
            throw LibraryError.bookAlreadyAdded
        }

        items[book.id] = book
        print("Book has been assigned!")
    }


    func borrowItem(by id: String) throws -> Item {
        guard let item = items[id] else {
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


let goodBook = Book(id:"jhsdgfjhsdfsd" ,title: "Extension du domaine de la lutte", author: "Michel Houellebecq")

let book = Book(id: "ksgdfddfsd" ,title: "ABC", author: "Lukasz Fabia")

let movie = Movie(id: "ksgdfsd" ,title: "Rambo", author: "Lukasz Fabia")// not borrowable

lib.addItem(movie)

do {
    try lib.addBook(book)
} catch LibraryError.bookAlreadyAdded {
    print("Book already exists in the library.")
} catch {
    print("Unknown error: \(error)")
}

do {
    let item = try lib.borrowItem(by: book.id) as! Book

    print(item.description)
    print(item.state)


    // let _ = try lib.borrowItem(by: movie.id) 
    // let _ = try lib.borrowItem(by: book.id)
    let _ = try lib.borrowItem(by: goodBook.id) 
} catch LibraryError.itemNotFound {
    print("Not found in the library.")
} catch LibraryError.itemNotBorrowable {
    print("Item is not borrowable.")
} catch LibraryError.alreadyBorrowed {
    print("Book is already borrowed.")
} catch {
    print("Unknown: \(error)")
}

