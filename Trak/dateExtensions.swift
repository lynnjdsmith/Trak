//
//  theExtensions.swift
//  
// http://stackoverflow.com/questions/24590604/changing-button-text-from-modal-view-controller-in-swift
// https://www.parse.com/questions/how-do-i-search-objects-created-on-a-specific-date
// http://stackoverflow.com/questions/24844568/swift-custom-back-button-and-destination

import Foundation

/* CALENDAR AND DATE FUNCTIONS */

func addDaysToDate(daysToAdd: Int, originalDate: NSDate) -> NSDate? {
  let newDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.CalendarUnitDay, value: daysToAdd, toDate: originalDate, options: nil)
  return newDate
}

    // UTC

func getUTCDateFromString(theDT :String) -> NSDate {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
  let d :NSDate = dateFormatter.dateFromString(theDT)!
  return d
}

func getUTCStringFromDate(theDT :NSDate) -> String {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
  let d :String = dateFormatter.stringFromDate(theDT)
  return d
}

    // descriptive 

func getDateDescriptiveStringFromString(val :NSString) -> NSString {
  println("getDateDescriptiveStringFromString val: \(val)")
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "MM/dd/yyyy"
  let str1 :NSDate = dateFormatter.dateFromString(val as! String)!
  let dateFormatter2 = NSDateFormatter()
  dateFormatter2.dateFormat = "EEEE, MMM d "
  let str2 :NSString = dateFormatter2.stringFromDate(str1)
  return str2
}

    // YYYYMMDD for weatherBot

func getDateStringYYYYMMDDFromString(val :NSString) -> NSString {
  // in: 04/21/2015
  println("getDateStringYYYYMMDDFromString val: \(val)")
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "MM/dd/yyyy"
  let str1 :NSDate = dateFormatter.dateFromString(val as! String)!
  let dateFormatter2 = NSDateFormatter()
  dateFormatter2.dateFormat = "YYYYMMdd"
  let str2 :NSString = dateFormatter2.stringFromDate(str1)
  return str2
}

func getDateStringForYYYYMMDD(val :NSDate) -> NSString {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "YYYYMMdd"
  let dateString :NSString = dateFormatter.stringFromDate(val) as NSString
  return dateString
}

    // used in weatherBot

func getUTCDateFromPrettyString(theDT :String) -> NSDate {
  // Pretty is: 12:53 AM CDT on April 24, 2015
  //"EEE, MMM dd yyyy hh:mm a"] = Wed, Dec 14 2011 1:50 PM
  //"MMMM dd, yyyy (EEEE) HH:mm:ss z Z"] = January 23, 2013 (Wednesday) 12:33:46 PST -0800
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "hh:mm a z MMMM dd, yyyy"
  let d :NSDate = dateFormatter.dateFromString(theDT)!
  return d
}


// TIME

func getTimeStringFromDate(theDT :NSDate) -> String {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "hh:mm a"
  let d :String = dateFormatter.stringFromDate(theDT)
  return d
}

func getTimeFromString(theDT :NSString) -> NSDate {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "hh:mm a"
  //var d = dateFormatter.stringFromDate(theDT)
  let d :NSDate = dateFormatter.dateFromString(theDT as! String)!
  //if let checkedVal = d.dateByAddingTimeInterval(5.0) { }// if this works, d is a date
  //else { println("** YO! You probably have an empty value!") } // this means d is nil
  return d
}

