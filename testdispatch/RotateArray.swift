//
//  RotateArray.swift
//  testdispatch
//
//  Created by ky on 2018/7/30.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation

class RotateArray {
  
  func rotate(_ nums: inout [Int], _ k:Int) {
    
    if nums.isEmpty || k == 0 {
      
      return
    }
    
    let count = nums.count
    
    var curr = k % count
    
    var start = 0
    
    var prev = nums[start]
    
    for _ in 1 ... nums.count {
      
      let temp = nums[curr]
      
      nums[curr] = prev
      
      prev = temp
      
      if curr == start {
        
        start = (start + 1) % count
        
        curr = (start + k) % count
        
        prev = nums[start]
      }
      else {
        
        curr = (curr + k) % count
      }
    }
  }
}
