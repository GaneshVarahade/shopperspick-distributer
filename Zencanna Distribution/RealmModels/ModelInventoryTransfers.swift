//
//  ModelInventory.swift
//  shopperspick Distribution
//
//  Created by Apple on 08/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public enum InvetoryTransferStatus:String {
    case Pending = "PENDING"
    case Declined = "DECLINED"
    case Accepted = "ACCEPTED"
}

public class ModelInventoryTransfers: ModelBase {
    
    @objc public dynamic var transferNo:String?        = ""
    @objc public dynamic var fromShopId:String?        = ""
    @objc public dynamic var toShopId:String?          = ""
    @objc public dynamic var fromInventoryId:String?   = ""
    @objc public dynamic var toInventoryId:String?     = ""
    @objc public dynamic var fromShopName:String?      = ""
    @objc public dynamic var toShopName:String?        = ""
    @objc public dynamic var fromInventoryName:String? = ""
    @objc public dynamic var toInventoryName:String?   = ""
    @objc public  dynamic var completeTransfer:Bool    = false
    @objc public  dynamic var isStatusUpdated:Bool     = false
    @objc public dynamic var status:String?            = ""
    @objc public dynamic var putBulkError:String?      = ""
    @objc public dynamic var createdByEmployeeName:String?         = ""
    public var slectedProducts = List<ModelCartProduct>()
    public var transferLogs = List<ModelTransferLogs>()
    
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
        modelInventoryTransfers.updated           = self.updated
        modelInventoryTransfers.fromInventoryId   = self.fromInventoryId
        modelInventoryTransfers.toInventoryId     = self.toInventoryId
        modelInventoryTransfers.completeTransfer  = self.completeTransfer
        modelInventoryTransfers.isStatusUpdated  = self.isStatusUpdated
        modelInventoryTransfers.createdByEmployeeName  = self.createdByEmployeeName
        modelInventoryTransfers.putBulkError      = self.putBulkError
        
        for prod in self.slectedProducts{
            modelInventoryTransfers.slectedProducts.append(prod.copy() as! ModelCartProduct)
        }
        for prod in self.transferLogs{
            modelInventoryTransfers.transferLogs.append(prod.copy() as! ModelTransferLogs)
        }
        
        return modelInventoryTransfers
    }
}


public class ModelTransferLogs:ModelBase{
    
    @objc public dynamic var productId:String?     = ""
    @objc public dynamic var transferAmount:Double  = 0
    @objc public dynamic var prepackageName:String  = ""
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelProduct      = ModelTransferLogs()
        modelProduct.id = self.id
        modelProduct.productId     = self.productId
        modelProduct.transferAmount  = self.transferAmount
        modelProduct.prepackageName = self.prepackageName
        
        return modelProduct
    }
}
