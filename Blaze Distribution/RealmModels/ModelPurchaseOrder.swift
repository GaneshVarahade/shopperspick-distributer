//
//  ModelPurchaseOrder.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelPurchaseOrder:ModelBase{
    @objc public dynamic var purchaseOrderNumber:String? = ""
    @objc public dynamic var isMetRc:String?             = ""
    @objc public dynamic var metrcId:String?             = ""
    @objc public dynamic var status:String?              = ""
    @objc public dynamic var origin:String?              = ""
    @objc public dynamic var received:String?            = ""
   // var productInShipment = List<ModelProduct>()
    var productReceived   = List<ModelProductReceived>()
    public override func copy(with zone:NSZone? = nil) -> Any {
        
        let modelPurchaseOrder                 = ModelPurchaseOrder()
        modelPurchaseOrder.purchaseOrderNumber = self.purchaseOrderNumber
        modelPurchaseOrder.isMetRc             = self.isMetRc
        modelPurchaseOrder.metrcId             = self.metrcId
        modelPurchaseOrder.status              = self.status
        modelPurchaseOrder.origin              = self.origin
        modelPurchaseOrder.received            = self.received
        
      //  for prodInShip in self.productInShipment{
     //       modelPurchaseOrder.productInShipment.append(prodInShip.copy() as! ModelProduct)
     //   }
        for prodRcv in self.productReceived{
            modelPurchaseOrder.productReceived.append(prodRcv)
        }
        
        return modelPurchaseOrder
    }
    
}
