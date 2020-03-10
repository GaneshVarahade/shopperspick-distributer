//
//  LocationDataResponse.swift
//  Dispensary
//
//  Created by Apple on 02/03/20.
//  Copyright © 2020 420connect. All rights reserved.
//

import Foundation
import RealmSwift

open class LocationDataResponse:Object,BaseResponseModel{
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    public var state:String?
    public var available:Bool?
    public var recreational:Bool?
    public var medicinal:Bool?
    public var cbd:Bool?
    
    open override class func primaryKey() -> String? {
        "state"
    }
}
