//
//  RequestPurchaseOrderProductReceived.swift
//  Blaze Distribution
//
//  Created by Apple on 05/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class RequestPurchaseOrderProductReceived: BaseRequest {
    public var id:String?  = ""
    public var productId:String?  = ""
    public var productName:String?     = ""
    public var requestQuantity:Double = 0
    public var receivedQuantity:Double = 0
    public var unitPrice:Double = 0
    public var totalCost:Double = 0
    
    public var discount:Double = 0
    public var exciseTax:Double = 0
    public var totalExciseTax:Double = 0
    public var totalCultivationTax:Double = 0
    
    public var requestStatus:String? = ""
    public var receiveBatchStatus:String? = ""
    
}
