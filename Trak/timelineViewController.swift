//
//  timelineViewController.swift
//

import UIKit
import QuartzCore
import CoreData

class timelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, calDelegate {
  
  // MARK: Variables
  
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
  var daDate          :String!
  var daTime          :NSString! = ""
  var leftTextMargin  :CGFloat = 25.0
  var selectedRow     = 0
  var daDateAndTime   :NSDate!
  var myWeatherBot    :weatherBot = weatherBot()
  var theMO = [NSManagedObject]()
  
  
  // MARK: - Functions
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    // setup nav bar
    self.navigationController?.navigationBarHidden = true
    tableView.allowsSelection = true

    // empty text string
    self.text1.text = ""
    
    loadDataForDate(daDate)
    self.tableView.reloadData()
  
    /*    
    // TESTING how to save things - with core data. Don't need? Use localstore from parse.
    //1
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext!
    
    //2
    let entity =  NSEntityDescription.entityForName("TestString", inManagedObjectContext: managedContext)
    let ts = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
    
    //3
    ts.setValue("name", forKey: "string1")
    
    var error: NSError?
    if !managedContext.save(&error) {
      println("Could not save \(error), \(error?.userInfo)")
    }
    //5
    theMO.append(ts)
    */
    //p("appended")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // add focus event on main entry box
    text1.addTarget(self, action:"focusMainText", forControlEvents:.EditingDidBegin)
    
    // add lightbox
    var lb :lightboxView = lightboxView(filename: "howto")
    //self.view.addSubview(lb)
    
    // set daDate
    let formatter = NSDateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    let d :String = formatter.stringFromDate(NSDate())
    daDate = d
    
    // general set stuff
    topBackView.layer.borderWidth = 0.3
    topBackView.layer.borderColor = UIColor.appLightGray().CGColor
    self.navigationController?.navigationBarHidden = true
    text1.becomeFirstResponder()
    tableView.separatorStyle = UITableViewCellSeparatorStyle.None

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
    timePicker = myTimePicker(frame: CGRectMake(0, self.view.frame.height - 240, self.view.frame.width, 240), myparent: self) as myTimePicker
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
      let vc :logInViewController = storyboard.instantiateViewControllerWithIdentifier("logInViewController") as! logInViewController
      let svc = signUpViewController()
      vc.signUpController = svc
      self.presentViewController(vc, animated: true, completion: nil)
    }
  }
  
  @IBAction func menuPressed(sender: AnyObject) {
    //println("menuP")
    self.revealViewController()?.rightRevealToggle(sender)
    self.view.endEditing(true)
  }
  
  @IBAction func showCalendar(sender: AnyObject) {
    // setup view controller
    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vc : calendarViewController = storyboard.instantiateViewControllerWithIdentifier("calendarViewController") as! calendarViewController
    vc.delegate = self
    self.presentViewController(vc, animated: true, completion: nil)
  }
  
  @IBAction func processInput(sender: AnyObject) {
    // split entries
    var myItemBot :itemBot = itemBot()
    var newItems = myItemBot.splitIntoEntries(text1.text)
    
    // add entries
    var datetime :String! = "\(daDate) \(daTime)"
    let d :NSDate! = getUTCDateFromString(datetime)
    myItemBot.makeNewEntries(newItems, daDateTime: d)
    text1.text = nil
    text1.becomeFirstResponder()
    
    // reload table
    loadDataForDate(daDate)
    self.tableView.reloadData()
  }
  
  
  @IBAction func topTimeBtnPress(sender: UIButton) {
    // highlight the field
    highlightOff()
    topTimeBtn.layer.borderWidth = 3.0
    
    //println("timeBtn tag: \(sender.tag)")
    saveTheItem() // save other if one was selected
    
    // set the time on the picker
    timePicker.startWithTime(topTimeBtn.titleForState(UIControlState.Normal)!)
    
    currentTag = -1
  }
  
  @IBAction func timeBtnPress(sender: UIButton) {
    //highlight the field
    highlightOff()
    sender.layer.borderWidth = 3.0
    sender.layer.borderColor = UIColor.appBlue().CGColor
    
    println("timeBtn tag: \(sender.tag)")
    //saveTheItem() // save other if one was selected
    
    // set the time on the picker and show it
    timePicker.startWithTime(sender.titleForState(UIControlState.Normal)!)
    
    currentTag = sender.tag
  }
  
      // MARK: - Helpers
  
  func loadDataForDate(theDate :String) {
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
    //HUD.delegate = self
    HUD.labelText = "loading"
    
    findData.findObjectsInBackgroundWithBlock {
        (objects:[AnyObject]!, error:NSError!)->Void in
        
        HUD.hidden = true
        
        if (error == nil) {
          self.items = []
            for object in objects as! [PFObject] {
                self.items.addObject(object)
                //println(object)
            }
            self.tableView.reloadData()
        }
    }
  }
  
  func focusMainText() {
    closePicker()
  }

  func highlightOff() {
    if (currentTag != -1) {
      let myBtn = self.tableView.viewWithTag(currentTag) as! UIButton
      myBtn.layer.borderWidth = 0.0
    } else {
      topTimeBtn.layer.borderWidth = 1.0
    }
  }
  
  func saveTheItem() {
    var theItem :PFObject
    
      if (currentTag != -1) {
        theItem = self.items[currentTag - 1] as! PFObject
        let theButton = self.tableView.viewWithTag(currentTag) as! UIButton
        let theTime :String = theButton.titleForState(UIControlState.Normal)!
      
        // set date
        var datetime :String! = "\(daDate) \(theTime)"
        var d = getUTCDateFromString(datetime)
        theItem.setObject(d, forKey:"myDateTime")
        self.items[currentTag - 1] = theItem
        
        theItem.saveInBackgroundWithBlock {
          (success, error) -> Void in
          if (success == false) { println("ERROR in Saving: %@", error) }
          else {
            println("Saved - this turns off the highlight!! FIX IT!!")
            self.tableView.reloadData()
          }
        }
    }
  }

  
  // MARK: - Table View
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //println("tableloading cell")
    
    // setup cell
    var cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! timelineCell
    cell.selectionStyle = UITableViewCellSelectionStyle.None;
    // cell.delegate = self remove in future cleanup of tCellDelegate
    
    // set the name
    cell.label1.text = items[indexPath.row].valueForKey("name") as? String
    
    // set the time
    let daDateVal: AnyObject! = items[indexPath.row].valueForKey("myDateTime")
    if (daDateVal == nil) { println("*** YO! You have a blank myDateTime in the DB, probably!! ***") }
    let timeFormatter = NSDateFormatter()
    timeFormatter.dateFormat = "h:mm a" // "h:mm a"
    let str2 = timeFormatter.stringFromDate(daDateVal as! NSDate)
    
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
    var theType :NSString = items[indexPath.row].valueForKey("type") as! NSString
    
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
  
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //println("You selected cell #\(indexPath.row)!")
    //selectedIndexPath = tableView.indexPathForSelectedRow()!
    
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    let s = mainView.instantiateViewControllerWithIdentifier("itemDetailController") as! itemDetailController
    s.objID = items[indexPath.row].objectId
    s.delegate = self
    self.navigationController?.pushViewController(s, animated: true)
    //self.presentViewController(s, animated: true, completion: nil)
    //println("You selected cell #\(indexPath.row)!")
  }
  
  
  // MARK: - Calendar Delegate
  
  func didPressDate(val :String) {
    println("didPressDate val: \(val)")
    
    var dateString :String = getDateStringYYYYMMDDFromString(val) as String
    
    //var locationArray = NSUserDefaults.standardUserDefaults().objectForKey("coordLogArray") as! NSArray
    //NSData *data = [NSPropertyListSerialization dataFromPropertyList:array format:NSPropertyListBinaryFormat_v1_0 errorDescription:&error];
    //var locationObj = locationArray.lastObject as! CLLocation
    //var coord :CLLocationCoordinate2D = locationObj.coordinate
    //myWeatherBot.checkWeatherForTriggers(coord, dateString: dateString)
      
    daDate = val
    loadDataForDate(daDate)
    
    // day button at top of page, change
    let str = getDateDescriptiveStringFromString(val)
    dayBtn.setTitle(str as? String, forState: UIControlState.Normal)
    dayBtn.setTitle(str as? String, forState: UIControlState.Highlighted)
  }
  
  
      // MARK: - Time Picker
  
  func timePickerTimeChanged(sender: UIDatePicker) {
    //println("timepickertimechanged currentTag: \(currentTag)")
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    var newTimeString :NSString = dateFormatter.stringFromDate(sender.date)
    newTimeSelected(newTimeString)
  }

  
  func newTimeSelected(newTimeString :NSString) {
    //println("newtimeselected")
    if (currentTag != -1) {
      let myBtn = self.tableView.viewWithTag(currentTag) as! UIButton
      myBtn.setTitle(newTimeString as String, forState: UIControlState.Normal)
    } else {
      topTimeBtn.setTitle(newTimeString as String, forState: UIControlState.Normal)
      daTime = newTimeString
    }
  }
  
  func getCurrentButton() -> UIButton {
    var myBtn :UIButton = UIButton()
    if (currentTag != -1) {
      myBtn = self.tableView.viewWithTag(currentTag) as! UIButton
    } else {
      myBtn = topTimeBtn
    }
    return myBtn
  }
  
  func closePicker() {      // called from done button
    timePicker.hidden = true
    saveTheItem()
    highlightOff()
  }
  
  // MARK - Item Detail Delegate
  
  func detailSave() {
    loadDataForDate(daDate)
    self.tableView.reloadData()
  }
  
}

