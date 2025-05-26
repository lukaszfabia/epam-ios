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
        borrowDate = nil
        returnDate = nil
        isBorrowed = false
    }

    mutating func borrow() -> Void {
        isBorrowed = true
        borrowDate = Date()
        returnDate = Date().addingTimeInterval(60 * 60 * 24 * 7) // 7d  
    }
}


class Item {
    var ID: String
    var title: String
    var author: String

    init(newTitle: String, newAuthor: String) {
        ID = UUID().uuidString
        title = newTitle
        author = newAuthor
    }

    var description: String {
        return "ID: \(ID) title: \(title) author: \(author)"
    }
}

class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool

    override init(newTitle: String, newAuthor: String) {
        isBorrowed = false
        super.init(newTitle: newTitle, newAuthor: newAuthor)
    }


    var state: String {
        return isBorrowed ? "Borrowed" : "Available"
    }
}

// for testing
class Movie: Item {
}


class Library {
    private var books: [String: Item] = [:]

    func addItem(_ item: Item) {
        books[item.ID] = item
    }

    func addBook(_ book: Book) throws {
        let hasBook = books.contains { (key: String, _: Item) in
            return book.ID == key
        }

        guard !hasBook else {
            throw LibraryError.duplicatedBook
        }

        books[book.ID] = book
        print("Book has been assigned!")
    }


    func borrowItem(by id: String) throws -> Item {
        guard let item = books[id] else {
            throw LibraryError.itemNotFound
        }

        guard var bookToBorrow = (item as? Borrowable) else {
            throw LibraryError.itemNotBorrowable
        }
        
        // optional chaining but imo its not needed here
        if let isBorrowed = (books[id] as? Borrowable)?.isBorrowed, isBorrowed {
            throw LibraryError.alreadyBorrowed
        }

        // imo this is the better slt
        // if bookToBorrow.isBorrowed {
        //     throw LibraryError.alreadyBorrowed
        // }


        bookToBorrow.borrow()
        
        print("Book borrowed successfully!")
        return item
    }
}


let lib = Library()


let goodBook = Book(newTitle: "Extension du domaine de la lutte", newAuthor: "Michel Houellebecq")

let book = Book(newTitle: "ABC", newAuthor: "Lukasz Fabia")

let movie = Movie(newTitle: "Rambo", newAuthor: "Lukasz Fabia")// not borrowable

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

