//
//  myTimePicker.swift
//  Trak
//
//  Created by Lynn Smith on 4/8/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation

/* protocol pickerDelegate {
  func newTimeSelected(newTime :NSString)
  //func reloadMainData()
} */

class myTimePicker :UIView {

  var myparent        :timelineViewController!
  var myparent2       :itemDetailController!
  var myparenttype    :String!
  var datePickerView  :UIDatePicker = UIDatePicker()
  
  override init (frame : CGRect) {
    super.init(frame : frame)
    //println("a")
  }
  
  // don't need this separation of parents? todo fix
  init (frame : CGRect, myparent :timelineViewController) {
    //println("tvc init")
    self.myparent = myparent
    self.myparenttype = "tvc"
    super.init(frame : frame)
    setup()
  }

  init (frame : CGRect, myparent2 :itemDetailController) {
    //println("idc init")
    self.myparent2 = myparent2
    self.myparenttype = "idc"
    super.init(frame : frame)
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
    datePickerView.addTarget(myparent, action: Selector("timePickerTimeChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    self.backgroundColor = UIColor.whiteColor()
    self.addSubview(datePickerView)
    
    // make buttons
    let btn1:UIButton = UIButton(frame: CGRect(x: spacing + 2, y: 12, width: btnWidth, height: 35))
    btn1.setTitle("< 10 mins", forState: UIControlState.Normal)
    btn1.backgroundColor = UIColor.btnColorB()
    btn1.titleLabel!.font = theFont
    btn1.layer.cornerRadius = 15
    btn1.addTarget(self, action: "timePickerBack10:", forControlEvents: UIControlEvents.TouchUpInside)
    self.addSubview(btn1)
    
    let btn2:UIButton = UIButton(frame: CGRect(x: frame.width/3 + spacing, y: 12, width: btnWidth, height: 35))
    btn2.setTitle("< 30 mins", forState: UIControlState.Normal)
    btn2.backgroundColor = UIColor.btnColorB()
    btn2.titleLabel!.font = theFont
    btn2.layer.cornerRadius = 15
    btn2.addTarget(self, action: "timePickerBack30:", forControlEvents: UIControlEvents.TouchUpInside)
    self.addSubview(btn2)
    
    let btn3:UIButton = UIButton(frame: CGRect(x: (frame.width/3 * 2) + spacing - 2, y: 12, width: btnWidth, height: 35))
    btn3.setTitle("Done", forState: UIControlState.Normal)
    btn3.titleLabel!.font = theFont
    btn3.backgroundColor = UIColor.btnColorB()
    btn3.layer.cornerRadius = 15
    btn3.addTarget(myparent, action: "closePicker", forControlEvents: UIControlEvents.TouchUpInside)
    self.addSubview(btn3)
  }
  
  func startWithTime(theTimeString :String) {
    var theTime = getTimeFromString(theTimeString)
    datePickerView.setDate(theTime, animated: false)
    self.hidden = false
    myparent.view.endEditing(true)
  }
  
  func timePickerBack10(sender: UIButton) {
    println("tpb10")
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    var newTime = datePickerView.date
    newTime = newTime.dateBySubtractingMinutes(10)
    datePickerView.date = newTime
    
    // set button title
    var newTimeString = getTimeStringFromDate(newTime)
    if(myparenttype == "tvc") {
      myparent.timePickerTimeChanged(datePickerView)
    } else {
      myparent2.timePickerTimeChanged(datePickerView)
    }

  }
  
  func timePickerBack30(sender: UIButton) {
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    var newTime = datePickerView.date
    newTime = newTime.dateBySubtractingMinutes(30)
    datePickerView.date = newTime
    
    // set button title
    var newTimeString = getTimeStringFromDate(newTime)
    if(myparenttype == "tvc") {
      myparent.timePickerTimeChanged(datePickerView)
    } else {
      myparent2.timePickerTimeChanged(datePickerView)
    }
  }
  
  
}