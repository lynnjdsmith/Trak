//  GraphView.swift
//  Graph


import UIKit
import QuartzCore

class SingleSymptomLine_GraphView: UIView {

  private var data = NSMutableArray()
  //private var context : CGContextRef?
  
  //private let padding     : CGFloat = 0
  //private var graphWidth  : CGFloat = 0
  //private var graphHeight : CGFloat = 0
  //private var axisWidth   : CGFloat = 0
  //private var axisHeight  : CGFloat = 0
  //private var everest     : CGFloat = 0
  
  // DRAW background setup
  // set vars
  var size :CGFloat = 16
  var xPos :CGFloat = 5 //268
  let daColorz = UIColor.appRed()
  var sizeLabelDot :CGFloat = 30
  var dotColor = UIColor.color4()
  var graphWidth :CGFloat = 300
 
  
  var sizeLegendDot :CGFloat = 16
  var xPosLegend :NSNumber = 35
  var yPosLegend :NSNumber = 3
  var yPos :NSNumber = 78
  
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
    /* add time markers/labels
    let timeLabel1 = UILabel(frame: CGRectMake(15, 50, 100, 20))
    timeLabel1.text = "Incident"
    timeLabel1.font = fontMedium
    timeLabel1.backgroundColor = backgroundColor
    timeLabel1.textAlignment = NSTextAlignment.Left
    timeLabel1.layer.borderColor = UIColor.blackColor().CGColor
    timeLabel1.layer.borderWidth = 0
    timeLabel1.textColor = UIColor.blackColor()
    //addSubview(timeLabel1) */

    // label 2
    let timeLabel2 = UILabel(frame: CGRectMake(90, 50, 100, 20))
    timeLabel2.text = "2 hrs"
    timeLabel2.font = fontMedium
    timeLabel2.backgroundColor = backgroundColor
    timeLabel2.textAlignment = NSTextAlignment.Left
    timeLabel2.layer.borderColor = UIColor.blackColor().CGColor
    timeLabel2.layer.borderWidth = 0
    timeLabel2.textColor = UIColor.blackColor()
    addSubview(timeLabel2)
    
    // label 3
    let timeLabel3 = UILabel(frame: CGRectMake(190, 50, 100, 20))
    timeLabel3.text = "12 hrs"
    timeLabel3.font = fontMedium
    timeLabel3.backgroundColor = backgroundColor
    timeLabel3.textAlignment = NSTextAlignment.Left
    timeLabel3.layer.borderColor = UIColor.blackColor().CGColor
    timeLabel3.layer.borderWidth = 0
    timeLabel3.textColor = UIColor.blackColor()
    addSubview(timeLabel3)
    
    // label 4
    let timeLabel4 = UILabel(frame: CGRectMake(268, 50, 100, 20))
    timeLabel4.text = "24 hrs"
    timeLabel4.font = fontMedium
    timeLabel4.backgroundColor = backgroundColor
    timeLabel4.textAlignment = NSTextAlignment.Left
    timeLabel4.layer.borderColor = UIColor.blackColor().CGColor
    timeLabel4.layer.borderWidth = 0
    timeLabel4.textColor = UIColor.blackColor()
    addSubview(timeLabel4)
    

    // draw legend
    
    let labelList :NSArray = nameArray //["Wine", "Bacon", "Cheese", "Tea", "Milk"]
    let colorz :NSArray = [UIColor.color1(), UIColor.color2(), UIColor.color3(), UIColor.color4(), UIColor.color5()]
    
    for (index, value) in enumerate(labelList) {
      //println("Item \(index + 1): \(value)")
      let obj1 :Dictionary<String, AnyObject> = ["size" : sizeLegendDot, "xPos" : xPosLegend, "yPos" : yPosLegend, "color" : colorz[index]] as Dictionary
      var l :CALayer = placeCircle(obj1)
      layer.addSublayer(l)
      
      let theLabel = UILabel(frame: CGRectMake(xPosLegend - sizeLegendDot, yPosLegend + sizeLegendDot, sizeLegendDot * 3, sizeLegendDot))
      theLabel.text = value as NSString
      theLabel.font = labelFont
      theLabel.backgroundColor = backgroundColor
      theLabel.textAlignment = NSTextAlignment.Center
      theLabel.layer.borderColor = UIColor.blackColor().CGColor
      theLabel.layer.borderWidth = 0
      theLabel.textColor = UIColor.blackColor()
      addSubview(theLabel)
      
      xPosLegend = xPosLegend + 58
    }
    

    // draw line chart
    // draw line
    let m1 = CALayer()
    m1.frame = CGRectMake(20, yPos + (sizeLabelDot/2) - 1, 320, 2)
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
  
  
  /* override func drawRect(rect: CGRect) {
  } */
  
  func drawTrigger(theObj: PFObject) { //, yPos: NSNumber) {

      //println(it)
      //var itObject :PFObject = theObj as PFObject
      // set incident time
      //var incidentTime :NSDate = theEvent.valueForKey("myDateTime") as NSDate
      var triggerEventTime :NSDate = theObj.valueForKey("myDateTime") as NSDate
      var minutesBetween :Float = Float(triggerEventTime.minutesBeforeDate(symptomEvent.dateTime()))
      println("minutesBetween \(minutesBetween)")
    
      // set vars -- ALL NEEDED?
      //var size :CGFloat = 16
      //var xPos :NSNumber = 5 //268
      //let daColorz = UIColor.appRed()
      //var sizeLabelDot :CGFloat = 38
      //var dotColor = UIColor.color3()
      //var graphWidth = 300
    
      // within the last day
    //var theName :NSString = theObj.valueForKey("name") as NSString
    
    var count = 1
    for theName in nameArray {
      //var theName :NSString = nameArray.valueForKey("name") as NSString
      var theObjName :NSString = theObj.valueForKey("name") as NSString
      if theName as NSString == theObjName {
        if (count == 1) { dotColor = UIColor.color1() }
        if (count == 2) { dotColor = UIColor.color2() }
        if (count == 3) { dotColor = UIColor.color3() }
        if (count == 4) { dotColor = UIColor.color4() }
        if (count == 5) { dotColor = UIColor.color5() }
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
        
        println("time Between: \(minutesBetween) || myXPos: \(myXPos)")
        let objDot :Dictionary<String, AnyObject> = ["size" : size, "xPos" : myXPos, "yPos" : yPos + (sizeLabelDot/2) - (size/2), "color" : dotColor] as Dictionary
        var dl :CALayer = placeCircle(objDot)
        layer.addSublayer(dl)
    }
  }
  
  
  func drawIncident(theEvent :PFObject, yPos :NSNumber) {
  
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
        let objDot :Dictionary<String, AnyObject> = ["size" : size, "xPos" : myXPos, "yPos" : yPos + (sizeLabelDot/2) - (size/2), "color" : dotColor] as Dictionary
        var dl :CALayer = placeCircle(objDot)
        layer.addSublayer(dl)
      }
    }
  
    
    /*  // draw big circles
    var sizeLabelDot :CGFloat = 38
    var sizeDataDot :CGFloat = 15
    yPos = 75
    xPos = 268
    
    let daLabel = "12/15"
    let daColorz = UIColor.appRed()
    
    
    // draw line
    let m1 = CALayer()
    m1.frame = CGRectMake(0, yPos + (sizeLabelDot/2) - 1, 320, 2)
    m1.masksToBounds = true
    m1.backgroundColor = UIColor.redColor().CGColor
    layer.addSublayer(m1)
    
    // draw bigDot
    let obj1 :Dictionary<String, AnyObject> = ["label" : daLabel,  "labelType" : "inside", "size" : sizeLabelDot, "xPos" : xPos, "yPos" : yPos, "color" : daColorz] as Dictionary
    placeCircle(obj1)
    
    for index in 1 ... 5 {
      let objDot :Dictionary<String, AnyObject> = ["label" : "none", "labelType" : "none", "size" : sizeDataDot, "xPos" : 15, "yPos" : yPos + (sizeLabelDot/2) - (sizeDataDot/2), "color" : UIColor.color3()] as Dictionary
      placeCircle(objDot)
      yPos = yPos + 60
    }  */
  }
    
  
  
  // Places a point
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
    //layer.addSublayer(pointMarker)
    
    /* draw Label - under
    if (labelType == "under") {
      let theLabel = UILabel(frame: CGRectMake(xPos - size, yPos + size, size * 3, size))
      theLabel.text = label
      theLabel.font = labelFont
      theLabel.backgroundColor = backgroundColor
      theLabel.textAlignment = NSTextAlignment.Center
      theLabel.layer.borderColor = color.CGColor
      theLabel.layer.borderWidth = 0
      theLabel.textColor = UIColor.blackColor()
      addSubview(theLabel)
    }
    
    // draw Label - inside
    if (labelType == "inside") {
      let theLabel = UILabel(frame: CGRectMake(xPos - size, yPos, size * 3, size))
      theLabel.text = label
      theLabel.font = fontBigger
      theLabel.backgroundColor = backgroundColor
      theLabel.textAlignment = NSTextAlignment.Center
      theLabel.layer.borderColor = color.CGColor
      theLabel.layer.borderWidth = 0
      theLabel.textColor = UIColor.whiteColor()
      addSubview(theLabel)
    } */
    
    return pointMarker
  }
    
}






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
} */
