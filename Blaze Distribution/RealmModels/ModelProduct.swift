//
//  ModelProduct.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 12/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class ModelProduct:ModelBase{
    
    @objc public var name:String? = ""
    var quantity = List<ModelQuantity>()
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelQuantity      = ModelQuantity()
        
        modelQuantity.inventoryId        = self.inventoryId
        modelQuantity.quantity        = self.quantity
        modelQuantity.id          = self.id
        return modelQuantity
    }}
