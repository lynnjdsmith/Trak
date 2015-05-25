//
//  WeatherBot.swift
//  Trak
//
//  Created by Lynn Smith on 4/23/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation
import CoreLocation

class weatherBot :NSObject {
  
  // MARK: - functions

  func checkWeatherForTriggers(theCoord: CLLocationCoordinate2D, theDate: NSDate) {
    var currentMinutesIntoDay :Double = 0
    var previousMinutesIntoDay :Double = 0
    var theHour :Double = 0
    var theMins :Double = 0
    var myItemBot :itemBot = itemBot()
    var previousP :Double = 0.0
    var currentP :Double = 0.0
    var currentItemDateString :String = "12:53 AM CDT on April 24, 2015"  // placeholders
    var previousItemDateString :String = "12:53 AM CDT on April 24, 2015"
    var theDateString :String = ""
    
    // find your city
    self.findCity(theCoord) { result in
      switch result {
      case .Error(let response, let error): println("Some error occured. Try again.")
      case .Success(let response, let dictionary):
        let city = dictionary["location"]!["city"] as! String
        let state = dictionary["location"]!["state"] as! String

        // call forecast
        var theDateString :String = getDateStringForYYYYMMDD(NSDate()) as String
        self.forecast(city, state: state, dateVal: theDateString) { result in
          switch result {
          case .Error(let response, let error): println("Some error occured. Try again.")
          case .Success(let response, let dictionary2):
            var results: NSArray = dictionary2["history"]!["observations"] as! NSArray
            //println(results)
            
            // check each weather observation for a barometric trigger
            for item in results {
              let obj = item as! NSDictionary
              for (key, value) in obj {
                
                // put variables into variables
                if (key as! String == "date") {
                  let valObj = value as! NSDictionary
                  for (key2, value2) in valObj {
                    if (key2 as! String == "hour") { theHour = (value2 as? NSString)!.doubleValue }
                    if (key2 as! String == "min") {
                      theMins = (value2 as? NSString)!.doubleValue
                      previousMinutesIntoDay = currentMinutesIntoDay
                      currentMinutesIntoDay = (theHour * 60) + theMins
                    }
                    if (key2 as! String == "pretty") {
                      theDateString = value2 as! String
                      currentItemDateString = value2 as! String
                    }
                  }
                }
                
                // check pressure - time to make the new item! (if it's valid)
                if (key as! String == "pressurei") {
                  var timeToChange :Double = (currentMinutesIntoDay - previousMinutesIntoDay)
                  theDateString = previousItemDateString.stringByReplacingOccurrencesOfString(" on", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                  let d :NSDate! = getUTCDateFromPrettyString(theDateString)
                  previousP = currentP
                  currentP = value.doubleValue
                  if (previousP != 0.0) {
                    var diff = abs(currentP - previousP)
                    if (diff > 0.03) {
                      myItemBot.makeNewItem("BaroChangeQuick", daDateTime: d)
                  } }
                    previousItemDateString = currentItemDateString
                }
              
        } } } } // call forecast
        
    } } // call city
    
  }
  
  
  // MARK: - data calling functions
  
  func findCity(coordinate: CLLocationCoordinate2D, callback: (Result) -> ()) {
    call("http://api.wunderground.com/api/75d83e44364c755f/geolookup/q/\(coordinate.latitude),\(coordinate.longitude).json", callback: callback);
  }
  
  func forecast(cityName: String, state: String, dateVal: String, callback: (Result) -> ()) {
    call("http://api.wunderground.com/api/75d83e44364c755f/history_\(dateVal)/q/\(state)/\(cityName).json", callback: callback);
  }
  
  private func call(url: String, callback: (Result) -> ()) {
    //println(url)
    let request = NSURLRequest(URL: NSURL(string: url)!)
    let currentQueue = NSOperationQueue.currentQueue();
    
    NSURLConnection.sendAsynchronousRequest(request, queue: currentQueue) { (response: NSURLResponse!, data: NSData!, error: NSError?) -> Void in
      var error: NSError? = error
      var dictionary: NSDictionary?
      
      if let data = data {
        dictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &error) as? NSDictionary;
      }
      currentQueue?.addOperationWithBlock {
        var result = Result.Success(response, dictionary)
        if error != nil {
          result = Result.Error(response, error)
        }
        callback(result)
      }
    }
  }
  
  internal enum Result {
    case Success(NSURLResponse!, NSDictionary!)
    case Error(NSURLResponse!, NSError!)
    
    internal func data() -> NSDictionary? {
      switch self {
      case .Success(let response, let dictionary):
        return dictionary
      case .Error(let response, let error):
        return nil
      }
    }
    
    internal func response() -> NSURLResponse? {
      switch self {
      case .Success(let response, let dictionary):
        return response
      case .Error(let response, let error):
        return response
      }
    }
    
    internal func error() -> NSError? {
      switch self {
      case .Success(let response, let dictionary):
        return nil
      case .Error(let response, let error):
        return error
      }
    }
  }
  
}