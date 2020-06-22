//
//  RequestPostModel.swift
//  shopperspick Distribution
//
//  Created by Apple on 05/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class RequestPostModel: BaseRequest {
    
    public var purchaseOrder = [RequestPurchaseOrder]()
    public var inventoryTransfer = [RequestInventry]()
    public var invoice = [RequestInvoice]()
}
