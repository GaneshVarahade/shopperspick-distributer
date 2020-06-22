//
//  ModelTransfer.swift
//  shopperspick Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


public class ModelCreateTransfer:ModelBase{
    @objc public dynamic var name:String?    = ""
    @objc public dynamic var request:String? = ""
    @objc public dynamic var date:String?    = ""
    @objc public dynamic var fromLocation:ModelLocation?
    @objc public dynamic var toLocation:ModelLocation?
    public var slectedProducts = List<ModelCartProduct>()
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    
    public override func copy(with zone:NSZone? = nil) -> Any {
        
        let modelTransfer          = ModelCreateTransfer()
        modelTransfer.name         = self.name
        modelTransfer.request      = self.request
        modelTransfer.date         = self.date
        modelTransfer.fromLocation = self.fromLocation
        modelTransfer.toLocation   = self.toLocation
        for prod in self.slectedProducts{
            modelTransfer.slectedProducts.append(prod.copy() as! ModelCartProduct)
        }
        return modelTransfer
    }
}
