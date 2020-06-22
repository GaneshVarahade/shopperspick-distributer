//
//  ResponseBulkRequestModel.swift
//  shopperspick Distribution
//
//  Created by Apple on 07/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class ResponseBulkRequest: BaseResponseModel  {
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var signatureAssets : ResponseSignatureAsset?
    public var invoice: ResponseArrayInvoice?
    public var inventoryTransfers: ResponseArrayInventory?
    public var product:ResponseProducts?
    public var purchaseOrder: ResponseArrayPurchaseOrder?
    public var inventories:[ResponseInventories]?
    public var employees: ResponseArrayDriverInfo?
    
    public var inventoryTransferError:[inventoryTransferError]?
    public var invoiceError:[invoiceError]?
    public var poError:[poError]?
}
