//
//  calendarViewController.swift
//
// EEE, dd MMM yyyy HH:mm:ss z      Tue, 19 Aug 2014 09:35:05 EDT
// yyyy-MM-dd'T'HH:mm:ssz           2014-08-19T09:35:05EDT
// FONTS: http://iosfonts.com/

import UIKit
import QuartzCore


  // MARK: - Protocol calDelegate
protocol calDelegate {
    func didPressDate(val :String)
}

class calendarViewController: UIViewController {

  // MARK: - Variables
  
  var delegate: calDelegate?
  // The delegate that the parent view controller will conform to
  @IBOutlet var doneBtn: UIButton?
  
  var calWidth :CGFloat!
  var boxW :CGFloat!
  var boxH :CGFloat! = 35
  var screenHeight :CGFloat!
  var margin :CGFloat!
  var spacerW :CGFloat!
  var spacerH :CGFloat! = 10
  var monthH :CGFloat!
  var today :NSDate = NSDate()
  
  var strDay :NSString! = ""
  var strMonth :NSString! = ""
  var strYear :NSString! = ""
  
  var posX :CGFloat! = 0
  var daDay :NSDate = NSDate()
  var scrollView :UIScrollView!
  
  
    // MARK: - Functions
  
  override func viewDidLoad() {
      super.viewDidLoad()
      loadDataForStart()
      self.view.bringSubviewToFront(doneBtn!)
  }
  
  @IBAction func done(sender: AnyObject) {
    if((self.presentingViewController) != nil){
      self.dismissViewControllerAnimated(false, completion: nil)
      //println("done")
    }
  }
  
    // MARK: - Helpers
  
  func loadDataForStart() {
    
    // sizing variables
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    self.margin = 20
    self.spacerW = 5
    self.spacerH = 5
    self.calWidth = screenSize.width - (margin * 2)
    var widthMinusSpacers = calWidth - (spacerW * 6)
    self.boxW = widthMinusSpacers / 7
    self.screenHeight = screenSize.height
    self.posX = margin
    self.monthH = (boxH * 5) + (spacerH * 5)
  
    //white back of top area
    var bT = UIView()
    bT.frame = CGRectMake(0, -800, screenSize.width, 870)
    bT.backgroundColor = UIColor.whiteColor()
    self.view.addSubview(bT)
    
    // set initial values
    daDay = NSDate()
    
    scrollView.contentSize=CGSizeMake(320,3070);
    
    let dateFormatterAll = NSDateFormatter()
    dateFormatterAll.dateFormat = "yyyy"
    strYear = dateFormatterAll.stringFromDate(daDay)
    
    let dateFormatterMonth = NSDateFormatter()
    dateFormatterMonth.dateFormat = "MMMM"
    strMonth = dateFormatterMonth.stringFromDate(daDay)
    //println("month: \(strMonth)")
    
    let dfmn = NSDateFormatter()
    dfmn.dateFormat = "MM"
    var strMonthNum = dfmn.stringFromDate(daDay)
    //println("month: \(strMonthNum)")

    // year
    //theYear.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
    var theYear = UIButton()
    theYear.setTitle("< \(strYear)", forState: UIControlState.Normal)
    theYear.setTitleColor(UIColor.appRed(), forState: UIControlState.Normal)
    theYear.frame = CGRectMake(30, screenSize.height * 0.035, self.calWidth / 2, 50)
    theYear.backgroundColor = UIColor.clearColor()
    theYear.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
    theYear.addTarget(self, action: "yearPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(theYear)

    
    layoutMonths(strMonthNum)
  }

  
  func layoutMonths(strMonthNum :NSString) {
      var mNum: Int = strMonthNum.integerValue
      var mNumF :CGFloat! = CGFloat(mNum)
      //var mNumString :NSString! = strMonthNum
      
      //layoutAMonth(strMonthNum, top:50)
      let scrollToHere :CGFloat = mNumF * (monthH + spacerH)
      scrollView.setContentOffset(CGPointMake(0,scrollToHere), animated: true)
      
      var tTop :CGFloat! = 45.0
      //for i in reverse(3...1) {
      for i in stride(from: 1, to: 13, by: 1) {   //mNum ... 1 {
          //mNum = mNum - 1
              //println("other month: \(mNum)")
              var tNum :NSString = NSString(format: "%i", i)  // mNum
              layoutAMonth(tNum, top: tTop)
              tTop = tTop + self.monthH + 40 // + this is the month spacer
      }
  }
  
  
  func layoutAMonth(strMonthNum: NSString, top: CGFloat) {
    //println("in layoutMonth. strMonthNum: \(strMonthNum)")
    
    // FIX TODO BEFORE LAUNCH - get the 2015 out of there. *********** FIX
    let dffd = NSDateFormatter()
    dffd.dateFormat = "MM/dd/yyyy"
    let firstDay :NSDate = dffd.dateFromString("\(strMonthNum)/01/\(strYear)")!
    
    let dfmn = NSDateFormatter()
    dfmn.dateFormat = "MM"
    let strMonthNum = dfmn.stringFromDate(firstDay)
    //println("month: \(strMonthNum)")

    let dfm = NSDateFormatter()
    dfm.dateFormat = "MMMM"
    let dMonth = dfm.stringFromDate(firstDay)
    
    let df = NSDateFormatter()
    df.dateFormat = "e"
    let theDayOfWeekForFirst :NSString! = df.stringFromDate(firstDay)

  
    // add the month label
    var theMonthB = UIButton()
    theMonthB.setTitle(dMonth, forState: UIControlState.Normal)
    theMonthB.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
    theMonthB.setTitleColor(UIColor.appRed(), forState: UIControlState.Normal)
    theMonthB.frame = CGRectMake(30, top - 40, 100, 50)
    theMonthB.backgroundColor = UIColor.whiteColor()
    self.scrollView.addSubview(theMonthB)

    // add the days
    let i: Int = theDayOfWeekForFirst.integerValue
    var theDayOfWeek :CGFloat! = CGFloat(i)
    var thePosX = self.margin
    var thePosY :CGFloat! = top //50
    var boxWWSpacer = self.boxW + self.spacerW
    var boxHWSpacer = self.boxH + self.spacerH
  
    var numDaysInMonth = 31
    
    var numOfWeeks = 1
    
    for index in 1 ... numDaysInMonth {
    
      thePosX = (boxWWSpacer * (theDayOfWeek - 1)) + self.margin
      // -1 because you want the first to be 0
      
      // FIX TODO
      let strAll = "\(strMonthNum)/\(index)/2015"
      
      let todayF = NSDateFormatter()
      todayF.dateFormat = "MM/dd/yyyy"
      let firstDay = todayF.stringFromDate(NSDate())

      let cF = NSDateFormatter()
      cF.dateFormat = "MM/dd/yyyy"
      
      if let d = cF.dateFromString(strAll) { // date is valid
      //println("strAll: \(strAll)")
        
      let myB = UIButton()
      myB.setTitle(NSString(format:"%i", index) as String, forState: UIControlState.Normal)
      myB.setTitle(strAll, forState: UIControlState.Highlighted)
      myB.setTitleColor(UIColor.appRed(), forState: UIControlState.Normal)
      myB.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
      //println("thePosY: \(thePosY)")
      myB.frame = CGRectMake(thePosX, thePosY, self.boxW, self.boxH)
      myB.layer.borderWidth = 1
      myB.layer.borderColor = UIColor.appRed().CGColor
      myB.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 14)
      //myB.showsTouchWhenHighlighted = false

      myB.addTarget(self, action: "datePressed:", forControlEvents: UIControlEvents.TouchUpInside)
      
      
      if (strAll == firstDay) {
          myB.backgroundColor = UIColor.appRed()
          myB.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
          myB.setTitleColor(UIColor.appRed(), forState: UIControlState.Highlighted)
          //println("TODAY! \(strAll)")
      }
      self.scrollView.addSubview(myB)
      
      theDayOfWeek = theDayOfWeek + 1
      
      if (theDayOfWeek == 8 ) {
        theDayOfWeek = 1
        thePosX = self.margin
        thePosY = thePosY + self.boxH + self.spacerH
        numOfWeeks = numOfWeeks + 1
        if (numOfWeeks == 5) { self.monthH = (boxH * 5) + (spacerH * 5) }
        if (numOfWeeks == 6) { self.monthH = (boxH * 6) + (spacerH * 6) }
        //println(numOfWeeks)
      }
        
    }
    }
  }

  
  func datePressed(sender: UIButton!) {
      var btnSent:UIButton = sender
      //println("the strDay: \(btnSent.titleForState(.Highlighted))")
      let s :String = btnSent.titleForState(.Highlighted)!
      
      // send the date
      var mainView: UIStoryboard!
      mainView = UIStoryboard(name: "Main", bundle: nil)
      var viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("navViewController") as! UIViewController
      
      if let d = self.delegate {
          d.didPressDate(s)
      }
      
      //Dismiss
      done(self)
  }

  func yearPressed(sender: UIButton!) {
      //println("yearPressed")
  }
  
}