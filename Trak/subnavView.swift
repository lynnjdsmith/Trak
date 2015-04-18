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

  var myparent    :UIViewController!
  var btn1 :UIButton!
  var btn2 :UIButton!
  var btn3 :UIButton!
  var myBtnInt :Int! = 0

  override init (frame : CGRect) {
    super.init(frame : frame)
    setup()
  }

  init (myBtnInt :Int) {
    var myBtnInt = myBtnInt
    super.init(frame: CGRectMake(0,0,0,0))
    setup()
  }
  
  func setup() {
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    var myHeight :CGFloat = 50.0
    var spacing :CGFloat = 8.0
    var theFont = UIFont(name: "Corbel-Bold", size: 17)
    var btnWidth :CGFloat = (screenSize.width / 3.0) - spacing * 2.0
    
    // draw background. The -10 and + 20 are so the shadow looks correct.
    self.frame = CGRectMake(-10, screenSize.height - 100, screenSize.width + 20, myHeight)
    self.backgroundColor = UIColor.appColorA()
    self.layer.cornerRadius = 0;
    self.layer.shadowOpacity = 0.3
    self.layer.shadowRadius = 2.0
    self.layer.shadowOffset = CGSizeMake(0, -3)
    
  
    // make buttons. add 10 to x for the shadow adjustment above.
    btn1 = UIButton(frame: CGRect(x: spacing + 2 + 10, y: 12, width: btnWidth, height: 35))
    btn1.setTitle("Migraines", forState: UIControlState.Normal)
    btn1.backgroundColor = UIColor.btnColorB()
    btn1.titleLabel!.font = theFont
    btn1.layer.cornerRadius = 15
    btn1.addTarget(self, action: "btn1Press", forControlEvents: UIControlEvents.TouchUpInside)
    if (myBtnInt == 1) { println("btn1"); btn1.backgroundColor = UIColor.btnColorHighlight() }
    self.addSubview(btn1)


    btn2 = UIButton(frame: CGRect(x: screenSize.width/3 + spacing + 10, y: 12, width: btnWidth, height: 35))
    btn2.setTitle("Day By Day", forState: UIControlState.Normal)
    btn2.backgroundColor = UIColor.btnColorB()
    btn2.titleLabel!.font = theFont
    btn2.layer.cornerRadius = 15
    btn2.addTarget(self, action: "btn2Press", forControlEvents: UIControlEvents.TouchUpInside)
    if (myBtnInt == 2) { println("btn2"); btn2.backgroundColor = UIColor.btnColorHighlight() }
    self.addSubview(btn2)

    
    btn3 = UIButton(frame: CGRect(x: (screenSize.width/3 * 2) + spacing - 2 + 10, y: 12, width: btnWidth, height: 35))
    btn3.setTitle("By Trigger", forState: UIControlState.Normal)
    btn3.titleLabel!.font = theFont
    btn3.backgroundColor = UIColor.btnColorB()
    btn3.layer.cornerRadius = 15
    btn3.addTarget(self, action: "btn3Press", forControlEvents: UIControlEvents.TouchUpInside)
    if (myBtnInt == 3) { btn3.backgroundColor = UIColor.btnColorHighlight() }
    self.addSubview(btn3)

    
  }
  
  func btn1Press() {
    println("btn pressed")
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("chartListMigrainesVC") as! UIViewController
    myparent.presentViewController(viewcontroller, animated: false, completion: nil)
  }

  func btn2Press() {
    println("btn pressed")
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("chartListDaysVC") as! UIViewController
    myparent.presentViewController(viewcontroller, animated: false, completion: nil)
  }

  func btn3Press() {
    println("btn3 pressed")
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("chartListTriggersVC") as! UIViewController
    myparent.presentViewController(viewcontroller, animated: false, completion: nil)
  }
  
  func highlightMe() {
    // change highlight
    btn2.backgroundColor = UIColor.btnColorHighlight()
    btn1.backgroundColor = UIColor.btnColorB()
    btn3.backgroundColor = UIColor.btnColorB()
  }
  
  
  /* override init () {
    super.init(style: .Plain)
  } */
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }


  

}