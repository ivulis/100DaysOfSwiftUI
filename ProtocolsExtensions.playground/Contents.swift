import Cocoa

// MARK: How to create and use protocols
protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

// Car struct that conforms to Vehicle
struct Car: Vehicle {
    let name = "Car"
    var currentPassengers = 1
    
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute(distance: 100, using: car)

struct Bicycle: Vehicle {
    let name = "Bicycle"
    var currentPassengers = 1
    
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

let bike = Bicycle()
commute(distance: 50, using: bike)

// method that accepts an array of vehicles and uses it to calculate estimates across a range of options
func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

getTravelEstimates(using: [car, bike], distance: 150)


// MARK: How to use opaque return types
// To upgrade two functions to opaque return types, add the keyword "some" before their return type
func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())


// MARK: How to create and use extensions
// string that has whitespace on either side
var quote = "   The truth is rarely pure and never simple   "

extension String {
    // method that returns a new string with whitespace and newlines removed
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // modify the string directly
    mutating func trim() {
        self = self.trimmed()
    }
    
    // computed property, which breaks the string up into an array of individual lines
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}

// everywhere we want to remove whitespace and newlines we can just write the following
let trimmed = quote.trimmed()

// Because the quote string was created as a variable, we can trim it in place like this
quote.trim()

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines.count)

struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

// with default memberwise initializer
let lotr = Book(title: "Lord of the Rings", pageCount: 1178, readingHours: 24)

// with custom initializer
let hp = Book(title: "Harry Potter", pageCount: 768)


// MARK: How to create and use protocol extensions
extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let guests = ["Mario", "Luigi", "Peach"]

if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}

protocol Person {
    var name: String { get }
    func sayHello()
}

// default implementation of "sayHello()" as an extension
extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

// because Employee conforms to Person...
struct Employee: Person {
    let name: String
}

// ...it's possible use the default implementation provided in extension
let taylor = Employee(name: "Taylor Swift")
taylor.sayHello()
