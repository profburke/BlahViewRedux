//
//  ViewController.swift
//  BlahViewRedux
//
//  Created by Matthew Burke on 10/12/15.
//  Copyright © 2015 BlueDino Software. 

import UIKit

class ViewController: UIViewController
{

  override func viewWillAppear(animated: Bool)
  {
    super.viewWillAppear(animated)
    createSubViews()
    
    let tgc = UITapGestureRecognizer(target: self, action: "replaceSubViews")
    view.addGestureRecognizer(tgc)
  }


  
  
  func replaceSubViews()
  {
    for subView in view.subviews {
      subView.removeFromSuperview()
    }
    createSubViews()
  }
  
  
  
  
  func createSubViews()
  {
    for _ in 0 ... randomFrom(4, to: 20) {
      let blahView = BlahView()
      
      let (x, y) = (randomFrom(20, to: 300), randomFrom(20, to: 300))
      let (width, height) = (randomFrom(50, to: 200), randomFrom(50, to: 200))
      
      blahView.frame = CGRect(x: x, y: y, width: width, height: height)
      view.addSubview(blahView)
    }
  }
  
  
  
  
  func randomFrom(lower: UInt32, to: UInt32) -> Int
  {
    guard to >= lower else {
      return 0
    }
    
    let range = to - lower
    return Int(lower) + Int(arc4random() % range)
  }
  
  
}

