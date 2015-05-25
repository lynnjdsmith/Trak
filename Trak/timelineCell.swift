//
//  timelineCell.swift
//

import UIKit


class timelineCell: PFTableViewCell {
  @IBOutlet var   label1: UILabel!
  @IBOutlet var   timeTextField: UITextField!
  @IBOutlet var   timeBtn: UIButton!
  @IBOutlet var cellVerticalBar: UIView!
  var pickerView :UIPickerView
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
    pickerView = UIPickerView()
    super.init(style: style, reuseIdentifier: reuseIdentifier)

  }
  
  required init(coder aDecoder: NSCoder)
  {
      pickerView = UIPickerView()
      super.init(coder: aDecoder)
  }
}



 /*  @IBAction func timeStartEditing(sender: UITextField!) {
    println("a")
    pickerView.frame = CGRectMake(0, 500, self.frame.size.width, pickerView.frame.size.height);
    self.addSubview(pickerView)
  } */

  


  
