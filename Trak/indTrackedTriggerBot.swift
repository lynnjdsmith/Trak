//
//  ind_TrackedTrigger.swift
//  Trak
//
//  Created by Lynn Smith on 5/24/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation
import UIKit

class indTrackedTriggerBot :NSObject
{
  
  func makeNewITT(itemText :NSString, active :Bool) {
    // create Item
    var new:PFObject = PFObject(className: "indTT")
    new.setObject("\(itemText)", forKey: "name")
    
    // add user
    new.setObject(PFUser.currentUser().username, forKey: "username")
    
    // set datetime
    new.setObject(NSDate(), forKey: "myDateTime")
    
    // add active state
    new.setObject(active, forKey: "active")
    
    // save item
    //self.saveObject(newItem)
    new.saveInBackgroundWithBlock {
      (Bool, NSError) -> Void in
      //if (success == true) {
      println("\n ** Object created") // \(sender.objectId)")
      //self.items.insertObject(newItem, atIndex: 0)
      //self.tableView.reloadData();                 // todo fix - move this later?
      //} else {
      //println("%@", error)
      // }
    }
  }

  
}