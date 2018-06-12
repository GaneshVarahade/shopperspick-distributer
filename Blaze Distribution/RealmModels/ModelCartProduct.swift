//
//  File.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelCartProduct:ModelBase{
    
    @objc public dynamic var name:String?     = ""
    @objc public dynamic var batchId:String?  = ""
    @objc public dynamic var quantity:Double = 0.0
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelProduct      = ModelCartProduct()
        modelProduct.name     = self.name
        modelProduct.batchId  = self.batchId
        modelProduct.quantity = self.quantity
        
        return modelProduct
    }
}
