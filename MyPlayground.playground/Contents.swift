import UIKit

var str = "Hello, playground

// Mark: - Methods

sho
func createNewItem(_ name: String, addedToList: Bool = false) {
    let shoppingItem = ShoppingItem(name: name, addedToList: addedToList)
    
    guard !shoppingList.contains(shoppingItem) else { return }
    shoppingList.append(shoppingItem)
    savetoPersistenStore()
        
}

func addedtoShoppingList(for item: ShoppingItem) {
    if let index = shoppingList.firstIndex(of: item) {
        shoppingList[index].addedToList.toggle()
        savetoPersistenStore()
    }
}
