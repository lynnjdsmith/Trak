//
//  itemBot.swift
//  Trak

import Foundation
import UIKit

class itemBot :NSObject
{

func makeNewEntries(theNewItems :NSArray, daDateTime :NSDate) {
    // process each item
    for daNewItem in theNewItems {
      // trim characters
      var itemText = daNewItem.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
      if (itemText != "") {
        makeNewItem(itemText, daDateTime: daDateTime)
    } }
}
  
func makeNewItem(itemText :NSString, daDateTime :NSDate) {
    // create Item
    var newItem:PFObject = PFObject(className: "Items")
    newItem.setObject("\(itemText)", forKey: "name")
    
    // add user
    newItem.setObject(PFUser.currentUser().username, forKey: "username")
    
    // add triggerOrSymptom
    newItem.setObject("trigger", forKey: "type")
    
    var d = daDateTime
    
    //if (d != nil) {
    //println("datetime d: \(d)")
    newItem.setObject(d, forKey: "myDateTime")
    //} else {
    //  println("*** YO!! nil on datetime - In process input, saving nil to DB! ***")
    //}
    
    // add amount
    newItem.setObject("2", forKey: "amount")
    
    // save item
    //self.saveObject(newItem)
    newItem.saveInBackgroundWithBlock {
    (Bool, NSError) -> Void in
      /* if (success == true) {
      //println("\n ** Object created: \(sender.objectId)")
      //self.items.insertObject(newItem, atIndex: 0)
      //self.tableView.reloadData();                 // todo fix - move this later?
      } else {
      println("%@", error)
      } */
    }
}
  

func splitIntoEntries(theText :NSString) -> NSArray {
    var newText = theText.stringByTrimmingCharactersInSet(NSCharacterSet (charactersInString: "., "))
    var newItems :NSArray = newText.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: ".,"))
    return newItems
}

}