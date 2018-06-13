//
//  ResponseInvoice.swift
//  Blaze Distribution
//
//  Created by Apple on 07/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class ResponseInvoice :BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var invoiceNumber: String?
    public var dueDate:Int?
    public var company:ResponseVendor?
    public var salesPerson:String?
    public var balanceDue:Double?
    public var companyContact:String?
    public var total:Double?
    public var items:[ResponseInvoiceItems]?
    public var paymentsReceived:[ResponsePaymentsReceived]?
    public var shippingManifests: [ResponseShippingManifests]?
    public var remainingProductInformations:[ResponseRemaingProduct]?
}
