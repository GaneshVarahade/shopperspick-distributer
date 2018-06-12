//
//  ModelInvoiceItems.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 12/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class ModelInvoiceItems: ModelBase{
    
    @objc public var  productId:String? = ""
    @objc public var  batchId:String? = ""
    @objc public var  productName:String? = ""
    @objc public var  quantity:Double = 0.0
    open override class func primaryKey() -> String? {
        return "productId"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelInvoiceItems         = ModelInvoiceItems()
        modelInvoiceItems.productId   = self.productId
        modelInvoiceItems.batchId     = self.batchId
        modelInvoiceItems.productName = self.productName
        modelInvoiceItems.quantity    = self.quantity
        return modelInvoiceItems
    }
}
