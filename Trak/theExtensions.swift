//
//  theExtensions.swift
//  


import Foundation

extension UIButton {
  
  func normalStyle(name: NSString) -> UIButton {
    self.backgroundColor = UIColor.appRed()
    self.layer.cornerRadius = 8
    self.layer.borderWidth = 0
    self.clipsToBounds = true;
    self.setTitle(name as! String, forState: .Normal)
    self.setTitleColor(UIColor.btnText(), forState: .Normal)
    return self
  }
  
}

/* extension CGRect {
  var wh: (w: CGFloat, h: CGFloat) {
    return (size.width, size.height)
  }
} */

extension UITextField {
  
  func normalStyle(name: NSString) -> UITextField {
    self.backgroundColor = UIColor.appRed()
    self.layer.cornerRadius = 8
    self.layer.borderWidth = 0
    self.clipsToBounds = true;
    self.text = name as! String
    self.textColor = UIColor.whiteColor()
    //self.setTitleColor(UIColor.btnText(), forState: .Normal)
    return self
  }
  
}

extension NSString {
  
  func isSymptom(name: NSString) -> ObjCBool {
    
    var theSymptoms :NSMutableArray = ["Migraine","Headache"]
    for strObj in theSymptoms {
      var strObjNSS :NSString = (strObj as? NSString)!
      //if strObjNSS.compare(name) { // works with a new string
        if strObj.isEqualToString(name as! String) {
        println("SYMPTOM! \(name)")
        return true
      }
    }
    
    return false
  }
  
}


extension Int  {
  var day: (Int, NSCalendarUnit) {
  return (self, NSCalendarUnit.CalendarUnitDay)
  }
}

extension NSMutableArray {

  func get12Colors() -> NSMutableArray {
    self.addObject(UIColor.c1())
    self.addObject(UIColor.c2())
    self.addObject(UIColor.c3())
    self.addObject(UIColor.c4())
    self.addObject(UIColor.c5())
    self.addObject(UIColor.c6())
    self.addObject(UIColor.c7())
    self.addObject(UIColor.c8())
    self.addObject(UIColor.c9())
    self.addObject(UIColor.c10())
    self.addObject(UIColor.c11())
    self.addObject(UIColor.c12())
    return self
  }
  
  func dotImageNames() -> NSMutableArray {
    var dotNames :NSMutableArray = ["dot_green.png", "dot_yellow.png", "dot_blue1.png", "dot_blue2.png", "dot_purple1.png", "dot_pink.png",]
    return dotNames
  }

  
}

/*
func + (date: NSDate, tuple: (value: Int, unit: NSCalendarUnit)) -> NSDate {
  return NSCalendar.currentCalendar().dateByAddingUnit(tuple.unit, value: tuple.value, toDate: date, options: NSCalendarOptions.SearchBackwards)!
}

func - (date: NSDate, tuple: (value: Int, unit: NSCalendarUnit)) -> NSDate {
  return NSCalendar.currentCalendar().dateByAddingUnit(tuple.unit, value: (-tuple.value), toDate: date, options: NSCalendarOptions.SearchBackwards)!
}

func += (inout date: NSDate, tuple: (value: Int, unit: NSCalendarUnit)) {
  date = NSCalendar.currentCalendar().dateByAddingUnit(tuple.unit, value: tuple.value, toDate: date, options: NSCalendarOptions.SearchBackwards)!
}

func -= (inout date: NSDate, tuple: (value: Int, unit: NSCalendarUnit)) {
  date = NSCalendar.currentCalendar().dateByAddingUnit(tuple.unit, value: -tuple.value, toDate: date, options: NSCalendarOptions.SearchBackwards)!
} */

extension UIColor {
  class func appGreen() -> UIColor {
    return UIColor(red: 0.255, green: 0.804, blue: 0.470, alpha: 1)
  }
  class func appBlue() -> UIColor {
    return UIColor(red: 0.333, green: 0.784, blue: 1, alpha: 1)
  }
  class func appLightBlue2() -> UIColor {
    return UIColor(red: 155/255, green: 217/255, blue: 247/255, alpha: 1)
  }
  class func appPurple() -> UIColor {
    return UIColor(red: 0.659, green: 0.271, blue: 0.988, alpha: 1)
  }
  class func btnBkg() -> UIColor {
    return UIColor(red: 233/255, green: 244/255, blue: 217/255, alpha: 1)
  }
  class func btnBorder() -> UIColor {
    return UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
  }
  class func appLightGray() -> UIColor {
    return UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
  }
  class func appLightestGray() -> UIColor {
    return UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
  }
  class func btnText() -> UIColor {
    return UIColor.whiteColor() //UIColor(red: 43/255, green: 49/255, blue: 41/255, alpha: 1)
  }
  class func appRed() -> UIColor {
    return UIColor(red: 235/255, green: 68/255, blue: 68/255, alpha: 1)
  }
  class func appColorA() -> UIColor {
    return UIColor(red: 30/255, green: 166/255, blue: 122/255, alpha: 1)
  }
  class func btnColorB() -> UIColor {
    return UIColor(red: 132/255, green: 198/255, blue: 176/255, alpha: 1)
  }
  class func btnColorHighlight() -> UIColor {
    return UIColor(red: 18/255, green: 221/255, blue: 159/255, alpha: 1)
  }
  class func appLightBlue() -> UIColor {
    //return UIColor(red: 236/255, green: 243/255, blue: 248/255, alpha: 1)
    return UIColor(red: 246/255, green: 251/255, blue: 255/255, alpha: 1)
  }
  class func darkBlue() -> UIColor {
    return UIColor(red: 3/255, green: 63/255, blue: 108/255, alpha: 1)
  }
  
  class func color1() -> UIColor {
    return UIColor(red: 53/255, green: 144/255, blue: 211/255, alpha: 1)
  }
  class func color2() -> UIColor {
    return UIColor(red: 101/255, green: 188/255, blue: 130/255, alpha: 1)
  }
  class func color3() -> UIColor {
    return UIColor(red: 248/255, green: 168/255, blue: 131/255, alpha: 1)
  }
  class func color4() -> UIColor {
    return UIColor(red: 113/255, green: 75/255, blue: 154/255, alpha: 1)
  }
  class func color5() -> UIColor {
    return UIColor(red: 209/255, green: 81/255, blue: 216/255, alpha: 1)
  }
  
  
  // colors for dots
  class func c1() -> UIColor {
    return UIColor(red: 155/255, green: 219/255, blue: 59/255, alpha: 1)    //195, 255, 105
  }
  class func c2() -> UIColor {
    return UIColor(red: 176/255, green: 92/255, blue: 207/255, alpha: 1)
  }
  class func c3() -> UIColor {
    return UIColor(red: 237/255, green: 102/255, blue: 84/255, alpha: 1)
  }
  class func c4() -> UIColor {
    return UIColor(red: 78/255, green: 90/255, blue: 183/255, alpha: 1)
  }
  class func c5() -> UIColor {
    return UIColor(red: 52/255, green: 157/255, blue: 158/255, alpha: 1)
  }
  class func c6() -> UIColor {
    return UIColor(red: 85/255, green: 181/255, blue: 91/255, alpha: 1)
  }
  class func c7() -> UIColor {
    return UIColor(red: 250/255, green: 120/255, blue: 5/255, alpha: 1)
  }
  class func c8() -> UIColor {
    return UIColor(red: 129/255, green: 69/255, blue: 123/255, alpha: 1)
  }
  class func c9() -> UIColor {
    return UIColor(red: 28/255, green: 130/255, blue: 214/255, alpha: 1)
  }
  class func c10() -> UIColor {
    return UIColor(red: 233/255, green: 52/255, blue: 149/255, alpha: 1)
  }
  class func c11() -> UIColor {
    return UIColor(red: 251/255, green: 232/255, blue: 17/255, alpha: 1)
  }
  class func c12() -> UIColor {
    return UIColor(red: 118/255, green: 88/255, blue: 75/255, alpha: 1)
  }
  
  
/*  class func color6() -> UIColor {      // blue
    return UIColor(red: /255, green: /255, blue: /255, alpha: 1)
  }
  class func color7() -> UIColor {      // blue
    return UIColor(red: /255, green: /255, blue: /255, alpha: 1)
  }
  class func color8() -> UIColor {      // blue
    return UIColor(red: /255, green: /255, blue: /255, alpha: 1)
  }
  class func color9() -> UIColor {      // blue
    return UIColor(red: /255, green: /255, blue: /255, alpha: 1)
  }
  class func color10() -> UIColor {      // blue
    return UIColor(red: /255, green: /255, blue: /255, alpha: 1)
  }
  class func color11() -> UIColor {      // blue
    return UIColor(red: /255, green: /255, blue: /255, alpha: 1)
  }
  class func color12() -> UIColor {      // blue
    return UIColor(red: /255, green: /255, blue: /255, alpha: 1)
  } */
  
}

func randomInt(min: Int, max:Int) -> Int {
  return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}



@objc(regSeg) class regSeg: UIStoryboardSegue {
  
  override func perform() {
    //println("segue")
    let sourceViewController = self.sourceViewController as! UIViewController
    let destinationViewController = self.destinationViewController as! UIViewController
    
    sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil)
  }
  
}

// Look here for transitions http://www.thinkandbuild.it/how-to-create-custom-viewcontroller-transitions/


@objc(segOne) class segOne: UIStoryboardSegue {
  override func perform() {
    //println("segue")
    let sourceViewController = self.sourceViewController as! UIViewController
    let destinationViewController = self.destinationViewController as! UIViewController

    sourceViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
    sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil)
  }
}


func addDaysToDate(daysToAdd: Int, originalDate: NSDate) -> NSDate? {
  let newDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.DayCalendarUnit, value: daysToAdd, toDate: originalDate, options: nil)
  return newDate
}

func placeCircle(point : Dictionary<String, AnyObject>) -> UIView {
  
  var aView :UIView = UIView()
  
  // unwrap variables
  let size :CGFloat = point["size"] as AnyObject? as! CGFloat
  var xPos :CGFloat = point["xPos"] as AnyObject? as! CGFloat
  var yPos :CGFloat = point["yPos"] as AnyObject? as! CGFloat
  var color :UIColor = point["color"] as AnyObject? as! UIColor
  
  
  // holder for circle and label
  let pointMarker = CALayer()
  
  // draw circle
  let markerInner = CALayer()
  markerInner.frame = CGRectMake(0, 0, size, size)
  markerInner.cornerRadius = size / 2
  markerInner.masksToBounds = true
  markerInner.backgroundColor = color.CGColor
  
  pointMarker.addSublayer(markerInner)
  pointMarker.frame = CGRectMake(xPos, yPos, 50, 50)
  aView.frame = CGRectMake(xPos, yPos, 50, 50)
  
  return aView
}

func getUTCDateFromString(theDT :String) -> NSDate {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
  let d :NSDate = dateFormatter.dateFromString(theDT)!
  //if let checkedVal = d.dateByAddingTimeInterval(5.0) { }// if this works, d is a date
  //else { println("** YO! You probably have an empty value!") } // this means d is nil
  return d
}


func getTimeStringFromDate(theDT :NSDate) -> String {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "hh:mm a"
  let d :String = dateFormatter.stringFromDate(theDT)
  return d
}

func getTimeFromString(theDT :NSString) -> NSDate {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "hh:mm a"
  //var d = dateFormatter.stringFromDate(theDT)
  let d :NSDate = dateFormatter.dateFromString(theDT as! String)!
  //if let checkedVal = d.dateByAddingTimeInterval(5.0) { }// if this works, d is a date
  //else { println("** YO! You probably have an empty value!") } // this means d is nil
  return d
}

func getDateDescriptiveStringFromString(val :NSString) -> NSString {
  println("getDateDescriptiveStringFromString val: \(val)")
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "MM/dd/yyyy"
  let str1 :NSDate = dateFormatter.dateFromString(val as! String)!
  let dateFormatter2 = NSDateFormatter()
  dateFormatter2.dateFormat = "EEEE, MMM d "
  let str2 :NSString = dateFormatter2.stringFromDate(str1)
  return str2
}

/* extension UIView {
  func parentViewController() -> UIViewController? {
    var parentResponder: UIResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder!.nextResponder()
      if parentResponder is UIViewController {
        return parentResponder as! UIViewController!
      }
    }
    return nil
  }
} */


// http://stackoverflow.com/questions/24590604/changing-button-text-from-modal-view-controller-in-swift
//https://www.parse.com/questions/how-do-i-search-objects-created-on-a-specific-date

// http://stackoverflow.com/questions/24590604/changing-button-text-from-modal-view-controller-in-swift
//https://www.parse.com/questions/how-do-i-search-objects-created-on-a-specific-date
// http://stackoverflow.com/questions/24844568/swift-custom-back-button-and-destination



