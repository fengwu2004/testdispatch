//
//  TestInoutParams.swift
//  testdispatch
//
//  Created by ky on 2018/8/9.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation

struct People {
  
  var name:String
  
  var health:Int
  
  var energy:Int
}

func balance(_ x:inout Int, _ y: inout Int) {

  x = (x + y)/2
  
  y = (x + y)/2
}

func doBanlance() {
  
  
}
