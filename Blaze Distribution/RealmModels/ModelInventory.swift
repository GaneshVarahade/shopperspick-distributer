//
//  ModelInventory.swift
//  Blaze Distribution
//
//  Created by Apple on 08/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class ModelInventoryTransfers: ModelBase {
    
    @objc public dynamic var transferNo:String?        = ""
    @objc public dynamic var fromShopId:String?        = ""
    @objc public dynamic var toShopId:String?          = ""
    @objc public dynamic var fromShopName:String?      = ""
    @objc public dynamic var toShopName:String?        = ""
    @objc public dynamic var fromInventoryName:String? = ""
    @objc public dynamic var toInventoryName:String?   = ""
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelInventoryTransfers      = ModelInventoryTransfers()
       
        modelInventoryTransfers.transferNo        = self.transferNo
        modelInventoryTransfers.fromShopId        = self.fromShopId
        modelInventoryTransfers.toShopId          = self.toShopId
        modelInventoryTransfers.fromShopName      = self.fromShopName
        modelInventoryTransfers.toShopName        = self.toShopName
        modelInventoryTransfers.fromInventoryName = self.fromInventoryName
        modelInventoryTransfers.toInventoryName   = self.toInventoryName
        modelInventoryTransfers.id = self.id
        
        return modelInventoryTransfers
    }
}
