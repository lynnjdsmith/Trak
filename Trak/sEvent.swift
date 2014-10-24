//
//  sEvent.swift
//  Trak MODEL
//
//  Created by Lynn Smith on 10/24/14.
//  Copyright (c) 2014 Lynn Smith. All rights reserved.
//

//import Foundation - ?

import UIKit

class sEvent
{
  var name = ""
  var ID = 0
  var date :NSDate = NSDate()
  
  //init function??
  
  func relatedEvents(name: NSString, endDate: NSDate, daysBack: NSNumber) -> NSMutableArray {
    
    var theArray :NSMutableArray = [] //findData.findObjects() // as AnyObject as [String]
    
    // loading data for last 50 incidents      // THIS WORKS
    //var today :NSDate = NSDate()
    
    var beginDate :NSDate = endDate.dateByAddingTimeInterval(-100*24*60*60*daysBack) // daysback usually = 1
    
    // query parameters
    var findData:PFQuery = PFQuery(className: "Items")
    findData.whereKey("username", equalTo:PFUser.currentUser().username)
    //findData.whereKey("name", equalTo:name)
    //findData.whereKey("myDateTime", greaterThan:beginDate)
    //findData.whereKey("myDateTime", lessThan:endDate)
    //findData.limit = 50
    findData.orderByDescending("myDateTime")
    
    // query

    
    findData.findObjectsInBackgroundWithBlock{
      
      (objects:[AnyObject]! , error:NSError!)-> Void in
      
      if  nil != error {

        for object:AnyObject in objects!   {
          theArray.addObject(object as PFObject)
        }
      }
    }
    
    
    println(theArray)
    return theArray
  }
  
  
  func relatedEventsOLD(timePeriodHours :Int, offsetForTime :Int, theName :NSString) -> NSMutableArray {
    var theArray :NSMutableArray = []
    
    
    // write query to pull the correct time frame, all symptom events before self.
    //query limited to type trigger
    // query time range
    
    // create query
    var findData:PFQuery = PFQuery(className: "Items")
    findData.whereKey("username", equalTo:PFUser.currentUser().username)
    findData.whereKey("name", equalTo:theName)
    
    // send query
    /* findData.findObjectsInBackgroundWithBlock {
      (objects:[AnyObject]!, error:NSError!)->Void in
      
      if (error == nil) {
        println("return")
        self.items = []
        for object in objects as [PFObject] {
          println("return2")
          self.items.addObject(object)
          println(object)
        }
        self.tableViewData.reloadData()
      } else {
        println("error: \(error)")
      }
    }
    
    
    for item in ... {
      theArray.addObject(item) ...
    } */
    
    return theArray
  }
  
  func relatedEventsOfType(timePeriodHours :Int, offsetForTime :Int, typeName :NSString) -> NSMutableArray {
    var theArray :NSMutableArray = []
    
    return theArray
  }
  
  
}

