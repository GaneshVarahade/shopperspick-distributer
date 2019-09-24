//
//  ModelRemainingProduct.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 12/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import RealmSwift
public class ModelRemainingProduct: ModelBase{
    @objc public dynamic var productId:String? = ""
    @objc public dynamic var productName:String? = ""
    @objc public dynamic var orderItemId:String? = ""
    @objc public dynamic var remainingQuantity:Double = 0.0
    @objc public dynamic var requestQuantity:Double = 0.0
    @objc public dynamic var isSelected:Bool = false
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone:NSZone? = nil) -> Any {

        let modelRemainingProduct               = ModelRemainingProduct()
        modelRemainingProduct.id                = self.id
        modelRemainingProduct.productId         = self.productId
        modelRemainingProduct.productName       = self.productName
        modelRemainingProduct.remainingQuantity = self.remainingQuantity
        modelRemainingProduct.requestQuantity   = self.requestQuantity
        modelRemainingProduct.orderItemId       = self.orderItemId
        return modelRemainingProduct
    }
}
