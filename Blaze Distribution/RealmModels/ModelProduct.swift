//
//  ModelProduct.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 12/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
public class ModelProduct:ModelBase{
    
    @objc public dynamic var name:String? = ""
    @objc public dynamic var shopId:String? = ""
    @objc public  dynamic var quantity:Double = 0.0
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelProduct      = ModelProduct()
        modelProduct.id          = self.id
        modelProduct.name        = self.name
        modelProduct.quantity    = self.quantity
        modelProduct.shopId      = self.shopId
        return modelProduct
        
    }
}
