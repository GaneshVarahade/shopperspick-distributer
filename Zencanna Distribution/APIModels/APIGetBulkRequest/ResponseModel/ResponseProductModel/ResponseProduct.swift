//
//  ResponseProduct.swift
//  shopperspick Distribution
//
//  Created by Fidel iOS on 12/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class ResponseProduct:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var name:String?
    public var shopId:String?
    public var companyLinkId:String?
    public var sku:String?
    public var quantities:[ResponseQuantities]?
    
}
