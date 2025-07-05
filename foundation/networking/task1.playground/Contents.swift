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

func printEmails(from url: String = "https://jsonplaceholder.typicode.com/users") {
    guard let url = URL(string: url) else {return}
    
    var request = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: request) {data, response, error in
        if let err = error {
            print("An error occured during requesting data: ", err.localizedDescription)
        }
        
        guard let data = data else {return}
    
        
        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            print(users.map{$0.email})
        } catch let err {
            print("An error occured during parsing: ", err)
        }
    }
    
    task.resume()
}

printEmails()
