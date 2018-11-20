//
//  ResponseTransferUpdate.swift
//  BLAZE Distribution
//
//  Created by Nishant's Mac on 20/11/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation


public class ResponseUpdateTransferStatus: BaseResponseModel  {
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var shopId: String?
    public var status: String?
}
