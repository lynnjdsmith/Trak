//
//  profileViewController.swift
//

import UIKit
import QuartzCore

class profileViewController: UIViewController{
  
    // MARK: - Variables
  
  // IBOutlets
  @IBOutlet var username: UILabel!
  @IBOutlet var deleteMyAccount: UIButton!
  @IBOutlet var logout: UIButton!
  @IBOutlet var weatherInfo :UITextView!
  @IBOutlet var menuButton: UIButton!
  @IBOutlet var topBackView: UIView!
  var myZip = 0
  
    // MARK: - Functions
  
    override func viewDidLoad() {
      super.viewDidLoad()
      username.text = PFUser.currentUser().username
      deleteMyAccount.normalStyle("Delete My Account")
      logout.normalStyle("Logout")

      // general set stuff
      topBackView.layer.borderWidth = 0.3
      topBackView.layer.borderColor = UIColor.appLightGray().CGColor
      
      //var theForecast :NSDictionary = (NSUserDefaults.standardUserDefaults().objectForKey("weatherForecast") as? NSDictionary)!
      //println("\n *** the forecast ***")
      //println(theForecast)
      //cWeather.unpinInBackground()
      
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
    PFUser.logOut()
    self.performSegueWithIdentifier("go_login", sender: self)
  }
  
}
