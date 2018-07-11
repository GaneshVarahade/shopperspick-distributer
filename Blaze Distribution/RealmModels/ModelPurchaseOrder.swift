//
//  ModelPurchaseOrder.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public enum PurchaseOrderStatus:String {
    case Closed = "Closed"
    case ReceivingShipment = "ReceivingShipment"
}

public class ModelPurchaseOrder:ModelBase{
    @objc public dynamic var purchaseOrderNumber:String? = ""
    @objc public dynamic var isMetRc:Bool                = false
    @objc public dynamic var metrcId:String?             = ""
    @objc public dynamic var status:String?              = ""
    @objc public dynamic var origin:String?              = ""
    @objc public dynamic var received:Int64              = 0
    @objc public dynamic var completedDate:Int64         = 0
    
    var productInShipment = List<ModelPurchaseOrderProduct>()
    var productReceived   = List<ModelPurchaseOrderProductReceived>()
    public override func copy(with zone:NSZone? = nil) -> Any {
        
        let modelPurchaseOrder                 = ModelPurchaseOrder()
        modelPurchaseOrder.id                  = self.id
        modelPurchaseOrder.purchaseOrderNumber = self.purchaseOrderNumber
        modelPurchaseOrder.isMetRc             = self.isMetRc
        modelPurchaseOrder.metrcId             = self.metrcId
        modelPurchaseOrder.status              = self.status
        modelPurchaseOrder.origin              = self.origin
        modelPurchaseOrder.received            = self.received
        modelPurchaseOrder.completedDate       = self.completedDate
        modelPurchaseOrder.updated              = self.updated
        
        for prodInShip in self.productInShipment{
            modelPurchaseOrder.productInShipment.append(prodInShip.copy() as! ModelPurchaseOrderProduct)
        }
        for prodRcv in self.productReceived{
            modelPurchaseOrder.productReceived.append(prodRcv.copy() as! ModelPurchaseOrderProductReceived)
        }
        
        return modelPurchaseOrder
    }
    
    open override class func primaryKey() -> String? {
        return "purchaseOrderNumber"
    }
    
}
