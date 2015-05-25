//
//  triggerDetailVC.swift


import UIKit

class triggerDetailVC: UIViewController {
  
  //var detailTaskModel: TaskModel!
  var mainVC :UITableViewController!
  var daName :String!
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var activeSwitch :UISwitch!
  //@IBOutlet weak var subtaskTextField: UITextField!
  //@IBOutlet weak var dueDatePicker: UIDatePicker!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    self.nameField.text = daName //"Yo" //detailTaskModel.task
    //self.subtaskTextField.text = detailTaskModel.subTask
    //self.dueDatePicker.date = detailTaskModel.date
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
    
    //var task = TaskModel(task: taskTextField.text, subTask: subtaskTextField.text, date: dueDatePicker.date, completed: false)
    //mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow()!.row] = task
    
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  
  
  
  
}