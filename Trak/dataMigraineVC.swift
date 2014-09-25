//
//  dataMigraineVC.swift
//

import UIKit
import QuartzCore

class dataMigraineVC: UIViewController{

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

    loadElements()
    
    let myData = [
      ["label" : "Milk",   "value" : NSNumber(int:15)],
      ["label" : "Wheat",  "value" : NSNumber(int:30)],
      ["label" : "Bilk",  "value" : NSNumber(int:7)],
      ["label" : "Chocolate", "value" : NSNumber(int:60)],
      ["label" : "Butter",   "value" : NSNumber(int:30)],
      ["label" : "Coffee",   "value" : NSNumber(int:15)],
      ["label" : "Red Wine",   "value" : NSNumber(int:45)],
      ] as NSArray
    
    let graph = SingleSymptomLine_GraphView(frame: CGRectMake(0, 70, 320, 400), data: myData)
    self.view.addSubview(graph)
    
  }
  
  
  /****   Load Data Functions   ****/
  func loadElements() {
  //func loadElements(theWord: NSString) {
/*    let radius = 100.0
    
    // Create the circle layer
    var circle = CAShapeLayer()
    
    // Set the center of the circle to be the center of the view
    let center = CGPointMake(CGRectGetMidX(self.layer.frame) - radius, CGRectGetMidY(self.frame) - radius)
    
    let fractionOfCircle = 3.0 / 4.0
    
    let twoPi = 2.0 * Double(M_PI)
    // The starting angle is given by the fraction of the circle that the point is at, divided by 2 * Pi and less
    // We subtract M_PI_2 to rotate the circle 90 degrees to make it more intuitive (i.e. like a clock face with zero at the top, 1/4 at RHS, 1/2 at bottom, etc.)
    let startAngle = Double(fractionOfCircle) / Double(twoPi) - Double(M_PI_2)
    let endAngle = 0.0 - Double(M_PI_2)
    let clockwise: Bool = true
    
    // `clockwise` tells the circle whether to animate in a clockwise or anti clockwise direction
    circle.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).CGPath
    
    // Configure the circle
    circle.fillColor = UIColor.blackColor().CGColor
    circle.strokeColor = UIColor.redColor().CGColor
    circle.lineWidth = 5
    
    // When it gets to the end of its animation, leave it at 0% stroke filled
    circle.strokeEnd = 0.0
    
    // Add the circle to the parent layer
    self.layer.addSublayer(circle)
    
    // Configure the animation
    var drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
    drawAnimation.repeatCount = 1.0
    
    // Animate from the full stroke being drawn to none of the stroke being drawn
    drawAnimation.fromValue = NSNumber(double: fractionOfCircle)
    drawAnimation.toValue = NSNumber(float: 0.0)
    
    drawAnimation.duration = 30.0
    
    drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    // Add the animation to the circle
    circle.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
    
    
    println("Load data for string: \(theWord)")

    // show HUD
    var HUD = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
    HUD.labelText = "loading"
    HUD.hidden = true */
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
