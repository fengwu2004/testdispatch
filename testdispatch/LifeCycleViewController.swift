//
//  LifeCycleViewController.swift
//  testdispatch
//
//  Created by ky on 2018/8/13.
//  Copyright © 2018 yellfun. All rights reserved.
//

import UIKit

class LifeCycleViewController: UIViewController {
  
  override func viewDidLoad() {
    
    print("viewDidLoad")
    
    super.viewDidLoad()
    
    let observer = CFRunLoopObserverCreateWithHandler(nil, CFRunLoopActivity.allActivities.rawValue, true, 0) { (observer, activity) in
      
      print("\(activity.rawValue)")
    }
    
    CFRunLoopAddObserver(RunLoop.current.getCFRunLoop(), observer!, CFRunLoopMode.commonModes)
  }
  
  override func didReceiveMemoryWarning() {
    
    super.didReceiveMemoryWarning()
  }
  
  override func loadView() {
    
    print("loadView")
    
    super.loadView()    
  }
  
  @IBAction func doAdd() {
    
    for index in 0...50000 {
      
      print("\(index)")
    }
  }
  
  func addButtons(title:String, index:Int) -> Void {
    
    let button = UIButton.init(frame: CGRect.init(x: index/2, y: index/2, width: 50, height: 40))
    
    button.layer.cornerRadius = 5
    
    button.backgroundColor = UIColor.blue
    
    button.setTitle(title, for: UIControlState.normal)
    
    self.view.addSubview(button)
  }
  
  override func viewWillAppear(_ animated: Bool) {
  
    print("viewWillAppear")
  }
  
  override func viewDidAppear(_ animated: Bool) {
  
    print("viewDidAppear")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    print("viewWillDisappear")
  }
  
  override func viewDidDisappear(_ animated: Bool) {
  
    print("viewDidDisappear")
  }
  
  override func viewWillLayoutSubviews() {
    
    print("viewWillLayoutSubviews")
  }
  
  override func viewDidLayoutSubviews() {
  
    print("viewDidLayoutSubviews")
  }
}
