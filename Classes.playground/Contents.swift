import Cocoa

// MARK: How to create your own classes
class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10


// MARK: How to make one class inherit from another
class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

final class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    
    // if a child class wants to change a method from a parent class, you must use keyword override in the child class’s version
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }
}

final class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()

// Because "Developer" inherits from "Employee", it's possible to call "printSummary()" on instances of "Developer"
let novall = Developer(hours: 8)
novall.printSummary()


// MARK: How to add initializers for classes
// need to write your own initializer, or provide default values for all the properties of the class
class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

// Car class inheriting from Vehicle
class Car: Vehicle {
    let isConvertible: Bool
    
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let teslaX = Car(isElectric: true, isConvertible: false)

// If a subclass does not have any of its own initializers...
class Truck: Vehicle {
    let is18Wheeler: Bool = false
}

// ...it automatically inherits the initializers of its parent class
let cyberTruck = Truck(isElectric: true)


// MARK: How to copy classes
class User {
    var username = "Anonymous"
    
    // If you want to create a unique copy of a class instance,
    // sometimes called a deep copy,
    // you need to handle creating a new instance and copy across all your data safely
    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

var user1 = User()

var user2 = user1
// can safely call copy() to get an object with the same starting data,
// but any future changes won’t impact the original
var user3 = user1.copy()

user2.username = "Taylor"
user3.username = "Donald"

print(user1.username)
print(user2.username)
print(user3.username)


// MARK: How to create a deinitializer for a class
// class that prints a message when it’s created and destroyed, using an initializer and deinitializer
class User2 {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}

// It's possible to create and destroy instances of class quickly using a loop
for i in 1...3 {
    let user = User2(id: i)
    print("User \(user.id): I'm in control!")
}

// If User instances would be added to an array as they were created,
// they would only be destroyed when the array is cleared
var users = [User2]()

for i in 1...3 {
    let user = User2(id: i)
    print("User \(user.id): I'm in control!")
    users.append(user)
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")


// MARK: How to work with variables inside classes
class User3 {
    var name = "Paul"
}

let user = User3()
user.name = "Taylor"
print(user.name)

// Even though name is changed to “Taylor”, the whole user object is overwritten with a new one, resetting it back to “Paul”
class User4 {
    var name = "Paul"
}

var user4 = User4()
user4.name = "Taylor"
user4 = User4()
print(user4.name)
