//
//  GraphView.swift
//  Graph
//
//  Created by Tim Davies on 11/08/2014.
//  Copyright (c) 2014 Tim Davies. All rights reserved.
//

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

  var size :CGFloat = 20
  //var label :NSString = "Bacon"
  var yPos :NSNumber = 20
  var ySpacing :NSNumber = size * 1.5
  var xPos :NSNumber = 30

  let labelList :NSArray = ["Milk", "Bacon", "Cheese"]
  let colorz :NSArray = [UIColor.greenColor(), UIColor.redColor(), UIColor.blueColor()]
  
  for (index, value) in enumerate(labelList) {
    println("Item \(index + 1): \(value)")
    let obj1 :Dictionary<String, AnyObject> = ["label" : value, "size" : size, "xPos" : xPos, "yPos" : yPos, "color" : colorz[index]] as Dictionary
    placePoint(obj1)
    xPos = xPos + (size * 2.5)
  }
  
  
  /* let obj1 :Dictionary<String, AnyObject> = ["label" : "Milk", "size" : size, "xPos" : xPos, "yPos" : yPos] as Dictionary
  
  xPos = xPos + (size * 2.5)
  let obj2 :Dictionary<String, AnyObject> = ["label" : "Bacon", "size" : size, "xPos" : xPos, "yPos" : yPos] as Dictionary
  
  placePoint(obj1)
  placePoint(obj2) */
  
  //let myP = [["label" : "Milk",   "value" : NSNumber(int:38), "x" : NSNumber(int:10), "y" : yNum]] as NSArray
  //plotPoint(myP[0] as NSDictionary) // label: daLabel)

  //yNum = yNum + 48
  
  //let myP2 = [["label" : "Bacon",   "value" : NSNumber(int:38), "x" : NSNumber(int:10), "y" : yNum]] as NSArray
  //plotPoint(myP2[0] as NSDictionary) // label: daLabel)

  

  
  // Graph size
  //graphWidth = (rect.size.width - padding) - 10
  //graphHeight = rect.size.height - 40
  //axisWidth = rect.size.width - 10
  //axisHeight = (rect.size.height - padding) - 10
  
  
  // draw initial circle
  //let pointPath = CGPathCreateMutable()
  
  // Set stroke colours and stroke the values path
  //CGContextAddPath(context, pointPath)
  //CGContextSetLineWidth(context, 2)
  //CGContextSetStrokeColorWithColor(context, graphColor.CGColor)
  //CGContextStrokePath(context)
  
  
      //everest = CGFloat(Int(ceilf(Float(10) / 25) * 25))
  
      // Lets work out the highest value and round to the nearest 25. 
      // This will be used to work out the position of each value
      // on the Y axis, it essentialy reperesents 100% of Y
      /* for point in data {
          let n : Int = (point.objectForKey("value") as NSNumber).integerValue
          if CGFloat(n) > everest {
              everest = CGFloat(Int(ceilf(Float(n) / 25) * 25))
          }
      } */
      
      /* Draw graph AXIS
      let axisPath = CGPathCreateMutable()
      CGPathMoveToPoint(axisPath, nil, padding, 10)
      CGPathAddLineToPoint(axisPath, nil, padding, rect.size.height - 31)
      CGPathAddLineToPoint(axisPath, nil, axisWidth, rect.size.height - 31)
      CGContextAddPath(context, axisPath)
      
      CGContextSetStrokeColorWithColor(context, axisColor.CGColor)
      CGContextStrokePath(context) */
  
      /* Draw y axis labels and lines */
      //var yLabelInterval : Int = Int(everest / 5)
      //let label = axisLabel(NSString(format: "%d", 1 * yLabelInterval))
  
      /* for i in 0...5 {
          
          let label = axisLabel(NSString(format: "%d", i * yLabelInterval))
          label.frame = CGRectMake(0, floor((rect.size.height - padding) - CGFloat(i) * (axisHeight / 5) - 10), 20, 20)
          addSubview(label)
          
          if(showLines && i != 0) {
              let line = CGPathCreateMutable()
              CGPathMoveToPoint(line, nil, padding + 1, floor(rect.size.height - padding) - (CGFloat(i) * (axisHeight / 5)))
              CGPathAddLineToPoint(line, nil, axisWidth, floor(rect.size.height - padding) - (CGFloat(i) * (axisHeight / 5)))
              CGContextAddPath(context, line)
              CGContextSetStrokeColorWithColor(context, linesColor.CGColor)
              CGContextStrokePath(context)
          }
      }  */
  
  

  //let daPoint = (myP[0] as NSDictionary).objectForKey("value") as NSNumber
  //let daY : CGFloat = 100  //ceil((CGFloat(daPoint.integerValue as Int) * (axisHeight / everest))) - 10
  //let daX : CGFloat = 30//padding + (showPoints ? 10 : 0)
  //CGPathMoveToPoint(pointPath, nil, daX, graphHeight - daY)
  //var daLabel = "Migraine"

      /* Lets move to the first point
      let pointPath = CGPathCreateMutable()
      let firstPoint = (data[0] as NSDictionary).objectForKey("value") as NSNumber
      let initialY : CGFloat = ceil((CGFloat(firstPoint.integerValue as Int) * (axisHeight / everest))) - 10
      let initialX : CGFloat = padding + (showPoints ? 10 : 0)
      CGPathMoveToPoint(pointPath, nil, initialX, graphHeight - initialY)
      
      // Loop over the remaining values
      for point in data {
        var aPoint = (data[0] as NSDictionary).objectForKey("value") as NSNumber
        var aLabel = "Mig"//(data[1] as NSDictionary).objectForKey("value") as NSString
        plotPoint(point as NSDictionary, path: pointPath)
        //plotPoint(point as NSNumber, path: pointPath, label: aLabel)
      }
      */

  }
  
  // Places a point
  func placePoint(point : Dictionary<String, AnyObject>) -> CALayer {
    
    let size :CGFloat = point["size"] as AnyObject? as CGFloat
    var label :NSString = point["label"] as AnyObject? as NSString
    var xPos :CGFloat = point["xPos"] as AnyObject? as CGFloat
    var yPos :CGFloat = point["yPos"] as AnyObject? as CGFloat
    var color :UIColor = point["color"] as AnyObject? as UIColor
    
    let pointMarker = valueMarker(size, color: color) //myP2[0] as NSDictionary)
    pointMarker.frame = CGRectMake(xPos, yPos, 50, 50)
    layer.addSublayer(pointMarker)
    
    let xLabel = axisLabel(label as NSString) //myP2[0].objectForKey("label") as NSString)
    xLabel.frame = CGRectMake(xPos - size, yPos + size, size * 3, size)
    xLabel.textAlignment = NSTextAlignment.Center
    xLabel.layer.borderColor = color.CGColor //.CGColor //UIColor.redColor().CGColor
    xLabel.layer.borderWidth = 0
    xLabel.textColor = UIColor.blackColor()
    addSubview(xLabel)
    
    
    /*let pointMarker = CALayer()
    pointMarker.backgroundColor = backgroundColor?.CGColor
    pointMarker.cornerRadius = 8
    pointMarker.masksToBounds = true
    
    let pointValue = point.objectForKey("value") as NSNumber
    
    let markerInner = CALayer()
    //markerInner.frame = CGRectMake(0, 0, 50, 50)
    markerInner.frame = CGRectMake(0, 0, pointValue, pointValue)
    markerInner.cornerRadius = pointValue / 2
    
    // ORIG - with space between surrounding line and circle  markerInner.frame = CGRectMake(3, 3, 20, 20)
    //markerInner.cornerRadius = 5
    markerInner.masksToBounds = true
    markerInner.backgroundColor = graphColor.CGColor
    
    pointMarker.addSublayer(markerInner) */
    
    return pointMarker
  }
  
  

  // Plot a point on the graph
 /*  func plotPoint(point : NSDictionary) {
    
    // work out the distance to draw the remaining points at
    let interval = Int(graphWidth) / (data.count - 1);
    
    let pointValue = point.objectForKey("value") as NSNumber
    
    // Calculate X and Y positions
    // var yposition : CGFloat = ceil((CGFloat(pointValue.integerValue as Int) * (axisHeight / everest))) - 10
    var yposition : CGFloat = point.objectForKey("x") as NSNumber
    var xposition : CGFloat = point.objectForKey("y") as NSNumber
    //CGFloat(interval * (data.indexOfObject(point))) + padding
    
    // If its the first point we want to nuge it in slightly
    //if(data.indexOfObject(point) == 0 && showPoints) {
    //  xposition += 10
    //}
    
    // Draw line to this value
    //CGPathAddLineToPoint(path, nil, xposition, graphHeight - yposition);
  
    
    //if(showPoints) {
      // Add a marker for this value
      let pointMarker = valueMarker(point)
      pointMarker.frame = CGRectMake(xposition, yposition, 50, 50)
      layer.addSublayer(pointMarker)
    //}
    
    let xLabel = axisLabel(point.objectForKey("label") as NSString)
    xLabel.frame = CGRectMake(xposition, yposition, pointValue, pointValue)
    xLabel.textAlignment = NSTextAlignment.Center
    xLabel.textColor = UIColor.whiteColor() 
    addSubview(xLabel)
  } */

  
  // Returns an axis label
  func axisLabel(title: NSString) -> UILabel {
      let label = UILabel(frame: CGRectZero)
      label.text = title
      label.font = labelFont
      label.textColor = labelColor
      label.backgroundColor = backgroundColor
      label.textAlignment = NSTextAlignment.Right
      return label
  }
  
  
  //func valueMarker(point : NSDictionary) -> CALayer {
  func valueMarker(size : CGFloat, color: UIColor) -> CALayer {
      let pointMarker = CALayer()
      pointMarker.backgroundColor = backgroundColor?.CGColor
      pointMarker.cornerRadius = 8
      pointMarker.masksToBounds = true

      //let pointValue = point.objectForKey("value") as NSNumber
    
      let markerInner = CALayer()
      //markerInner.frame = CGRectMake(0, 0, 50, 50)
      markerInner.frame = CGRectMake(0, 0, size, size)
      markerInner.cornerRadius = size / 2

      // ORIG - with space between surrounding line and circle  markerInner.frame = CGRectMake(3, 3, 20, 20)
      //markerInner.cornerRadius = 5
      markerInner.masksToBounds = true
      markerInner.backgroundColor = color.CGColor //graphColor.CGColor
      
      pointMarker.addSublayer(markerInner)
      
      return pointMarker
  }
    
}
