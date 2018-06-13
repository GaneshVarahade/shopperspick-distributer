//
//  ModelInventory.swift
//  Blaze Distribution
//
//  Created by Apple on 08/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class ModelInventory: ModelBase {
    
    @objc public dynamic var transferNo:String?        = ""
    @objc public dynamic var fromShopId:String?        = ""
    @objc public dynamic var toShopId:String?          = ""
    @objc public dynamic var fromShopName:String?      = ""
    @objc public dynamic var toShopName:String?        = ""
    @objc public dynamic var fromInventoryName:String? = ""
    @objc public dynamic var toInventoryName:String?   = ""
    @objc public dynamic var status:String?   = ""
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelInventory      = ModelInventory()
       
        modelInventory.transferNo        = self.transferNo
        modelInventory.fromShopId        = self.fromShopId
        modelInventory.toShopId          = self.toShopId
        modelInventory.fromShopName      = self.fromShopName
        modelInventory.toShopName        = self.toShopName
        modelInventory.fromInventoryName = self.fromInventoryName
        modelInventory.toInventoryName   = self.toInventoryName
        modelInventory.status            = self.status
        modelInventory.id = self.id
        
        return modelInventory
    }
}
