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
    public override func copy(with zone:NSZone? = nil) -> Any {
        let modelProductReceived = ModelPurchaseOrderProductReceived()
        
        modelProductReceived.id       = self.id
        modelProductReceived.productId = self.productId
        modelProductReceived.name     = self.name
        modelProductReceived.expected = self.expected
        modelProductReceived.received = self.received
        modelProductReceived.updated = self.updated
        
        return modelProductReceived
    }
    
    open override class func primaryKey() -> String? {
        return "id"
    }
}
