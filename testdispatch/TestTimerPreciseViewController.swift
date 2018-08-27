//
//  TestTimerPreciseTableViewCell.swift
//  testdispatch
//
//  Created by ky on 2018/8/18.
//  Copyright © 2018 yellfun. All rights reserved.
//

import UIKit

class TestTimerPreciseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  private let fpsIndicator = FPSIndicator()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    self.fpsIndicator.stop()
    
    super.viewWillDisappear(animated)
  }
  
  override func didReceiveMemoryWarning() {
  
    super.didReceiveMemoryWarning()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 2000
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
    
    if cell != nil {
      
      cell!.textLabel?.text = "\(indexPath.row)"
      
      return cell!
    }
    
    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
    
    cell?.textLabel?.text = "\(indexPath.row)"
    
    return cell!
  }
}
