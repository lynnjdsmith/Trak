//
//  aTimelineViewController.swift
//  Trak
//
//  Created by Lynn Smith on 4/4/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation

import UIKit
import QuartzCore

class aDayTimelineSingleDay: UIView {

  var myDate :NSDate
  var myWidth :CGFloat
  var myHeight :CGFloat
  var myDayEvents :NSMutableArray = []
  var myMigraineEvents :NSMutableArray = []
  var dotImages    :NSMutableArray = []
  var dotSize       :CGFloat = 25
  
  required init(coder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  init(frame: CGRect, theDate: NSDate) {
    self.myDate = theDate
    self.myWidth = frame.width
    self.myHeight = frame.height
    super.init(frame: frame)
    self.frame = frame
    backgroundColor = UIColor.whiteColor()
    setup()
  }
  
  func setup() {
    var theFont = UIFont(name: "Corbel-Bold", size: 17)
    self.layer.borderWidth=0
    //self.layer.borderColor = UIColor.redColor().CGColor
    dotImages = dotImages.dotImageNames()
    
    var midLine :UIView = UIView(frame: CGRectMake(0, myHeight - 35, myWidth, 35))
    midLine.backgroundColor = UIColor.btnColorHighlight()
    self.addSubview(midLine)
    
    var label = UILabel(frame: CGRectMake(5, myHeight - 35, 200, 35))
    label.textAlignment = NSTextAlignment.Left
    label.font = theFont
    label.textColor = UIColor.whiteColor()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "EEEE, MMM d"
    label.text = formatter.stringFromDate(myDate)
    self.addSubview(label)
    
    placeEventsForDay(myDate)
  }
  
  
  func placeEventsForDay(theDate: NSDate) {
    //println("current username \(PFUser.currentUser().username)")
    
    // pare down date info
    let preformatter = NSDateFormatter()
    preformatter.dateFormat = "MM/dd/yyyy"
    var d :NSString = preformatter.stringFromDate(theDate)
    
    // create dates for beginning and end of day
    var date1String: NSString = "\(d) 12:00 AM"
    var date2String: NSString = "\(d) 11:59 PM"
    
    //println("CHART date1String: \(date1String) date2String: \(date2String)")
    
    let formatter = NSDateFormatter()
    formatter.dateFormat = "MM/dd/yyyy hh:mm a"
    var date1: NSDate! = formatter.dateFromString(date1String as! String)
    var date2: NSDate! = formatter.dateFromString(date2String as! String)
    
    //println("date1: \(date1) date2: \(date2)")
    //println("date1: \(date1)")
    
    // create query
    var findData:PFQuery = PFQuery(className: "Items")
    findData.whereKey("username", equalTo:PFUser.currentUser().username!)
    findData.whereKey("myDateTime", greaterThan:date1)
    findData.whereKey("myDateTime", lessThan:date2)
    findData.orderByDescending("myDateTime")
  
    // send query
    var num = 1
    
    findData.findObjectsInBackgroundWithBlock {
      (objects:[AnyObject]!, error:NSError!)->Void in
      if (error == nil) {
        for object in objects as! [PFObject] {
          //println("CHART EVENT date1String: \(date1String)")
          self.myDayEvents.addObject(object)
          var theName :String = object.valueForKey("name") as! String
          var theSymptom :String = "migraine"
          if theName.lowercaseString != theSymptom.lowercaseString {
             self.drawTrigger(object, endOfDay: date2, imageName: self.dotImages[num] as! NSString)
            }
            else {
              //println("Migraine!")
              self.myMigraineEvents.addObject(object)
            }
          num = num + 1
        }
      }
      for object in self.myMigraineEvents {
        self.drawMigraine(object as! PFObject, endOfDay: date2)
        //println(object)
      }
    }
  }

  func drawTrigger(theObj: PFObject, endOfDay: NSDate, imageName: NSString) {
  
    var triggerEventTime :NSDate = theObj.valueForKey("myDateTime") as! NSDate
    var minutesBetween :CGFloat = CGFloat(triggerEventTime.minutesBeforeDate(endOfDay))

    var smallBlock = myWidth / 1440
    var myXPos :CGFloat = (smallBlock * (1400 - minutesBetween)) // THIS GETS 24hr's XPOS,
    //println("smallBlock \(smallBlock)")
    //println("myWidth \(myWidth)")
    //println("myPosX \(myXPos)")
    //println(".")
    
    var circleView :UIButton = UIButton(frame:CGRectMake(myXPos, 40, dotSize, dotSize))
    let imageName = imageName
    let image = UIImage(named: imageName as! String)
    circleView.setImage(image, forState: .Normal)
    self.addSubview(circleView)
  }
  
  func drawMigraine(theObj: PFObject, endOfDay: NSDate) {
    
    var triggerEventTime :NSDate = theObj.valueForKey("myDateTime") as! NSDate
    var minutesBetween :CGFloat = CGFloat(triggerEventTime.minutesBeforeDate(endOfDay))
    
    //println("minutesBetween \(minutesBetween)")
    
    var smallBlock = myWidth / 1440
    var myXPos :CGFloat = (smallBlock * (1400 - minutesBetween)) // THIS GETS 24hr's XPOS,
  
    var circleView :UIButton = UIButton(frame:CGRectMake(myXPos, 16, 50, 50))
    let imageName = "dot_migraine_head_full_100.png"
    let image = UIImage(named: imageName)
    circleView.setImage(image, forState: .Normal)
    self.addSubview(circleView)
  }
}
  
