//
//  ResponseRemaingProduct.swift
//  shopperspick Distribution
//
//  Created by Fidel iOS on 12/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class ResponseRemaingProduct:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var productId:String?
    public var productName:String?
    public var remainingQuantity:Double?
    public var requestQuantity:Double?
}


public class ResponceItem : BaseResponseModel{
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    public var productId:String?
    public var quantity:Double?
    public var productName:String?
}
