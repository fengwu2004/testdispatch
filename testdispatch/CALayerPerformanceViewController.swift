//
//  LifeCycleViewController.swift
//  testdispatch
//
//  Created by ky on 2018/8/13.
//  Copyright © 2018 yellfun. All rights reserved.
//

import UIKit

class CALayerPerformanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
//  private let fpsIndicator = FPSIndicator()
  
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
    
    super.loadView()
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
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "My_Cell")
    
    if let _cell = cell {
      
      return _cell
    }
    
    cell = TableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "My_cell")
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 2000
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 100
  }
}
