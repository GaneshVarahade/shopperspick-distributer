//
//  ResponseAsset.swift
//  shopperspick Distribution
//
//  Created by Fidel iOS on 08/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class ResponseAsset:BaseResponseModel{
    public var id: String?
    public var type: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var publicURL:String?
    public var referenceNumber:String?    
    public var thumbURL:String?
    public var mediumURL:String?
    public var largeURL:String?
    
    public var name: String?
    public var key: String?
    public var assetType: String?
    

}
