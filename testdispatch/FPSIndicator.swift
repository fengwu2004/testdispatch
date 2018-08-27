//
//  FPSIndicator.swift
//  testdispatch
//
//  Created by ky on 2018/8/18.
//  Copyright © 2018 yellfun. All rights reserved.
//

import UIKit

final class FPSIndicator: NSObject {

  private var displayLink:CADisplayLink?
  
  private var timeStamp:CFTimeInterval = 0.0
  
  var fps = 0.0
  
  override init() {
    
    super.init()
    
    self.displayLink = CADisplayLink(target: self, selector: #selector(display))
    
    self.displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
  }
  
  deinit {
  
    print("deinit")
  }
  
  func stop() {
  
    self.displayLink!.invalidate()
  }
  
  func display(displayLink:CADisplayLink) -> Void {
    
    if self.timeStamp == 0.0 {
      
      self.timeStamp = displayLink.timestamp
      
      return
    }
    
    self.fps = 1 / (displayLink.targetTimestamp - displayLink.timestamp)
    
    self.timeStamp = displayLink.timestamp
    
    print("当前fps是\(self.fps)")
  }
}
