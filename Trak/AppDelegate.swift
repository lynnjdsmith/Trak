//
//  AppDelegate.swift
// Created by Lynn Smith Trak copyright tm May 2014
//
// http://blog.parse.com/2014/12/09/parse-local-datastore-for-ios/
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
      
      // set parse and instabug
      Parse.enableLocalDatastore()
      Parse.setApplicationId("YOv7iq9CvkNPChaTF34w3e1epQ9qyiTRbGEHvrDt", clientKey: "tdB12swrr8c2axfE26eZXVvxDq4ZahdOEhMXSjoA")
      Instabug.startWithToken("dcea2ba4a815b84590074f75715ae8b9", captureSource:IBGCaptureSourceUIKit, invocationEvent:IBGInvocationEventShake)
    
      // reroute to parse login if user is not logged in
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      
      if self.window != nil {

        if PFUser.currentUser() == nil {
          self.window!.rootViewController = storyboard.instantiateViewControllerWithIdentifier("logInViewController") as PFLogInViewController
        }
        else {
          self.window!.rootViewController = storyboard.instantiateViewControllerWithIdentifier("SWRevealViewController") as SWRevealViewController
        }
      }
      
      return true
      
  
    }

    func applicationWillResignActive(application: UIApplication!) {
    }

    func applicationDidEnterBackground(application: UIApplication!) {
    }

    func applicationWillEnterForeground(application: UIApplication!) {
    }

    func applicationDidBecomeActive(application: UIApplication!) {
    }

    func applicationWillTerminate(application: UIApplication!) {
    }
  
}

