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
  @IBOutlet var timeBtn         :UIButton!
  @IBOutlet var trigSympControl :UISegmentedControl!
  @IBOutlet var deleteBtn       :UIButton!
  @IBOutlet var amountSegment   :UISegmentedControl!
  @IBOutlet weak var scrollView :UIScrollView!
  
  // Variables
  var delegate  :timelineViewController? = nil
  var timePicker :myTimePicker!
  var theItem   :PFObject!
  var objID     :NSString! = ""
  var daDate    :NSString!
  var daTime    :NSString! = ""
  var name      :NSString! = ""
  
  
  override func viewWillAppear(animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated:true)
    loadDataForItem()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set scroll view height
    self.scrollView.contentSize.height = 580
    
    // create back btn
    let b = UIButton()
    b.frame = CGRectMake(-10, 22, 100, 50)
    b.backgroundColor = UIColor.clearColor()
    b.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
    b.setTitleColor(UIColor.appLightGray(), forState: .Normal)
    b.setTitle("Back", forState: UIControlState.Normal)
    b.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(b)
    
    // add time picker
    timePicker = myTimePicker(frame: CGRectMake(0, self.view.frame.height - 240, self.view.frame.width, 240), myparent2: self) as myTimePicker
    self.view.addSubview(timePicker)
    timePicker.hidden = true
    
    //set time field pattern
    var paddingView :UIView = UIView(frame: CGRectMake(0, 0, 7, 20))
    paddingView.backgroundColor = UIColor.clearColor()
    daTitle.leftView = paddingView
    daTitle.leftViewMode = UITextFieldViewMode.Always

    amountSegment.layer.borderColor = UIColor.appRed().CGColor
    amountSegment.layer.borderWidth = 0
    amountSegment.layer.cornerRadius = 15
    
    trigSympControl.layer.borderColor = UIColor.appRed().CGColor
    trigSympControl.layer.borderWidth = 0
    trigSympControl.layer.cornerRadius = 15
    
    // style the buttons
    deleteBtn.normalStyle("Delete This Item")
    
    // add gesture recognizer to close keyboard on general tap
    let recognizer = UITapGestureRecognizer(target: self, action:Selector("handleTap:"))
    view.addGestureRecognizer(recognizer)
   }
  
  
  //override func viewDidDisappear(animated: Bool) {
  func saveTheItem() {
  //super.viewDidDisappear(false)
    
    // set name
    theItem.setObject(daTitle.text, forKey: "name")
    
    // set date
    var theDateWithTime: NSString! = "\(daDate) \(daTime)"
    var d = getUTCDateFromString(theDateWithTime)
    //println("d: \(d)")
    theItem.setObject(d, forKey:"myDateTime")
    
    // set amount
    switch amountSegment.selectedSegmentIndex {
    case 0:
      theItem.setObject("1", forKey:"amount")
    case 1:
      theItem.setObject("2", forKey:"amount")
    case 2:
      theItem.setObject("3", forKey:"amount")
    default:
      theItem.setObject("2", forKey:"amount")
    }

    // set type
    switch trigSympControl.selectedSegmentIndex  {
    case 0:
      theItem.setObject("trigger", forKey:"type")
    case 1:
      theItem.setObject("symptom", forKey:"type")
    case 2:
      theItem.setObject("treatment", forKey:"type")
    default: break;
    }

    theItem.saveInBackgroundWithBlock {           // LYNN - really?
      (success, error) -> Void in
      if (success == false) { println("ERROR in Saving: %@", error) }
      else {
        if let d = self.delegate {
          d.detailSaveDone()
        }
    }
    }
  }
  
  func loadDataForItem() {
    // send query
    var HUD = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
    HUD.labelText = "loading"
    //println("objID: \(objID)")
    var query:PFQuery = PFQuery(className: "Items")
    query.whereKey("objectId", equalTo:objID)
    query.whereKey("username", equalTo:PFUser.currentUser().username)
  
    query.getFirstObjectInBackgroundWithBlock {
        (object: PFObject!, error: NSError!) -> Void in
      
      HUD.hidden = true
      
      if (object == nil) {
        println("loadDataForItem - The getFirstObject request failed.")
      } else {
        // store the item
        self.theItem = object
        
        // set title
        self.daTitle.text = object.valueForKey("name") as! NSString as! String
        self.name = object.valueForKey("name") as! NSString

        // set date
        let date :NSDate = object.valueForKey("myDateTime") as! NSDate
        let df = NSDateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        let d :String = df.stringFromDate(date)
        self.daDate = d
        
        // set daTime
        let myDate :NSDate = object.valueForKey("myDateTime") as! NSDate
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        let myTime :String = timeFormatter.stringFromDate(myDate)
        self.daTime = myTime
        self.timeBtn.setTitle((myTime as! String), forState: .Normal)

        // set amount
        switch object.valueForKey("amount") as! NSString {
        case "1":
          self.amountSegment.selectedSegmentIndex = 0
        case "2":
          self.amountSegment.selectedSegmentIndex = 1
        case "3":
          self.amountSegment.selectedSegmentIndex = 2
        default:
          self.amountSegment.selectedSegmentIndex = 1
        }
        
        // set the trigger or symptom
        switch object.valueForKey("type") as! NSString { //== "trigger") {
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

  
  @IBAction func endEditTitle(sender: UITextField) {
    println("endEdit")
    daTitle.layer.borderColor = UIColor.clearColor().CGColor
    daTitle.layer.backgroundColor = UIColor.clearColor().CGColor
    self.resignFirstResponder()
  }

  @IBAction func startEdit(sender: UITextField) {
    println("startEdit")
    //sender.layer.borderColor = UIColor.appBlue().CGColor
    //sender.layer.backgroundColor = UIColor.whiteColor().CGColor
  }
  
  @IBAction func deleteMe(sender: AnyObject) {
    //println("Delete Me!")
    //println("Deleting. objID: \(objID)")
    
    var query = PFQuery(className:"Items")
    query.getObjectInBackgroundWithId(objID! as! String) {
        (theItem: PFObject!, error: NSError!) -> Void in
        if (theItem != nil) {
            theItem.deleteInBackground()
          if let d = self.delegate {
            d.closeMod()
          }
        } else {
            println("deleteMe error: \(error)")
        }
    }
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  

  /***   TIME FUNCTIONS   ***/
  
  @IBAction func timeBtnPress(sender: UIButton) {
    //println("timeBtn")
    var theTime :NSDate = getTimeFromString(daTime)
    timePicker.setTheTime(theTime)
    timePicker.hidden = false
  }
  
  func timePickerTimeChanged(sender: UIDatePicker) {
    //println("handle!")
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    var newTimeString :String = dateFormatter.stringFromDate(sender.date)
    newTimeSelected(newTimeString)
  }
  

  func newTimeSelected(newTimeString :String) {
      timeBtn.setTitle(newTimeString, forState: UIControlState.Normal)
      daTime = newTimeString
  }
  
  func closePicker()
  {
    timePicker.hidden = true
  }
  
  /* func doneButton(sender:UIButton)
  {
    timePicker.hidden = true
    timeBtn.layer.borderWidth = 0.0
  } */
  
  func goBack(sender: UIButton) {                           // go back top nav
    navigationController?.popViewControllerAnimated(true)
    saveTheItem()
  }
  
  func handleTap(recognizer: UITapGestureRecognizer) {      // global tap to close keyboard - todo add picker
    self.view.endEditing(true)
    daTitle.resignFirstResponder()
  }
  

  
  
}

