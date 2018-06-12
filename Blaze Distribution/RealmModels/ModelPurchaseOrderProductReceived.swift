//
//  ModelPurchaseOrderProductReceived.swift
//  Blaze Distribution
//
//  Created by Apple on 12/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelPurchaseOrderProductReceived:ModelBase {
    
    @objc public dynamic var name:String?     = ""
    @objc public dynamic var expected:String?  = ""
    @objc public dynamic var received:String? = ""
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelProduct      = ModelPurchaseOrderProductReceived()
        modelProduct.name     = self.name
         modelProduct.id     = self.id
        modelProduct.expected  = self.expected
        modelProduct.received = self.received
        
        return modelProduct
    }
    
}
