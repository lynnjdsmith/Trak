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

class aDayTimelineTrigger: UIView {

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
  
  /* override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    var symptomEvents :NSArray = getEventsForADay(myStartingDate)//baseSymptomEvent.precedingSymptomEvents(name)
    
  }*/ 
  
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
  
    // query
    //theArray = findData.findObjects()
    //println("findData.findObjects() in sEvent   ** - Warning OK. Ignore. - **  ")

  
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
    //println("smallBlock \(smallBlock)")
    //println("myWidth \(myWidth)")
    //println("myPosX \(myXPos)")
    //println(".")
  
    var circleView :UIButton = UIButton(frame:CGRectMake(myXPos, 16, 50, 50))
    let imageName = "dot_migraine_head_full_100.png"
    let image = UIImage(named: imageName)
    circleView.setImage(image, forState: .Normal)
    self.addSubview(circleView)
  }
  
  
  /* func getUTCFormatDate(localDate: NSDate) -> NSDate {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    var timeZone :NSTimeZone = NSTimeZone(name:"UTC")!
    formatter.timeZone = timeZone
    var d :String = formatter.stringFromDate(localDate)
    var dateUTC: NSDate! = formatter.dateFromString(d)
    return dateUTC
  } */
  
  
  /* Use this if you're doing layers.
  func drawIt(theObject :PFObject) {
    println(theObject)
    
    let radius = 100.0
    
    // Create the circle layer
    var circle = CAShapeLayer()
    
    // Set the center of the circle to be the center of the view
    //let theCenter = CGPointMake(CGRectGetMidX(self.frame) - radius, CGRectGetMidY(self.frame) - radius)
    
    let fractionOfCircle = 3.0 / 4.0
    
    let twoPi = 2.0 * Double(M_PI)
    let startAngle = Double(fractionOfCircle) / Double(twoPi) - Double(M_PI_2)
    let endAngle = 0.0 - Double(M_PI_2)
    let clockwise: Bool = true
    
    // `clockwise` tells the circle whether to animate in a clockwise or anti clockwise direction
    circle.path = UIBezierPath(arcCenter: center, radius: 30, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).CGPath
    
    // Configure the circle
    circle.fillColor = UIColor.blackColor().CGColor
    //circle.strokeColor = UIColor.redColor().CGColor
    circle.lineWidth = 5
    
    // When it gets to the end of its animation, leave it at 0% stroke filled
    circle.strokeEnd = 0.0
    
    // Add the circle to the parent layer
    self.layer.addSublayer(circle)
    
    // Configure the animation
    var drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
    drawAnimation.repeatCount = 1.0
    
    // Animate from the full stroke being drawn to none of the stroke being drawn
    drawAnimation.fromValue = NSNumber(double: fractionOfCircle)
    drawAnimation.toValue = NSNumber(float: 0.0)
    drawAnimation.duration = 30.0
    drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    // Add the animation to the circle
    circle.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
    println("Load data for string")
    
  } */

}


//println("minutesBetween \(minutesBetween)")
//var multiplier :Float = Float(graphWidth)

// set the UIColor.
//nameArray is the names in the legend
/* var count = 1 // lets you know where you are in the nameArray. it's your index.
for theName in nameArray {
var theObjName :NSString = theObj.valueForKey("name") as! NSString
if theName as! NSString == theObjName {
if count < colorz.count {
dotColor = colorz[count] as! UIColor
}
}
count++
} */

//var yOffset :CGFloat = CGFloat(randomInt(0, (Int(myHeight) - Int(dotSize/2))))
//println("xoffset \(yOffset)")


//var dl :UIView = placeCircle(objDot)



// put dot into dictionary
//let objDot :Dictionary<String, AnyObject> =
//["size" : dotSize, "xPos" : 100, "yPos" : CGFloat(100), "color" : UIColor.redColor()] as Dictionary
//println("myWidth: \(myWidth) || minutesBetween: \(minutesBetween) || myXPos: \(myXPos)") //" || myXPos: \(myXPos)")

