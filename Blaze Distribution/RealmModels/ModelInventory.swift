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
<<<<<<< HEAD
        let modelInventory      = ModelInventory()
=======
        let modelInventoryTransfers      = ModelInventoryTransfers()
       
        modelInventoryTransfers.transferNo        = self.transferNo
        modelInventoryTransfers.created           = self.created
        modelInventoryTransfers.fromShopId        = self.fromShopId
        modelInventoryTransfers.toShopId          = self.toShopId
        modelInventoryTransfers.fromShopName      = self.fromShopName
        modelInventoryTransfers.toShopName        = self.toShopName
        modelInventoryTransfers.fromInventoryName = self.fromInventoryName
        modelInventoryTransfers.toInventoryName   = self.toInventoryName
        modelInventoryTransfers.status            = self.status
        modelInventoryTransfers.id                = self.id
>>>>>>> 13a51be2a9c8a813b7db9114dbf5d0f953e569d5
        
        modelInventory.id          = self.id
        modelInventory.name        = self.name
        modelInventory.shopId      = self.shopId
        return modelInventory
    }
}
