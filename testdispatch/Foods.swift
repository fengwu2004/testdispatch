//
//  Foods.swift
//  testdispatch
//
//  Created by ky on 2018/7/31.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation

class Food {
  
  var name: String
  
  init(name: String) {
    
    self.name = name
  }
  
  convenience init() {
    
    self.init(name: "[Unnamed]")
  }
}

class RecipeIngredient: Food {
  
  var quantity: Int = 10
  
  init(name: String, quantity: Int) {

    self.quantity = quantity

    super.init(name: name)
  }
  
  override convenience init(name: String) {

    self.init(name: name, quantity: 1)
  }
}

class Address {
  
  var buildingName: String?
  
  var buildingNumber: String?
  
  var street: String?
  
  func buildingIdentifier() -> String? {
    
    if let buildingNumber = buildingNumber, let street = street {
      
      return "\(buildingNumber) \(street)"
    }
    else if buildingName != nil {
      
      return buildingName
    }
    else {
      
      return nil
    }
  }
}

class Person {
  
  var residence: Residence?
}

class Room {
  
  let name: String
  
  init(name: String) { self.name = name }
}


class Residence {
  
  var rooms = [Room]()
  
  var numberOfRooms: Int {
    
    return rooms.count
  }
  
  subscript(i: Int) -> Room {
    get {
      return rooms[i]
    }
    set {
      rooms[i] = newValue
    }
  }
  
  func printNumberOfRooms() {
    
    print("The number of rooms is \(numberOfRooms)")
  }
  
  var address: Address?
}
