//  GraphView.swift
//  Graph


import UIKit
import QuartzCore

class singleSymptomHorizontalGraphView: UIView {
  
  // set vars
  var theItem       :PFObject!
  var symptomEvent  :sEvent!
  var beforeEvents  :NSArray = []
  var nameArray     :NSArray = []
  var colorz        :NSMutableArray = []
  var dateText      :NSString!
  
  //var screenWidth   :CGFloat  = 0.0
  //var padding       :CGFloat = 10
  
  var graphWidth    :CGFloat = 0
  var graphHeight   :CGFloat = 0
  var height        :CGFloat = 0
  //var bigDotSize    :CGFloat = 0
  
  //var sizeLegendDot :CGFloat = 16
  var xPosLegend    :CGFloat = 35
  var yPosLegend    :CGFloat = 3
  
  var dotSize       :CGFloat = 15
  var dotColor      :UIColor = UIColor.clearColor()
 
  var labelFont   = UIFont.systemFontOfSize(12)
  var fontMedium :UIFont = UIFont.systemFontOfSize(11)
  var fontSmall :UIFont = UIFont.systemFontOfSize(10)
  
  init(frame: CGRect, theItem: PFObject) {
    
    // set vars
    super.init(frame: frame)
    self.layer.borderColor = UIColor.grayColor().CGColor
    self.layer.borderWidth = 0
    self.colorz.get12Colors()
    self.graphWidth = frame.width
    self.graphHeight = frame.width
    self.height = frame.height

    //let myDate :NSDate = theItem.valueForKey("myDateTime") as! NSDate
    //let dateFormatterAll = NSDateFormatter()
    //dateFormatterAll.dateFormat = "MM/dd"
    //dateText = dateFormatterAll.stringFromDate(myDate)
    
    // load data
    self.symptomEvent = sEvent(theEvent:theItem)
    self.beforeEvents = self.symptomEvent.relatedTriggerEvents(24)
    self.nameArray = self.symptomEvent.mostCommonPrecedingTriggers(self.beforeEvents)
    
    // draw background
    var gridNames = ["6 hrs.","12","18","24"]
    drawBackGrid(gridNames)
    
    // draw big dot
    let obj1 :Dictionary<String, AnyObject> = ["size" : height, "xPos" : graphWidth - height, "yPos" : 0, "color" : UIColor.appRed()] as Dictionary
    var bl :UIView = placeCircle(obj1)
    self.addSubview(bl)
    
    //println(beforeEvents)
    
    // draw triggers
    for obj in self.beforeEvents {
      drawTrigger(obj as! PFObject)
    }
  
  }
  
  
  func drawBackGrid(gridNames :NSArray) {
  
    var xPos :CGFloat = 50//padding
    var segmentWidth :CGFloat = CGFloat(graphWidth / 4.0)
    
    for name in gridNames {

      let timeLabel1 = UILabel(frame: CGRectMake(xPos - 10, -20, 40, 20))
      timeLabel1.text = name as! NSString as String
      timeLabel1.font = fontMedium
      timeLabel1.backgroundColor = UIColor.clearColor()
      timeLabel1.textAlignment = NSTextAlignment.Center
      timeLabel1.layer.borderColor = UIColor.blackColor().CGColor
      timeLabel1.layer.borderWidth = 0
      timeLabel1.textColor = UIColor.blackColor()
      //addSubview(timeLabel1)

      // add single vertical line on left
      let l1 = CALayer()
      l1.frame = CGRectMake(0, 0, 1, height)
      l1.masksToBounds = true
      l1.backgroundColor = UIColor.grayColor().CGColor
      layer.addSublayer(l1)
      xPos = CGFloat(xPos + segmentWidth)
    }
  
    // draw horizontal line
    let m1 = CALayer()
    m1.frame = CGRectMake(0, (height/2), graphWidth, 2)
    // ON RIGHT - m1.frame = CGRectMake(0, (height/2) - 2, graphWidth, 2)
    m1.masksToBounds = true
    m1.backgroundColor = UIColor.redColor().CGColor
    layer.addSublayer(m1)

  }


  func drawTrigger(theObj: PFObject) {
    
    var triggerEventTime :NSDate = theObj.valueForKey("myDateTime") as! NSDate
    var minutesBetween :Float = Float(triggerEventTime.minutesBeforeDate(symptomEvent.dateTime()))
    //println("minutesBetween \(minutesBetween)")
    //var multiplier :Float = Float(graphWidth)
    
    // set the UIColor. nameArray is the names in the legend
    var count = 1 // lets you know where you are in the nameArray. it's your index.
    for theName in nameArray {
      var theObjName :NSString = theObj.valueForKey("name") as! NSString
      if theName as! NSString == theObjName {
         if count < colorz.count {
          dotColor = colorz[count] as! UIColor
        }
      }
      count++
    }
    
    // 1440  = minutes in the day
    if (minutesBetween < 1440) {
     
      // this works for 24 hours
      var placementWidth :Float = (Float(graphWidth - dotSize - (frame.height)) / 1440)
      var myXPos :Float = ((placementWidth * minutesBetween) - Float(dotSize)) + Float(dotSize)
      
      //println("minutesBetween: \(minutesBetween) || myXPos: \(myXPos)") //" || myXPos: \(myXPos)")
      
      var yOffset = randomInt(0, (Int(height) - Int(dotSize/2)))
      //println("xoffset \(yOffset)")
      let objDot :Dictionary<String, AnyObject> = ["size" : dotSize, "xPos" : myXPos, "yPos" : CGFloat(yOffset), "color" : dotColor] as Dictionary
      var dl :UIView = placeCircle(objDot)
      self.addSubview(dl)
    }
  }
  
  

 
  required init(coder: NSCoder) {
    fatalError("NSCoding not supported")
  }
  
  
}