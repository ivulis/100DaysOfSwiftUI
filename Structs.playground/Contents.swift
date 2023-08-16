import Cocoa

// MARK: How to create your own structs
struct Album {
    let title: String
    let artist: String
    let year: Int

    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title)
print(wings.artist)

red.printSummary()
wings.printSummary()

struct Employee {
    let name: String
    // Struct can have property with default value
    var vacationRemaining: Int = 14

    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
archer.takeVacation(days: 5)
print(archer.vacationRemaining)

// Syntactic sugar – Swift silently creates a special function inside the struct called init(),
// using all the properties of the struct as its parameters
var archer2 = Employee.init(name: "Sterling Archer", vacationRemaining: 14)

// Double type is implemented as a struct, and has an initializer function that accepts an integer
let a = 1
let b = 2.0
let c = Double(a) + b

// Swift will silently generate an initializer with a default value of 14 for vacationRemaining,
// making both of these valid:
let kane = Employee(name: "Lana Kane")
let poovey = Employee(name: "Pam Poovey", vacationRemaining: 35)


// MARK: How to compute property values dynamically
struct Employee2 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }

        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

var archer3 = Employee2(name: "Sterling Archer", vacationAllocated: 14)
archer3.vacationTaken += 4
archer3.vacationRemaining = 5
print(archer3.vacationAllocated)


// MARK: How to take action when a property changes
// Struct with a property observer "didSet"
struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10
game.score -= 3
game.score += 1

// Struct with a property observers "willSet" and "didSet"
struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")


// MARK: How to create custom initializers
struct Player {
    let name: String
    let number: Int

    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    }
}

let player = Player(name: "Megan R")
print(player.number)

// If you want the default memberwise initializer to stay,
// move custom initializer to an extension
struct Employee3 {
    var name: String
    var yearsActive = 0
}

extension Employee3 {
    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee…")
    }
}

// creating a named employee now works
let roslin = Employee3(name: "Laura Roslin")

// as does creating an anonymous employee
let anon = Employee3()


// MARK: How to limit access to internal data using access control
// Access control keyword "private(set)" let anyone read this property, but only let methods write it
struct BankAccount {
    private(set) var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

account.funds


// MARK: Static properties and methods
// Keyword "static" means that both the "studentCount" property and "add()" method belong to the School struct itself,
// rather than to individual instances of the struct
struct School {
    static var studentCount = 0

    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add(student: "Taylor Swift")
print(School.studentCount)

// Static properties can be used to organize common data in apps
struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

// Static data can be comonly used to create examples of structs
struct Employee4 {
    let username: String
    let password: String

    static let example = Employee4(username: "cfederighi", password: "hairforceone")
}
