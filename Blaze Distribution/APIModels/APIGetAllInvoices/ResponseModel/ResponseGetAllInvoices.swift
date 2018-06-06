//
//  ResponseGetAllInvoices.swift
//  CodableRealm
//
//  Created by Apple on 03/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
public class ResponseGetAllInvoices: BaseResponseModel{
  
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    var values: [ResponseInvoices]?
}
