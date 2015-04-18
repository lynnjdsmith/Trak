//
//

import UIKit

class triggerCell: PFTableViewCell {
  @IBOutlet var   labelTitle: UILabel!
  //@IBOutlet var   timeTextField: UITextField!
  //@IBOutlet var   timeBtn: UIButton!
  //@IBOutlet var   cellVerticalBar: UIView!
  
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init(coder aDecoder: NSCoder)
  {
      super.init(coder: aDecoder)
  }
  
  
}