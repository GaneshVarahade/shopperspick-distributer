//
//  ModelProductReceived.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelPurchaseOrderProductReceived:ModelBase{
    @objc public dynamic var name:String?     = ""
    @objc public dynamic var productId:String?     = ""
    @objc public dynamic var expected:Double = 0
    @objc public dynamic var received:Double = 0
    @objc public dynamic var totalCost:Double = 0
    @objc public dynamic var unitPrice:Double = 0
    
    @objc public dynamic var discount:Double = 0
    @objc public dynamic var exciseTax:Double = 0
    @objc public dynamic var totalExciseTax:Double = 0
    @objc public dynamic var totalCultivationTax:Double = 0
    
    @objc public dynamic var requestStatus:String? = ""
    @objc public dynamic var receiveBatchStatus:String? = ""
    
    public override func copy(with zone:NSZone? = nil) -> Any {
        let modelProductReceived = ModelPurchaseOrderProductReceived()
        modelProductReceived.id       = self.id
        modelProductReceived.productId = self.productId
        modelProductReceived.name     = self.name
        modelProductReceived.expected = self.expected
        modelProductReceived.received = self.received
        modelProductReceived.updated = self.updated
        modelProductReceived.totalCost = self.totalCost
        modelProductReceived.unitPrice = self.unitPrice
        
        modelProductReceived.discount = self.discount
        modelProductReceived.exciseTax = self.exciseTax
        modelProductReceived.totalExciseTax = self.totalExciseTax
        modelProductReceived.totalCultivationTax = self.totalCultivationTax
        modelProductReceived.receiveBatchStatus = self.receiveBatchStatus
        modelProductReceived.requestStatus = self.requestStatus
        return modelProductReceived
    }
    
    open override class func primaryKey() -> String? {
        return "id"
    }
}
