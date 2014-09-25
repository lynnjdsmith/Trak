//
//  signUpViewController.swift
//
//https://parse.com/tutorials/login-and-signup-views
//https://parse.com/docs/ios_guide#top/iOS
//self.view.backgroundColor = UIColor.blackColor()
//self.view.backgroundColor = UIColor.colorWithPatternImage.UIImage imageNamed:@"main_background.png"]];


class signUpViewController: PFSignUpViewController, PFSignUpViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        var fieldsBackground = UIImageView(image:UIImage(named:"bkg1_320.png"))
        self.signUpView.insertSubview(fieldsBackground, atIndex:1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.signUpView.logo.layer.frame = CGRectMake(66.5, 60.0, 187.0, 58.5)
        self.signUpView.logo.backgroundColor = UIColor(patternImage:(UIImage(named:"logo_470x130.png")))
        
        self.signUpView.dismissButton.layer.frame = CGRectMake(275.0, 8.0, 45.5, 45.5)
        self.signUpView.dismissButton.hidden = false;
        
        self.signUpView.usernameField.layer.frame = CGRectMake(35.0, 150.0, 250.0, 50.0)
        self.signUpView.usernameField.backgroundColor = UIColor.whiteColor()
        self.signUpView.usernameField.textColor = UIColor(red: 135.0/255.0, green: 100.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        self.signUpView.usernameField.layer.shadowOpacity = 0.0
        self.signUpView.usernameField.borderStyle = UITextBorderStyle.RoundedRect
        self.signUpView.usernameField.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor
        
        self.signUpView.passwordField.layer.frame = CGRectMake(35.0, 220.0, 250.0, 50.0)
        self.signUpView.passwordField.backgroundColor = UIColor.whiteColor()
        self.signUpView.passwordField.textColor = UIColor(red: 135.0/255.0, green: 100.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        self.signUpView.passwordField.layer.shadowOpacity = 0.0
        self.signUpView.passwordField.borderStyle = UITextBorderStyle.RoundedRect
        self.signUpView.passwordField.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor
        
        self.signUpView.emailField.layer.frame = CGRectMake(35.0, 290.0, 250.0, 50.0)
        self.signUpView.emailField.backgroundColor = UIColor.whiteColor()
        self.signUpView.emailField.textColor = UIColor(red: 135.0/255.0, green: 100.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        self.signUpView.emailField.layer.shadowOpacity = 0.0
        self.signUpView.emailField.borderStyle = UITextBorderStyle.RoundedRect
        self.signUpView.emailField.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor
        
        self.signUpView.signUpButton.layer.frame = CGRectMake(35.0, 370.0, 250.0, 40.0)
        self.signUpView.signUpButton.backgroundColor = UIColor.clearColor()
        self.signUpView.signUpButton.setImage(UIImage(named:"Default-568h@2x.png"), forState: UIControlState.Highlighted)
        self.signUpView.signUpButton.setTitle("Start Tracking!", forState:UIControlState.Normal)
        self.signUpView.signUpButton.setTitle("Start Tracking!", forState:UIControlState.Highlighted)
        self.signUpView.signUpButton.addTarget(self, action: Selector("showMain"), forControlEvents: .TouchUpInside)
    }
  
  /* func signUpViewController(PFSignUpViewController!, didSignUpUser PFUser:user) {
  
    println("******* DIDSIGNUPUSER ******* /n")
    
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("navViewController") as UIViewController
    self.presentViewController(viewcontroller, animated: true, completion: nil)
    
  } */
  
  //if(self.presentingViewController){
 // self.dismissViewControllerAnimated(false, completion: nil)
  //println("done")
//}
    func showMain() {
      if((self.presentingViewController) != nil){
        self.dismissViewControllerAnimated(false, completion: nil)
        println("Signed in. Navigating to timeline")
      }
    }
}