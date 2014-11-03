//
//  itemDetailController.swift
//

import UIKit
import QuartzCore

protocol itemDetailDelegate {
    func closeMod()
    //func reloadMainData()
}

class itemDetailController: UIViewController {
  
  // IBOutlets
  @IBOutlet var daTitle         :UITextField!
  @IBOutlet var dayTextField    :UITextField!
  @IBOutlet var AMPMBtn         :UIButton!
  @IBOutlet var timeTextField   :UITextField!
  @IBOutlet var noteTextField   :UITextView!
  @IBOutlet var trigSympControl :UISegmentedControl!
  @IBOutlet var amountField     :UILabel!
  @IBOutlet var amountSlider    :UISlider!
  @IBOutlet var deleteBtn       :UIButton!
  //@IBOutlet var seeAllBtn       :UIButton!
  @IBOutlet var seeChart        :UIButton!
  @IBOutlet var scrollView      :UIScrollView!
  @IBOutlet var topBackView     :UIView!
  
  // Variables
  var delegate  :itemDetailDelegate? = nil
  var objID     :NSString! = ""
  var theItem   :PFObject!
  var daDate    :NSString!
  var daTime    :NSString! = ""
  var daAMPM    :NSString! = "AM"
  var name      :NSString! = ""
  
  // first value is doubled, because 0 isn't really used.
  var amountNames :NSArray = ["a tiny bit (a1)", "a tiny bit (a1)", "very little (a2)","a little (a3)", "just less than normal (a4)", "normal amount (a5)","a little extra (a6)","a lot (a7)", "a lot + (a8)", "double or more (a9)", "an extreme amount (a10)"]
  
  override func viewWillAppear(animated: Bool) {
    loadDataForStart()
    navigationController?.setNavigationBarHidden(true, animated:true)
    //seeAllBtn.hidden = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.contentSize = CGSize(width: 320, height: 620)
    
    // general set stuff
    topBackView.layer.borderWidth = 0.3
    topBackView.layer.borderColor = UIColor.appLightGray().CGColor
    //titleTop.text = name
    
    //let graph = SingleSymptomLine_GraphView(frame: CGRectMake(0, 430, 320, 200))
    //self.view.addSubview(graph)
    
    // add gesture recognizer
    let recognizer = UITapGestureRecognizer(target: self, action:Selector("handleTap:"))
    //recognizer.delegate = scrollView
    view.addGestureRecognizer(recognizer)
    
    // set time field look
    daTitle.layer.borderColor = UIColor.clearColor().CGColor
    daTitle.layer.backgroundColor = UIColor.clearColor().CGColor
    daTitle.layer.borderWidth = 1
    daTitle.layer.cornerRadius = 8

    // set time field look
    dayTextField.layer.borderColor = UIColor.appLightestGray().CGColor
    dayTextField.layer.backgroundColor = UIColor.clearColor().CGColor
    dayTextField.layer.borderWidth = 1
    dayTextField.layer.cornerRadius = 8
    
    //set time field pattern
    var paddingView :UIView = UIView(frame: CGRectMake(0, 0, 7, 20))
    paddingView.backgroundColor = UIColor.clearColor()
    daTitle.leftView = paddingView
    daTitle.leftViewMode = UITextFieldViewMode.Always

    // create back btn
    navigationController?.setNavigationBarHidden(true, animated:true)
    let b   = UIButton() //UIButton.buttonWithType(UIButtonType.System) as UIButton
    b.frame = CGRectMake(-15, 20, 100, 50)
    b.backgroundColor = UIColor.clearColor()
    b.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
    b.setTitleColor(UIColor.appLightGray(), forState: .Normal)
    b.setTitle("Back", forState: UIControlState.Normal)
    b.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(b)
    
    // show nav bar
    //self.navigationController?.navigationBarHidden = false
    
    // amountNames for amount field
    amountField.text = amountNames[5] as NSString
    
    // style the buttons
    dayTextField.normalStyle("")
    timeTextField.normalStyle("")
    deleteBtn.normalStyle("Delete This Item")
    //seeAllBtn.normalStyle("See All")
    seeChart.normalStyle("See Chart")
    AMPMBtn.normalStyle("")
    trigSympControl.layer.borderColor = UIColor.appRed().CGColor
    trigSympControl.layer.borderWidth = 0
    trigSympControl.layer.cornerRadius = 10
    //trigSympControl.transform = CGAffineTransformMakeScale(0.88, 0.88)
    
    // style the text field
    noteTextField.layer.borderColor = UIColor.appRed().CGColor
    noteTextField.layer.borderWidth = 1
    noteTextField.layer.cornerRadius = 10
    noteTextField.layer.cornerRadius = 10
  }
  
  func handleTap(recognizer: UITapGestureRecognizer) {
    //println("a")
    self.view.endEditing(true)
    daTitle.resignFirstResponder()
    dayTextField.resignFirstResponder()
    timeTextField.resignFirstResponder()
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(false)
    // set data
    theItem.setObject(NSString(format: "%2.02f", amountSlider.value), forKey: "amount")
    
    // save name
    theItem.setObject(daTitle.text, forKey: "name")
    
    //println("dissapear. datitle: \(daTitle.text)")
    
    theItem.saveInBackgroundWithBlock {
      (success: Bool!, error: NSError!) -> Void in
      if (success != nil) {
        if let d = self.delegate {
          //d.closeMod()
        }
        //self.navigationController?.popToRootViewControllerAnimated(true)
      } else {
        println("%@", error)
      }
    }
    
  }
  
/*
  func popToRoot(sender:UIBarButtonItem){
      println("*** poptoroot ***")
    // set data
    theItem.setObject(NSString(format: "%2.02f", amountSlider.value), forKey: "amount")
    
    // save myDateTime - FIX - needed? No. exiting these fields triggers save
    /*
    var theDateWithTime: NSString! = "\(dayTextField.text) \(timeTextField.text) \(daAMPM)"
    println("day edited. theDateWithTime: |\(theDateWithTime)|")
    let dateStringFormatter = NSDateFormatter()
    dateStringFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
    let d = dateStringFormatter.dateFromString(theDateWithTime)
    
    // check for correct date format
    if (d == nil) {
      var alert = UIAlertController(title: "Alert", message: "Please use format: \n'MM/DD/YYYY'", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
    }
    
    theItem.setObject(d, forKey: "myDateTime") */
    
    // save name
    theItem.setObject(daTitle.text, forKey: "name")
    
    //println("day edited. poptoroot d: \(d)")
    
    theItem.saveInBackgroundWithBlock {
      (success: Bool!, error: NSError!) -> Void in
      if (success != nil) {
        if let d = self.delegate {
          d.closeMod()
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
      } else {
        println("%@", error)
      }
    }
  } */
  
  
  func loadDataForStart() {
    // send query
    var HUD = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
    //HUD.delegate = self;
    HUD.labelText = "loading"
    //println("objID: \(objID)")
    var query:PFQuery = PFQuery(className: "Items")
    query.whereKey("objectId", equalTo:objID)
    query.whereKey("username", equalTo:PFUser.currentUser().username)
  
    query.getFirstObjectInBackgroundWithBlock {
        (object: PFObject!, error: NSError!) -> Void in
      
      HUD.hidden = true
      
      if (object == nil) {
        println("The getFirstObject request failed.")
      } else {
        // store the item
        self.theItem = object
        
        // set title
        self.daTitle.text = object.valueForKey("name") as NSString
        self.name = object.valueForKey("name") as NSString
        // set date
        let myDate :NSDate = object.valueForKey("myDateTime") as NSDate
        let dateFormatterAll = NSDateFormatter()
        //dateFormatterAll.dateFormat = "EEEE, MMM d"
        dateFormatterAll.dateFormat = "MM/dd/yyyy"
        let myStr :NSString = dateFormatterAll.stringFromDate(myDate)
        //self.dayBtn.setTitle(myStr, forState: .Normal)
        self.dayTextField.text = myStr
        
        // set date variable
        let date :NSDate = object.valueForKey("myDateTime") as NSDate
        let df = NSDateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        let d :NSString = df.stringFromDate(date)
        self.daDate = d as NSString
        
        // set daTime
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "h:mm" //"h:mm:ss a "
        let myTime :NSString = timeFormatter.stringFromDate(myDate)
        self.daTime = myTime as NSString

        // set timeTextField
        let timeFormatterB = NSDateFormatter()
        timeFormatterB.dateFormat = "h:mm" //"h:mm:ss a "
        let myTimeB :NSString = timeFormatterB.stringFromDate(myDate)
        self.timeTextField.text = myTimeB
        
        // set AM/PM
        let ampmf = NSDateFormatter()
        ampmf.dateFormat = "a" //"h:mm:ss a "
        let myAMPM :NSString = ampmf.stringFromDate(myDate)
        self.daAMPM = myAMPM
        self.AMPMBtn.setTitle(myAMPM, forState: .Normal)

        //self.timeTextField.text = self.daTime.stringByTrimmingCharactersInSet(NSCharacterSet (charactersInString: "AMP "))

        // set time button
        let tf = NSDateFormatter()
        tf.dateFormat = "h:mm"
        let mT :NSString = tf.stringFromDate(myDate)
        self.timeTextField.text = mT //.setTitle(mT, forState: .Normal)

        // set amount slider
        self.amountSlider.value = object.valueForKey("amount").floatValue
        
        // amountNames for amount field
        var theAmount :Int = Int(object.valueForKey("amount").floatValue)
        self.amountField.text = self.amountNames[theAmount] as NSString
        
        //println("daTime, setting \(self.daTime)")
        // set the segmented control for trigger or symptom
        switch object.valueForKey("type") as NSString { //== "trigger") {
          case "trigger":
            self.trigSympControl.selectedSegmentIndex = 0
          case "symptom":
            self.trigSympControl.selectedSegmentIndex = 1
          case "treatment":
            self.trigSympControl.selectedSegmentIndex = 2
          default:
            self.trigSympControl.selectedSegmentIndex = 0
        }
      }
    }
  }
  
  
  @IBAction func startEditTitle(sender: UITextField) {
    println("startEdit")
    daTitle.layer.borderColor = UIColor.appBlue().CGColor
    daTitle.layer.backgroundColor = UIColor.whiteColor().CGColor
  }
  
  
  @IBAction func endEditTitle(sender: UITextField) {
    println("endEdit")
    daTitle.layer.borderColor = UIColor.clearColor().CGColor
    daTitle.layer.backgroundColor = UIColor.clearColor().CGColor
    self.resignFirstResponder()
    theItem.setObject(sender.text, forKey: "name")
    theItem.saveInBackground()
  }

  
  @IBAction func startEditTime(sender: UITextField) {
    println("startEdit")
    timeTextField.layer.borderColor = UIColor.appBlue().CGColor
    timeTextField.layer.backgroundColor = UIColor.whiteColor().CGColor
  }
  
  
  @IBAction func startEdit(sender: UITextField) {
    println("startEdit")
    sender.layer.borderColor = UIColor.appBlue().CGColor
    sender.layer.backgroundColor = UIColor.whiteColor().CGColor
  }
  
  @IBAction func endEditTime(sender: UITextField) {
    println("endEdit")
    timeTextField.layer.borderColor = UIColor.clearColor().CGColor
    timeTextField.layer.backgroundColor = UIColor.clearColor().CGColor
    
    // resign first responder
    sender.resignFirstResponder()
    
    // save myDateTime
    // set time into global page variable
    daTime = self.timeTextField.text
    let theTime :NSString = sender.text as NSString
    saveMyDateTime(theTime)
  }
  
  @IBAction func changeAmountSlider(sender: UISlider) {
    //println("changeAmountSlider")
    //theItem.setObject(NSString(format: "%2.02f", amountSlider.value), forKey: "amount")
    var theAmount :Int = Int(sender.value) //- 0.7
    amountField.text = amountNames[theAmount] as NSString
  }


  func saveMyDateTime(theText :NSString) {
    // save myDateTime
    println("theTime edited \(theText)")
    var theDateWithTime: NSString! = "\(daDate) \(self.daTime) \(self.daAMPM)"
    //println("time edited. theDateWithTime: |\(theDateWithTime)|")
    let dateStringFormatter = NSDateFormatter()
    dateStringFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
    let d = dateStringFormatter.dateFromString(theDateWithTime)
    //println("d in item detail: \(d)")
    
    if (d == nil) {
      var alert = UIAlertController(title: "Alert", message: "Please use format: \n 'MM/DD/YYYY' for the date and \n'11:11' for the time.", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      
    } else {
      theItem.setObject(d, forKey: "myDateTime")
      theItem.saveInBackground()
      println("time edited. d: \(d)")
      
      // put the new time on the button
      self.timeTextField.text = daTime
    }
  }
  
  @IBAction func touchAMPMBtn(sender: UIButton) {
    println("start daAMPM \(daAMPM)")
    
    if (self.daAMPM == "PM") {
      println("in PM -- daAMPM \(daAMPM)")
      AMPMBtn.setTitle("AM", forState: .Normal)
      self.daAMPM = "AM"
      saveMyDateTime(self.timeTextField.text)
    } else {
      if (self.daAMPM == "AM") {
        println("in AM -- daAMPM \(daAMPM)")
        AMPMBtn.setTitle("PM", forState: .Normal)
        self.daAMPM = "PM"
        saveMyDateTime(self.timeTextField.text)
      }
    }
  }

  
  @IBAction func endEditDay(sender: UITextField) {    
    println("endEdit")
    sender.layer.borderColor = UIColor.clearColor().CGColor
    sender.layer.backgroundColor = UIColor.clearColor().CGColor
    self.resignFirstResponder()
    
    /**** Next up - make it so it updates main list. Also, editing date, mm/dd/yyyy needs to be shown to user   ****/
    daDate = self.dayTextField.text
    
    // save myDateTime
    // set time into global page variable
    daTime = self.timeTextField.text
    let theTime :NSString = sender.text as NSString
    saveMyDateTime(theTime)
  }
  
  
  @IBAction func onTOSValueChanged(sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex  {
    case 0:
      //println("triggered")
      theItem.setObject("trigger", forKey:"type")
      theItem.saveInBackground()
    case 1:
      //println("sympt")
      theItem.setObject("symptom", forKey:"type")
      theItem.saveInBackground()
    case 2:
      //println("treatment")
      theItem.setObject("treatment", forKey:"type")
      theItem.saveInBackground()
    default: break;
    }
  }
  
  
  @IBAction func deleteMe(sender: AnyObject) {
    //println("Delete Me!")
    println("objID: \(objID)")
    
    var query = PFQuery(className:"Items")
    query.getObjectInBackgroundWithId(objID) {
        (theItem: PFObject!, error: NSError!) -> Void in
        if (theItem != nil) {
            //NSLog("deleted - %@", theItem)
            theItem.deleteInBackground()
            //if let d = self.delegate {
              //  self.delegate.closeMod(theItem)
            //}
          
          if let d = self.delegate {
            d.closeMod()
          }
        } else {
            println("error: \(error)")
        }
    }
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  

  @IBAction func seeChart(sender: AnyObject) {
    //println("Delete Me!")
    println("objID: \(objID)")
  }
  
  @IBAction func goToSingleSymptomDetail(sender: AnyObject) {
    //println("yo! gotossd")
    let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("singleSymptomDataVC") as singleSymptomDataVC
    secondViewController.objID = self.objID
    secondViewController.name = self.name
    secondViewController.theItem = self.theItem
    secondViewController.daDate = self.daDate
    secondViewController.daTime = self.daTime
    //secondViewController.delegate = self
    self.navigationController?.pushViewController(secondViewController, animated: true)
  }
  
  
  func goBack(sender: UIButton) {
    navigationController?.popViewControllerAnimated(true)
  }
  
}

