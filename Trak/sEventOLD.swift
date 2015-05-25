//
//  sEvent.swift
//  Trak MODEL
//
//  Created by Lynn Smith on 10/24/14.
//  Copyright (c) 2014 Lynn Smith. All rights reserved.
//

import UIKit

class sEvent :anEvent
{

  /* var name  :NSString = ""
  var date  :NSDate = NSDate()
  var objID         :NSString! = ""
  var theItem       :PFObject!
  var dateString    :NSString!
  var beforeEvents  :NSArray = []
  
  init(theEvent:PFObject) {
    self.name = theEvent.valueForKey("name") as! NSString
    self.date = theEvent.valueForKey("myDateTime") as! NSDate
  }

  func dateTime() -> NSDate {
    return self.date
  }

  
  // get most common triggers as a list of names   // FIX TODO to-do improve here. no frequency treated here right now.
  func mostCommonPrecedingTriggers(theArray :NSArray) -> NSArray {
    
    //println("theArray.count \(theArray.count)")
    //println(theArray)
    
    // make an array of the names
    var nameArray :NSMutableArray = []
    
    for theItem in theArray {
      var theName :NSString! = theItem.valueForKey("name") as! NSString
      //println("theName: \(theName)")
      nameArray.addObject(theName)
    }
    //println("nameArray: \(nameArray)")

    return nameArray as! NSArray
  }
  
    
  func relatedTriggerEvents(daysBack: NSNumber) -> NSArray {
    
    // load data
    var endDate :NSDate = self.date //NSDate()
    var beginDate :NSDate = self.date.dateByAddingTimeInterval(-100*24*60*60*daysBack) // daysback usually = 1
    var findData:PFQuery = PFQuery(className: "Items")
    findData.whereKey("username", equalTo:PFUser.currentUser().username)
    //findData.whereKey("name", equalTo:name)
    findData.whereKey("type",equalTo:"trigger")
    findData.whereKey("myDateTime", greaterThan:beginDate)
    findData.whereKey("myDateTime", lessThan:endDate)
    //findData.limit = 50
    findData.orderByDescending("myDateTime")
    
    // query
    var theArray = findData.findObjects()
    println("findData.findObjects() in sEvent   ** - Warning OK. Ignore. - **  ")
    return theArray
  }
  

//func doneFindObj() {}

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
  } */
  
  
}

