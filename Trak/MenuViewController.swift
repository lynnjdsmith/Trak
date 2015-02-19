//
//  MenuViewController.swift
//  Trak
//
//  Created by Lynn Smith on 2/4/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation

class MenuViewController: UIViewController {

  @IBOutlet weak var mainButton: UIButton!
  @IBOutlet weak var profileButton: UIButton!
  @IBOutlet weak var logoutButton: UIButton!
  
  @IBAction func mainButtonPressed(sender: AnyObject) {
    //self.revealViewController()?.rightRevealToggle(sender)
    performSegueWithIdentifier("sw_main", sender: self)
  }
  
  @IBAction func profileButtonPressed(sender: AnyObject) {
      performSegueWithIdentifier("sw_profile", sender: self)
  }
  
  @IBAction func logoutButtonPressed(sender: AnyObject) {
    //println("loggedout Current User: \(PFUser.currentUser())")
    PFUser.logOut()
    //let appDomain = NSBundle.mainBundle().bundleIdentifier
    //NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
    performSegueWithIdentifier("sw_logout", sender: self)
  }
  
  
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "sw_profile") {
      //let navigationController = segue.destinationViewController as UINavigationController
      //var controller = navigationController.topViewController as AddItemViewController
      //controller.delegate = self
    }
  }
  
  
  /* - (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
  {
  // configure the destination view controller:
  if ( [sender isKindOfClass:[UITableViewCell class]] )
  {
  UILabel* c = [(SWUITableViewCell *)sender label];
  UINavigationController *navController = segue.destinationViewController;
  ColorViewController* cvc = [navController childViewControllers].firstObject;
  if ( [cvc isKindOfClass:[ColorViewController class]] )
  {
  cvc.color = c.textColor;
  cvc.text = c.text;
  }
  }
  } */
  

}