//
//  RequestPurchaseOrderProductReceived.swift
//  Blaze Distribution
//
//  Created by Apple on 05/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class RequestPurchaseOrderProductReceived: BaseRequest {
    
    public var name:String?     = ""
    public var expected:Double = 0
    public var received:Double = 0
}
