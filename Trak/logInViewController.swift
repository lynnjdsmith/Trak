//
//  loginViewController.swift
//
//self.view.backgroundColor = UIColor.colorWithPatternImage.UIImage imageNamed:@"main_background.png"]];
//https://parse.com/tutorials/login-and-signup-views
//https://parse.com/docs/ios_guide#top/iOS
// error - no initalizers, put ? at the end of your IBOutlets

class logInViewController: PFLogInViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.backgroundColor = UIColor.clearColor()
        var fieldsBackground = UIImageView(image:UIImage(named:"bkg1_320.png"))
        self.logInView.insertSubview(fieldsBackground, atIndex:1)
        var svc :signUpViewController = signUpViewController()
        self.signUpController = svc
     // NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillA"), name: UIKeyboardWillShowNotification, object: nil)
     // NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillH"), name: UIKeyboardWillHideNotification, object: nil)
      // NSNotificationCenter().addObserver(self, selector: Selector(keyboardWillA()), name: UIKeyboardWillShowNotification, object: nil)
      // NSNotificationCenter().addObserver(self, selector: Selector(keyboardWillH()), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.logInView.signUpLabel.hidden = true;
        self.logInView.dismissButton.hidden = true;
        self.logInView.passwordForgottenButton.hidden = true;
        
        //self.logInView.logo.layer.frame = CGRectMake(66.5, 60.0, 187.0, 58.5)
        //self.logInView.logo.backgroundColor = UIColor(patternImage:(UIImage(named:"logo_470x130.png")))
        
        //self.logInView.signUpButton.backgroundColor = setImage(UIImage(named:"Default-568h@2x.png"), forState: UIControlState.Normal)
        //self.logInView.signUpButton.setImage(UIImage(named:"Default-568h@2x.png"), forState: UIControlState.Highlighted)
        self.logInView.signUpButton.setTitle("Sign Up", forState:UIControlState.Normal)
        self.logInView.signUpButton.setTitle("Sign Up", forState:UIControlState.Highlighted)
        
        self.logInView.usernameField.layer.frame = CGRectMake(35.0, 145.0, 250.0, 50.0)
        self.logInView.usernameField.backgroundColor = UIColor.whiteColor()
        self.logInView.usernameField.borderStyle = UITextBorderStyle.RoundedRect
        self.logInView.usernameField.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor;
        self.logInView.usernameField.textColor = UIColor(red: 135.0/255.0, green: 100.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        self.logInView.usernameField.layer.shadowOpacity = 0.0
        
        self.logInView.passwordField.layer.frame = CGRectMake(35.0, 210.0, 250.0, 50.0)
        self.logInView.passwordField.backgroundColor = UIColor.whiteColor()
        self.logInView.passwordField.borderStyle = UITextBorderStyle.RoundedRect
        self.logInView.passwordField.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor;
        self.logInView.passwordField.textColor = UIColor(red: 135.0/255.0, green: 100.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        self.logInView.passwordField.layer.shadowOpacity = 0.0
        
        self.logInView.logInButton.layer.frame = CGRectMake(35.0, 295.0, 250.0, 50.0)
        self.logInView.logInButton.setTitle("Login & Start Tracking!", forState:UIControlState.Normal)
        self.logInView.logInButton.setTitle("Login & Start Tracking!", forState:UIControlState.Highlighted)
        self.logInView.logInButton.addTarget(self, action: Selector("showMain"), forControlEvents: .TouchUpInside)
        
        self.logInView.signUpButton.layer.frame = CGRectMake(35.0, 405.0, 250.0, 40.0)
    }
    
    func showMain () {
        PFUser.logInWithUsername(self.logInView.usernameField.text, password: self.logInView.passwordField.text)
        var mainView: UIStoryboard!
        mainView = UIStoryboard(name: "Main", bundle: nil)
        var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("navViewController") as UIViewController
        self.presentViewController(viewcontroller, animated: true, completion: nil)
    }
    
}


func keyboardWillA() {
  println("keyboardWasShown")

}

func keyboardWillH() {
  println("keyboardWasHidden")
  
}
/*

/* WORKS for making a button
let myFirstButton = UIButton()
myFirstButton.setTitle("✸**", forState: .Normal)
myFirstButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
myFirstButton.frame = CGRectMake(15, 50, 30, 50)
myFirstButton.addTarget(self, action: "logInPressed", forControlEvents: .TouchUpInside)
self.view.addSubview(myFirstButton) */

@IBOutlet var loginBtn:UIButton?

func logInPressed() {
println("pressed")
}

- (IBAction)loginButton:(id)sender {
[PFUser logInWithUsernameInBackground:_loginUsernameField.text password:_loginPasswordField.text block:^(PFUser *user, NSError *error) {
if (!error) {
NSLog(@"Login user!");
_loginPasswordField.text = nil;
_loginUsernameField.text = nil;
_usernameField.text = nil;
_passwordField.text = nil;
_reEnterPasswordField.text = nil;
_emailField.text = nil;
[self performSegueWithIdentifier:@"login" sender:self];
}
if (error) {
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ooops!" message:@"Sorry we had a problem logging you in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
[alert show];
}
}];
} */



