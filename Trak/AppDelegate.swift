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
        Parse.setApplicationId("fYKgQaZQVXiHaPF4CqpTpYCUHrgjcdTd0mUg6EZX", clientKey: "anNgZkMlFrFNOVFIMgJJs1BmZUgTBm4Zkie00oUB")
        Instabug.startWithToken("dcea2ba4a815b84590074f75715ae8b9", captureSource:IBGCaptureSourceUIKit, invocationEvent:IBGInvocationEventShake)
        
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

