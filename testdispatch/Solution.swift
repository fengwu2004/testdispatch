//: Playground - noun: a place where people can play

//买卖股票最佳时机

import Foundation

class Solution {
  
  private var startIndex = 0
  
  private var result = 0
  
  func findStart(start:Int, prices:[Int]) -> Int? {
    
    var index = start
    
    while index < prices.count && index + 1 < prices.count {
      
      if prices[index] > prices[index + 1] {
        
        index += 1
        
        continue
      }
      
      break
    }
    
    return index < prices.count ? index : nil
  }
  
  func findEnd(start:Int, prices:[Int]) -> Int? {
    
    var index = start
    
    while index < prices.count && index + 1 < prices.count {
      
      if prices[index] < prices[index + 1] {
        
        index += 1
        
        continue
      }
      
      break
    }
    
    return index < prices.count ? index : nil
  }
  
  func maxProfit(_ prices: [Int]) -> Int {
    
    if prices.count <= 1 {
      
      return 0
    }
    
    while startIndex < prices.count - 1 {
      
      let start = findStart(start: startIndex, prices: prices)
      
      if let _start = start {
        
        let end = findEnd(start: _start + 1, prices: prices)
        
        if let _end = end {
          
          result += prices[_end] - prices[_start]
          
          startIndex = _end
          
          continue
        }
      }
      
      break
    }
    
    return result
  }
}
