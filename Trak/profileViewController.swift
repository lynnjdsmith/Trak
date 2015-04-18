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
  @IBOutlet var weatherInfo :UITextView!
  @IBOutlet var menuButton: UIButton!
  @IBOutlet var topBackView: UIView!
  var client: Sweather?
  
    override func viewDidLoad() {
      super.viewDidLoad()
      username.text = PFUser.currentUser().username
      deleteMyAccount.normalStyle("Delete My Account")
      logout.normalStyle("Logout")
      client = Sweather(apiKey: "9e0cabd83c8615c7f232ad172c032585")
      
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
  
  func checkWeather() {
    client?.currentWeather("55419") { result in
      //self.activityIndicatorView?.hidden = true;
      switch result {
      case .Error(let response, let error):
        self.weatherInfo.text = "Some error occured. Try again."
      case .Success(let response, let dictionary):
        self.weatherInfo.text = "Received data: \(dictionary)"
        
        // Get temperature for city this way
        let city = dictionary["name"] as? String;
        let temperature = dictionary["main"]!["temp"] as! Int;
        println("City: \(city) Temperature: \(temperature)")
      }
    }
  }
  
}
