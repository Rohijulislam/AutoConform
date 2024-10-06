## AutoConform
AutoConform is a Swift package that provides automatic implementations for Equatable, Hashable, and Comparable protocols. It simplifies the process of making your custom types conform to these protocols by leveraging property-based comparisons.

## Features

- 🔍 Automatic Equatable conformance
- 🔑 Automatic Hashable conformance
- 📊 Automatic Comparable conformance
- 🛠 Easy to use with any custom type
- 🧩 Flexible and extensible design

## Requirements
- Swift 5.0+
- iOS 12.0+ / macOS 10.15+

## Installation
### Swift Package Manager
You can install Custom Auto-Protocols using the Swift Package Manager:
- In Xcode, select "File" → "Swift Packages" → "Add Package Dependency"
- Enter the repository URL: https://github.com/Rohijulislam/AutoConform.git
- Specify the version or branch you want to use

## Usage
### CustomAutoEquatable
To make your type automatically conform to Equatable:
```swift
 struct Person: CustomAutoEquatable {
    let name: String
    let age: Int
    
    var equatableProperties: [any Equatable] {
        [name, age]
    }
}

let person1 = Person(name: "Alice", age: 30)
let person2 = Person(name: "Alice", age: 30)
print(person1 == person2) // true 
```

### CustomAutoHashable
To make your type automatically conform to Hashable:

```swift
struct Book: CustomAutoHashable {
    let title: String
    let author: String
    let year: Int
    
    var hashableProperties: [AnyHashable] {
        [title, author, year]
    }
}

let book = Book(title: "1984", author: "George Orwell", year: 1949)
let bookSet = Set([book])
```
### CustomAutoComparable
To make your type automatically conform to Comparable:

```swift
struct Score: CustomAutoComparable {
    let value: Int
    let playerName: String
    
    var comparableProperties: [any Comparable] {
        [value]
    }
}

let score1 = Score(value: 100, playerName: "Alice")
let score2 = Score(value: 90, playerName: "Bob")
print(score1 > score2) // true
```

## License
This package is released under the MIT License. 
