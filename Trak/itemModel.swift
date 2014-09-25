//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Main Account on 7/7/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation

class anItem: PFObject {

    var name:NSString
    var triggerOrSymptom: NSString
    var type: NSString
    
    init(name:NSString) {
        self.name = "name"
        self.triggerOrSymptom = "trigger"
        self.type = "trigger"
        super.init()
    }
    
   //var total: Double
   //var taxPct: Double
  
/* var subtotal: Double {
    get {
      return total / (taxPct + 1)
    }
  }
  
  init(total:Double, taxPct:Double) {
    self.total = total
    self.taxPct = taxPct
  }
  
  func calcTipWithTipPct(tipPct:Double) -> Double {
    return subtotal * tipPct
  }
  
  func returnPossibleTips() -> [Int: Double] {
   
    let possibleTipsInferred = [0.15, 0.18, 0.20]
    let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
   
    var retval = [Int: Double]()
    for possibleTip in possibleTipsInferred {
      let intPct = Int(possibleTip*100)
      retval[intPct] = calcTipWithTipPct(possibleTip)
    }
    return retval
   
  } */
}
