//
//  timelineCell.swift
//

import UIKit

protocol tCellDelegate {
  func didChangeTime(val: NSString!)
}

// class daCell
class timelineCell: UITableViewCell {
  @IBOutlet var   label1: UILabel!
  @IBOutlet var   timeTextField: UITextField!
  
  var delegate    :tCellDelegate? = nil
  
  
  /* NAH override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

  }

  /* required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  } */
  
  required init(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
        timeTextField.text = time
  } */
  
  /* func datePressed(sender: UIButton!) {
    var btnSent:UIButton = sender
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
    done(self)
  } */
  

  @IBAction func timeStartEditing(sender: UITextField!) {
    //println("a")
    //sender.layer.borderColor = UIColor.appBlue().CGColor
    //sender.layer.backgroundColor = UIColor.whiteColor().CGColor
  }
  
  
  @IBAction func timeEdited(sender: UITextField!) {
    
    //sender.layer.borderColor = UIColor.appLightestGray().CGColor
    //sender.layer.backgroundColor = UIColor.clearColor().CGColor

    //if (delegate != nil) {
      //delegate!.didChangeTime(sender.titleForState(.Normal))//(self, type: pizzaType, price: pizzaPrice)
      //delegate!.didChangeTime(sender.text)
    //}
  }
  
}
  
  
    /*
    
    if (d == nil) {
      //println("time edited. d: \(d)")
      var alert = UIAlertController(title: "Alert", message: "Please use format: \n'11:11'", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      //self.presentViewController(alert, animated: true, completion: nil)
      
      /* var HUD = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
      //HUD.delegate = self;
      //HUD.customView = [[[UIImageView alloc] initWithImage:
      //    [UIImage imageNamed:"X-Mark.png"]] autorelease];
      HUD.mode = MBProgressHUDModeCustomView;
      HUD.labelText = "An error occured";
      HUD.showWhileExecuting(Selector("waitForTwoSeconds"), onTarget:self, withObject:nil, animated:true)
      */
      
    } else {
      theItem.setObject(d, forKey: "myDateTime")
      theItem.saveInBackground()
      println("time edited. d: \(d)")
      
      // put the new time on the button
      self.timeBtn.setTitle(daTime, forState: .Normal)
      
      // hide me
      self.timeBtn.hidden = false
      self.timeTextField.hidden = true
    }*/
    

  
  
 /*  @IBAction func touchTimeBtn(sender: UIButton) {
    sender.hidden = true
    self.timeTextField.becomeFirstResponder()
    self.timeTextField.text = sender.titleForState(.Normal) //daTime
    self.timeTextField.hidden = false
  } */
  
  
