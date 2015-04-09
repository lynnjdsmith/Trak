//
//  myTimePicker.swift
//  Trak
//
//  Created by Lynn Smith on 4/8/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation

class myTimePicker :UIView {

  var myparent    :UIViewController!
  
  override init (frame : CGRect) {
    super.init(frame : frame)
    //println("a")
  }
  
  
  init (frame : CGRect, myP :UIViewController) {
    self.myparent = myP
    super.init(frame : frame)
    setup()
  }
  
  init (filename :NSString) {
    super.init()
    setup()
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    
    // make picker
    var datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
    datePickerView.datePickerMode = UIDatePickerMode.Time
    datePickerView.addTarget(myparent, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    self.addSubview(datePickerView) // add date picker to UIView
    
    // make done button
    let doneButton = UIButton(frame: CGRectMake((frame.size.width/2) - (100/2), 0, 100, 50))
    doneButton.setTitle("Done", forState: UIControlState.Normal)
    doneButton.setTitle("Done", forState: UIControlState.Highlighted)
    doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
    doneButton.addTarget(myparent, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside)
    self.addSubview(doneButton)
    println("timePicker loaded")
  }
  
  
  
 /*  @IBAction func menuButtonPressed(sender: AnyObject) {
    self.revealViewController()?.rightRevealToggle(sender)
    self.view.endEditing(true)
  } */
  
  
}