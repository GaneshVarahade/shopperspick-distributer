//
//  ModelTimesStampLog.swift
//  Blaze Distribution
//
//  Created by Apple on 16/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public enum activityLogEvent : String {
    case Invoices = "Invoice"
    case Inventry = "Inventry"
    case PurchaseOrderes = "Purchase Orders"
    case LastSync = "Last Sync"
}

public class ModelTimesStampLog : ModelBase {
    @objc public dynamic var timesStamp:String? = ""
    @objc public dynamic var objectId:String?  = ""
    @objc public dynamic var event:String?  = ""
    @objc public dynamic var lastSyncTime:String?
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelTimesStamp          = ModelTimesStampLog()
        modelTimesStamp.id           = self.id
        modelTimesStamp.timesStamp   = self.timesStamp
        modelTimesStamp.objectId     = self.objectId
        modelTimesStamp.event        = self.event
        modelTimesStamp.lastSyncTime = self.lastSyncTime
        return modelTimesStamp
    }
}
