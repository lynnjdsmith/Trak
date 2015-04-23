//
//  AppDelegate.swift
// Created by Lynn Smith Trak copyright tm May 2014
//
// http://blog.parse.com/2014/12/09/parse-local-datastore-for-ios/
import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
                            
    var window: UIWindow?
    var client: Sweather_Underground?
    let locationManager = CLLocationManager()
    var locationDone : Bool = false
    var locationObj :CLLocation = CLLocation()
  
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
      // core location permission - OPENWEATHERMAP not working, use weather underground
      //client = Sweather(apiKey: "9e0cabd83c8615c7f232ad172c032585")
      client = Sweather_Underground(apiKey: "9e0cabd83c8615c7f232ad172c032585") // you can take this api key out later
      
      if (CLLocationManager.locationServicesEnabled()) {
        locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
      } else {
        println("Location services are not enabled")
      }
      
      //mixpanel
      Mixpanel.sharedInstanceWithToken("0b438b51e33091163dc132a4094c241e")
      var mixPanel = Mixpanel.sharedInstance()
      mixPanel.track("Finished Launching", properties: ["name1":"property1","name2":"property2"])
      mixPanel.track("Opened Launch")
      //println("logged mixpanel")
      
      // set parse and instabug
      Parse.enableLocalDatastore()
      Parse.setApplicationId("YOv7iq9CvkNPChaTF34w3e1epQ9qyiTRbGEHvrDt", clientKey: "tdB12swrr8c2axfE26eZXVvxDq4ZahdOEhMXSjoA")
      Instabug.startWithToken("dcea2ba4a815b84590074f75715ae8b9", captureSource:IBGCaptureSourceUIKit, invocationEvent:IBGInvocationEventShake)
    
      // reroute to parse login if user is not logged in
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      
      if self.window != nil {

        if PFUser.currentUser() == nil {
          self.window!.rootViewController = storyboard.instantiateViewControllerWithIdentifier("logInViewController") as! PFLogInViewController
        }
        else {
          self.window!.rootViewController = storyboard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
        }
      }
      
      return true
      
  
    }

  
  /****  MARK: - CoreLocation Methods  ****/
  
  func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
    locationManager.stopUpdatingLocation()
    if ((error) != nil) {
      print(error)
    }
  }
  
  //http://api.openweathermap.org/data/2.5/history/city?id=2885679&type=hour
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    locationManager.stopUpdatingLocation()
    if !locationDone {
      var locationArray = locations as NSArray
      var locationObj = locationArray.lastObject as! CLLocation
      var coord :CLLocationCoordinate2D = locationObj.coordinate
      //var theCity :AnyObject! = locationManager.findCity(coord)
      //getHistoryWeather(Int(5043193))
      //getCurrentWeather(coord)
      //getForecast(coord)
      updateWeatherInfo(coord)
      self.locationDone = true
    }
  }
  
  func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus)
  {
    if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse || CLLocationManager.authorizationStatus() == .AuthorizedAlways {
    manager.startUpdatingLocation()
    }
  }
  
  /**** Weather Underground *****/
  func updateWeatherInfo(theCoord: CLLocationCoordinate2D) {
    //println(params)
    client?.findCity(theCoord) { result in
      //println("result time!")
      switch result {
      case .Error(let response, let error):
        println("Some error occured. Try again.")
      case .Success(let response, let dictionary):
        let city = dictionary["location"]!["city"] as! String
        let state = dictionary["location"]!["state"] as! String
        self.client?.forecast(city, state: state, dateVal: "20150411") { result in
          println("result time 2!")
          switch result {
          case .Error(let response, let error):
            println("Some error occured. Try again.")
          case .Success(let response, let dictionary2):
          
            var results: NSArray = dictionary2["history"]!["observations"] as! NSArray
            //println(results)
            var theHour :Int = 0
            var theMins :Int = 0
            var currentMinutesIntoDay :Int = 0
            
            for item in results {
              let obj = item as! NSDictionary
              for (key, value) in obj {
                if (key as! String == "date") {
                  let valObj = value as! NSDictionary
                  for (key2, value2) in valObj {
                    if (key2 as! String == "hour") {
                      let theVal = value2 as! NSString
                      theHour = theVal.integerValue
                    }
                    if (key2 as! String == "min") {
                      let theVal = value2 as! NSString
                      theMins = theVal.integerValue
                    }
                    currentMinutesIntoDay = (theHour * 60) + theMins
                  }
                }
                if (key as! String == "pressurei") {
                  println("currentMinsIntoDay: \(currentMinutesIntoDay)")
                  println("\(key) : \(value)")
                }
              }
            }
            
            //println(dictionary2)
            NSUserDefaults.standardUserDefaults().setObject(dictionary2, forKey: "weatherForecast")
            NSUserDefaults.standardUserDefaults().synchronize()
          }
        }
      }
    }
  }
 
  func findCity(theCoord: CLLocationCoordinate2D) {
    client?.findCity(theCoord) { result in
      //println("result time!")
      switch result {
      case .Error(let response, let error):
        println("Some error occured. Try again.")
      case .Success(let response, let dictionary):
        println("got City... \n \(dictionary)")
        //var city :NSArray = dictionary["list"] as! NSArray
        //var main :AnyObject? = list.valueForKey("main")
        //NSUserDefaults.standardUserDefaults().setObject(dictionary, forKey: "weatherForecast")
        //NSUserDefaults.standardUserDefaults().synchronize()
      }
    }
  }
  
  /**** OLD Open Weather Map stuff *****/
 /*  func getHistoryWeather(theCityID :Int) {
    client?.historyWeather(theCityID) { result in
      println("in Get History Weather")
      switch result {
      case .Error(let response, let error):
        println("***** history weather error -- \(error)")
      case .Success(let response, let dictionary):
        println(dictionary)
        
        /* var list :NSArray = dictionary["list"] as! NSArray
        var main :AnyObject? = list.valueForKey("main")
        var seaLevelBarP_Group :AnyObject? = main!.valueForKey("sea_level")
        var main1 :AnyObject? = list.valueForKey("main")   // this makes it just the first one
        var seaLevelBarP :Double = (main1!.valueForKey("sea_level") as? Double)!
        var seaLevelInches :Double = seaLevelBarP * 0.02953
        println("Bar Inches: \(seaLevelInches)")
        var barPStatus = seaLevelInches.getBarP_Status()
        println("Bar Status: \(barPStatus)") */
      }
    }
  }
  
  func getCurrentWeather(theCoord: CLLocationCoordinate2D) {
    client?.currentWeather(theCoord) { result in
      switch result {
      case .Error(let response, let error):
        println("Some error occured. Try again.")
        println("Error: \(error)")
      case .Success(let response, let dictionary):
        //println("Received data: \(dictionary)")
        
        // Get temperature
        let city = dictionary["name"] as? String
        //println("City: \(city)")
        
        let temperature = dictionary["main"]!["temp"] as! Int
        //println("Current Temperature: \(temperature)")
        //self.weatherInfo.text = "\(self.weatherInfo.text) Temp: \(temperature) \n"
        
        /* weatherReading.saveInBackgroundWithBlock {
          (success: Bool, error: NSError?) -> Void in
          if (success) {
            // The object has been saved.
          } else {
            // There was a problem, check error.description
          }
        } */

        
        /* example from https://github.com/bfolder/Sweather/blob/master/Example/Example/ViewController.swift
        let city = dictionary["name"] as? String;
        let temperature = dictionary["main"]!["temp"] as Int;
        println("City: \(city) Temperature: \(temperature)")
        */
      }
    }
  }
  
  func getForecast(theCoord: CLLocationCoordinate2D) {
    client?.forecast(theCoord) { result in
      //println("result time!")
      switch result {
      case .Error(let response, let error):
        println("Some error occured. Try again.")
      case .Success(let response, let dictionary):
        println("setting weather forecast")
        NSUserDefaults.standardUserDefaults().setObject(dictionary, forKey: "weatherForecast")
        NSUserDefaults.standardUserDefaults().synchronize()
        var list :NSArray = dictionary["list"] as! NSArray
        var main :AnyObject? = list.valueForKey("main")
        var seaLevelBarP_Group :AnyObject? = main!.valueForKey("sea_level")
        var main1 :AnyObject? = list[1].valueForKey("main")   // this makes it just the first one
        var seaLevelBarP :Double = (main1!.valueForKey("sea_level") as? Double)!
        var seaLevelInches :Double = seaLevelBarP * 0.02953
        //println("Bar Inches: \(seaLevelInches)")
        var barPStatus = seaLevelInches.getBarP_Status()
        //println("Bar Status: \(barPStatus)")
      }
    }
  } */
  
    /****  END: - CoreLocation  ****/
  
    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
  
}

