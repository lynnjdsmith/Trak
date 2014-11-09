//
//  singleSymptomDataVC.swift
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

class singleSymptomDataVC: UIViewController, stlDelegate, MFMailComposeViewControllerDelegate {

  @IBOutlet var topBackView         :UIView!
  @IBOutlet var titleTopLabel       :UILabel!
  @IBOutlet var dateTimeLabel       :UILabel!
  @IBOutlet var generateReportBtn   :UIButton!
    
  var items     :NSMutableArray = []
  var objID     :NSString! = ""
  var name      :NSString! = ""
  var daDate    :NSString!  /* NOTE: always use hh:mm - no seconds! */
  var daTime    :NSString! = ""
  var theItem   :PFObject!
  var fileData  :NSData!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set things
    generateReportBtn.normalStyle("Create Report (PDF)")
    topBackView.layer.borderWidth = 0.3
    topBackView.layer.borderColor = UIColor.appLightGray().CGColor
    titleTopLabel.text = name
    dateTimeLabel.text = daDate  // + " " + daTime
      
    // create back btn
    navigationController?.setNavigationBarHidden(true, animated:true)
    let button   = UIButton() //UIButton.buttonWithType(UIButtonType.System) as UIButton
    button.frame = CGRectMake(-15, 20, 100, 50)
    button.backgroundColor = UIColor.clearColor()
    button.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
    button.setTitleColor(UIColor.appLightGray(), forState: .Normal)
    button.setTitle("Back", forState: UIControlState.Normal)
    button.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(button)
    let graph = singleSymptomHorizontalGraphView(frame: CGRectMake(0, 140, 320, 200), theItem: theItem)
    self.view.addSubview(graph)
  }
  
  
  func createPDF()
  {
    var textToDraw :NSString = "Hello World"
    
    // set file name
    let fileName = "Invoice.PDF"
    let arrayPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
    let path :AnyObject = arrayPaths[0]
    let pdfFileName :NSString = path.stringByAppendingPathComponent(fileName)
    
    
    // create text
    let coreTextFont:CTFontRef = CTFontCreateWithName("ArialMT" as NSString, 25.0, nil)
    var paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
    //paragraphStyle.alignment = NSTextAlignment.Center
    let fontBoundingBox: CGRect = CTFontGetBoundingBox(coreTextFont)
    let frameMidpoint = CGRectGetHeight(CGRectMake(0,0,300,300))
    let textBoundingBoxMidpoint = CGRectGetHeight(fontBoundingBox)
    //let verticalOffsetToCenterTextVertically = frameMidpoint - textBoundingBoxMidpoint
    let attributes = [
      NSFontAttributeName : coreTextFont,
      NSParagraphStyleAttributeName: paragraphStyle,
      kCTForegroundColorAttributeName:UIColor.redColor().CGColor
    ]
    var attributedString = NSMutableAttributedString(string:"Report", attributes:attributes)
  
    // Create the PDF context using the default page size of 612 x 792.
          // 612 x 792 points = 8.5 x 11 inch = 215.9 mm x 279.4 mm = US Letter
    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    // Draw text (CTFramesetterCreateFrame requires a path).
    let textPath: CGMutablePathRef = CGPathCreateMutable()
    CGPathAddRect(textPath, nil, CGRectMake(0, 0, 300, CGRectGetHeight(fontBoundingBox)))
    let framesetter: CTFramesetterRef = CTFramesetterCreateWithAttributedString(attributedString)
    let frame: CTFrameRef = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributedString.length), textPath, nil)
    var context :CGContextRef = UIGraphicsGetCurrentContext();
    CTFrameDraw(frame, context)
    
    // draw image
    var backImage = UIImageView(image:UIImage(named:"AppIcon.png"))
    backImage.frame.origin = CGPointMake(100,150)
    backImage.layer.renderInContext(context)
  
    // draw UIView
    var theView :UIView = singleSymptomHorizontalGraphView(frame: CGRectMake(0, 140, 320, 200), theItem: theItem)
    //theView.layer.renderInContext(context)
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext()
    
    println("ended context. pdfFileName: \(pdfFileName)")
  }
  
  
  @IBAction func sendEmail(sender: AnyObject) {
    createPDF()
  
    let fileName = "Invoice.PDF"
    let arrayPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
    
    let path :AnyObject = arrayPaths[0]
    let fName :NSString = path.stringByAppendingPathComponent(fileName)
    
    self.fileData = NSData(contentsOfFile:fName)
    
    let vc = configuredMailComposeViewController()
    //vc.emailPDF = fileData
    //vc.delegate = self
    if MFMailComposeViewController.canSendMail() {
      self.presentViewController(vc, animated: true, completion: nil)
    } else {
      self.showSendMailErrorAlert()
    }
  }

  /**** MAIL FUNCTIONS ***/
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
  
  
  func goBack(sender: UIButton) {
    navigationController?.popViewControllerAnimated(true)
  }
 
  
}

