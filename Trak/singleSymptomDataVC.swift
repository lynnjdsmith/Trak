//
//  singleSymptomDataVC.swift
//  Trak
//
//  Created by Lynn Smith on 10/24/14.
//  Copyright (c) 2014 Lynn Smith. All rights reserved.
//

import Foundation

import UIKit
import QuartzCore

class singleSymptomDataVC: UIViewController, stlDelegate {


@IBOutlet var topBackView     :UIView!
@IBOutlet var titleTopLabel   :UILabel!
@IBOutlet var dateTimeLabel   :UILabel!
  
var items     :NSMutableArray = []
var objID     :NSString! = ""
var name      :NSString! = ""
var daDate    :NSString!  /* NOTE: always use hh:mm - no seconds! */
var daTime    :NSString! = ""
var theItem   :PFObject!
  
override func viewWillAppear(animated: Bool) {
  super.viewWillAppear(true)
}

override func viewDidLoad() {
  super.viewDidLoad()
  
  // general set stuff
  topBackView.layer.borderWidth = 0.3
  topBackView.layer.borderColor = UIColor.appLightGray().CGColor
  titleTopLabel.text = name
  dateTimeLabel.text = daDate  // + " " + daTime
    
  // create back btn
  navigationController?.setNavigationBarHidden(true, animated:true)
  let button   = UIButton() //UIButton.buttonWithType(UIButtonType.System) as UIButton
  button.frame = CGRectMake(-15, 20, 100, 50)
  button.backgroundColor = UIColor.clearColor()
  button.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
  button.setTitleColor(UIColor.appLightGray(), forState: .Normal)
  button.setTitle("Back", forState: UIControlState.Normal)
  button.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
  self.view.addSubview(button)
  
  
  let myData = []
  /* let myData = [
  ["label" : "Red Wine",   "value" : NSNumber(int:15)],
  ["label" : "Bacon",  "value" : NSNumber(int:30)],
  ["label" : "Milk",  "value" : NSNumber(int:7)],
  ["label" : "Chocolate", "value" : NSNumber(int:60)],
  ["label" : "Butter",   "value" : NSNumber(int:30)],
  ["label" : "Coffee",   "value" : NSNumber(int:15)],
  ["label" : "Red Wine",   "value" : NSNumber(int:45)],
  ] as NSArray */
  
  let graph = singleSymptomHorizontalGraphView(frame: CGRectMake(0, 140, 320, 200), theItem: theItem)
  self.view.addSubview(graph)
  
}

  func goBack(sender: UIButton) {
    navigationController?.popViewControllerAnimated(true)
  }
  
}

