//
//  LightboxView.swift
//  Trak
//
//  Created by Lynn Smith on 3/21/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation
import QuartzCore

class navView: UIView {

    var theTitle    :UILabel!
    var topHeight   :CGFloat!
    var webView     :UIWebView!
    var theFileName :NSString!
    var myparent    :UIViewController!
  
  override init (frame : CGRect) {
    super.init(frame : frame)
    //println("nav")
    setup()
  }
  
  func setup() {
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    var myHeight :CGFloat = 50
    
    // draw background. The -10 and + 20 are so the shadow looks correct.
    self.frame = CGRectMake(-10, screenSize.height - 50, screenSize.width + 20, myHeight)
    self.backgroundColor = UIColor.appColorA()
    self.layer.cornerRadius = 0;
    self.layer.shadowOpacity = 0.3
    self.layer.shadowRadius = 2.0
    
    let imageName = "pancake_dark.png"
    let image = UIImage(named: imageName)
    let btn1:UIButton = UIButton(frame: CGRect(x: screenSize.width - 30, y: 10, width: 30, height: 30))
    btn1.setTitle("Migraines", forState: UIControlState.Normal)
    btn1.addTarget(self, action: "revealTheToggle", forControlEvents: UIControlEvents.TouchUpInside)
    btn1.setImage(image, forState: .Normal)
    self.addSubview(btn1)
  }

  
  func revealTheToggle() {
    myparent.revealViewController()?.rightRevealToggle(self)
    myparent.view.endEditing(true)
  }
  
  /* override init () {
    super.init(style: .Plain)
  } */
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }

}