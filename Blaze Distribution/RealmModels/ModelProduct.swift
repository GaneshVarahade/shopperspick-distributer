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
    
    @objc public var name:String? = ""
    @objc public var quantity:Double = 0.0
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelProduct      = ModelProduct()
        modelProduct.name        = self.name
        modelProduct.quantity    = self.quantity
        modelProduct.id          = self.id
        return modelProduct
        
    }
}
