import Cocoa

// MARK: How to create and use closures
// Functions can be assigned to variables
func greetUser() {
    print("Hi there!")
}

greetUser()

var greetCopy = greetUser
greetCopy()

// Skip creating a separate function, assign the functionality directly to a constant
let sayHello = {
    print("Hi there!")
}

sayHello()

// For the closure to accept parameters, put info about input parameters and return value inside the braces
let sayHello2 = { (name: String) -> String in
    "Hi \(name)!"
}

// Type annotation for greetCopy
var greetCopy2: () -> Void = greetUser

// Type of function's "getUserData" copy "data" doesn’t include the "for" external parameter name
func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserData
let user = data(1989)
print(user)

// Closures also uses no parameter name
sayHello2("Taylor")

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

// Function for putting captain Suzanne in first position of array
func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}

// Function "captainFirstSorted" can be passed to function "sorted" as parameter
let captainFirstTeam = team.sorted(by: captainFirstSorted)
print(captainFirstTeam)

// Function "sorted" called using closure
let captainFirstTeam2 = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})
print(captainFirstTeam2)


// MARK: How to use trailing closures and shorthand syntax
// Swift can automatically provide parameter names using shorthand syntax
let captainFirstTeam3 = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }

    return $0 < $1
}

// Keyword "return" can be removed, because closure's body has 1 line of code
let reverseTeam = team.sorted { $0 > $1 }

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)


// MARK: How to accept functions as parameters
// Function that generates an array of integers by repeating a function a certain number of times
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}

// It's possible to make arbitrary-sized integer arrays by passing in a function that should be used to generate each number
let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}

print(rolls)

// Same functionality works with dedicated functions too
func generateNumber() -> Int {
    Int.random(in: 1...20)
}

let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)

// Function that accepts three function parameters, each of which accept no parameters and return nothing
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}
