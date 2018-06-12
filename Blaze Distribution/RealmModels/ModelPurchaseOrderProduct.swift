//
//  ModelPurchaseOrderProduct.swift
//  Blaze Distribution
//
//  Created by Apple on 12/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelPurchaseOrderProduct:ModelBase {
    
    
    @objc public dynamic var name:String?     = ""
    @objc public dynamic var batchId:String?  = ""
    @objc public dynamic var quantity:Double = 0
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        
        let modelProduct      = ModelPurchaseOrderProduct()
        modelProduct.id       = self.id
        modelProduct.name     = self.name
        modelProduct.batchId  = self.batchId
        modelProduct.quantity = self.quantity
        
        return modelProduct
    }
    
    open override class func primaryKey() -> String? {
        return "id"
    }
}
