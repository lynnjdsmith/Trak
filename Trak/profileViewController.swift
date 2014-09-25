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
    
    override func viewDidLoad() {
      super.viewDidLoad()
      username.text = PFUser.currentUser().username
      deleteMyAccount.normalStyle("Delete My Account")
      logout.normalStyle("Logout")

    }

  
    @IBAction func deleteMe(sender: AnyObject) {
        //println("Delete Me!")
        
        /* delete an item var query = PFQuery(className:"Items")
        query.getObjectInBackgroundWithId(objID) {
            (theItem: PFObject!, error: NSError!) -> Void in
            if !error {
                //NSLog("deleted - %@", theItem)
                theItem.deleteInBackground()
                if let d = self.delegate {
                    d.closeMod(theItem)
                }
            } else {
                NSLog("%@", error)
            }
        } */
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
  
  
  
  @IBAction func logoutTapped(sender : UIButton) {

    PFUser.logOut()
    //println("loggedout Current User: \(PFUser.currentUser())")

    let appDomain = NSBundle.mainBundle().bundleIdentifier
    NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
    
    self.performSegueWithIdentifier("go_login", sender: self)
    
    /* var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController
    self.presentViewController(viewcontroller, animated: true, completion: nil) */
  }
  
  
    func addAndStyleButtons() {

        // add Delete button
        var delete = UIButton.buttonWithType(UIButtonType.System) as UIButton
        delete.normalStyle("Delete This Item")

        /*delete.frame = CGRectMake(25, 480, 160, 30)
        delete.backgroundColor = UIColor.appRed()
        delete.layer.cornerRadius = 8
        delete.layer.borderWidth = 0

        delete.clipsToBounds = true;
        delete.setTitle("Delete This Item", forState: .Normal)
        delete.setTitleColor(UIColor.btnText(), forState: .Normal) */
        delete.addTarget(self, action: "deleteMe:", forControlEvents: .TouchUpInside)
        self.view.addSubview(delete)
    }

    
    @IBAction func done(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(false, completion: nil)
            println("done")
        }
    }
    
}
