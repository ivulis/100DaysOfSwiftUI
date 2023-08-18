import Cocoa

// MARK: How to handle missing data with optionals
let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]

// tries to read a key that doesn’t exist
let peachOpposite = opposites["Peach"]

// way of unwrapping optional using "if let" syntax
if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}

var username: String? = nil

// else block can be added
if let unwrappedName = username {
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty.")
}

func square(number: Int) -> Int {
    number * number
}

var number: Int? = nil

// SHADOWING - temporarily creating a second constant of the same name,
// available only inside the condition’s body
if let number = number {
    print(square(number: number))
}


// MARK: How to unwrap optionals with guard
func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")

        // 1: We *must* exit the function here
        return
    }

    // 2: `number` is still available outside of `guard`
    print("\(number) x \(number) is \(number * number)")
}

var myVar: Int? = 3

func printInt(of number: Int?) {
    if let unwrapped = myVar {
        print("Run if myVar has a value inside")
    }

    guard let unwrapped = myVar else {
        print("Run if myVar doesn't have a value inside")
        return
    }
}

printInt(of: myVar)

// function that returns the meaning of life as an optional integer
func getMeaningOfLife() -> Int? {
    42
}

// Function uses if let...
func printMeaningOfLifeIfLet() {
    // ...so that the result of getMeaningOfLife() will only be printed if it returned an integer rather than nil
    if let name = getMeaningOfLife() {
        print(name)
    }
}

// Same function written using guard let
func printMeaningOfLifeGuardLet() {
    guard let name = getMeaningOfLife() else { return }

    print(name)
}


// MARK: How to unwrap optionals with nil coalescing
let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

// Following reads a non-existent key in captains dictionary,
// which means "new" will be an optional string to set to nil
let new = captains["Serenity"]

// With the nil coalescing operator "??" we can provide a default value for any optional
let new2 = captains["Serenity"] ?? "N/A"

// randomElement() method on arrays returns one random item from the array,
// but it returns an optional because you might be calling it on an empty array
let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
// nil coalescing can be used to provide a default
let favorite = tvShows.randomElement() ?? "None"

struct Book {
    let title: String
    let author: String?
}

// If you have a struct with an optional property...
let book = Book(title: "Beowulf", author: nil)
// ...and want to provide a sensible default for when it’s missing
let author = book.author ?? "Anonymous"
print(author)

// It’s useful if you create an integer from a string, where you actually get back an optional Int?
let input = ""
// nil coalescing can be used to provide a default value
let number2 = Int(input) ?? 0
print(number2)


// MARK: How to handle multiple optionals using optional chaining
let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")

struct Book2 {
    let title: String
    let author: String?
}

var book2: Book2? = nil
let author2 = book2?.author?.first?.uppercased() ?? "A"
print(author2)

let names2 = ["Vincent": "van Gogh", "Pablo": "Picasso", "Claude": "Monet"]
let surnameLetter = names2["Vincent"]?.first?.uppercased() ?? "?"


// MARK: How to handle function failure with optionals
enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}

let user = (try? getUser(id: 23)) ?? "Anonymous"
print(user)
