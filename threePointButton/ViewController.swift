//
//  ViewController.swift
//  threePointButton
//
//  Created by tpeng on 15/12/24.
//  Copyright © 2015年 tttpeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
  var button: threePointButton! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.button = threePointButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100));
    self.button.addTarget(self, action: "toggle:", forControlEvents:.TouchUpInside)
    self.button.backgroundColor = UIColor.whiteColor()
    self.view.addSubview(button)
    
    self.view.backgroundColor = UIColor.brownColor();
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func toggle(sender: AnyObject!) {
    self.button.showsMenu = !self.button.showsMenu
  }


}


