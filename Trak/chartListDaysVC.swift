//
//  Trak
//
//  Created by Lynn Smith on 10/24/14.
//  Copyright (c) 2014 Lynn Smith. All rights reserved.
//
//http://www.andrewcbancroft.com/2014/08/25/send-email-in-app-using-mfmailcomposeviewcontroller-with-swift/
//http://stackoverflow.com/questions/25567214/send-file-by-e-mail-in-swift

import Foundation

import UIKit
import QuartzCore
import MessageUI

class chartListDaysVC: UIViewController, stlDelegate, MFMailComposeViewControllerDelegate {

  //@IBOutlet var topBackView         :UIView!
  //@IBOutlet var titleTopLabel       :UILabel!
  //@IBOutlet var chartLabel          :UILabel!
  //@IBOutlet var generateReportBtn   :UIButton!
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
      var aTimeline :aDayTimelineSingleDay = aDayTimelineSingleDay(
                frame: CGRectMake(0, position, screenSize.width, graphHeight),
                theDate: myDate)
      myDate = addDaysToDate(-1, myDate)!
      //aTimeline.backgroundColor = UIColor.appLightBlue()
      scrollView.addSubview(aTimeline)
      position = position + graphHeight + margin
    }
    
    scrollView.contentSize.height = position
    //contentSize=CGSizeMake(self.view.bounds.width, position + 20)
    //drawLegend()
    
    // add nav
    var nav :navView = navView()
    nav.myparent = self
    self.view.addSubview(nav)
    
    // add subnav
    var snv :subnavView = subnavView(myBtnInt: 2)
    snv.myparent = self
    self.view.addSubview(snv)
    
    drawTimeLegend()
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

