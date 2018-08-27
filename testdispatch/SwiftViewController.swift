//
//  SwiftViewController.swift
//  testdispatch
//
//  Created by ky on 2018/7/30.
//  Copyright © 2018 yellfun. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {
  
  private var jsonValue:String?
  
  required init?(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
  }
  
  func initSome() {
    
    jsonValue = "sdfsdf"
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
    ]
  
  func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    
    try vendingMachine.vend(itemNamed: snackName)
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
