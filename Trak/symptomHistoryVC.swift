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

class symptomHistoryVC: UIViewController, stlDelegate, MFMailComposeViewControllerDelegate {

  @IBOutlet var topBackView         :UIView!
  @IBOutlet var titleTopLabel       :UILabel!
  @IBOutlet var chartLabel          :UILabel!
  @IBOutlet var generateReportBtn   :UIButton!
  @IBOutlet var scrollView          :UIScrollView!
  
  var items     :NSMutableArray = []
  var objID     :NSString! = ""
  var name      :NSString! = ""
  var daDate    :NSString!
  var daTime    :NSString! = ""
  var theItem   :PFObject!
  var fileData  :NSData!
  var colorz    :NSMutableArray = []
  var margin    :CGFloat!
  var screenSize :CGRect!
  var graphHeight :CGFloat = 40
  
  //var symptomEvent  :sEvent!
  var symptomEvents :NSArray = []
  var beforeEvents  :NSArray = []
  var nameArray     :NSArray = []
  
  // legend
  //var sizeLegendDot :CGFloat = 15
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
    self.colorz.get12Colors()
    screenSize = UIScreen.mainScreen().bounds
    self.margin = 10
    var graphWidth = screenSize.width - (margin * 2)
    scrollView.backgroundColor = UIColor.clearColor()
      
    // set things
    generateReportBtn.normalStyle("Send Report")
    topBackView.layer.borderWidth = 0.3
    topBackView.layer.borderColor = UIColor.appLightGray().CGColor
    titleTopLabel.text = name
    chartLabel.text = name
    //dateTimeLabel.text = daDate  // + " " + daTime
      
    // create back btn
    navigationController?.setNavigationBarHidden(true, animated:true)
    let button   = UIButton()
    button.frame = CGRectMake(-15, 20, 50, 50)
    button.backgroundColor = UIColor.clearColor()
    button.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
    button.setTitleColor(UIColor.appLightGray(), forState: .Normal)
    button.setTitle("<", forState: UIControlState.Normal)
    button.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(button)
    
    // load past symptoms relative to current item
    var baseSymptomEvent = sEvent(theEvent:theItem)
    symptomEvents = baseSymptomEvent.precedingSymptomEvents(name)
    
    // draw legend
    var befoEvents = baseSymptomEvent.relatedTriggerEvents(24)
    self.nameArray = baseSymptomEvent.mostCommonPrecedingTriggers(befoEvents)
    drawLegend(nameArray)
    
    // draw graphs
    var position :CGFloat = -20
    for obj in symptomEvents as [PFObject] {
    
      var theEvent = sEvent(theEvent:obj)
      var theBeforeEvents = theEvent.relatedTriggerEvents(24)
    
      // draw date
      let myDate :NSDate = obj.valueForKey("myDateTime") as NSDate
      let dateFormatterAll = NSDateFormatter()
      dateFormatterAll.dateFormat = "MM/dd"
      let d1 = UILabel(frame: CGRectMake(graphWidth - 32, position, 45, 20))
      d1.text = dateFormatterAll.stringFromDate(myDate)
      d1.font = fontMedium
      d1.backgroundColor = UIColor.clearColor()
      d1.textAlignment = NSTextAlignment.Center
      d1.textColor = UIColor.blackColor()
      scrollView.addSubview(d1)

      // draw Time
      let dateFormatTime = NSDateFormatter()
      dateFormatTime.dateFormat = "h:mm a"
      let d2 = UILabel(frame: CGRectMake(graphWidth - 32, position + 14, 45, 20))
      d2.text = dateFormatTime.stringFromDate(myDate)
      d2.font = fontMedium
      d2.backgroundColor = UIColor.clearColor()
      d2.textAlignment = NSTextAlignment.Center
      d2.textColor = UIColor.blackColor()
      scrollView.addSubview(d2)
      
      // draw graph
      let graph = singleSymptomHorizontalGraphView(frame: CGRectMake(10, position + 35, graphWidth, graphHeight), theItem: obj)
      graph.backgroundColor = UIColor.appLightBlue()
      scrollView.addSubview(graph)
    
      position = position + 100
    }
    
    scrollView.contentSize=CGSizeMake(screenSize.width,position + 20)
  }
  
  
  func drawLegend(names: NSArray) {

    var count = 1
    var spaceAmt = (screenSize.width - (margin*2)) / 3
    println("spaceAmt \(spaceAmt)")
    println("num of names \(names.count)")
    var currentX = xPosLegend
    var currentY = yPosLegend
    
    for (index, value) in enumerate(names) {

      let obj1 :Dictionary<String, AnyObject> = ["size" : dotSize, "xPos" : currentX, "yPos" : currentY, "color" : self.colorz[index]] as Dictionary
      var l :CALayer = placeCircle(obj1)
      self.view.layer.addSublayer(l)
      
      let theLabel :UILabel = UILabel(frame: CGRectMake(currentX + 20, currentY, spaceAmt - 20, 15))
      //UILabel(frame: CGRectMake(CGFloat(xPosLegend - (spaceAmt/2) + (dotSize/2)), yPosLegend + dotSize, spaceAmt, 30))
      theLabel.text = value as NSString
      theLabel.lineBreakMode = .ByWordWrapping
      theLabel.numberOfLines = 0
      theLabel.font = labelFont
      //theLabel.textAlignment = NSTextAlignment.left
      theLabel.layer.borderColor = UIColor.blackColor().CGColor
      theLabel.layer.borderWidth = 0
      theLabel.textColor = UIColor.blackColor()
      self.view.addSubview(theLabel)

      // even number
      if count % 2 == 0 {
        currentY = yPosLegend
        currentX = currentX + spaceAmt
      } else {  // odd number
        currentY = currentY + 23
      }
      
      //xPosLegend = xPosLegend + spaceAmt
      if (count == 6) { break }
      count = count + 1
    }
  }
  
  func createPDF()
  {
    // set file info
    let fileName = "report.pdf"
    let arrayPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
    let path :AnyObject = arrayPaths[0]
    let pdfFileName :NSString = path.stringByAppendingPathComponent(fileName)
    
    // Create the PDF context using the default page size of 612 x 792.
    // 612 x 792 points = 8.5 x 11 inch = 215.9 mm x 279.4 mm = US Letter
    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil)
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil)
    var context :CGContextRef = UIGraphicsGetCurrentContext()
    
    var title :NSString = "Migraine"
    
    // draw image
    var backImage = UIImageView(image:UIImage(named:"AppIcon.png"))
    backImage.frame.origin = CGPointMake(100,150)
    backImage.layer.renderInContext(context)
  
    // draw UIView
    var theView :UIView = reportBasicView(frame: CGRectMake(0, 0, 612, 792), theItem: theItem)
    theView.layer.renderInContext(context)
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext()
  
    self.fileData = NSData(contentsOfFile:pdfFileName)
    
    println("pdfFileName: \(pdfFileName)")
  }
  
  
  
  func goBack(sender: UIButton) {
    navigationController?.popViewControllerAnimated(true)
  }
  
  
  /**** MAIL FUNCTIONS ***/
  @IBAction func sendEmail(sender: AnyObject) {

    //create pdf
    createPDF()
    
    // send email
    let vc = configuredMailComposeViewController()
    if MFMailComposeViewController.canSendMail() {
      self.presentViewController(vc, animated: true, completion: nil)
    } else {
      self.showSendMailErrorAlert()
    }
  }

  func configuredMailComposeViewController() -> MFMailComposeViewController {
    let mailComposerVC = MFMailComposeViewController()
    mailComposerVC.mailComposeDelegate = self
    mailComposerVC.setSubject("Report from Trak")
    mailComposerVC.setMessageBody("Hi. Here's your report.", isHTML: false)
    mailComposerVC.addAttachmentData(self.fileData, mimeType:"application/pdf", fileName:"Report")
    return mailComposerVC
  }
  
  func showSendMailErrorAlert() {
    let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
    sendMailErrorAlert.show()
  }
  
  func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }
  /**** END MAIL FUNCTIONS ***/

 
  
}

