struct User {
    let username: String
    let password: String
    let email: String
}

class UserManager { 
    // storing username - user
    var users: [String: User]

    var userCount: Int {
        self.users.count
    }

    init() {
       self.users = Dictionary<String, User>(); 
    }

    deinit {
        print("Deinit manager")
    }

    func registerUser(username: String, email: String, password: String) -> Bool {
        let newUser = User(username: username, password: password, email: email)
        let existingUsers = self.users.filter { (key: String, value: User) in
            return key == username
        }

        guard existingUsers.count == 0 else {
            print("User with username: \(username) already exists")
            return false
        }

        // we can validate email

        self.users[username] = newUser
        print("User has been added successfully!")
        return true
    }

    func login(username: String, password: String) -> Bool {
        let existingUsers = self.users.filter { (key: String, value: User) in
            return key == username
        }

        let searchedUser = existingUsers.first
        if let u = searchedUser {
            let isValidPassword =  u.value.password == password

            if (isValidPassword) {
                print("Welcome, \(username)!")
            } else {
                print("Password or login are incorrect!")
            }

            return u.value.password == password
        } 

        print("Don't have an account? Create one!")
        return false 
    }

    func removeUser(username: String) -> Bool {
        let removed = self.users.removeValue(forKey: username)
        return removed != nil
    }
}


class AdminUser: UserManager {
    func listAllUsers() -> [String] {
        return self.users.map { (username: String, value: User) in
            return username
        }
    }

    deinit {
        print("Admin says Bye!")
    }
}

var managerToRemove: AdminUser? = AdminUser()
managerToRemove = nil

let manager: AdminUser = AdminUser()

let res = manager.registerUser(username: "Lukasz", email: "lukaszfabia@interia.pl", password: "secret123")
print(res)

let dup = manager.registerUser(username: "Lukasz", email: "lukaszfabia@interia.p1l", password: "secret123")
print(dup)

let res1 = manager.login(username: "Lukasz", password: "secret123")

print(res1)
let notAuth = manager.login(username: "Luk1asz", password: "secret")
print(notAuth)


print(manager.userCount)

print(manager.listAllUsers())

print(manager.removeUser(username: "Lukasz"))

print(manager.userCount)

print(manager.listAllUsers())

// deinit: from leaf -> root 