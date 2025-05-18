class Person {
    static var minAgeForEnrollment: Int = 16

    var name: String 
    var age: Int

    var isAdult: Bool {
        return self.age >= 18
    }

    lazy var profileDescription: String = {
        print("thinking...")
        return "\(self.name) is \(self.age) years old."
    }()

    // designated init must init all values
    init(age: Int, name: String) {
        self.name = name
        self.age = age
    }

    init?(age: Int) {
        guard age >= Person.minAgeForEnrollment else {
            return nil
        }

        self.age = age
        self.name = "no name"
    }


    // maybe this is the better solution instead of creating 
    // 2 constructors
    // init?(name: String, age: Int) { 
    //     guard age >= 16 else {
    //         return nil
    //     }
        
    //     self.name = name
    //     self.age = age
    // }
}

class Student: Person {
    var studentID: String
    var major: String 
    // weak ref - without 'weak' you cant deallocate and type must be optional
    weak var advisor: Professor?

    static var studentCount: Int = 0

    var formattedID: String {
        return "ID: \(self.studentID)".uppercased()
    }

    required init(name: String, age: Int, major: String, studentID: String) {
        // firstly we need to assign subclass props then call super contructor
        self.major=major
        self.studentID=studentID

        super.init(age: age, name: name)

        Student.studentCount+=1
    }

    // copying constructor + optional advisor
    convenience init(student: Student, advisor: Professor?) {
        print("Copying...")
        self.init(name: student.name, age: student.age, major: student.major, studentID: student.studentID)
        self.advisor = advisor
    }
}

class Professor: Person {
    var faculty: String
    static var professorCount: Int = 0

    var fullTitle: String {
        return "Title: \(name), \(faculty)"
    }

    init(faculty: String, age: Int, name: String) {
        self.faculty = faculty
        super.init(age: age, name: name)

        Professor.professorCount+=1
    }

    deinit {
        print("Died of old :(")
        Professor.professorCount-=1
    }
}

// memberwise init - auto constructor no need to create init()
struct University {
    let name: String
    let location: String

    var description: String {
        return "\(name) is located in \(location)"
    }
}


let uni = University(name: "Pwr", location: "Wroclaw")
print(uni.description)

let stud = Student(name: "Lukasz", age: 22, major: "IT", studentID: "xd")

let desc = stud.profileDescription

print(stud.formattedID)

var oldie: Professor? = Professor(faculty: "Faculty of Java 5", age: 100, name: "Eduardo Bieleninik")

print(Professor.professorCount)
let piotr = Student(student: stud, advisor: oldie)

print(piotr.advisor!.fullTitle)

print("Created: ",Student.studentCount)

oldie = nil // deallcation 

if let advisor = piotr.advisor {
    print(advisor.fullTitle)
} else {
    print(desc, "is seeking for advisor")
}
