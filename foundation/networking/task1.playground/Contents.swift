import UIKit
import Foundation

struct User: Codable {
    struct Address: Codable {
        struct Geo: Codable {
            let lat : String
            let lng : String
        }
        //        address    { street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough", … }
        
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo : Geo
    }
    
    struct Company: Codable {
        let name : String
        let catchPhrase: String
        let bs : String
    }
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

enum EmailErrors: Error {
    case failedToParse
    case networkError
    case unknown
    case invalidURL
    case noDataInPayload
    case clientError
}

func fetchEmails(from url: String = "https://jsonplaceholder.typicode.com/users") async throws -> [String] {
    guard let url = URL(string: url) else {
        throw EmailErrors.invalidURL
    }

    let request = URLRequest(url: url)

    do {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let res = response as? HTTPURLResponse else {
            throw EmailErrors.unknown
        }

        guard (200..<300).contains(res.statusCode) else {
            throw EmailErrors.clientError
        }

        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            return users.map { $0.email }
        } catch {
            throw EmailErrors.failedToParse
        }

    } catch is URLError {
        throw EmailErrors.networkError
    } catch {
        throw EmailErrors.unknown
    }
}


Task {
    do {
        let emails = try await fetchEmails()
        print(emails)
    } catch {
        print(error.localizedDescription)
    }

}
