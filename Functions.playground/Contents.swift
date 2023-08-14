import Cocoa

// MARK: How to reuse code with functions
func showWelcome() {
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}

showWelcome()

let number = 139

if number.isMultiple(of: 2) {
    print("Even")
} else {
    print("Odd")
}

let roll = Int.random(in: 1...20)

func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5, end: 20)


// MARK: How to return values from functions
let root = sqrt(169)
print(root)

func rollDice() -> Int {
    Int.random(in: 1...6)
}

let result = rollDice()
print(result)

func areLettersIdentical(string1: String, string2: String) -> Bool {
    string1.sorted() == string2.sorted()
}

func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

let c = pythagoras(a: 3, b: 4)
print(c)

func sayHello() {
    return
}

func greet(name: String) -> String {
    name == "Taylor Swift" ? "Oh wow!" : "Hello, \(name)"
}


// MARK: How to return multiple values from functions
// Function return array
func getUser() -> [String] {
    ["Taylor", "Swift"]
}

let user = getUser()
print("Name: \(user[0]) \(user[1])")

// Function return dictionary
func getUser2() -> [String: String] {
    [
        "firstName": "Taylor",
        "lastName": "Swift"
    ]
}

let user2 = getUser2()
print("Name: \(user2["firstName", default: "Anonymous"]) \(user2["lastName", default: "Anonymous"])")

// Function return tuple
func getUser3() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let user3 = getUser3()
print("Name: \(user3.firstName) \(user3.lastName)")

let user4 = getUser3()
let firstName = user4.firstName
let lastName = user4.lastName

print("Name: \(firstName) \(lastName)")

let (firstName2, lastName2) = getUser3()
print("Name: \(firstName2) \(lastName2)")

let (firstName3, _) = getUser3()
print("Name: \(firstName3)")


// MARK: How to customize parameter labels
func hireEmployee(name: String) { }
func hireEmployee(title: String) { }
func hireEmployee(location: String) { }

let lyric = "I see a red door and I want it painted black"
print(lyric.hasPrefix("I see"))

// Add an underscore before the parameter name, the external parameter label can be removed
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let result2 = isUppercase(string)

// Name "for" is used externally, name "number" - internally
func printTimesTables(for number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5)


// MARK: How to provide default values for parameters
func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)

// Function "removeAll" has parameter "keepingCapacity" with default value "false"
var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)
characters.removeAll(keepingCapacity: true)
print(characters.count)


// MARK: How to handle errors in functions
enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }

    if password == "12345" {
        throw PasswordError.obvious
    }

    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

let string2 = "12345"

do {
    let result = try checkPassword(string2)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error: \(error.localizedDescription).")
}
