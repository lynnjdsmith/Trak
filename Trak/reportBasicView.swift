//
//  reportBasicView.swift
//  Trak
//
//  Created by Lynn Smith on 11/8/14.
//  Copyright (c) 2014 Lynn Smith. All rights reserved.
//
//import Foundation

import UIKit
import QuartzCore

class reportBasicView: UIView {
  
  private var data = NSMutableArray()
  
  // set vars
  var size :CGFloat = 16
  var xPos :CGFloat = 5 //268
  let daColorz = UIColor.appRed()
  var sizeLabelDot :CGFloat = 25
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
  var colorz :NSArray = []
  var margin :CGFloat = 10
  
  required init(coder: NSCoder) {
    fatalError("NSCoding not supported")
  }
  
  init(frame: CGRect, theItem: PFObject) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.whiteColor()
    
    let title = UILabel(frame: CGRectMake(margin, 20, 100, 50))
    title.text = "Migraine"
    title.font = UIFont(name: "HelveticaNeueBold", size: 22)
    title.backgroundColor = UIColor.clearColor()
    title.textAlignment = NSTextAlignment.Left
    title.textColor = UIColor.darkBlue()
    addSubview(title)
    
    let graph = singleSymptomHorizontalGraphView(frame: CGRectMake(margin, 140, 300, 200), theItem: theItem)
    self.addSubview(graph)
    
    /*
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
      
      let theLabel = UILabel(frame: CGRectMake(xPosLegend - sizeLegendDot, yPosLegend + sizeLegendDot, sizeLegendDot * 3, sizeLegendDot))
      theLabel.text = value as! NSString
      theLabel.font = labelFont
      theLabel.backgroundColor = backgroundColor
      theLabel.textAlignment = NSTextAlignment.Center
      theLabel.layer.borderColor = UIColor.blackColor().CGColor
      theLabel.layer.borderWidth = 0
      theLabel.textColor = UIColor.blackColor()
      addSubview(theLabel)
      
      xPosLegend = xPosLegend + 58
      if (count == 5) { break }     // control number of legend items here.
      count = count + 1
    }
    
    
    // draw line chart
    // draw line
    let m1 = CALayer()
    m1.frame = CGRectMake(20, yPos + (sizeLabelDot/2) - 1, 285, 2)
    m1.masksToBounds = true
    m1.backgroundColor = UIColor.redColor().CGColor
    layer.addSublayer(m1)
    
    // draw bigDot
    let obj1 :Dictionary<String, AnyObject> = ["size" : sizeLabelDot, "xPos" : xPos, "yPos" : yPos, "color" : daColorz] as Dictionary
    var bl :CALayer = placeCircle(obj1)
    layer.addSublayer(bl)
    
    for obj in self.beforeEvents {
      drawTrigger(obj as! PFObject) //, xPos: xPos)
      //xPos = xPos + 60
      //println(obj.valueForKey("name"))
    }
    */
  }
  
  
}