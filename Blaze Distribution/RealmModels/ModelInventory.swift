//
//  ModelInventory.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 13/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import RealmSwift

public class ModelInventory:ModelBase{
    
    @objc public  dynamic var name:String?   = ""
    @objc public  dynamic var shopId:String? = ""
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelInventory      = ModelInventory()
        
        modelInventory.id          = self.id
        modelInventory.name        = self.name
        modelInventory.shopId      = self.shopId
        return modelInventory
    }
}
