//  GraphView.swift
//  Graph


import UIKit
import QuartzCore

class SingleSymptomLine_GraphView: UIView {

  private var data = NSMutableArray()

  // set vars
  var size :CGFloat = 16
  var xPos :CGFloat = 5 //268
  let daColorz = UIColor.appRed()
  var sizeLabelDot :CGFloat = 25
  var dotColor = UIColor.color4()
  var graphWidth :CGFloat = 300 //self.frame.width
 
  var sizeLegendDot :CGFloat = 16
  var xPosLegend :NSNumber = 35
  var yPosLegend :NSNumber = 3
  var yPos :CGFloat = 78
  
  // Graph Styles
  var showLines   = true
  var showPoints  = true
  var linesColor  = UIColor.clearColor()
  var axisColor   = UIColor.grayColor()
  var graphColor  = UIColor.appRed()
  var labelFont   = UIFont.systemFontOfSize(12)
  var labelColor  = UIColor.blackColor()
  var labelWidth :CGFloat = 36.0
  var fontBigger :UIFont = UIFont.systemFontOfSize(12)
  var fontMedium :UIFont = UIFont.systemFontOfSize(11)
  var dataPoints :NSMutableArray = []
  var theItem   :PFObject!
  var symptomEvent :sEvent!
  var beforeEvents :NSArray = []
  var nameArray :NSArray = []
  var colorz :NSArray = []
  
  required init(coder: NSCoder) {
    fatalError("NSCoding not supported")
  }
  
  init(frame: CGRect, theItem: PFObject) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.appLightBlue()
    
    // load data
    self.symptomEvent = sEvent(theEvent:theItem)
    self.beforeEvents = self.symptomEvent.relatedTriggerEvents(1)
    self.nameArray = self.symptomEvent.mostCommonPrecedingTriggers(self.beforeEvents)
    
    //println("nameArray: \(nameArray)")
    // add time markers/labels
    let timeLabel1 = UILabel(frame: CGRectMake(70, 50, 100, 20))
    timeLabel1.text = "6 hrs."
    timeLabel1.font = fontMedium
    timeLabel1.backgroundColor = backgroundColor
    timeLabel1.textAlignment = NSTextAlignment.Left
    timeLabel1.layer.borderColor = UIColor.blackColor().CGColor
    timeLabel1.layer.borderWidth = 0
    timeLabel1.textColor = UIColor.blackColor()
    addSubview(timeLabel1)
    
    let l1 = CALayer()
    l1.frame = CGRectMake(82, 70, 1, 45)
    l1.masksToBounds = true
    l1.backgroundColor = UIColor.grayColor().CGColor
    layer.addSublayer(l1)
    
    // label 2
    let timeLabel2 = UILabel(frame: CGRectMake(150, 50, 100, 20))
    timeLabel2.text = "12"
    timeLabel2.font = fontMedium
    timeLabel2.backgroundColor = backgroundColor
    timeLabel2.textAlignment = NSTextAlignment.Left
    timeLabel2.layer.borderColor = UIColor.blackColor().CGColor
    timeLabel2.layer.borderWidth = 0
    timeLabel2.textColor = UIColor.blackColor()
    addSubview(timeLabel2)
    
    let l2 = CALayer()
    l2.frame = CGRectMake(158, 70, 1, 45)
    l2.masksToBounds = true
    l2.backgroundColor = UIColor.grayColor().CGColor
    layer.addSublayer(l2)
    
    // label 3
    let timeLabel3 = UILabel(frame: CGRectMake(220, 50, 100, 20))
    timeLabel3.text = "18"
    timeLabel3.font = fontMedium
    timeLabel3.backgroundColor = backgroundColor
    timeLabel3.textAlignment = NSTextAlignment.Left
    timeLabel3.layer.borderColor = UIColor.blackColor().CGColor
    timeLabel3.layer.borderWidth = 0
    timeLabel3.textColor = UIColor.blackColor()
    addSubview(timeLabel3)
    
    let l3 = CALayer()
    l3.frame = CGRectMake(228, 70, 1, 45)
    l3.masksToBounds = true
    l3.backgroundColor = UIColor.grayColor().CGColor
    layer.addSublayer(l3)
    
    // label 4
    let timeLabel4 = UILabel(frame: CGRectMake(298, 50, 100, 20))
    timeLabel4.text = "24"
    timeLabel4.font = fontMedium
    timeLabel4.backgroundColor = backgroundColor
    timeLabel4.textAlignment = NSTextAlignment.Left
    timeLabel4.layer.borderColor = UIColor.blackColor().CGColor
    timeLabel4.layer.borderWidth = 0
    timeLabel4.textColor = UIColor.blackColor()
    addSubview(timeLabel4)
    
    let l4 = CALayer()
    l4.frame = CGRectMake(304, 70, 1, 45)
    l4.masksToBounds = true
    l4.backgroundColor = UIColor.grayColor().CGColor
    layer.addSublayer(l4)
    
    // draw legend
    let labelList :NSArray = nameArray
    self.colorz = [UIColor.color1(), UIColor.color2(), UIColor.color3(), UIColor.color4(), UIColor.color5()]
  
    // limit to 5
    var count = 1
    for (index, value) in enumerate(labelList) {
      //println("Item \(index + 1): \(value)")
      let obj1 :Dictionary<String, AnyObject> = ["size" : sizeLegendDot, "xPos" : xPosLegend, "yPos" : yPosLegend, "color" : self.colorz[index]] as Dictionary
      var l :CALayer = placeCircle(obj1)
      layer.addSublayer(l)
      
      var x = CGFloat(xPosLegend) - CGFloat(sizeLegendDot)
      var y = CGFloat(yPosLegend) + CGFloat(sizeLegendDot)
      let theLabel = UILabel(frame: CGRectMake(x, y, sizeLegendDot * 3, sizeLegendDot))
      theLabel.text = value as NSString
      theLabel.font = labelFont
      theLabel.backgroundColor = backgroundColor
      theLabel.textAlignment = NSTextAlignment.Center
      theLabel.layer.borderColor = UIColor.blackColor().CGColor
      theLabel.layer.borderWidth = 0
      theLabel.textColor = UIColor.blackColor()
      addSubview(theLabel)
      
      xPosLegend = Int(xPosLegend) + 58
      if (count == 5) { break }     // control number of legend items here.
      count = count + 1
    }
    

    // draw line chart
    // draw line
    let m1 = CALayer()
    let y :CGFloat = CGFloat(yPos) + sizeLabelDot/2.0 - 1.0
    m1.frame = CGRectMake(20, y, 285, 2)
    m1.masksToBounds = true
    m1.backgroundColor = UIColor.redColor().CGColor
    layer.addSublayer(m1)
    
    // draw bigDot
    let obj1 :Dictionary<String, AnyObject> = ["size" : sizeLabelDot, "xPos" : xPos, "yPos" : yPos, "color" : daColorz] as Dictionary
    var bl :CALayer = placeCircle(obj1)
    layer.addSublayer(bl)
    
    for obj in self.beforeEvents {
      drawTrigger(obj as PFObject) //, xPos: xPos)
      //xPos = xPos + 60
      println(obj.valueForKey("name"))
    }
    
  }
  
  
  func drawTrigger(theObj: PFObject) { //, yPos: NSNumber) {

    var triggerEventTime :NSDate = theObj.valueForKey("myDateTime") as NSDate
    var minutesBetween :Float = Float(triggerEventTime.minutesBeforeDate(symptomEvent.dateTime()))
    //println("minutesBetween \(minutesBetween)")
    
    // set the UIColor. nameArray is the names in the legend
    var count = 1 // lets you know where you are in the nameArray. it's your index.
    for theName in nameArray {
      var theObjName :NSString = theObj.valueForKey("name") as NSString
      if theName as NSString == theObjName {
        if count < colorz.count {
          //println(colorz[count])
          dotColor = colorz[count] as UIColor
        }
      }
        count++
    }
    
      if (minutesBetween < 1440) {
        //if (theName == self.nameArray[0]) { dotColor = UIColor.color1() }
        //if (theName == self.nameArray[1]) { dotColor = UIColor.color2() }
        //if (theName == self.nameArray[2]) { dotColor = UIColor.color3() }
        
        //var dotColor = UIColor.color4()
        
        // this works for 24 hours, 300 width graph
        var myXPos = Int((minutesBetween * 60)) / Int(graphWidth)
        myXPos = Int(myXPos) + Int(xPos) + Int(sizeLabelDot)
        
        //println("time Between: \(minutesBetween) || myXPos: \(myXPos)")
        
        var yOffset = randomInt(-15, 15)
        //println("xoffset \(yOffset)")
        let y :CGFloat = yPos + CGFloat(yOffset)
        let objDot :Dictionary<String, AnyObject> = ["size" : size, "xPos" : myXPos, "yPos" : y, "color" : dotColor] as Dictionary
        var dl :CALayer = placeCircle(objDot)
        layer.addSublayer(dl)
    }
  }
  
  
  func placeCircle(point : Dictionary<String, AnyObject>) -> CALayer {
    
    // unwrap variables
    let size :CGFloat = point["size"] as AnyObject? as CGFloat
    //var label :NSString = point["label"] as AnyObject? as NSString
    //var labelType :NSString = point["labelType"] as AnyObject? as NSString
    var xPos :CGFloat = point["xPos"] as AnyObject? as CGFloat
    var yPos :CGFloat = point["yPos"] as AnyObject? as CGFloat
    var color :UIColor = point["color"] as AnyObject? as UIColor
    

    // holder for circle and label
    let pointMarker = CALayer()

    // draw circle
    let markerInner = CALayer()
    markerInner.frame = CGRectMake(0, 0, size, size)
    markerInner.cornerRadius = size / 2
    markerInner.masksToBounds = true
    markerInner.backgroundColor = color.CGColor //graphColor.CGColor
    
    pointMarker.addSublayer(markerInner)
    pointMarker.frame = CGRectMake(xPos, yPos, 50, 50)

    return pointMarker
  }
    
}




/*  func drawIncident(theEvent :PFObject, yPos :NSNumber) {

// set vars
var size :CGFloat = 16
var xPos :NSNumber = 5 //268
let daColorz = UIColor.appRed()
var sizeLabelDot :CGFloat = 38
var dotColor = UIColor.color3()
var graphWidth = 300

// draw line
let m1 = CALayer()
m1.frame = CGRectMake(0, yPos + (sizeLabelDot/2) - 1, 320, 2)
m1.masksToBounds = true
m1.backgroundColor = UIColor.redColor().CGColor
layer.addSublayer(m1)

// set incident time
var incidentTime :NSDate = theEvent.valueForKey("myDateTime") as NSDate

let dateStringFormatter = NSDateFormatter()
dateStringFormatter.dateFormat = "MM/dd"
let d = dateStringFormatter.stringFromDate(theEvent.valueForKey("myDateTime") as NSDate)

// draw bigDot
let obj1 :Dictionary<String, AnyObject> = ["size" : sizeLabelDot, "xPos" : xPos, "yPos" : yPos, "color" : daColorz] as Dictionary
var bl :CALayer = placeCircle(obj1)
layer.addSublayer(bl)
let theLabel = UILabel(frame: CGRectMake(xPos - sizeLabelDot, yPos, sizeLabelDot * 3, sizeLabelDot))
theLabel.text = d
theLabel.font = fontBigger
theLabel.backgroundColor = backgroundColor
theLabel.textAlignment = NSTextAlignment.Center
theLabel.layer.borderColor = UIColor.whiteColor().CGColor
theLabel.layer.borderWidth = 0
theLabel.textColor = UIColor.whiteColor()
addSubview(theLabel)


// load data for incident
var findData:PFQuery = PFQuery(className: "Items")
findData.whereKey("username", equalTo:PFUser.currentUser().username)
findData.limit = 5
findData.whereKey("myDateTime", lessThan:incidentTime)
findData.orderByDescending("myDateTime")

// query
var theTriggers :NSArray = findData.findObjects() as NSArray

// draw data dots       //1440 = minutes in a day
for it in theTriggers {

//println(it)
var itObject :PFObject = it as PFObject
var eventTime :NSDate = itObject.valueForKey("myDateTime") as NSDate
var minutesBetween = incidentTime.minutesAfterDate(eventTime)


// within the last day
if (minutesBetween < 1440) {
if (itObject.valueForKey("name") as NSString  == "Chocolate") { dotColor = UIColor.color1() }
if (itObject.valueForKey("name") as NSString == "Milk") { dotColor = UIColor.color2() }
if (itObject.valueForKey("name") as NSString == "Cheese") { dotColor = UIColor.color4() }

var myXPos = minutesBetween + 40 //* 0.25
//println("time Between: \(minutesBetween) || myXPos: \(myXPos)")

var xOffset = randomInt(-20, 20)
println("xoffset \(xOffset)")
let objDot :Dictionary<String, AnyObject> = ["size" : size, "xPos" : (myXPos + xOffset), "yPos" : yPos + (sizeLabelDot/2) - (size/2), "color" : dotColor] as Dictionary
var dl :CALayer = placeCircle(objDot)
layer.addSublayer(dl)
}
}
}
*/



/* func loadSymptoms(endDate: NSDate, name: NSString) -> NSArray {

// query parameters
var findData:PFQuery = PFQuery(className: "Items")
findData.whereKey("username", equalTo:PFUser.currentUser().username)
findData.whereKey("name", equalTo:name)
//query.skip = 50
findData.limit = 50
//findData.whereKey("myDateTime", greaterThan:beginDate)
//findData.whereKey("myDateTime", lessThan:endDate)
findData.orderByDescending("myDateTime")

// query
var theArray :NSArray = findData.findObjects() // as AnyObject as [String]
//println(theArray)
return theArray
} 
*/  */
