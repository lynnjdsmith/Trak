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
  var datePickerView :UIDatePicker = UIDatePicker()
  
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
    var spacing :CGFloat = 8.0
    var theFont = UIFont(name: "Corbel-Bold", size: 17)
    var btnWidth :CGFloat = (frame.width / 3.0) - spacing * 2.0
    
    // make picker
    datePickerView = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
    datePickerView.datePickerMode = UIDatePickerMode.Time
    datePickerView.addTarget(myparent, action: Selector("handleTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    self.backgroundColor = UIColor.whiteColor()
    self.addSubview(datePickerView) // add date picker to UIView
    
    // make done button
    let doneButton = UIButton(frame: CGRect(x: spacing + 2 + 10, y: 12, width: btnWidth, height: 35))
    doneButton.setTitle("Done", forState: UIControlState.Normal)
    doneButton.setTitle("Done", forState: UIControlState.Highlighted)
    doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
    //self.addSubview(doneButton)
    
    // make buttons.
    let btn1:UIButton = UIButton(frame: CGRect(x: spacing + 2, y: 12, width: btnWidth, height: 35))
    btn1.setTitle("< 10 mins", forState: UIControlState.Normal)
    btn1.backgroundColor = UIColor.btnColorB()
    btn1.titleLabel!.font = theFont
    btn1.layer.cornerRadius = 15
    btn1.addTarget(myparent, action: "timePickerBack10:", forControlEvents: UIControlEvents.TouchUpInside)
    //btn1.setImage(image, forState: .Normal)
    self.addSubview(btn1)
    
    let btn2:UIButton = UIButton(frame: CGRect(x: frame.width/3 + spacing, y: 12, width: btnWidth, height: 35))
    btn2.setTitle("< 30 mins", forState: UIControlState.Normal)
    btn2.backgroundColor = UIColor.btnColorHighlight()
    btn2.titleLabel!.font = theFont
    btn2.layer.cornerRadius = 15
    btn2.addTarget(myparent, action: "timePickerBack30:", forControlEvents: UIControlEvents.TouchUpInside)
    self.addSubview(btn2)
    
    let btn3:UIButton = UIButton(frame: CGRect(x: (frame.width/3 * 2) + spacing - 2, y: 12, width: btnWidth, height: 35))
    btn3.setTitle("Done", forState: UIControlState.Normal)
    btn3.titleLabel!.font = theFont
    btn3.backgroundColor = UIColor.btnColorB()
    btn3.layer.cornerRadius = 15
    btn3.addTarget(myparent, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside)
    self.addSubview(btn3)
  }
  
  func setTheTime(theDate :NSDate) {
    datePickerView.setDate(theDate, animated: false)
  }
  
 /*  @IBAction func menuButtonPressed(sender: AnyObject) {
    self.revealViewController()?.rightRevealToggle(sender)
    self.view.endEditing(true)
  } */
  
  
}