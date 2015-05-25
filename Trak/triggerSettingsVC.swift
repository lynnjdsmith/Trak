//
//  Trak
//
//  Created by Lynn Smith on 10/24/14.
//  Copyright (c) 2014 Lynn Smith. All rights reserved.
//

import Foundation

import UIKit
import QuartzCore

class triggerSettingsVC: UITableViewController {

  var items           :NSMutableArray = []
  var activeItems           :NSMutableArray = []
  var completedItems           :NSMutableArray = []
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    println("will appear")
    // create query
    var findData:PFQuery = PFQuery(className: "ind_TrackedTriggers")
    findData.whereKey("username", equalTo:PFUser.currentUser().username!)
    //var findData:PFQuery = PFQuery(className: "TriggerList_Base")
    //findData.orderByAscending("rank")
    
    // start Loading...
    var HUD = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
    HUD.labelText = "loading"
    
    // run query
    findData.findObjectsInBackgroundWithBlock {
      (objects:[AnyObject]!, error:NSError!)->Void in
      HUD.hidden = true
      if (error == nil) {
        println("1")
        self.items = []
        self.activeItems = []
        self.completedItems = []
        for object in objects as! [PFObject] {
          var activeState :Bool = object.valueForKey("isActive") as! Bool
          if activeState == true {
          self.activeItems.addObject(object)
            }
          else {
            self.completedItems.addObject(object)
          }
        }
        self.tableView.reloadData()
      }
    }
    
    
    
    /* let date1 = Date.from(year: 2014, month: 05, day: 20)
    let date2 = Date.from(year: 2014, month: 03, day: 3)
    let date3 = Date.from(year: 2014, month: 12, day: 13)
    
    let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: date1, completed: false)
    let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: date2, completed: false)
    
    var taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Leg Day", date: date3, completed: false )]
    
    var completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, completed: true)]
    
    baseArray = [taskArray, completedArray] */
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    
  }
  
  
  /**  Table Info and Functions  **/
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count;
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    // setup cell
    var cell = tableView.dequeueReusableCellWithIdentifier("triggerCell") as! triggerCell
    cell.selectionStyle = UITableViewCellSelectionStyle.None;
    
    // set the name
    cell.labelTitle.text = items[indexPath.row].valueForKey("name") as? String
    
    //Add dot
    var circle :UIImageView = UIImageView(frame:CGRectMake(15, 20, 12, 12))
    circle.image = UIImage(named: "dot_green.png")
    cell.addSubview(circle)
    
    //Add carat
    var carat :UIImageView = UIImageView(frame:CGRectMake(self.view.frame.width - 30, 20, 12, 16))
    carat.image = UIImage(named: "indicator20.png")
    carat.alpha = 0.4
    cell.addSubview(carat)
    
    return cell
  }
  
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    println("You selected cell #\(indexPath.row)!")
    //selectedIndexPath = tableView.indexPathForSelectedRow()!
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    let s = mainView.instantiateViewControllerWithIdentifier("triggerDetailVC") as! triggerDetailVC
    //s.objID = items[indexPath.row].objectId
    //s.delegate = self
    s.daName = "Yoa!"
    self.navigationController?.pushViewController(s, animated: true)
  }
  
  // giving it sections
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2 //baseArray.count
  }
  
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 25
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "Active"
    }
    else {
      return "Completed"
    }
  }
  
  
  
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "triggerDetail" {
      let detailVC: triggerDetailVC = segue.destinationViewController as! triggerDetailVC
      let indexPath = self.tableView.indexPathForSelectedRow()
      //let thisTask = baseArray[indexPath!.section][indexPath!.row]
      //detailVC.detailTaskModel = thisTask
      detailVC.mainVC = self
    }
    //else if segue.identifier == "showTaskAdd" {
    //  let addTaskVC:AddTaskViewController = segue.destinationViewController as! AddTaskViewController
    //  addTaskVC.mainVC = self
    //}
  }
  
  @IBAction func addButtonTapped(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("showTaskAdd", sender: self)
  }
  
  
}

