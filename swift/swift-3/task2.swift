struct School {
    var people: [Person]

    enum SchoolRole {
        case student, teacher, administrator
    }

    class Person {
        var name: String
        var role: SchoolRole

        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
    }

    subscript(role: SchoolRole) -> [Person] {
        return people.filter { $0.role == role }
    }

    mutating func addPerson(_ person: Person) {
        guard !people.contains(where: { $0.name == person.name }) else { return }

        self.people.append(person)
    }

}

func countStudents(_ school: School) -> Int {
    return school[.student].count
}

func countAdmins(_ school: School) -> Int {
    return school[.administrator].count
}

func countTeachers(_ school: School) -> Int {
    return school[.teacher].count
}

func countRole(in school: School, role: School.SchoolRole) -> Int {
    return school[role].count
}

let person1 = School.Person(name: "Lukasz", role: .student)
let person2 = School.Person(name: "Jan", role: .student)
let person3 = School.Person(name: "Liwia", role: .student)
let person11 = School.Person(name: "Liwia", role: .student)

let person4 = School.Person(name: "Natalia", role: .teacher)

var pwr = School(people: [person1, person2, person3, person4])

pwr.addPerson(School.Person(name: "Tomasz", role: .administrator))
pwr.addPerson(person11)

assert(countAdmins(pwr) == 1)
assert(countTeachers(pwr) == 1)
assert(countStudents(pwr) == 3)

print(countRole(in: pwr, role: .student))
