//
//  settingsMainVC.swift
//  Trak
//
//  Created by Lynn Smith on 4/16/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation


class settingsMainVC: UIViewController {
  
  
  @IBOutlet weak var triggersBtn: UIButton!
  @IBOutlet weak var symptomsBtn: UIButton!
  @IBOutlet weak var treatmentsBtn: UIButton!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // add nav
    var nav :navView = navView()
    nav.myparent = self
    self.view.addSubview(nav)
  }
  
  
 /*  @IBAction func triggersBtnPress(sender: AnyObject) {
    
  }
  
  @IBAction func symptomsBtnPress(sender: AnyObject) {
    
  }
  
  @IBAction func treatmentsBtnPress(sender: AnyObject) {
    
  } */
  
  
}
