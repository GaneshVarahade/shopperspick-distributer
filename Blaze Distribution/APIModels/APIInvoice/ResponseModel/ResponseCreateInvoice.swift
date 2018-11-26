//
//  ResponseCreateInvoice.swift
//  BLAZE Distribution
//
//  Created by Nishant's Mac on 26/11/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class ResponseCreateInvoice: BaseResponseModel {
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var shopId: String?
    public var dirty: Bool?
    public var customerId: String?
    public var license: String?
    public var invoiceNumber: String?
    public var orderNumber: String?
    public var invoiceTerms: String?
    public var salesPersonId: String?
    public var dueDate: Int?
    public var termsAndconditions: String?
    public var invoiceDate: Int?
    public var estimatedDeliveryDate: Int?
    public var estimatedDeliveryTime: Int?
    public var invoiceStatus: String?
    public var invoicePaymentStatus: String?
    public var inventoryProcessed: Bool?
    public var inventoryProcessedDate: Int?
    public var active: Bool?
    public var relatedEntity: Bool?
    public var invoiceQrCodeUrl: String?
    public var deliveryCharges: Int?
    public var total: Int?
    public var wholeSaleCostOfCannabiesItems: Int?
    public var markup: Int?
    public var exciseTax: Int?
    public var totalInvoiceAmount: Int?
    public var wholeSaleCostOfNonCannabisItems: Int?
    public var transactionType: String?
    public var companyContactId: Bool?
    
}



