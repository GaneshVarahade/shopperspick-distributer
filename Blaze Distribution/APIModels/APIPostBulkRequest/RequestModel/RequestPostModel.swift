//
//  RequestPostModel.swift
//  Blaze Distribution
//
//  Created by Apple on 05/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class RequestPostModel: BaseRequest {
    
    public var purchaseOrders = [RequestPurchaseOrder]()
    public var inventryTrasfer = [RequestInventry]()
    public var invoice = [RequestInvoice]()
}
