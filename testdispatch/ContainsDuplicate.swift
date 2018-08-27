//
//  ContainsDuplicate.swift
//  testdispatch
//
//  Created by ky on 2018/7/31.
//  Copyright © 2018 yellfun. All rights reserved.
//

import Foundation

class ContainsDuplicate {
  
  func containsDuplicate(_ nums: [Int]) -> Bool {
    
    return Set(nums).count != nums.count
  }
}
