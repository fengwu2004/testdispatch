//
//  TestProtocal.swift
//  testdispatch
//
//  Created by ky on 2018/8/8.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation

protocol Container {
  
  associatedtype Item
  
  mutating func append(_ item: Item)
  
  var count: Int { get }
  
  subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
  // original IntStack implementation
  var items = [Int]()
  
  mutating func push(_ item: Int) {
    
    items.append(item)
  }
  
  mutating func pop() -> Int {
    
    return items.removeLast()
  }
  
  // conformance to the Container protocol
  typealias Item = Int
  
  mutating func append(_ item: Int) {
    
    self.push(item)
  }
  
  var count: Int {
    
    return items.count
  }
  
  subscript(i: Int) -> Int {
    
    return items[i]
  }
}

struct Stack<Element>: Container {
  
  // original Stack<Element> implementation
  var items = [Element]()
  
  mutating func push(_ item: Element) {
    
    items.append(item)
  }
  
  mutating func pop() -> Element {
    
    return items.removeLast()
  }
  
  // conformance to the Container protocol
  mutating func append(_ item: Element) {
    
    self.push(item)
  }
  
  var count: Int {
    
    return items.count
  }
  
  subscript(i: Int) -> Element {
    
    return items[i]
  }
  
  typealias Item = Element
}

protocol SuffixableContainer: Container {
  
  associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
  
  func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {
  
  func suffix(_ size: Int) -> Stack {
    
    var result = Stack()
    
    for index in (count-size)..<count {
      
      result.append(self[index])
    }
    
    return result
  }
}
