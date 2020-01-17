

let array: [Double] = [1, 2, 3]

let friends: [String] = ["Janee", "Lexi", "Buddy", "Palomo"]

let myBesFriend = friends[0]

print(myBesFriend)

var favoriteFoods: [String] = ["Tacos", "Cheeseburgers", "Pizza", "Lasagna", "Burrito"]

let secondFavoriteFood = favoriteFoods[1]

let newFavorite = "Cheesestakes"

favoriteFoods.insert(newFavorite, at: 0)


print(secondFavoriteFood)

print(favoriteFoods)

let favoriteFood = "Salad"
favoriteFoods.append(favoriteFood)



favoriteFoods[0] = "Steak Tacos"

print(favoriteFoods)

if let tacoIndex = favoriteFoods.firstIndex(of: "Tacos") {
    favoriteFoods.remove(at: tacoIndex)
}

print(favoriteFoods)

var zooArray = ["Giraffe", "Monkey",]

let newAnimal = "Rhino"

zooArray.insert(newAnimal, at: 1)

print(zooArray)

let lastAnimal = "Panda"

zooArray.insert(lastAnimal, at: 3)

print(zooArray)

let anotherAnimal = "Snake"

zooArray.append(anotherAnimal)

print(zooArray)


zooArray.remove(at: 2)

print(zooArray)


let myFriends = ["Janee", "Lexi", "Buddy", "Palomo"]

for friend in myFriends {
    print("\(friend) is one of my friends.")
}

for index in 0..<myFriends.count {
    let friend = myFriends[index]
    
    print("Friend \(index + 1) is \(friend)")
}

// easier way to count
for (index, friend) in myFriends.enumerated() {
    print("Friend \(index) is \(friend)")
}

//count of a string in an [Stinrgs]

func count(of name: String, in names: [String]) -> Int {
    var countOfName = 0
    
    for matchingName in names {
        if name == matchingName {
        countOfName += 1
    }
}
    return countOfName
}

let names = ["Janee", "Lexi", "Buddy", "Palomo"]

print(count(of: "Janee", in: names))





if names.contains("Janee") {
    print("I really need to catch up with Janee")
}



