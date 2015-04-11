//
//  timelineViewController.swift
//

import UIKit
import QuartzCore

class timelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, calDelegate, itemDetailDelegate { //tCellDelegate
  
  // set variables
  @IBOutlet var tableView: UITableView!
  @IBOutlet var text1: UITextField!
  @IBOutlet var dayBtn: UIButton!
  @IBOutlet var topBackView: UIView!
  @IBOutlet var topTimeBtn: UIButton!
  @IBOutlet var hiddenTF: UITextField!
  @IBOutlet weak var menuButton: UIButton!
  
  var timePicker :myTimePicker!
  var currentTag :Int = -1
  
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
    //let timeFormatter = NSDateFormatter()
    //timeFormatter.dateFormat = "h:mm a" // works for +10pm?
    //daTime = timeFormatter.stringFromDate(NSDate())
    
    // set top time field
    let tf = NSDateFormatter()
    tf.dateFormat = "h:mm a"
    var time = tf.stringFromDate(NSDate())
    daTime = time
    topTimeBtn.setTitle(time, forState: UIControlState.Normal)
    //topTimeBtn.layer.borderColor = UIColor.appLightestGray().CGColor
    topTimeBtn.layer.borderColor = UIColor.appBlue().CGColor
    topTimeBtn.layer.backgroundColor = UIColor.clearColor().CGColor
    topTimeBtn.layer.borderWidth = 1
    topTimeBtn.layer.cornerRadius = 8
    
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
    //hiddenTF.inputView = timePicker
    
    if PFUser.currentUser() != nil
    {
      //println("current username \(PFUser.currentUser().username)")
      loadDataForDate(daDate)
    } else {
      println("logging in")
      let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let vc :logInViewController = storyboard.instantiateViewControllerWithIdentifier("logInViewController") as logInViewController
      let svc = signUpViewController()
      vc.signUpController = svc
      self.presentViewController(vc, animated: true, completion: nil)
    }
  }

  
  /****   Load Data Functions   ****/
  
  func loadDataForDate(theDate: NSString) {
    //println("Load data for date - string: \(theDate)")
    
    // convert dates
    let date1 :NSDate = getUTCDateFromString("\(theDate) 12:00 AM")
    let date2 :NSDate = getUTCDateFromString("\(theDate) 11:59 PM")
    //println("date1: \(date1) date2: \(date2)")
    
    // create query
    var findData:PFQuery = PFQuery(className: "Items")
    findData.whereKey("username", equalTo:PFUser.currentUser().username!)
    findData.whereKey("myDateTime", greaterThan:date1)
    findData.whereKey("myDateTime", lessThan:date2)
    findData.orderByDescending("myDateTime")
    
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
  
  @IBAction func processInput(sender: AnyObject) {
    
    // split into items OLD
    //var theText :NSString = text1.text.stringByTrimmingCharactersInSet(NSCharacterSet (charactersInString: "., "))
    //var newitems = theText.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: ".,"))
    
    // split entries
    var myTextBot :textBot = textBot()
    var newItems = myTextBot.splitIntoEntries(text1.text)
    
    // add entries
    var datetime: NSString! = "\(daDate) \(daTime)"
    let d :NSDate! = getUTCDateFromString(datetime)
    
    myTextBot.makeNewEntries(newItems, daDateTime: d)
    
    text1.text = nil
    text1.becomeFirstResponder()
    
    loadDataForDate(daDate)
    self.tableView.reloadData()
  }


  func triggerOrSymptom(name: NSString) {
    var tOs = "Trigger"
  }

  
/*   // this is for the table's time fields
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
  } */
  
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
  
  //sent from item detail - FIX DON'T NEED
  func closeMod() {
    println("closeMod")
    loadDataForDate(daDate) // We prob don't need, now that it's in viewillappear
  }
  
  
  // sent from calendar
  func didPressDate(val: NSString) {
    println("didPressDate val: \(val)")
    daDate = val
    loadDataForDate(daDate)
    
    // day button at top of page, change
    let str = getDateDescriptiveStringFromString(val)
    dayBtn.setTitle(str, forState: UIControlState.Normal)
    dayBtn.setTitle(str, forState: UIControlState.Highlighted)
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
    // cell.delegate = self remove in future cleanup of tCellDelegate
    
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
    
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    let s = mainView.instantiateViewControllerWithIdentifier("itemDetailController") as itemDetailController
    s.objID = items[selectedRow].objectId
    s.delegate = self
    self.navigationController?.pushViewController(s, animated: true)
    //self.presentViewController(s, animated: true, completion: nil)
    //println("You selected cell #\(indexPath.row)!")
  }
  


  @IBAction func topTimeBtnPress(sender: UIButton) {
    //println("timeBtn tag: \(sender.tag)")
    
    // turn off current time btn if one is selected (-1 means nothing selected yet or top time button selected)
    if (currentTag != -1) {
      let oldBtn = self.tableView.viewWithTag(currentTag) as UIButton
      oldBtn.layer.borderWidth = 1.0
      oldBtn.layer.borderColor = UIColor.clearColor().CGColor
    }

    var theTimeString = topTimeBtn.titleForState(UIControlState.Normal)
    var theTime = getTimeFromString(theTimeString!)
    timePicker.setTheTime(theTime)
    hiddenTF.becomeFirstResponder()
    timePicker.hidden = false
    topTimeBtn.layer.borderWidth = 3.0
    currentTag = -1
  }
  
  @IBAction func timeBtnPress(sender: UIButton) {
    println("timeBtn tag: \(sender.tag)")
    
    // turn off top time btn
    if (currentTag == -1) {
      topTimeBtn.layer.borderWidth = 1.0
      //topTimeBtn.layer.borderColor = UIColor.clearColor().CGColor
    } else {        // turn off table's time btn if one is selected
      let oldBtn = self.tableView.viewWithTag(currentTag) as UIButton
      oldBtn.layer.borderWidth = 1.0
      oldBtn.layer.borderColor = UIColor.clearColor().CGColor
    }
    
    //highlight the field
    sender.layer.borderWidth = 3.0
    sender.layer.borderColor = UIColor.appBlue().CGColor
    
    //let myBtn = self.tableView.viewWithTag(currentTag) as UIButton
    var theTimeString = sender.titleForState(UIControlState.Normal)
    var theTime = getTimeFromString(theTimeString!)
    timePicker.setTheTime(theTime)
    hiddenTF.becomeFirstResponder()
    timePicker.hidden = false
    currentTag = sender.tag
  }
  
  func handleTimePicker(sender: UIDatePicker) {
    println("handle! currentTag: \(currentTag)")
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    var newTimeString :NSString = dateFormatter.stringFromDate(sender.date)

    newTimeSelected(newTimeString)
  }
  
  func timePickerBack10(sender: UIButton) {
    //println("handle! currentTag: \(currentTag)")
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    var newTime = timePicker.datePickerView.date
    newTime = newTime.dateBySubtractingMinutes(10)
    timePicker.datePickerView.date = newTime
    
    // set button title
    var newTimeString = getTimeStringFromDate(newTime)
    newTimeSelected(newTimeString)
  }

  func timePickerBack30(sender: UIButton) {
    //println("handle! currentTag: \(currentTag)")
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    var newTime = timePicker.datePickerView.date
    newTime = newTime.dateBySubtractingMinutes(30)
    timePicker.datePickerView.date = newTime
    
    // set button title
    var newTimeString = getTimeStringFromDate(newTime)
    newTimeSelected(newTimeString)
  }
  
  func newTimeSelected(newTimeString :NSString) {
    if (currentTag != -1) {
      let myBtn = self.tableView.viewWithTag(currentTag) as UIButton
      myBtn.setTitle(newTimeString, forState: UIControlState.Normal)
    } else {
      topTimeBtn.setTitle(newTimeString, forState: UIControlState.Normal)
      daTime = newTimeString
    }
  }
  
  func doneButton(sender:UIButton)
  {
    timePicker.hidden = true

    if (currentTag != -1) {
      let myBtn = self.tableView.viewWithTag(currentTag) as UIButton
      myBtn.layer.borderWidth = 0.0
    } else {
      topTimeBtn.layer.borderWidth = 1.0
    }
  }
  
  
  func revealTheToggle() {
    self.revealViewController()?.rightRevealToggle(self)
    self.view.endEditing(true)
  }
  
} // END class timeline view controller


