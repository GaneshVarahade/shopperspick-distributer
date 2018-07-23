//
//  ResponseInvoice.swift
//  Blaze Distribution
//
//  Created by Apple on 07/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public enum InvoiceStatus:String {
    
    case IN_PROGRESS = "IN_PROGRESS"
    case DRAFT = "DRAFT"
    case SENT = "SENT"
    case CANCELLED = "CANCELLED"
    case COMPLETED = "COMPLETED"
}
public class ResponseInvoice :BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var customerId: String?
    public var invoiceNumber: String?
    public var dueDate:Int?
    public var vendor:ResponseVendor?
    public var salesPerson:String?
    public var balanceDue:Double?
    public var companyContact:String?
    public var total:Double?
    public var invoiceStatus:String?
    public var items:[ResponseInvoiceItems]?
    public var paymentsReceived:[ResponsePaymentsReceived]?
    public var shippingManifests: [ResponseShippingManifests]?
    public var remainingProductInformations:[ResponseRemaingProduct]?
}
