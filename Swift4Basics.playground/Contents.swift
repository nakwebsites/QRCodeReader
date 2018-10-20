//: Playground - noun: a place where people can play

import Cocoa

//Declare Variable or constants

//Integer

var myInt: Int = 10
var myInt1 = 10
myInt1 = 23
myInt += 1
myInt *= 2
myInt /= myInt

//floats

var myFloat: Float = 22.3
var myFloat1 = 223.55

//Doubles

var myDouble: Double = 20.33
var myDouble1 = 44.5

// characters

var myCharacter: Character = "C"
var myCharacter1 = "C"

//String

var string: String = "Hi"
var str = "Hello Playground"
str += string
var greeting = "\(string) \(str) , your number is \(myInt) "
str + " " + string

//Bools

var myBools: Bool = false
var mybools1 = true

// var Vs Let

var variable = 22
let constant = 22

variable = 24
//constant = 25   // complie error cannot assign to value contant , change let to var to make it mutable

// Type Conversion

var integer = 10
var doubleValue = 22.33

integer + Int(doubleValue)
Double(integer) + doubleValue
string + String(integer)

//Control Flow

// Loops

var myNumber:Int = 0

//for loop
for i in 1...10 {
    
    myNumber += i
    print(myNumber)
    
}

for character in "Hi I am Sneha" {
    print(character)
}

var example = 10

//while loop
while(example > 0) {
    
    print("greather than 0")
    example -= 1
}

//Repeat While loop
var anotherExampleNumer: Int = 0
repeat {
    print("the repeat while loop is running")
} while anotherExampleNumer > 0     // Runs at least once and then checks for condition


// If Else Switch statements

// Bonus round
// example If you score 4 in the bonus round, your score will be doubled. If you score 8, you will lose 2 points

var bonusRoundScore = 7

if bonusRoundScore == 4 {
    bonusRoundScore *= 2
} else if bonusRoundScore == 8 {
    bonusRoundScore -= 2
} else{
    "No Bonus"
}

// sWitch Statement

var highScore = 11

switch highScore {
case 0: "Really ? 0?"
case 1: "Ouch"
case 2: " Thats awful"
case 3: "Thats a bad"
case 4: "Hmmm"
case 5: "Average"
case 6: "Getting there"
case 7: "yeah"
case 8: "Wooo"
case 9: "Nailed It"
case 10: "Champoin"
default: " Did you cheat"
    
}

// Functions

func sayHello() {
    "Hello"
}

sayHello()

func sayHellToUser(name: String) {
    "Hello \(name)"
}

sayHellToUser(name: "sneha")

// return value from the function

func convertKMToMiles(km : Double) -> Double{
    let miles = km * 0.62
    return miles
}

let fiveKMInMiles = convertKMToMiles(km: 5)

//Classes

class Person {
    let name: String
    var age: Int
    let country1: String
    
    init (name: String, age: Int, country: String) {
        self.name = name
        self.age = age
        self.country1 = country
        
    }
    
    func celebrateBirthday(){
        self.age += 1
        print("Happy Birthday \(name)")
    }
    
}

var person1:Person = Person(name: "sneha", age: 100, country: "India")

person1.name
person1.celebrateBirthday()

// Optionals 

let firstName: String = "sneha"
let middleName: String? = nil
let lastName: String = "Kasetty"
let person2Middelname: String? = "sudarshan"

// Force Unwrapping

if middleName != nil {
    let fullName: String = "\(firstName) \(middleName!) \(lastName)"
    print(fullName)
} else{
    "middle name is nil"
}

if person2Middelname != nil {
    let fullName: String = "\(firstName) \(person2Middelname!) \(lastName)"
    print(fullName)
} else{
    "middle name is nil"
}

// if let
if let middleName = person2Middelname {
    "\(firstName)  \(middleName) \(lastName)"
}else {
    "\(firstName)  \(lastName)"
}

// Guard provides an early exit to the functions if the value is nil

func printMiddle(middleName : String?) {
    
    guard let middleName = middleName else {
        print("exiting function")
        return
    }
    
    print("Middle name \(middleName)" )
    
}
printMiddle(middleName: middleName)

//Closures - Closures are self-contained blocks of functionality that can be passed around and used in your code.

//Soon to become a closure
func sayHello(name: String) -> String {
    return "Hello \(name)"
}

sayHello(name: "sneha")

// func to closure takes 4 steps
// 1. Remove curly brackets
// 2. add in keyword
// 3. remove func keyword and function name
// 4. Enclose it in bracktes

var sayHelloClosure = {
    (name: String) -> String in
    return "Hello \(name)"
}

sayHello(name: "sneha")



