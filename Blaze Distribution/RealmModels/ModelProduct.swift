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
    
    @objc public dynamic var productId:String? = "" {
        didSet {
            createCompoundKey()
        }
    }
    @objc public dynamic var shopId:String? = "" {
        didSet {
            createCompoundKey()
        }
    }
    @objc public dynamic var inventoryId:String? = "" {
        didSet {
            createCompoundKey()
        }
    }
    @objc public dynamic var name:String? = ""
    @objc public dynamic var sku:String? = ""
    @objc public dynamic var companyLinkId:String? = ""
    @objc public  dynamic var quantity:Double = 0.0
    @objc public  dynamic var totalQuantity:Double = 0.0
    @objc public dynamic var compositeKey: String = ""
    open override class func primaryKey() -> String? {
        return "compositeKey"
    }
    private func createCompoundKey() {
        compositeKey = "\(productId)\(shopId)\(inventoryId)"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelProduct      = ModelProduct()
        modelProduct.id          = self.id
        modelProduct.sku         = self.sku
        modelProduct.name        = self.name
        modelProduct.quantity    = self.quantity
        modelProduct.shopId      = self.shopId
        modelProduct.productId   = self.productId
        modelProduct.companyLinkId = self.companyLinkId
        modelProduct.inventoryId   = self.inventoryId
        modelProduct.totalQuantity = self.totalQuantity
        return modelProduct
        
    }
}
