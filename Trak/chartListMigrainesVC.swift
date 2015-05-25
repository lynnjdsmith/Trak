//
//  Trak
//
//  Created by Lynn Smith on 10/24/14.
//  Copyright (c) 2014 Lynn Smith. All rights reserved.
//

import Foundation

import UIKit
import QuartzCore
import MessageUI

class chartListMigrainesVC: UIViewController, MFMailComposeViewControllerDelegate {

  @IBOutlet var scrollView            :UIScrollView!
  
  var items     :NSMutableArray = []
  var objID     :NSString! = ""
  var name      :NSString! = ""
  var theItem   :PFObject!

  //var colorz    :NSMutableArray = []
  var margin    :CGFloat! = 10
  var screenSize :CGRect!
  var graphHeight :CGFloat = 100
  
  var xPosLegend    :CGFloat = 15
  var yPosLegend    :CGFloat = 118
  
  var dotSize       :CGFloat = 15
  var dotColor      :UIColor = UIColor.clearColor()
  
  var labelFont     :UIFont = UIFont.systemFontOfSize(12)
  var fontMedium    :UIFont = UIFont.systemFontOfSize(11.5)
  var fontLarge     :UIFont = UIFont.systemFontOfSize(14)
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    screenSize = UIScreen.mainScreen().bounds
    scrollView.backgroundColor = UIColor.whiteColor()

    // set up starting date - default here is today
    var myDate :NSDate = NSDate()
    var position :CGFloat = 40
    
    // create all the timelines
    for i in 1 ... 20 {
      
      // create dates for beginning and end of day
      let preformatter = NSDateFormatter()
      preformatter.dateFormat = "MM/dd/yyyy"
      var d :NSString = preformatter.stringFromDate(myDate)
      var date1String: NSString = "\(d) 12:00 AM"
      var date2String: NSString = "\(d) 11:59 PM"
      let formatter = NSDateFormatter()
      formatter.dateFormat = "MM/dd/yyyy hh:mm a"
      var date1: NSDate! = formatter.dateFromString(date1String as! String)
      var date2: NSDate! = formatter.dateFromString(date2String as! String)
      
      // create query
      var findData:PFQuery = PFQuery(className: "Items")
      findData.whereKey("username", equalTo:PFUser.currentUser().username!)
      findData.whereKey("myDateTime", greaterThan:date1)
      findData.whereKey("myDateTime", lessThan:date2)
      findData.orderByDescending("myDateTime")
      myDate = addDaysToDate(-1, myDate)!
      
      // this is each day
      findData.findObjectsInBackgroundWithBlock {
        (objects:[AnyObject]!, error:NSError!)->Void in
        if (error == nil) {
          for object in objects as! [PFObject] {
            var theName :String = object.valueForKey("name") as! String
            var theSymptom :String = "migraine"
            if theName.lowercaseString == theSymptom.lowercaseString {
              println("Migraine! theName = \(theName)")
              var theD :NSDate = object.valueForKey("myDateTime") as! NSDate
              println("date: \(theD)")
              var aTimeline :aDayTimelineMigraine = aDayTimelineMigraine(
                frame: CGRectMake(0, position, self.screenSize.width, self.graphHeight), theDate: theD)
              self.scrollView.addSubview(aTimeline)
              position = position + self.graphHeight + self.margin
              self.scrollView.contentSize.height = position
              break
            }
          }
        }
      }
    }
    
    // add nav
    var nav :navView = navView()
    nav.myparent = self
    self.view.addSubview(nav)
    
    // add subnav
    var snv :subnavView = subnavView(myBtnInt: 1)
    snv.myparent = self
    self.view.addSubview(snv)
    
    //drawTimeLegend()
  }
  
 /*  func revealTheToggle() {    // need?
    self.revealViewController()?.rightRevealToggle(self)
    self.view.endEditing(true)
  } */
  
  func drawTimeLegend() {
    
    var spacer = self.view.frame.width / 4
    
    let theLabel :UILabel = UILabel(frame: CGRectMake(3, 30, 50, 20))
    theLabel.text = "12AM"
    theLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 11)
    theLabel.textAlignment = NSTextAlignment.Left
    theLabel.textColor = UIColor.btnColorHighlight()
    self.view.addSubview(theLabel)
    
    let theLabel2 :UILabel = UILabel(frame: CGRectMake(spacer-25, 30, 50, 20))
    theLabel2.text = "6AM"
    theLabel2.font = UIFont(name: "HelveticaNeue-Bold", size:14)
    theLabel2.textAlignment = NSTextAlignment.Center
    theLabel2.textColor = UIColor.btnColorHighlight()
    self.view.addSubview(theLabel2)

    let theLabel3 :UILabel = UILabel(frame: CGRectMake(self.view.frame.width / 2 - 25, 30, 50, 20))
    theLabel3.text = "NOON"
    theLabel3.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
    theLabel3.textAlignment = NSTextAlignment.Center
    theLabel3.textColor = UIColor.btnColorHighlight()
    self.view.addSubview(theLabel3)
    
    let theLabel4 :UILabel = UILabel(frame: CGRectMake(spacer*3 - 25, 30, 50, 20))
    theLabel4.text = "6PM"
    theLabel4.font = UIFont(name: "HelveticaNeue-Bold", size:14)
    theLabel4.textAlignment = NSTextAlignment.Center
    theLabel4.textColor = UIColor.btnColorHighlight()
    self.view.addSubview(theLabel4)
    
    let theLabel5 :UILabel = UILabel(frame: CGRectMake(self.view.frame.width - 53, 30, 50, 20))
    theLabel5.text = "12PM"
    theLabel5.font = UIFont(name: "HelveticaNeue-Bold", size: 11)
    theLabel5.textAlignment = NSTextAlignment.Right
    theLabel5.textColor = UIColor.btnColorHighlight()
    self.view.addSubview(theLabel5)
    
    var tick1 :UIView = UIView(frame: CGRectMake(spacer, 50, 2, 10))
    tick1.backgroundColor = UIColor.btnColorHighlight()
    self.view.addSubview(tick1)

    var tick2 :UIView = UIView(frame: CGRectMake(spacer * 2, 50, 2, 10))
    tick2.backgroundColor = UIColor.btnColorHighlight()
    self.view.addSubview(tick2)

    var tick3 :UIView = UIView(frame: CGRectMake(spacer * 3, 50, 2, 10))
    tick3.backgroundColor = UIColor.btnColorHighlight()
    self.view.addSubview(tick3)
  }

  
}

