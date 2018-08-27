//
//  ThreadSafeDictionary.swift
//  testdispatch
//
//  Created by ky on 2018/8/2.
//  Copyright © 2018 yellfun. All rights reserved.
//

import UIKit

class ThreadSafeDictionary: NSObject {
  
  private var dic:Dictionary<String, Any>?
  
  func read(key:String) -> Any? {
  
    objc_sync_enter(self)
    
    let v = dic?[key]
    
    objc_sync_exit(self)
    
    return v
  }
  
  func write(key:String, with value:Any) -> Void {
    
    dic?[key] = value
  }
}
