//: [Previous](@previous)

/*:
 ## Return Values
 
 Write a function called `greeting` that takes a `String` argument called name, and returns a `String` that greets the name that was passed into the function. I.e. if you pass in "Dan" the return value might be "Hi, Dan! How are you?" Use the function and print the result.
 */

func greeting(name: String) {
    print("Hi, \(name)! How are you?")
}
greeting(name: "Gerardo")

/*:
 Write a function that takes two `Int` arguments, and returns an `Int`. The function should multiply the two arguments, then add 2 to that, then return the result.

 Call the function, passing in any two numbers you want for the arguments. Print the returned value from this function.
 */

func multiplyAddTwo(x: Int, y: Int) {
    let multiplyPlusTwo = (x * y) + 2
        print(multiplyPlusTwo)
}

multiplyAddTwo(x: 5, y: 5)


//: page 1 of 3  |  [Next: Prime Numbers](@next)

//: [Next](@next)
