// Advanced Functions

func introduce(name: String) {
    print("Hi my name is \(name)")
}

introduce(name: "Janee")

func addTogether(x: Int, y: Int) {
    let sum = x + y
    print(sum)
}

addTogether(x: 7, y: 8)

//func triple(number: Int) {
//    print(number * 3)
//}
//triple(number: 3)

func divide(number: Double, divisor: Double) {
    print(number / divisor)
}

divide(number: 5, divisor: 2)

func sayHello(to name: String) {
    let string = "Hello" + " " + name
    print(string)
}

sayHello(to: "Gerardo")

func triple(number: Int) -> Int {
    return number * 3
}

let age = 25

let trippleAge = triple(number: age)

print(trippleAge)

func nameCombinator(firstname: String, lastname: String) -> String {
    return "\(firstname) \(lastname)"
}

let fullName = nameCombinator(firstname: "Gerardo", lastname: "Hernandez")

print(fullName)

func greet(name: String, using greetingWord: String = "Hello") {
    let greeting = greetingWord + " " + name
    print(greeting)
}

greet(name: "Gerardo")

greet(name: "Gerardo", using: "Hola")


let userFavoriteOrder = "Cheesburger, fries, and shake"

func orderFood(_ order: String = userFavoriteOrder) {
    print(order)
}

orderFood()

orderFood("I'll just take some water.")

func lambdaDivisible(factor1: Int, factor2: Int, limit: Int) {
    
    for number in 0...limit {
        if number % factor1 == 0 && number % factor2 == 0 {
            print("Lambda School")
        } else if number % factor1 == 0 {
            print("Lambda")
        } else if number % factor1 == 0 {
            print("School")
        } else {
            print(number)
        }
    }
}

lambdaDivisible(factor1: 5, factor2: 10, limit: 100)

//////

func printNumbers(upto n: Int){
    for number in 1...n {
        var count = 0
        for num in 1..<number {
            if number % num == 0 {
                count += 1
            }
        }
        if count <= 1 {
            print(number, "is prime")
        }
    }
}

printNumbers(upto: 25)
