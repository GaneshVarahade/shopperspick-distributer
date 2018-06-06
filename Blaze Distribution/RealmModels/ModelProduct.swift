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

public class ModelProduct:ModelBase{
    
    @objc public dynamic var name:String?     = ""
    @objc public dynamic var batchId:String?  = ""
    @objc public dynamic var quantity:String? = ""
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelProduct      = ModelProduct()
        modelProduct.name     = self.name
        modelProduct.batchId  = self.batchId
        modelProduct.quantity = self.quantity
        
        return modelProduct
    }
}
