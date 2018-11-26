//
//  RequestCreateInvoice.swift
//  BLAZE Distribution
//
//  Created by Nishant's Mac on 26/11/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class RequestCreateInvoice: BaseRequest {
    
    public var customerId:String?
    public var license:String?
    public var invoiceNumber:String?
    public var orderNumber:String?
    public var invoiceTerms:String?
    public var salesPersonId:String?
    public var dueDate:Int = 0
    public var termsAndconditions:String?
    public var invoiceDate:Int = 0
    public var estimatedDeliveryDate:Int = 0
    public var estimatedDeliveryTime:Int = 0
    public var invoiceStatus:String?
    public var invoicePaymentStatus:String?
    public var inventoryProcessed:Bool?
    public var inventoryProcessedDate:Int = 0
    public var active:Bool?
    public var relatedEntity:Bool?
    public var deliveryCharges:Int = 0
    public var total:Int = 0
    public var wholeSaleCostOfCannabiesItems:Int = 0
    public var markup:Int = 0
    public var exciseTax:Int = 0
    public var totalInvoiceAmount:Int = 0
    public var wholeSaleCostOfNonCannabisItems:Int = 0
    public var transactionType:String?
    public var companyContactId:Bool?
    
}
