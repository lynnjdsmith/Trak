//
//  LightboxView.swift
//  Trak
//
//  Created by Lynn Smith on 3/21/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation
import QuartzCore

class lightboxView: UIView {

    var theTitle    :UILabel!
    var gutter      :CGFloat!
    var webView     :UIWebView!
    var theFileName :NSString!
  
  override init (frame : CGRect) {
    super.init(frame : frame)
    //println("a")
  }
  
  init (filename :NSString) {
    super.init(frame:CGRectZero)
    theFileName = filename
    //println("lightbox loaded")
    setup()
  }
  
  func setup() {
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    gutter = screenSize.width / 20.0
    
    self.frame = CGRectMake(gutter, gutter, screenSize.width - (gutter*2), screenSize.height - gutter*2)
    var myHeight = self.frame.size.height
    self.backgroundColor = UIColor.appLightBlue2()
    self.layer.cornerRadius = 25;
    self.layer.masksToBounds = true;
    
    let url = NSBundle.mainBundle().URLForResource(theFileName as String, withExtension:"html")
    let myRequest = NSURLRequest(URL: url!)
    webView = UIWebView(frame:CGRectMake(gutter, gutter, gutter*16, myHeight - gutter))
    webView.opaque = false
    webView.backgroundColor = UIColor.clearColor()
    webView.loadRequest(myRequest)
    self.addSubview(webView)
    
    /* theTitle = UILabel(frame:CGRectMake(gutter*2, gutter*2, gutter*14, gutter*2))
    theTitle.textAlignment = NSTextAlignment.Center
    theTitle.font = UIFont(name: "Corbel", size: 30) // Corbel Corbel-BoldItalic Corbel-Italic Corbel-Bold
    self.addSubview(theTitle) */
    
    let imageName = "icon_close.png"
    let image = UIImage(named: imageName)
    let closeBtn:UIButton = UIButton(frame: CGRect(x: gutter*16, y: gutter*0.75, width: gutter*1.5, height: gutter*1.5))
    closeBtn.setTitle("", forState: UIControlState.Normal)
    closeBtn.addTarget(self, action: "closeMe", forControlEvents: UIControlEvents.TouchUpInside)
    closeBtn.setImage(image, forState: .Normal)
    self.addSubview(closeBtn)
  }
  
  func setTitle(theString:String){
    theTitle.text = theString
  }
  
  func closeMe() {
    self.hidden = true
  }
  
  /* override init () {
    super.init(style: .Plain)
  } */
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }


  

}