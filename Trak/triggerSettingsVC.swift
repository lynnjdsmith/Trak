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
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    println("will appear")
    // create query
    var findData:PFQuery = PFQuery(className: "TriggerList_Base")
    findData.orderByAscending("rank")
    var HUD = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
    HUD.labelText = "loading"
    
    findData.findObjectsInBackgroundWithBlock {
      (objects:[AnyObject]!, error:NSError!)->Void in
      HUD.hidden = true
      if (error == nil) {
        println("1")
        self.items = []
        for object in objects as! [PFObject] {
          self.items.addObject(object)
        }
        self.tableView.reloadData()
      }
    }
    
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
    //println("You selected cell #\(indexPath.row)!")
    //selectedIndexPath = tableView.indexPathForSelectedRow()!
    
    var mainView: UIStoryboard!
    mainView = UIStoryboard(name: "Main", bundle: nil)
    let s = mainView.instantiateViewControllerWithIdentifier("triggerDetailController") as! itemDetailController
    s.objID = items[indexPath.row].objectId
    //s.delegate = self
    self.navigationController?.pushViewController(s, animated: true)
  }
  
  
}

