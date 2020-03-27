//
//  RequestPurchaseOrder.swift
//  Blaze Distribution
//
//  Created by Apple on 05/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import RealmSwift

public class RequestPurchaseOrder: BaseRequest {
    
    public var id:String? = ""
    public var purchaseOrderNumber:String? = ""
    public var isMetRc:Bool                = false
    public var metrcId:String?             = ""
    public var purchaseOrderStatus:String?              = ""
    public var origin:String?              = ""
    public var received:Int              = 0
    public var completedDate:Int         = 0
 
    public var poProductRequestList   = [RequestPurchaseOrderProductReceived]()
}
