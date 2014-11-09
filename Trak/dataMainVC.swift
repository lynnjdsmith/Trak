//
//  dataMainVC.swift
//

import UIKit
import QuartzCore

class dataMainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet var tableViewData: UITableView!
  @IBOutlet var topBackView: UIView!
  var items           :NSMutableArray = []
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // general set stuff
    topBackView.layer.borderWidth = 0.3
    topBackView.layer.borderColor = UIColor.appLightGray().CGColor
    self.navigationController?.navigationBarHidden = true
    //text1.becomeFirstResponder()
    //helpView.hidden = true
    tableViewData.separatorStyle = UITableViewCellSeparatorStyle.None

    loadData("Potato")
    
  }
  
  
  /****   Load Data Functions   ****/
  
  func loadData(theWord: NSString) {
    println("Load data for string: \(theWord)")

    // show HUD
    var HUD = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
    HUD.labelText = "loading"
    
    // create query
    var findData:PFQuery = PFQuery(className: "Items")
    findData.whereKey("username", equalTo:PFUser.currentUser().username)
    findData.whereKey("name", equalTo:theWord)
    
    // send query
    findData.findObjectsInBackgroundWithBlock {
      (objects:[AnyObject]!, error:NSError!)->Void in
    
      HUD.hidden = true
      
      if (error == nil) {
        println("return")
        self.items = []
        for object in objects as [PFObject] {
                  println("return2")
          self.items.addObject(object)
          //println(object)
        }
        self.tableViewData.reloadData()
      } else {
        println("error: \(error)")
      }
    }
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
    //cell.delegate = self
    
    // set the name
    var daName: AnyObject! = items[indexPath.row]
    cell.label1.text = daName.valueForKey("name") as NSString
    
    // set the time
    var daDateName: AnyObject! = items[indexPath.row]
    let daDateVal: AnyObject! = daDateName.valueForKey("myDateTime")
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
    
    //set time field pattern
    var paddingView :UIView = UIView(frame: CGRectMake(0, 0, 7, 20))
    paddingView.backgroundColor = UIColor.clearColor()
    cell.timeTextField.leftView = paddingView
    cell.timeTextField.leftViewMode = UITextFieldViewMode.Always
    
    //cell.allowsSelection = true
    
    return cell
  }
  
  
  func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    //println("You selected cell #\(indexPath.row)!")
    
    //select row, show item detail
    //self.selectedRow = indexPath.row
    let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("itemDetailController") as itemDetailController
    secondViewController.objID = items[indexPath.row].objectId
    //secondViewController.delegate = self
    self.navigationController?.pushViewController(secondViewController, animated: true)
  }
  
}
