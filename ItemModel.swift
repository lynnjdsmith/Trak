//
//  ItemModel.swift
//  Trak
//
//  Created by Lynn Smith on 2/18/15.
//  Copyright (c) 2015 Lynn Smith. All rights reserved.
//

import Foundation
import CoreData

@objc(ItemModel)
class ItemModel: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var myDateTime: NSDate
    @NSManaged var type: String
    @NSManaged var amount: NSNumber

}
