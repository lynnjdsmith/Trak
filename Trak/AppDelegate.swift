//
//  AppDelegate.swift
// Created by Lynn Smith Trak copyright tm May 2014
//
// http://blog.parse.com/2014/12/09/parse-local-datastore-for-ios/
// todo - prevent duplicate entries , especially the weather ones below.

import UIKit
import CoreLocation
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
 
    // MARK: - Variables
  
    var window          :UIWindow?
    let locationManager = CLLocationManager()
    var locationDone    :Bool = false
    var locationObj     :CLLocation = CLLocation()
    var myWeatherBot    :weatherBot = weatherBot()
  
    // MARK: - Functions
  
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
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
          
          // if we are logged in, start the location / weather trigger checking process
          if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
          } else {
            println("Location services are not enabled")
          }
          
          // navigate to main screen
          self.window!.rootViewController = storyboard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
        }
      }
      
      return true
    }

  
  // MARK: - Core Location
  
  func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
    //locationManager.stopUpdatingLocation()
    //p("loc manager ERROR! *** *** ***")
    if ((error) != nil) { print(error) }
  }
  
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    locationManager.stopUpdatingLocation()
    //p("loc manager NO ERROR! *** *** *** NO ERROR!")
    if !locationDone {
      self.locationDone = true
      //p("DO EEET!")
      
      // get your coordinates
      var locationArray = locations as NSArray
      var locationObj = locationArray.lastObject as! CLLocation
      var coord :CLLocationCoordinate2D = locationObj.coordinate
      
      // have we checked for weather triggers today?
      var todayDateString :String = getDateStringForYYYYMMDD(NSDate()) as String
      if (todayDateString != NSUserDefaults.standardUserDefaults().stringForKey("lastDayWeatherDone")) {
        
        // check for and add weather triggers
        // todo TURN THIS ON myWeatherBot.checkWeatherForTriggers(coord, theDate: NSDate())
      }
      NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "lastDayWeatherDone")
    }
  }
  
  func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus)
  {
    if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse || CLLocationManager.authorizationStatus() == .AuthorizedAlways {
    manager.startUpdatingLocation()
    }
  }
  
  /*
  // MARK: - Core Data - todo remove later?
  
  lazy var applicationDocumentsDirectory: NSURL = {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.count-1] as! NSURL
    }()
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    let modelURL = NSBundle.mainBundle().URLForResource("Trak", withExtension: "momd")!
    return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
  
  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
    var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Trak.sqlite")
    var error: NSError? = nil
    var failureReason = "There was an error creating or loading the application's saved data."
    if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
      coordinator = nil
      
      // Report any error we got.
      let dict = NSMutableDictionary()
      dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
      dict[NSLocalizedFailureReasonErrorKey] = failureReason
      dict[NSUnderlyingErrorKey] = error
      error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict as [NSObject : AnyObject])

      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog("Unresolved error \(error), \(error!.userInfo)")
      //abort()
    }
    return coordinator
    }()
  

  lazy var managedObjectContext: NSManagedObjectContext? = {
    let coordinator = self.persistentStoreCoordinator
    if coordinator == nil {
      return nil
    }
    var managedObjectContext = NSManagedObjectContext()
    managedObjectContext.persistentStoreCoordinator = coordinator
    return managedObjectContext
    }()
  
  
    // Core Data Saving Support
  
  func saveContext () {
    if let moc = self.managedObjectContext {
      var error: NSError? = nil
      if moc.hasChanges && !moc.save(&error) {
        NSLog("Unresolved error \(error), \(error!.userInfo)")
        abort()
  } } }
*/
  
  
    // MARK: - Empty Functions for App Delegate
  
  func applicationWillResignActive(application: UIApplication) { }
  
  func applicationDidEnterBackground(application: UIApplication) { }
  
  func applicationWillEnterForeground(application: UIApplication) { }
  
  func applicationDidBecomeActive(application: UIApplication) { }
  
  func applicationWillTerminate(application: UIApplication) { }
  
}

