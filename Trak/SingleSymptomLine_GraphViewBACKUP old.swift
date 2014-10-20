//  GraphView.swift
//  Graph


import UIKit
import QuartzCore


class SingleSymptomLine_GraphView: UIView {

  private var data = NSMutableArray()
  private var context : CGContextRef?
  
  private let padding     : CGFloat = 30
  private var graphWidth  : CGFloat = 0
  private var graphHeight : CGFloat = 0
  private var axisWidth   : CGFloat = 0
  private var axisHeight  : CGFloat = 0
  private var everest     : CGFloat = 0
  
  // Graph Styles
  var showLines   = true
  var showPoints  = true
  var linesColor  = UIColor.clearColor() //UIColor(white: 0.9, alpha: 1)
  var axisColor   = UIColor.grayColor()
  var graphColor  = UIColor.appRed()
  var labelFont   = UIFont.systemFontOfSize(12)
  var labelColor  = UIColor.blackColor()
  var labelWidth :CGFloat = 36.0
  
  
  required init(coder: NSCoder) {
      fatalError("NSCoding not supported")
  }
  
  
  override init(frame: CGRect) {
      super.init(frame: frame)
  }
  
  
  init(frame: CGRect, data: NSArray) {
      super.init(frame: frame)
      backgroundColor = UIColor.clearColor()
      self.data = data.mutableCopy() as NSMutableArray
  }
  
  
  // This function draws everything
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    context = UIGraphicsGetCurrentContext()

    // draw legend
    var size :CGFloat = 20
    //var label :NSString = "Bacon"
    var yPos :NSNumber = 20
    //var xSpacing :NSNumber = size * 1.5
    var xPos :NSNumber = 30

    let labelList :NSArray = ["Milk", "Bacon", "Cheese", "Tea", "Coffee"]
    let colorz :NSArray = [UIColor.color1(), UIColor.color2(), UIColor.color3(), UIColor.color4(), UIColor.color5()]
    
    for (index, value) in enumerate(labelList) {
      println("Item \(index + 1): \(value)")
      let obj1 :Dictionary<String, AnyObject> = ["label" : value, "size" : size, "xPos" : xPos, "yPos" : yPos, "color" : colorz[index]] as Dictionary
      placeCircle(obj1)
      xPos = xPos + 55
    }
    
    
    // draw data
    var sizeLabel :CGFloat = 53
    var sizeDataDot :CGFloat = 15
    yPos = 390
    xPos = 14
    
    let daLabel = "Migraine"
    let daColorz = UIColor.appRed()
    
    for index in 1 ... 5 {
      // draw line
      let m1 = CALayer()
      m1.frame = CGRectMake(xPos + (sizeLabel/2) - 1, 80, 2, 320)
      //markerInner.cornerRadius = size / 2
      m1.masksToBounds = true
      m1.backgroundColor = UIColor.redColor().CGColor //graphColor.CGColor
      layer.addSublayer(m1)
      
      let objDot :Dictionary<String, AnyObject> = ["label" : "none", "size" : sizeDataDot, "xPos" : xPos + (sizeLabel/2) - (sizeDataDot/2), "yPos" : 120, "color" : UIColor.color3()] as Dictionary
      placeCircle(objDot)
      
      let obj1 :Dictionary<String, AnyObject> = ["label" : daLabel, "size" : sizeLabel, "xPos" : xPos, "yPos" : yPos, "color" : daColorz] as Dictionary
      placeCircleLabelInside(obj1)
      xPos = xPos + 60
    }
    

    
  }
  
  
  
  // Places a point
  func placeCircleLabelInside(point : Dictionary<String, AnyObject>) -> CALayer {
    
    // unwrap variables
    let size :CGFloat = point["size"] as AnyObject? as CGFloat
    var label :NSString = point["label"] as AnyObject? as NSString
    var xPos :CGFloat = point["xPos"] as AnyObject? as CGFloat
    var yPos :CGFloat = point["yPos"] as AnyObject? as CGFloat
    var color :UIColor = point["color"] as AnyObject? as UIColor
    
    
    // draw holder for circle and label
    let pointMarker = CALayer()
    //pointMarker.backgroundColor = backgroundColor?.CGColor
    //pointMarker.cornerRadius = 8
    //pointMarker.masksToBounds = true
    
    // draw circle
    let markerInner = CALayer()
    markerInner.frame = CGRectMake(0, 0, size, size)
    markerInner.cornerRadius = size / 2
    markerInner.masksToBounds = true
    markerInner.backgroundColor = color.CGColor //graphColor.CGColor
    
    pointMarker.addSublayer(markerInner)
    pointMarker.frame = CGRectMake(xPos, yPos, 50, 50)
    layer.addSublayer(pointMarker)
    
    // Draw Label  ( none = don't add label )
    if (label != "none") {
      let theLabel = UILabel(frame: CGRectMake(xPos - size, yPos, size * 3, size))
      theLabel.text = label
      theLabel.font = UIFont.systemFontOfSize(11)
      theLabel.backgroundColor = backgroundColor
      theLabel.textAlignment = NSTextAlignment.Center
      theLabel.layer.borderColor = color.CGColor //.CGColor //UIColor.redColor().CGColor
      theLabel.layer.borderWidth = 0
      theLabel.textColor = UIColor.whiteColor()
      
      addSubview(theLabel)
    }
    
    return pointMarker
  }
  
  
  
  
  // Places a point
  func placeCircle(point : Dictionary<String, AnyObject>) -> CALayer {
    
    // unwrap variables
    let size :CGFloat = point["size"] as AnyObject? as CGFloat
    var label :NSString = point["label"] as AnyObject? as NSString
    var xPos :CGFloat = point["xPos"] as AnyObject? as CGFloat
    var yPos :CGFloat = point["yPos"] as AnyObject? as CGFloat
    var color :UIColor = point["color"] as AnyObject? as UIColor
    

    // draw holder for circle and label
    let pointMarker = CALayer()
    //pointMarker.backgroundColor = backgroundColor?.CGColor
    //pointMarker.cornerRadius = 8
    //pointMarker.masksToBounds = true

    // draw circle
    let markerInner = CALayer()
    markerInner.frame = CGRectMake(0, 0, size, size)
    markerInner.cornerRadius = size / 2
    markerInner.masksToBounds = true
    markerInner.backgroundColor = color.CGColor //graphColor.CGColor
    
    pointMarker.addSublayer(markerInner)
    pointMarker.frame = CGRectMake(xPos, yPos, 50, 50)
    layer.addSublayer(pointMarker)
    
    // Draw Label  ( none = don't add label )
    if (label != "none") {
      let theLabel = UILabel(frame: CGRectMake(xPos - size, yPos + size, size * 3, size))
      theLabel.text = label
      theLabel.font = labelFont
      theLabel.backgroundColor = backgroundColor
      theLabel.textAlignment = NSTextAlignment.Center
      theLabel.layer.borderColor = color.CGColor //.CGColor //UIColor.redColor().CGColor
      theLabel.layer.borderWidth = 0
      theLabel.textColor = UIColor.blackColor()
      
      addSubview(theLabel)
    }
    
    return pointMarker
  }

  
  // Returns an axis label
/*  func makeLabel(title: NSString) -> UILabel {
    let label = UILabel(frame: CGRectZero)
    label.text = title
    label.font = labelFont
    //label.textColor = labelColor
    label.backgroundColor = backgroundColor
    
    label.frame = CGRectMake(xPos - size, yPos + size, size * 3, size)
    label.textAlignment = NSTextAlignment.Center
    label.layer.borderColor = color.CGColor //.CGColor //UIColor.redColor().CGColor
    label.layer.borderWidth = 0
    label.textColor = UIColor.blackColor()
    
    //label.textAlignment = NSTextAlignment.Right
    return label
  } */
  
  
  //func valueMarker(point : NSDictionary) -> CALayer {
/*  func valueMarker(size : CGFloat, color: UIColor) -> CALayer {
    
      let pointMarker = CALayer()
      pointMarker.backgroundColor = backgroundColor?.CGColor
      pointMarker.cornerRadius = 8
      pointMarker.masksToBounds = true
    
      let markerInner = CALayer()
      markerInner.frame = CGRectMake(0, 0, size, size)
      markerInner.cornerRadius = size / 2
      markerInner.masksToBounds = true
      markerInner.backgroundColor = color.CGColor //graphColor.CGColor
      
      pointMarker.addSublayer(markerInner)
      
      return pointMarker
  } */
    
}
