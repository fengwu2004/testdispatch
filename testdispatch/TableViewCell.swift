//
//  TableViewCell.swift
//  testdispatch
//
//  Created by ky on 2018/8/13.
//  Copyright © 2018 yellfun. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    
    super.setSelected(selected, animated: animated)
  }
  
  func addButtons(title:String, index:Int) -> Void {
    
    let button = UIButton.init(frame: CGRect.init(x: index/2, y: index/2, width: 50, height: 40))
    
    button.layer.cornerRadius = 5
    
    button.backgroundColor = UIColor.blue
    
    button.setTitle(title, for: UIControlState.normal)
    
    self.addSubview(button)
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    for index in 0...150 {
      
      self.addButtons(title: "\(index)", index: index)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
  }
}
