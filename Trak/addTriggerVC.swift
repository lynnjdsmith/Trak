//
//  addTriggerVC.swift
//
//  Created by Lynn Smith on 5/24/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

//import Foundation
import UIKit

class addTriggerVC: UIViewController {
  
  var mainVC: UIViewController!
  
  @IBOutlet weak var nameField: UITextField!
//  @IBOutlet weak var typeField: UITextField!
  @IBOutlet weak var activeSwitch :UISwitch!
  
  //@IBOutlet weak var dueDatePicker: UIDatePicker!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var myITTBot :indTrackedTriggerBot = indTrackedTriggerBot()
    myITTBot.makeNewITT("NEW!", active:true)
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelButtonTapped(sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func addTaskButtonTapped(sender: UIButton) {
    //var task = TaskModel(task: taskTextField.text, subTask: subtaskTextField.text, date: dueDatePicker.date, completed: false)
    //mainVC.baseArray[0].append(task)
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
  
  
}