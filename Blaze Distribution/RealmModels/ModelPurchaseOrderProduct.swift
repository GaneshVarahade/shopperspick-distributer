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
    @objc public dynamic var productId:String?     = ""
    @objc public dynamic var validSelection:String?     = ""
    @objc public dynamic var batchId:String?  = ""
    @objc public dynamic var quantity:Double = 0
    @objc public dynamic var expected:Double = 0
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        
        let modelProduct      = ModelPurchaseOrderProduct()
        modelProduct.productId = self.productId
        modelProduct.id       = self.id
        modelProduct.name     = self.name
        modelProduct.batchId  = self.batchId
        modelProduct.quantity = self.quantity
        modelProduct.expected = self.quantity
        return modelProduct
    }
    
    open override class func primaryKey() -> String? {
        return "id"
    }
}
