//
//  ModelQuantity.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 12/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class ModelQuantity:ModelBase{
    
    @objc public var inventoryId:String? = ""
    @objc public var quantity:Double = 0.0
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelQuantity      = ModelQuantity()
        
        modelQuantity.inventoryId        = self.inventoryId
        modelQuantity.quantity        = self.quantity
        modelQuantity.id          = self.id
        return modelQuantity
    }
}
