//
//  Models.swift
//  CodableRealm
//
//  Created by Apple on 01/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

public class ResponseInvoices:BaseResponseModel {
   
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
  
    public var shopId: String?
    
    public var customerId: String?
    
    public var invoiceNumber: String?
    
    public var shippingManifests: [ResponseShipingMenifest]?
    
}

public class ResponseShipingMenifest: BaseResponseModel {
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var id: String? 
    
    public var companyId: String?
    
    public var shopId: String?
    
    public var invoiceId: String?
    
    public var shippingManifestNo: String?
    
    public var invoiceAmount: Double?
    
    public var invoiceBalanceDue: Double?
    
    public func getString() -> String {
        return "id: \(self.id), companyId:\(self.companyId), shopId: \(self.shopId)"
    }
}
