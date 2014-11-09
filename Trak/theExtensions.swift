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
    self.setTitle(name, forState: .Normal)
    self.setTitleColor(UIColor.btnText(), forState: .Normal)
    return self
  }
  
}

extension UITextField {
  
  func normalStyle(name: NSString) -> UITextField {
    self.backgroundColor = UIColor.appRed()
    self.layer.cornerRadius = 8
    self.layer.borderWidth = 0
    self.clipsToBounds = true;
    self.text = name
    self.textColor = UIColor.whiteColor()
    //self.setTitleColor(UIColor.btnText(), forState: .Normal)
    return self
  }
  
}

extension NSString {
  
  func isSymptom(name: NSString) -> ObjCBool {
    
    var theSymptoms :NSMutableArray = ["Migraine","Headache"]
    for strObj in theSymptoms {
      if strObj.isEqualToString(name) {
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

extension NSArray {

  func get12Colors() -> NSArray {
    var colorArray :NSArray = [UIColor.c1(),UIColor.c2(),UIColor.c3(),UIColor.c4(),UIColor.c5(),UIColor.c6(),UIColor.c7(),UIColor.c8(),UIColor.c9(),UIColor.c10(),UIColor.c11(),UIColor.c12()]
    return colorArray
  }
  
}

func + (date: NSDate, tuple: (value: Int, unit: NSCalendarUnit)) -> NSDate {
  return NSCalendar.currentCalendar().dateByAddingUnit(tuple.unit, value: tuple.value, toDate: date, options: NSCalendarOptions.SearchBackwards)
}

func - (date: NSDate, tuple: (value: Int, unit: NSCalendarUnit)) -> NSDate {
  return NSCalendar.currentCalendar().dateByAddingUnit(tuple.unit, value: (-tuple.value), toDate: date, options: NSCalendarOptions.SearchBackwards)
}

func += (inout date: NSDate, tuple: (value: Int, unit: NSCalendarUnit)) {
  date = NSCalendar.currentCalendar().dateByAddingUnit(tuple.unit, value: tuple.value, toDate: date, options: NSCalendarOptions.SearchBackwards)
}

func -= (inout date: NSDate, tuple: (value: Int, unit: NSCalendarUnit)) {
  date = NSCalendar.currentCalendar().dateByAddingUnit(tuple.unit, value: -tuple.value, toDate: date, options: NSCalendarOptions.SearchBackwards)
}

extension UIColor {
  class func appGreen() -> UIColor {
    return UIColor(red: 0.255, green: 0.804, blue: 0.470, alpha: 1)
  }
  class func appBlue() -> UIColor {
    return UIColor(red: 0.333, green: 0.784, blue: 1, alpha: 1)
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
  class func appLightBlue() -> UIColor {
    //return UIColor(red: 236/255, green: 243/255, blue: 248/255, alpha: 1)
    return UIColor(red: 246/255, green: 251/255, blue: 255/255, alpha: 1)
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
    return UIColor(red: 233/255, green: 52/255, blue: 149/255, alpha: 1)
  }
  class func c2() -> UIColor {
    return UIColor(red: 219/255, green: 54/255, blue: 58/255, alpha: 1)
  }
  class func c3() -> UIColor {
    return UIColor(red: 142/255, green: 34/255, blue: 66/255, alpha: 1)
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
    return UIColor(red: 161/255, green: 228/255, blue: 61/255, alpha: 1)    //195, 255, 105
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
    let sourceViewController = self.sourceViewController as UIViewController
    let destinationViewController = self.destinationViewController as UIViewController
    
    sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil)
  }
  
}



// http://stackoverflow.com/questions/24590604/changing-button-text-from-modal-view-controller-in-swift
//https://www.parse.com/questions/how-do-i-search-objects-created-on-a-specific-date

// http://stackoverflow.com/questions/24590604/changing-button-text-from-modal-view-controller-in-swift
//https://www.parse.com/questions/how-do-i-search-objects-created-on-a-specific-date
// http://stackoverflow.com/questions/24844568/swift-custom-back-button-and-destination



