/*:
 ## Prime Numbers
 
 Write a function called `printPrimes(upTo n: Int)`. The function should print the prime numbers that are between 1 and `n`. For example, if you pass in 100, the function should print the prime numbers between 1 and 100.

 A number is prime if it is only evenly divisible by itself and 1, and not evenly divisible by any other number. Call your function with several different values for `n` and verify that it prints the correct numbers.
 
 */
//
//func printPrimes(upTo n: Int){
//    for number in 1...n {
//        var count = 0
//        for num in 1..<number {
//            if number % num == 0  {
//                count += 1
//            }
//        }
//            if count <= 1 {
//                print(number)
//        }
//}
//}
//printPrimes(upTo: 75)

/*
 Rewrite the above function so that it's two functions. One called `printPrimes(upTo n: Int)` and the other called `isPrime(_ x: Int) -> Bool`. `isPrime()` should return true if the passed in number is prime, false otherwise. `printPrimes()` should do the same thing as before, but should call `isPrime()` to check if each number is prime.
 */

func printPrimes(upTo n: Int) {
    for number in 1...n {
        var count = 0
        for num in 1..<number {
            if number % num == 0  {
                count += 1
            }
        }
        if count <= 1 {
            print(number)
        }
    }
}


func isPrime(_ x: Int) -> Bool {
    let prime = true
    for number in 1...x {
        var count = 0
        for num in 1..<number {
            if number % num == 0 {
                count += 1
                
            }
        }
        if count <= 1 {
            print("Prime: \(number) \(prime)")
            
        } else {
            print("Prime: \(number) \(!prime)")
        }
    }
    return prime}

isPrime(100)

//: page 2 of 3  |  [Next: Fibonacci](@next)
//





