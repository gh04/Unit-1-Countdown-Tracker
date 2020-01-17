/*:
 
 ## Instructions
 
 * Create variables and constants for various parts about you, such as your name, your hometown, your favorite color and food, and anything else you think someone would be interested to know about you. Think about which of these should be variables, and which should be constants. Try to come up with at least 8 constants and variables in total.
 
 * Print each of these using `print()` statements and inserting the variable or constant in the parentheses.
 
 ### When completed, please zip up your code and upload it.

 ---
 
 ##### Bonus (this is optional):
 
 * Create a constant called `introduction`. This should be a readable sentence or paragraph that includes all of the constants and variables you made and combines them into a single string.
 
 *Hints:* Look up _string interpolation_ in Swift to learn how to turn variables into text. Google is your friend here. 😉
 
 > We will cover string interpolation in detail in a later lesson, so don't worry if you don't already know it, or find it confusing at first.
 
 */

import UIKit

let myName:String = ("Gerardo Hernandez")
print(myName)

let myHometown:String = ("Woodlake, CA")
print(myHometown)

var myAge:Int = 30
print(myAge)

let myFavoriteColor:String = ("black")
print(myFavoriteColor)

let numberAndTypeOfPets:String = ("3 dogs")
print(numberAndTypeOfPets)

var numberOfSiblings:Int = 2
print(numberOfSiblings)

let myCurrentLocation:String = ("Bay Area")
print(myCurrentLocation)

let myFavoriteFood:String = ("Mexican")
print(myFavoriteFood)

let myIntroduction:String = """
My name is \(myName) and I am \(myAge) years old. I am originally from \(myHometown), and now living in the \(myCurrentLocation) with my wife and \(numberAndTypeOfPets). Other facts about me are that I have \(numberOfSiblings) older siblings, my favorite color is \(myFavoriteColor), and I love \(myFavoriteFood) food.
"""
print(myIntroduction)




