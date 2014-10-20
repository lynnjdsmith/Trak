//
//  profileViewController.swift
//

import UIKit
import QuartzCore


class profileViewController: UIViewController {
    
  // IBOutlets
  @IBOutlet var username: UILabel!
  @IBOutlet var deleteMyAccount: UIButton!
  @IBOutlet var logout: UIButton!
  @IBOutlet var migraineTrak: UIButton!
  
  
    override func viewDidLoad() {
      super.viewDidLoad()
      username.text = PFUser.currentUser().username
      deleteMyAccount.normalStyle("Delete My Account")
      logout.normalStyle("Logout")
      //migraineTrak.normalStyle("Your Traks")
    }

  
    @IBAction func deleteMe(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
  
  
  
  @IBAction func logoutTapped(sender : UIButton) {
    //println("loggedout Current User: \(PFUser.currentUser())")
    PFUser.logOut()
    let appDomain = NSBundle.mainBundle().bundleIdentifier
    NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
    self.performSegueWithIdentifier("go_login", sender: self)
  }
  
  
  @IBAction func migraineTrak(sender : UIButton) {
    let appDomain = NSBundle.mainBundle().bundleIdentifier
    NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
    self.performSegueWithIdentifier("go_setTraks", sender: self)
  }
  
  
    @IBAction func done(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(false, completion: nil)
            println("done")
        }
    }
    
}
