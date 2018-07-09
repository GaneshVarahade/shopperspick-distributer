//
//  ModelInventory.swift
//  Blaze Distribution
//
//  Created by Apple on 08/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public enum InvetryTransferStatus:String {
    case Pending = "PENDING"
    case Declined = "DECLINED"
    case Accepted = "ACCEPTED"
}

public class ModelInventoryTransfers: ModelBase {
    
    @objc public dynamic var transferNo:String?        = ""
    @objc public dynamic var fromShopId:String?        = ""
    @objc public dynamic var toShopId:String?          = ""
    @objc public dynamic var fromInventoryId:String?   = ""
    @objc public dynamic var toInventoryId:String?   = ""
    @objc public dynamic var fromShopName:String?      = ""
    @objc public dynamic var toShopName:String?        = ""
    @objc public dynamic var fromInventoryName:String? = ""
    @objc public dynamic var toInventoryName:String?   = ""
    @objc public  dynamic var completeTransfer:Bool                = false
    @objc public dynamic var status:String?   = ""
    public var slectedProducts = List<ModelCartProduct>()
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelInventoryTransfers      = ModelInventoryTransfers()
       
        modelInventoryTransfers.transferNo        = self.transferNo
        modelInventoryTransfers.modified          = self.modified
        modelInventoryTransfers.fromShopId        = self.fromShopId
        modelInventoryTransfers.toShopId          = self.toShopId
        modelInventoryTransfers.fromShopName      = self.fromShopName
        modelInventoryTransfers.toShopName        = self.toShopName
        modelInventoryTransfers.fromInventoryName = self.fromInventoryName
        modelInventoryTransfers.toInventoryName   = self.toInventoryName
        modelInventoryTransfers.status            = self.status
        modelInventoryTransfers.id                = self.id
        modelInventoryTransfers.updated                = self.updated
        modelInventoryTransfers.fromInventoryId   = self.fromInventoryId
        modelInventoryTransfers.toInventoryId     = self.toInventoryId
        modelInventoryTransfers.completeTransfer  = self.completeTransfer
        
        for prod in self.slectedProducts{
            modelInventoryTransfers.slectedProducts.append(prod.copy() as! ModelCartProduct)
        }
        
        return modelInventoryTransfers
    }
}
