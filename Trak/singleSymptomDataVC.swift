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


@IBOutlet var topBackView: UIView!
@IBOutlet var titleTop: UILabel!

var items :NSMutableArray = []
var objID     :NSString! = ""
var name      :NSString! = ""
  
override func viewWillAppear(animated: Bool) {
  super.viewWillAppear(true)
}

override func viewDidLoad() {
  super.viewDidLoad()
  
  // general set stuff
  topBackView.layer.borderWidth = 0.3
  topBackView.layer.borderColor = UIColor.appLightGray().CGColor
  titleTop.text = name
  
  // create back btn
  navigationController?.setNavigationBarHidden(true, animated:true)
  //var myBackButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
  //myBackButton.addTarget(self, action: "popToRoot:", forControlEvents: UIControlEvents.TouchUpInside)
  //myBackButton.setTitle("Back", forState: UIControlState.Normal)
  //myBackButton.setTitleColor(UIColor.appLightGray(), forState: UIControlState.Normal)
  //myBackButton.sizeToFit()
  //var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
  //self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
  
  
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
  
  let graph = SingleSymptomLine_GraphView(frame: CGRectMake(0, 80, 320, 400), objID: objID)
  self.view.addSubview(graph)
  
}


}

