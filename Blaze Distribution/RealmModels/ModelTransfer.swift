//
//  ModelTransfer.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


public class ModelTransfer:ModelBase{
    @objc public dynamic var name:String?    = ""
    @objc public dynamic var request:String? = ""
    @objc public dynamic var date:String?    = ""
    @objc public dynamic var fromLocation:ModelLocation?
    @objc public dynamic var toLocation:ModelLocation?
   // var product = List<ModelProduct>()
    public override func copy(with zone:NSZone? = nil) -> Any {
        
        let modelTransfer          = ModelTransfer()
        modelTransfer.name         = self.name
        modelTransfer.request      = self.request
        modelTransfer.date         = self.date
        modelTransfer.fromLocation = self.fromLocation
        modelTransfer.toLocation   = self.toLocation
//        for prod in self.product{
//            modelTransfer.product.append(prod.copy() as! ModelProduct)
//        }
        return modelTransfer
    }
}
