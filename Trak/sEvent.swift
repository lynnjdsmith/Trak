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
  
  // Variables
  var name  :NSString = ""
  //var id    :Int
  var date  :NSDate = NSDate()
  var objID         :NSString! = ""
  var theItem       :PFObject!
  var dateString    :NSString!
  var beforeEvents  :NSArray = []
  //init function??
  
  init(theEvent:PFObject) {
    println("init sEvent")
    self.name = theEvent.valueForKey("name") as NSString
    //self.id = theEvent.valueForKey("id") as NSString
    
    //let dateStringFormatter = NSDateFormatter()
    //dateStringFormatter.dateFormat = "MM/dd/yyyy"
    self.date = theEvent.valueForKey("myDateTime") as NSDate
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
      var theName :NSString! = theItem.valueForKey("name") as NSString
      //println("theName: \(theName)")
      nameArray.addObject(theName)
    }
    //println("nameArray: \(nameArray)")
    
    /*
    
    // make countedSet for counting the names
    var stringSet :NSCountedSet!
    stringSet.addObjectsFromArray(nameArray)
    
    var mostCommon :NSString = ""
    var highestCount :NSInteger = 0
    
    
    println("stringSet.count \(stringSet.count)")
    println(stringSet)
    
    for theItem in theArray {
      var theName :NSString! = theItem.valueForKey("name") as NSString
      var count = stringSet.countForObject(theName)
      if(count > highestCount) {
        highestCount = count
        mostCommon = theName
      }
    }
    
    nameArray.addObject(mostCommon) */

    return nameArray as NSArray
  }
  
    
  func relatedTriggerEvents(daysBack: NSNumber) -> NSArray {
    
    //var theArray :NSArray // = [] //findData.findObjects() // as AnyObject as [String]
    
    // loading data for last 50 incidents      // THIS WORKS
    var endDate :NSDate = self.date //NSDate()
    
    var beginDate :NSDate = self.date.dateByAddingTimeInterval(-100*24*60*60*daysBack) // daysback usually = 1
    println("beginDate: \(beginDate)")
    // query parameters
    var findData:PFQuery = PFQuery(className: "Items")
    findData.whereKey("username", equalTo:PFUser.currentUser().username)
    //findData.whereKey("name", equalTo:name)
    findData.whereKey("type",equalTo:"trigger")
    findData.whereKey("myDateTime", greaterThan:beginDate)
    findData.whereKey("myDateTime", lessThan:endDate)
    //findData.limit = 50
    findData.orderByDescending("myDateTime")
    
    // query

    
    //findData.findObjectsInBackgroundWithTarget(<#target: AnyObject!#>, selector: "doneFindObj")
    var theArray = findData.findObjects()
    
    /*{
      (objects:[AnyObject]! , error:NSError!)-> Void in
      
      println("in!")
      //if  nil != error {
        println("in2!")
        for object:AnyObject in objects!   {
          println("in3!")
          theArray.addObject(object as PFObject)
        }
      //}
    } */
    
    
    //println("theArray: \(theArray)")
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
  }
  
  
}

