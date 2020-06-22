//
//  ModelInventory.swift
//  shopperspick Distribution
//
//  Created by Fidel iOS on 13/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import RealmSwift
public class ModelInventories:ModelBase{
    
    @objc public dynamic var  shopName:String? = ""
    @objc public dynamic var  shopId:String?   = ""
    var  inventory                             = List<ModelInventory>()
    open override class func primaryKey() -> String? {
        return "shopId"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelInventories      = ModelInventories()
        
        modelInventories.shopId   = self.shopId
        modelInventories.shopName = self.shopName
        for inv in self.inventory{
                       modelInventories.inventory.append(inv.copy() as! ModelInventory)
        }
        return modelInventories
    }
    
}
