//


//class anItem: PFObject, PFSubclassing  {
class anItem: PFObject  {
 /* override class func load() {
    self.registerSubclass()
  }
  
  class func parseClassName() -> String! {
    return "Armor"
  } */
  
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
