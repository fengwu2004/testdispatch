//
//  TestInit.swift
//  testdispatch
//
//  Created by ky on 2018/7/31.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation

class Base {
  
  var baseProperty:Int
  
  init() {
    
    self.baseProperty = 1
  }
  
  convenience init(with defaultvalue:Int) {
    
    self.init()
    
    self.baseProperty = defaultvalue
  }
  
  init?(withString str:String) {
    
    if str.lengthOfBytes(using: String.Encoding.utf8) > 10 {
      
      return nil
    }
    
    self.baseProperty = 10
  }
}

class DeriveType: Base {
  
  private var count = 0
  
  convenience init(from arrayLength:Int) {
    
    self.init(dovalue: 1)
    
    count = arrayLength
    
    baseProperty = 100
  }
  
  init(dovalue:Int) {
    
    super.init()
    
    count = dovalue
    
    baseProperty = 100
  }
  
  override init?(withString str: String) {
    
    super.init()
  }
}

let base = Base(with: 1212)
