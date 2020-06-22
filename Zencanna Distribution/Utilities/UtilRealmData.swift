//
//  UtilRealmData.swift
//  shopperspick Distribution
//
//  Created by Apple on 25/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class UtilRealmData {
    
    public static func hasData() -> Bool {
        
        let modelSignatures = RealmManager().readPredicate(type: ModelSignature.self, predicate: "updated = true")
        let modelPurchaseOrders = RealmManager().readPredicate(type: ModelPurchaseOrder.self, predicate: "updated = true && putBulkError = ''")
        let modelInventryTransfer = RealmManager().readPredicate(type: ModelInventoryTransfers.self, predicate: "updated = true && putBulkError = ''")
        let modelInvoice = RealmManager().readPredicate(type: ModelInvoice.self, predicate: "updated = true && putBulkError = ''")
        
        if modelSignatures.count > 0 || modelPurchaseOrders.count > 0 || modelInventryTransfer.count > 0 || modelInvoice.count > 0 {
            return true
        }
        
        return false
    }
    
    public static func deletAllTables(){
        
        RealmManager().deleteAll(type: ModelInvoice.self)
        RealmManager().deleteAll(type: ModelInventoryTransfers.self)
        RealmManager().deleteAll(type: ModelPurchaseOrder.self)
        RealmManager().deleteAll(type: ModelTimesStampLog.self)
        RealmManager().deleteAll(type: ModelSignature.self)
        RealmManager().deleteAll(type: ModelSignatureAsset.self)
        
    }
}
