//
//  LightboxView.swift
//  Trak
//
//  Created by Lynn Smith on 3/21/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation
import QuartzCore

class subnavView: UIView {

    var theTitle    :UILabel!
    var topHeight   :CGFloat!
    var webView     :UIWebView!
    var theFileName :NSString!
  
  override init (frame : CGRect) {
    super.init(frame : frame)
    //println("a")
  }
  
  init (filename :NSString) {
    super.init()
    theFileName = filename
    //println("b")
    setup()
  }
  
  func setup() {
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    topHeight = 70  //screenSize.width / 20.0
    
    self.frame = CGRectMake(0, topHeight, screenSize.width, 40)
    var myHeight = self.frame.size.height
    self.backgroundColor = UIColor.appLightBlue2()
    self.layer.cornerRadius = 25;
    self.layer.masksToBounds = true;
    
    //let imageName = "icon_close.png"
    //let image = UIImage(named: imageName)
    let btn1:UIButton = UIButton(frame: CGRect(x: 0, y: screenSize.width/3, width: screenSize.width/3, height: 40))
    btn1.setTitle("Migraines", forState: UIControlState.Normal)
    btn1.addTarget(self, action: "btn1Press", forControlEvents: UIControlEvents.TouchUpInside)
    //btn1.setImage(image, forState: .Normal)
    self.addSubview(btn1)
  }
  
  func setTitle(theString:NSString){
    theTitle.text = theString
  }
  
  func btn1Press() {
    self.hidden = true
  }
  
  override init () {
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }


  

}