//
//  loginViewController.swift
//
//self.view.backgroundColor = UIColor.colorWithPatternImage.UIImage imageNamed:@"main_background.png"]];
//https://parse.com/tutorials/login-and-signup-views
//https://parse.com/docs/ios_guide#top/iOS
// error - no initalizers, put ? at the end of your IBOutlets

let BedroomFloorKey = "BedroomFloor"
var bedroomFloorID: AnyObject = 101


class logInViewController: PFLogInViewController, UITextFieldDelegate, PFLogInViewControllerDelegate {
  
  
  override func viewWillAppear(animated: Bool) {
    var fieldsBackground = UIImageView(image:UIImage(named:"bkg1_320.png"))
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    fieldsBackground.frame =  CGRectMake(0.0, 0.0, screenSize.width, screenSize.height)
    self.logInView.insertSubview(fieldsBackground, atIndex:1)
    
    loadPlistData()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.SignUpButton | PFLogInFields.PasswordForgotten
    self.delegate = self
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    self.signUpController = storyboard.instantiateViewControllerWithIdentifier("signUpViewController") as! PFSignUpViewController

  }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        var screenSize: CGRect = UIScreen.mainScreen().bounds
        var eigthW :CGFloat = screenSize.width / 8
        var eigthH :CGFloat = screenSize.height / 8
      
        //self.logInView.signUpLabel.hidden = true;
      
        self.logInView.dismissButton.hidden = true;
        self.logInView.passwordForgottenButton.hidden = true;
        
        //self.logInView.logo.layer.frame = CGRectMake(66.5, 60.0, 187.0, 58.5)
        //self.logInView.logo.backgroundColor = UIColor(patternImage:(UIImage(named:"logo_470x130.png")))
        //self.logInView.signUpButton.backgroundColor = setImage(UIImage(named:"Default-568h@2x.png"), forState: UIControlState.Normal)
        //self.logInView.signUpButton.setImage(UIImage(named:"Default-568h@2x.png"), forState: UIControlState.Highlighted)
      
        self.logInView.signUpButton.setTitle("Sign Up", forState:UIControlState.Normal)
        self.logInView.signUpButton.setTitle("Sign Up", forState:UIControlState.Highlighted)
        
        self.logInView.usernameField.layer.frame = CGRectMake(eigthW, eigthH * 2.5, eigthW * 6, 50.0)
        self.logInView.usernameField.backgroundColor = UIColor.whiteColor()
        self.logInView.usernameField.borderStyle = UITextBorderStyle.RoundedRect
        self.logInView.usernameField.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor;
        self.logInView.usernameField.textColor = UIColor(red: 135.0/255.0, green: 100.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        self.logInView.usernameField.layer.shadowOpacity = 0.0
        
        self.logInView.passwordField.layer.frame = CGRectMake(eigthW, eigthH * 3.5, eigthW * 6, 50.0)
        self.logInView.passwordField.backgroundColor = UIColor.whiteColor()
        self.logInView.passwordField.borderStyle = UITextBorderStyle.RoundedRect
        self.logInView.passwordField.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor;
        self.logInView.passwordField.textColor = UIColor(red: 135.0/255.0, green: 100.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        self.logInView.passwordField.layer.shadowOpacity = 0.0
        
        self.logInView.logInButton.layer.frame = CGRectMake(eigthW, eigthH * 4.5, eigthW * 6, 50.0)
        self.logInView.logInButton.setTitle("Login & Start Tracking!", forState:UIControlState.Normal)
        self.logInView.logInButton.setTitle("Login & Start Tracking!", forState:UIControlState.Highlighted)
        //self.logInView.logInButton.addTarget(self, action: Selector("showMain"), forControlEvents: .TouchUpInside)
        
        self.logInView.signUpButton.layer.frame = CGRectMake(eigthW, eigthH * 6.5, eigthW * 6, 40.0)
    }
  
  
  func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
  
    println("didloguserin ...    ******")
    var error: NSError?
    
    var theUser = PFUser.logInWithUsername(self.logInView.usernameField.text, password: self.logInView.passwordField.text, error: &error)
    
    if let actualError = error {
      println("An Error Occurred: \(actualError)")
    }
    else {
      println("user exists")
      var mainView: UIStoryboard!
      mainView = UIStoryboard(name: "Main", bundle: nil)
      var viewcontroller : SWRevealViewController = mainView.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
      self.presentViewController(viewcontroller, animated: true, completion: nil)
      
      performSegueWithIdentifier("sw_main", sender: self)
    }
    
  
  }
  
  func logInViewController(logInController: PFLogInViewController!, didFailToLogInWithError error: NSError!) {
    println("Failed to login...    ****** ")
  }

}


func loadPlistData() {
  
  // getting path to GameData.plist
  let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
  let documentsDirectory = paths[0] as! String
  let path = documentsDirectory.stringByAppendingPathComponent("MigraineStopDeets.plist")
  
  let fileManager = NSFileManager.defaultManager()
  
  //check if file exists
  if(!fileManager.fileExistsAtPath(path)) {
    // If it doesn't, copy it from the default file in the Bundle
    if let bundlePath = NSBundle.mainBundle().pathForResource("MigraineStopDeets", ofType: "plist") {
      
      let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
      println("Bundle plist file is --> \(resultDictionary?.description)")
      
      fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
      println("copy")
    } else {
      println("plist not found. Please, make sure it is part of the bundle.")
    }
  } else {
    println("plist already exits at path.")
    // use this to delete file from documents directory
    //fileManager.removeItemAtPath(path, error: nil)
  }
  
  let resultDictionary = NSMutableDictionary(contentsOfFile: path)
  println("Loaded plist file is --> \(resultDictionary?.description)")
  
  var myDict = NSDictionary(contentsOfFile: path)
  
  if let dict = myDict {
    //loading values
    //bedroomFloorID = dict.objectForKey(BedroomFloorKey)!
    //...
  } else {
    println("WARNING: Couldn't create dictionary from GameData.plist! Default values will be used!")
  }
}



