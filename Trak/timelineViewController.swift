//
//  timelineViewController.swift
//

import UIKit
import QuartzCore

class timelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, calDelegate, itemDetailDelegate, tCellDelegate {
  
  // set variables
  @IBOutlet var tableView: UITableView!
  @IBOutlet var text1: UITextField!
  @IBOutlet var dayBtn: UIButton!
  @IBOutlet var topBackView: UIView!
  @IBOutlet var timeTF: UITextField!
  @IBOutlet var hiddenTF: UITextField!
  @IBOutlet weak var menuButton: UIButton!
  
  var timePicker :UIView!
  //var inputPicker :UIView = UIView()
  var currentTag :Int = 0
  //var selectedIndexPath: NSIndexPath?
  
  var items           :NSMutableArray = []
  var daDate          :NSString!
  var daTime          :NSString! = ""
  var leftTextMargin  :CGFloat = 25.0
  var selectedRow     = 0
  var daDateAndTime   :NSDate!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    // setup nav bar
    self.navigationController?.navigationBarHidden = true
    tableView.allowsSelection = true
    
    // empty text string
    self.text1.text = ""
    
    self.tableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
    
    // add lightbox
    var lb :lightboxView = lightboxView(filename: "howto")
    //self.view.addSubview(lb)
    
    // set daDate
    let formatter = NSDateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    let d :NSString = formatter.stringFromDate(NSDate())
    daDate = d
    
    // general set stuff
    topBackView.layer.borderWidth = 0.3
    topBackView.layer.borderColor = UIColor.appLightGray().CGColor
    self.navigationController?.navigationBarHidden = true
    text1.becomeFirstResponder()
    tableView.separatorStyle = UITableViewCellSeparatorStyle.None

    // set time
    let timeFormatter = NSDateFormatter()
    timeFormatter.dateFormat = "h:mm a" // works for +10pm?
    daTime = timeFormatter.stringFromDate(NSDate())
    
    // set top time field
    let tf = NSDateFormatter()
    tf.dateFormat = "h:mm a"
    var time = tf.stringFromDate(NSDate())
    timeTF.text = time
    timeTF.layer.borderColor = UIColor.appLightestGray().CGColor
    timeTF.layer.backgroundColor = UIColor.clearColor().CGColor
    timeTF.layer.borderWidth = 1
    timeTF.layer.cornerRadius = 8
    var paddingView :UIView = UIView(frame: CGRectMake(0, 0, 7, 20))
    paddingView.backgroundColor = UIColor.clearColor()
    timeTF.leftView = paddingView
    timeTF.leftViewMode = UITextFieldViewMode.Always
    timeTF.userInteractionEnabled = true
    
    // day button
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d "
    let str = dateFormatter.stringFromDate(NSDate())
    dayBtn.setTitle(str, forState: UIControlState.Normal)
    dayBtn.setTitle(str, forState: UIControlState.Highlighted)
    
    // add nav
    var nav :navView = navView()
    nav.myparent = self
    self.view.addSubview(nav)
    
    // add time picker
    timePicker = myTimePicker(frame: CGRectMake(0, self.view.frame.height - 240, self.view.frame.width, 240), myP: self) as myTimePicker
    self.view.addSubview(timePicker)
    timePicker.hidden = true
    hiddenTF.inputView = timePicker

    
    if PFUser.currentUser() != nil
    {
      //println("current username \(PFUser.currentUser().username)")
      loadDataForDate(daDate)
    } else {
      goLogin()
    }
    
  }
  
  func goLogin() {
    println("logging in")
    /* PFUser.logInWithUsernameInBackground("l", password:"l") {
      (user: PFUser!, error: NSError!) -> Void in
      if user != nil {
        self.loadDataForDate(self.daDate)
        // Do stuff after successful login.
      } else {
        // The login failed. Check error to see why.
      }
    }*/
    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vc :logInViewController = storyboard.instantiateViewControllerWithIdentifier("logInViewController") as logInViewController
    let svc = signUpViewController()
    //vc.delegate = self
    vc.signUpController = svc
    //svc.delegate = self
    self.presentViewController(vc, animated: true, completion: nil) 
  }
  
  @IBAction func datePickerAction(sender: AnyObject) {
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
    //var strDate = dateFormatter.stringFromDate(myDatePicker.date)
    //self.selectedDate.text = strDate
  }
  
  /****   Load Data Functions   ****/
  
  func loadDataForDate(theDate: NSString) {
    //println("In loadDataForDate")
    //println("Load data for date - string: \(theDate) daTime: \(daTime)")
    
    // convert date string to date
    var theDateWithTime: NSString! = "\(theDate) \(daTime)"
    //println("time edited. theDateWithTime: \(theDateWithTime)")
    let dateStringFormatter = NSDateFormatter()
    dateStringFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
    let d = dateStringFormatter.dateFromString(theDateWithTime)
    if (d == nil) { println("** YO! You probably have an empty value!") }
    
    // Set nav bar date display
    let f = NSDateFormatter()
    f.dateFormat = "EEEE, MMM d"
    var dateWritten = f.stringFromDate(d!)
    //println("dateWritten: \(dateWritten)")
    dayBtn.setTitle(dateWritten, forState: UIControlState.Normal)
    //dayBtn.setTitle(dateWritten, forState: UIControlState.Highlighted)
    
    // create dates for beginning and end of day
    var date1String: NSString! = "\(theDate) 12:00 AM"
    var date2String: NSString! = "\(theDate) 11:59 PM"
    //println("******  date1String: \(date1String) date2String: \(date2String)")
    let formatter = NSDateFormatter()
    formatter.dateFormat = "MM/dd/yyyy hh:mm a"
    var date1: NSDate! = formatter.dateFromString(date1String)
    var date2: NSDate! = formatter.dateFromString(date2String)

    println("date1: \(date1) date2: \(date2)")
    
    //println("current username \(PFUser.currentUser().username)")
    // create query
    var findData:PFQuery = PFQuery(className: "Items")
    findData.whereKey("username", equalTo:PFUser.currentUser().username!)
    findData.whereKey("myDateTime", greaterThan:date1)
    findData.whereKey("myDateTime", lessThan:date2)
    findData.orderByDescending("myDateTime")
    
    var lastMyDate = NSDate()
    
    // send query
    var HUD = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
    //HUD.delegate = self;
    HUD.labelText = "loading"
    
    findData.findObjectsInBackgroundWithBlock {
        (objects:[AnyObject]!, error:NSError!)->Void in
        
        HUD.hidden = true
        
        if (error == nil) {
          self.items = []
            for object in objects as [PFObject] {
                self.items.addObject(object)
                //println(object)
            }
            self.tableView.reloadData()
        }
    }
  }

  
  @IBAction func typeText(sender: AnyObject) {
    if (text1.text.hasSuffix(" ")) { text1.text = text1.text + sender.titleForState(.Highlighted)!
    } else {
    text1.text = text1.text + " " + sender.titleForState(.Highlighted)!
    }
  }
  
  @IBAction func startEditingEntryPanelTimeTF(sender: AnyObject) {
    println("startEditingEntryPanelTimeTF")
    timeTF.layer.borderColor = UIColor.appBlue().CGColor
    timeTF.layer.backgroundColor = UIColor.whiteColor().CGColor
  }
  
  
  @IBAction func endEditingEntryPanelTimeTF(sender: UITextField) {
    println("endEditingEntryPanelTimeTF \(sender.text)")
    
    // set time
    daTime = "\(sender.text)"
    timeTF.layer.borderColor = UIColor.clearColor().CGColor
    timeTF.layer.backgroundColor = UIColor.clearColor().CGColor
  } 
  
  
  @IBAction func processInput(sender: AnyObject) {
    //println("process input")
    // resign first responder. NAH.
    //text1.becomeFirstResponder()

    //closeHelper(sender)
    
    // split into items
    var theText :NSString = text1.text.stringByTrimmingCharactersInSet(NSCharacterSet (charactersInString: "., "))
    var newitems = theText.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: ".,"))
    
    // process each item
    for daNewItem in newitems {
      
      // trim characters
      var itemText = daNewItem.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
  
      // create Item
      var newItem:PFObject = PFObject(className: "Items")
      newItem.setObject("\(itemText)", forKey: "name")
      
      // add user
      newItem.setObject(PFUser.currentUser().username, forKey: "username")
    
      // add triggerOrSymptom
      newItem.setObject("trigger", forKey: "type")
      
      // add type
      //newItem.setObject("trigger", forKey: "type")
      
      // add myDateTime
      var datetime: NSString! = "\(daDate) \(daTime)"
      println("datetimestring: \(datetime)")
      let df = NSDateFormatter()
      df.dateFormat = "MM/dd/yyyy hh:mm a"
      let d :NSDate! = df.dateFromString(datetime)
    
      if (d != nil) {
        println("datetime d: \(d)")
        newItem.setObject(d, forKey: "myDateTime")
      } else {
        println("*** YO!! nil on datetime - In process input, saving nil to DB! ***")
      }
    
      // add amount
      newItem.setObject("3", forKey: "amount")
    
      // save item
      //self.saveObject(newItem)
      newItem.saveInBackgroundWithBlock {
        (success: Bool!, error: NSError!) -> Void in
        if (success != nil) {
          //println("\n ** Object created: \(sender.objectId)")
          self.items.insertObject(newItem, atIndex: 0)
          self.tableView.reloadData();                 // todo fix - move this later?
        } else {
          println("%@", error)
        }
      }
    }
    //text1.resignFirstResponder()
    text1.text = nil
    text1.becomeFirstResponder()
  }


  func triggerOrSymptom(name: NSString) {
    var tOs = "Trigger"
  }
  
  // sent from calendar.
  func didPressDate(val: NSString) {
    println("didPressDate")
    daDate = val // FIX FIX Need better error checking here
    loadDataForDate(daDate)
    //self.tableView.reloadData()  //todo fix why isn't this reloading?

    // load data
    //let formatter = NSDateFormatter()
    //formatter.dateFormat = "MM/dd/yyyy"
    //let d :NSDate = formatter.dateFromString(val)!

    //loadDataForDate(val)
    
  }
  
  // this is for the table's time fields
  func didChangeTime(val: NSString!) {
    println("TIME PRESSED! \(val)")
    /* var btnSent:UIButton = sender
    //println("the strDay: \(btnSent.titleForState(.Highlighted))")
    let s :NSString = btnSent.titleForState(.Highlighted)
    
    // send the date
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("navViewController") as UIViewController
    
    if let d = self.delegate {
      d.didPressDate(s)
    }
    
    //Dismiss
    done(self) */
  }
  
  @IBAction func menuPressed(sender: AnyObject) {
    //println("menuP")
    self.revealViewController()?.rightRevealToggle(sender)
    self.view.endEditing(true)
  }
  
  @IBAction func showCalendar(sender: AnyObject) {
    // setup view controller
    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vc : calendarViewController = storyboard.instantiateViewControllerWithIdentifier("calendarViewController") as calendarViewController
    vc.delegate = self
    self.presentViewController(vc, animated: true, completion: nil)
  }
 
  
  /** Delegate Functions **/
  
  func closeMod() {
    println("closeMod")
    loadDataForDate(daDate) // FIX to-do, test this. We prob don't need, now that it's in viewillappear
  }
  
  
  /**  Table Info and Functions  **/
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items.count;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //println("tableloading cell")
    
    // setup cell
    var cell = tableView.dequeueReusableCellWithIdentifier("cell1") as timelineCell
    cell.selectionStyle = UITableViewCellSelectionStyle.None;
    cell.delegate = self
    
    // set the name
    cell.label1.text = items[indexPath.row].valueForKey("name") as NSString
    
    // set the time
    let daDateVal: AnyObject! = items[indexPath.row].valueForKey("myDateTime")
    if (daDateVal == nil) { println("*** YO! You have a blank myDateTime in the DB, probably!! ***") }
    let timeFormatter = NSDateFormatter()
    timeFormatter.dateFormat = "h:mm a" // "h:mm a"
    let str2 = timeFormatter.stringFromDate(daDateVal as NSDate)
    
    // set time field look
    //cell.timeTextField.layer.borderColor = UIColor.appLightestGray().CGColor
    cell.timeTextField.layer.borderColor = UIColor.clearColor().CGColor
    cell.timeTextField.layer.backgroundColor = UIColor.clearColor().CGColor
    cell.timeTextField.text = str2
    cell.timeTextField.layer.borderWidth = 1
    cell.timeTextField.layer.cornerRadius = 8
    cell.timeTextField.clipsToBounds = true
    cell.timeTextField.inputView = timePicker
    //cell.timeTextField.tag = indexPath.row + 1
    cell.timeTextField.addTarget(self, action: "timeCellInputPress:", forControlEvents: UIControlEvents.EditingDidBegin)

    
    cell.timeBtn.layer.borderColor = UIColor.clearColor().CGColor
    cell.timeBtn.layer.backgroundColor = UIColor.clearColor().CGColor
    cell.timeBtn.setTitle(str2,forState: UIControlState.Normal)
    cell.timeBtn.layer.borderWidth = 1
    cell.timeBtn.layer.cornerRadius = 8
    cell.timeBtn.clipsToBounds = true
    //cell.timeBtn.inputView = inputPicker
    cell.timeBtn.tag = indexPath.row + 1
    cell.timeBtn.addTarget(self, action: "timeBtnPress:", forControlEvents: UIControlEvents.TouchUpInside)
    
    
    //Add dot
    var circle :UIImageView = UIImageView(frame:CGRectMake(85, (cell.frame.height / 2) - 6, 12, 12))
    circle.image = UIImage(named: "dot_green.png")
    cell.addSubview(circle)

    //Add carat
    var carat :UIImageView = UIImageView(frame:CGRectMake(self.view.frame.width - 30, (cell.frame.height / 2) - 8, 12, 16))
    carat.image = UIImage(named: "indicator20.png")
    carat.alpha = 0.4
    cell.addSubview(carat)
    
    // set the vertical line color
    var theType :NSString = items[indexPath.row].valueForKey("type") as NSString

    switch theType { //== "trigger") {
    //case "trigger":
      case "symptom":
          cell.cellVerticalBar.backgroundColor = UIColor.redColor()
      case "treatment":
          cell.cellVerticalBar.backgroundColor = UIColor.blueColor()
      default:
          cell.cellVerticalBar.backgroundColor = UIColor.appLightGray()
    }
    
    //set time field pattern
    var paddingView :UIView = UIView(frame: CGRectMake(0, 0, 7, 20))
    paddingView.backgroundColor = UIColor.clearColor()
    cell.timeTextField.leftView = paddingView
    cell.timeTextField.leftViewMode = UITextFieldViewMode.Always
    
    return cell
  }
  
  
  func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    println("You selected cell #\(indexPath.row)!")
    //selectedIndexPath = tableView.indexPathForSelectedRow()!
    
    //ResultsTableViewController *childViewController = [[ResultsTableViewController alloc] init];
    //childViewController.tableView.delegate = self.results;
    //[self.navigationController pushViewController:childViewController animated:YES];
    
    
    //select row, show item detail
    //self.selectedRow = indexPath.row
    
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    let s = mainView.instantiateViewControllerWithIdentifier("itemDetailController") as itemDetailController
    s.objID = items[selectedRow].objectId
    s.delegate = self
    self.navigationController?.pushViewController(s, animated: true)
    //self.presentViewController(s, animated: true, completion: nil)
    //println("You selected cell #\(indexPath.row)!")
  }
  
  func revealTheToggle() {
    self.revealViewController()?.rightRevealToggle(self)
    self.view.endEditing(true)
  }
  
  
  
  /* @IBAction func timeTFInputPressed(sender: UITextField) {
    println("timeTFInputPressed tag: \(sender.tag)")
    //selectedIndexPath = indexPath
    //handleDatePicker(datePickerView) // Set the date on start.
  } */

  func timeCellInputPress(sender: UITextField) {
    //println("timeCellInputPressed tag")
    println("timeCellInputPressed tag: \(sender.tag)")
    currentTag = sender.tag
  }
  /*
  func handleDatePicker(sender: UIDatePicker) {
    println("handle! currentTag: \(currentTag)")
    let myField = self.tableView.viewWithTag(currentTag) as UITextField
    println("handle!2")
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    var theDate :NSString = dateFormatter.stringFromDate(sender.date)
    println("handle!3 date: \(theDate)")
    myField.text = theDate
  }
   */
  
  
  /*** TOMORROW - add a hidden field for the UIText field. And, then do the time button thing. ***/
  @IBAction func timeBtnPress(sender: UIButton) {
    println("timeBtn tag: \(sender.tag)")
    currentTag = sender.tag
    hiddenTF.becomeFirstResponder()
    timePicker.hidden = false
  }
  
  func handleDatePicker(sender: UIDatePicker) {
    println("handle! currentTag: \(currentTag)")
    let myBtn = self.tableView.viewWithTag(currentTag) as UIButton
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    var theDate :NSString = dateFormatter.stringFromDate(sender.date)
    //myField.text = theDate
    myBtn.setTitle(theDate, forState: UIControlState.Normal)
  }
  
  
  func doneButton(sender:UIButton)
  {
    println("done pressed")
    //let myBtn = self.tableView.viewWithTag(currentTag) as UIButton
    //hiddenTF.resignFirstResponder()
    timePicker.hidden = true
    //self.view.endEditing(true)
  }
  
  
  
} // END class timeline view controller



// OLD view will appear
//helloView.hidden = true
//helperView.hidden = true
//helperView.layer.borderColor = UIColor.appLightGray().CGColor
//helperView.layer.borderWidth = 1
//helperView.layer.cornerRadius = 8

//var path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")
//var dict :NSMutableDictionary = NSMutableDictionary(contentsOfFile: path!)
//var theLaunchedVal :NSString = dict.objectForKey("hasLaunchedOnce") as NSString
//var theLaunchedVal :Bool = true;

// First time? Show Hello!
//if (theLaunchedVal == "t") {
// println("ONCE TRUE")
// not logged in - present login controller


/* } else {

println("ONCE FALSE")
text1.resignFirstResponder()
helloView.hidden = false

dict.setValue("t", forKey: "hasLaunchedOnce")  //("t" as NSString, forKey: "hasLaunchedOnce")
dict.writeToFile(path!, atomically: true)

//NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLaunchedOnce")
//NSUserDefaults.standardUserDefaults().synchronize()
} */




/*@IBAction func closeHelper(sender: AnyObject) {
println("closeHelper")
//helperView.hidden = true
}

@IBAction func closeHello(sender: AnyObject) {
println("closeHello")

// not logged in - present login controller
if (PFUser.currentUser() == nil) {
//println("current user nil")
let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
let vc : logInViewController = storyboard.instantiateViewControllerWithIdentifier("logInViewController") as logInViewController
let svc = signUpViewController()
vc.delegate = self
vc.signUpController = svc
svc.delegate = self
self.presentViewController(vc, animated: true, completion: nil)
} else {
println("current username \(PFUser.currentUser().username)")
loadDataForDate(daDate)
}

helloView.hidden = true
} */



/* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

// pass item objectID to item detail page
let index = tableView.indexPathForSelectedRow()

println("segue.identifier1: \(segue.identifier)")

if (segue.identifier != "") {    //todo FIX, need this check.  WAS ACTIVE -- ?
println("segue.identifier: \(segue.identifier)")
if (segue.identifier == "toDetails") {
let vc = segue.destinationViewController as itemDetailController
vc.objID = items[selectedRow + 1].objectId
}
}
} */


/*  @IBAction func setTime(sender: UIButton!) {

// set time into global page variable
//var daTime = self.timeTextField.text
//var daDate = NSDate()

// save myDateTime

let theTime :NSString! = sender.titleLabel.text as NSString //getTitle(forState: UIControlState.Normal) as NSString
println("theTime edited \(theTime)")
var theDateWithTime: NSString! = "\(daDate) \(self.daTime):00 PM"
println("time edited. theDateWithTime: |\(theDateWithTime)|")
let dateStringFormatter = NSDateFormatter()
dateStringFormatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
let d = dateStringFormatter.dateFromString(theDateWithTime)
println("d: \(d)")


//set time title
let timeFormatter = NSDateFormatter()
timeFormatter.dateFormat = "h:mm a" // works for +10pm?
let str2 = timeFormatter.stringFromDate(NSDate())
sender.setTitle(str2, forState: UIControlState.Normal)
sender.hidden = false
//self.timeTextField.hidden = true
} */


// ADD SUBVIEW
//customPicker!.backgroundColor = UIColor.redColor()
//var cdp : UIView = CustomDatePicker() as UIView
//self.view.addSubview(cdp) //(cdp, animated: true, completion: nil)

/* This is when you have the time in the string. Don't need it anymore.
var firstPart = theText.substringToIndex(8)
var newString = theText.substringFromIndex(8).stringByTrimmingCharactersInSet(NSCharacterSet (charactersInString: "., "))      //trim
*/

// http://www.weheartswift.com/how-to-make-a-simple-table-view-with-ios-8-and-swift/

