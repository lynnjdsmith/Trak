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
  //@IBOutlet var migraineTrak: UIButton!
  @IBOutlet var menuButton: UIButton!
  @IBOutlet var topBackView: UIView!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      username.text = PFUser.currentUser().username
      deleteMyAccount.normalStyle("Delete My Account")
      logout.normalStyle("Logout")
      
      // general set stuff
      topBackView.layer.borderWidth = 0.3
      topBackView.layer.borderColor = UIColor.appLightGray().CGColor

      //migraineTrak.normalStyle("Your Traks")
    }

  @IBAction func menuPressed(sender: AnyObject) {
    self.revealViewController()?.rightRevealToggle(sender)
    self.view.endEditing(true)
    //println("mP **")
  }
  
  @IBAction func deleteMe(sender: AnyObject) {
      self.navigationController?.popToRootViewControllerAnimated(true)
  }
  
  @IBAction func logoutTapped(sender : UIButton) {
    //println("loggedout Current User: \(PFUser.currentUser())")
    PFUser.logOut()   //
    //let appDomain = NSBundle.mainBundle().bundleIdentifier
    //NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
    self.performSegueWithIdentifier("go_login", sender: self)
  }
  
  
  @IBAction func migraineTrak(sender : UIButton) {
    //let appDomain = NSBundle.mainBundle().bundleIdentifier
    //NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
    self.performSegueWithIdentifier("go_setTraks", sender: self)
  }
  
  
    @IBAction func done(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(false, completion: nil)
            println("done")
        }
    }
    
}
