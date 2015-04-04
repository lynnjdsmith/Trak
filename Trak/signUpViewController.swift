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
        self.delegate = self
      
        self.signUpView.passwordField.delegate = self
      
        self.view.backgroundColor = UIColor.clearColor()
        var fieldsBackground = UIImageView(image:UIImage(named:"bkg1_320.png"))
        var screenSize: CGRect = UIScreen.mainScreen().bounds
        fieldsBackground.frame =  CGRectMake(0.0, 0.0, screenSize.width, screenSize.height)
        self.signUpView.insertSubview(fieldsBackground, atIndex:1)
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var screenSize: CGRect = UIScreen.mainScreen().bounds
        var eigthW :CGFloat = screenSize.width / 8
        var eigthH :CGFloat = screenSize.height / 8
      
        self.signUpView.logo.layer.frame = CGRectMake(66.5, 60.0, 187.0, 58.5)
        //self.signUpView.logo.backgroundColor = UIColor(patternImage:(UIImage(named:"logo_470x130.png"))!)
        
        self.signUpView.dismissButton.layer.frame = CGRectMake(eigthW * 7, eigthW * 0.5, eigthW * 0.8, eigthW * 0.8)
        self.signUpView.dismissButton.hidden = false;
        
        self.signUpView.usernameField.layer.frame = CGRectMake(eigthW, eigthH * 2.5, eigthW * 6, 50.0)
        self.signUpView.usernameField.backgroundColor = UIColor.whiteColor()
        self.signUpView.usernameField.textColor = UIColor(red: 135.0/255.0, green: 100.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        self.signUpView.usernameField.layer.shadowOpacity = 0.0
        self.signUpView.usernameField.borderStyle = UITextBorderStyle.RoundedRect
        self.signUpView.usernameField.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor
        
        self.signUpView.passwordField.layer.frame = CGRectMake(eigthW, eigthH * 3.5, eigthW * 6, 50.0)
        self.signUpView.passwordField.backgroundColor = UIColor.whiteColor()
        self.signUpView.passwordField.textColor = UIColor(red: 135.0/255.0, green: 100.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        self.signUpView.passwordField.layer.shadowOpacity = 0.0
        self.signUpView.passwordField.borderStyle = UITextBorderStyle.RoundedRect
        self.signUpView.passwordField.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor
        
        self.signUpView.emailField.layer.frame = CGRectMake(eigthW, eigthH * 4.5, eigthW * 6, 50.0)
        self.signUpView.emailField.backgroundColor = UIColor.whiteColor()
        self.signUpView.emailField.textColor = UIColor(red: 135.0/255.0, green: 100.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        self.signUpView.emailField.layer.shadowOpacity = 0.0
        self.signUpView.emailField.borderStyle = UITextBorderStyle.RoundedRect
        self.signUpView.emailField.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor
        
        self.signUpView.signUpButton.layer.frame = CGRectMake(eigthW, eigthH * 5.5, eigthW * 6, 50.0)
        self.signUpView.signUpButton.backgroundColor = UIColor.clearColor()
        self.signUpView.signUpButton.setImage(UIImage(named:"Default-568h@2x.png"), forState: UIControlState.Highlighted)
        self.signUpView.signUpButton.setTitle("Sign Up!", forState:UIControlState.Normal)
        self.signUpView.signUpButton.setTitle("Sign Up!", forState:UIControlState.Highlighted)
        //self.signUpView.signUpButton.addTarget(self, action: Selector("showMain"), forControlEvents: .TouchUpInside)
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
   /*  func showMain() {
      println("show main")
      var mainView: UIStoryboard!
      mainView = UIStoryboard(name: "Main", bundle: nil)
      var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("navViewController") as UIViewController
      self.presentViewController(viewcontroller, animated: true, completion: nil)
      
  } */
  
  // Parse login signup swift http://www.veasoftware.com/tutorials/2015/2/28/twitter-login-with-parse-in-swift-xcode-6-ios-8-tutorial
  
  func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
      println("**** didSignUpUser ***")
  }
  
  func signUpViewController(signUpController: PFSignUpViewController!, didFailToSignUpWithError error: NSError!) {
    
    println("FAiled to sign up...")
    
  }
  
  
  
  func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController!) {
    
    println("User dismissed sign up.")
    
  }
  
  
  func showMain() {
    println("show main on signup ***")
    var error: NSError?
    var theUser = PFUser.logInWithUsername(self.signUpView.usernameField.text, password: self.signUpView.passwordField.text, error: &error)
    
    if let actualError = error {
      println("An Error Occurred: \(actualError)")
    }
    else {
      println("user exists")
      var mainView: UIStoryboard!
      mainView = UIStoryboard(name: "Main", bundle: nil)
      var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("navViewController") as UIViewController
      self.presentViewController(viewcontroller, animated: true, completion: nil)
    }
    
    //var newuser :PFUser
    //newuser.setObject(self.signUpView.usernameField.text, forKey: "username")
    //newuser.setObject(self.signUpView.passwordField.text, forKey: "password")
    //newuser.setObject(self.signUpView.emailField.text, forKey: "username")
    //newuser.username = self.signUpView.usernameField.text
    //newuser.password = self.signUpView.passwordField.text
    //newuser.email = self.signUpView.emailField.text
    //var success = [user signUp];

    //error = PFUser.signUp(user)
    /* newuser.signUpInBackgroundWithBlock {
      (success: Bool!, error: NSError!) -> Void in
      /*  println("user exists")
      var mainView: UIStoryboard!
      mainView = UIStoryboard(name: "Main", bundle: nil)
      var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("navViewController") as UIViewController
      self.presentViewController(viewcontroller, animated: true, completion: nil) */
    } */
    //var theUser = PFUser.logInWithUsername(self.logInView.usernameField.text, password: self.logInView.passwordField.text, error: &error)
    
   /* if let actualError = error {
      println("An Error Occurred: \(actualError)")
    }
    else {
      println("user exists")
      var mainView: UIStoryboard!
      mainView = UIStoryboard(name: "Main", bundle: nil)
      var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("navViewController") as UIViewController
      self.presentViewController(viewcontroller, animated: true, completion: nil)
    }*/
    
  }
  
  override func textFieldShouldReturn(textField: (UITextField!)) -> Bool {   //delegate method
    super.textFieldShouldReturn(textField)
    println("return go")
    //self.logInView.passwordField.resignFirstResponder()
    self.showMain()
    return true
  }
  
  
  /*if((self.presentingViewController) != nil){
        self.dismissViewControllerAnimated(false, completion: nil)
        println("Signed in. Navigating to timeline")
      }
    }
  
  
  //func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
  
  //- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user;
  func signUpViewController(signUpController:PFSignUpViewController, didSignUpUser user:PFUser) {
    println("signupview done")
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("navViewController") as UIViewController
    self.presentViewController(viewcontroller, animated: true, completion: nil)
    //self.dismissModalViewControllerAnimated(true) //:YES]; // Dismiss the PFSignUpViewController
  }*/
  
 // - (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
 // [self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
 // }
  
 /*  func myMethod() {
    println("mymethod")
    var user = PFUser()
    user.username = "myUsername"
    user.password = "myPassword"
    user.email = "email@example.com"
    // other fields can be set just like with PFObject
    user["phone"] = "415-392-0202"
    
    user.signUpInBackgroundWithBlock {
      (succeeded: Bool!, error: NSError!) -> Void in
      if error == nil {
        // Hooray! Let them use the app now.
      } else {
        //let errorString = error.userInfo["error"] as NSString
        // Show the errorString somewhere and let the user try again.
      }
    }
  } */
  
  /* func showMain () {
    // set username/pass/email
    PFUser *user = [PFUser currentUser];
    user.username = @"existing username";
    user.password = @"my pass";
    user.email = @"email@example.com";
    [user setObject:@"415-392-0202" forKey:@"phone"];
    BOOL success = [user signUp];
    
    PFUser.signUp(<#PFUser#>) //WithUsername(self.signUpView.usernameField.text, password: self.signUpView.passwordField.text)
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("navViewController") as UIViewController
    self.presentViewController(viewcontroller, animated: true, completion: nil)
  } */
  
}