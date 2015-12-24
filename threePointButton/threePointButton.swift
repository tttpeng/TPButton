//
//  threePointButton.swift
//  threePointButton
//
//  Created by tpeng on 15/12/24.
//  Copyright © 2015年 tttpeng. All rights reserved.
//

import UIKit

class threePointButton: UIButton {
  
  var middle: CAShapeLayer! = CAShapeLayer()
  var left: CAShapeLayer! = CAShapeLayer()
  var right: CAShapeLayer! = CAShapeLayer()
  
  let shortStroke: CGPath = {
    let path = CGPathCreateMutable()
    CGPathMoveToPoint(path, nil, 30, 0)
    CGPathAddLineToPoint(path, nil, 0, 30)
//    CGPathMoveToPoint(path, nil, 2, 2)
//    CGPathAddLineToPoint(path, nil, 28, 2)
    return path
  }()
  
  let leftStroke: CGPath = {
    let path = CGPathCreateMutable()
    CGPathMoveToPoint(path, nil, 70, 50)
    CGPathAddLineToPoint(path, nil, 70, 51)
    //    CGPathMoveToPoint(path, nil, 2, 2)
    //    CGPathAddLineToPoint(path, nil, 28, 2)
    return path
  }()
  
  let rightStroke: CGPath = {
    let path = CGPathCreateMutable()
    CGPathMoveToPoint(path, nil, 40, 50)
    CGPathAddLineToPoint(path, nil, 70, 80)
    return path
  }()

  

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.middle.path = shortStroke
    self.left.path = leftStroke
    self.right.path = rightStroke
    for layer in [self.middle,self.left,self.right] {
      layer.fillColor = nil
      layer.strokeColor = UIColor(red: 0.45, green: 0.55, blue: 0.63, alpha: 1).CGColor
      layer.lineWidth = 4
      layer.miterLimit = 4
      layer.lineCap = kCALineCapRound
      layer.masksToBounds = true
      
      let strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, .Round, .Miter, 4)
      
      layer.bounds = CGPathGetPathBoundingBox(strokingPath)
      
      layer.actions = [
        "strokeStart": NSNull(),
        "strokeEnd": NSNull(),
        "transform": NSNull()
      ]
      
      self.layer.addSublayer(layer)
    }
    
    self.middle.position = CGPointMake(20, 70)
    self.middle.anchorPoint = CGPointMake(0, 1)
    
    self.left.position = CGPointMake(35, 70)
    self.left.anchorPoint = CGPointMake(0, 1)
    
    self.right.position = CGPointMake(55, 70)
    self.right.anchorPoint = CGPointMake(1, 1)



//    self.middle.strokeStart = 0.99
//    self.middle.strokeEnd = 0.1

  }
  
  
  var showsMenu: Bool = false {
    didSet {
      let strokeStart = CABasicAnimation(keyPath: "strokeStart")
      let opc = CABasicAnimation(keyPath: "opacity")
      if self.showsMenu {
        
        strokeStart.toValue = 0.0
        strokeStart.duration = 0.5
        strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.25, -0.4, 0.5, 1)
        
        opc.toValue = 0
        opc.duration = 1

        
      }
      else {
        strokeStart.toValue = 0.99
        strokeStart.duration = 0.5
        strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.25, -0.4, 0.5, 1)
        
        opc.toValue = 1
        opc.duration = 1
      }
      self.middle.ocb_applyAnimation(strokeStart)
      self.right.ocb_applyAnimation(strokeStart)
      self.left.ocb_applyAnimation(opc)
    }
  }
  

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}


extension CALayer {
  func ocb_applyAnimation(animation: CABasicAnimation) {
    let copy = animation.copy() as! CABasicAnimation
    
    if copy.fromValue == nil {
      copy.fromValue = self.presentationLayer()!.valueForKeyPath(copy.keyPath!)
    }
    
    self.addAnimation(copy, forKey: copy.keyPath)

    
    let time: NSTimeInterval = 0.3
    let delay = dispatch_time(DISPATCH_TIME_NOW,
      Int64(time * Double(NSEC_PER_SEC)))
    dispatch_after(delay, dispatch_get_main_queue()) {
      self.setValue(copy.toValue, forKeyPath:copy.keyPath!)
    }
  }
}

