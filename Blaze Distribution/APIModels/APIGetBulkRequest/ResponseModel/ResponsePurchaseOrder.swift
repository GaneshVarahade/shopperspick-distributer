//
//  ResponsePurchaseOrder.swift
//  Blaze Distribution
//
//  Created by Apple on 07/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class ResponsePurchaseOrderProduct: BaseResponseModel {
    public var id: String?
    public var productId: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    public var productName: String?
    
    public var batchId: String?
    
    public var requestQuantity: Double?
    
    
}

public class ResponsePurchaseOrder: BaseResponseModel {
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    public var poNumber: String?

    public var metrc: Bool?

    public var purchaseOrderStatus: String?
    
    public var parentPONumber: String?

    public var origin: Bool?

    public var receivedDate: Int64?
    
    public var completedDate: Int64?

    public var poProductRequestList:[ResponsePurchaseOrderProduct]?
}
