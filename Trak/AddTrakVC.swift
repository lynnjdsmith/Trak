//
//  AddTrakVC.swift
//  Trak
//
//  Created by Lynn Smith on 2/19/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation


class AddTrakVC: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var menuBtn: UIButton!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: 568)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  }
  
  
  @IBAction func menuButtonPressed(sender: AnyObject) {
    self.revealViewController()?.rightRevealToggle(sender)
    self.view.endEditing(true)
  }
  
  
}