//
//  ModelBase.swift
//  CodableRealm
//
//  Created by Apple on 03/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelBase:Object, NSCopying, Codable {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        fatalError("Subclass need to implement this method")
    }
    
    public func encode(with aCoder: NSCoder) {
        fatalError("Subclass need to implement this method")
    }

    convenience init(id:String?, companyId:String?){
        self.init()
        self.id         = id
        self.companyId  = companyId
    }
    
    convenience init(id:String?,
                     companyId:String?,
                     created:Int,
                     modified:Int64,
                     deleted:Bool,
                     updated: Bool){
        self.init(id: id, companyId: companyId)
        self.created    = created
        self.modified   = modified
        self.deleted    = deleted
        self.updated    = updated
    }
    
    
    @objc public dynamic var created: Int = 0
    
    @objc public dynamic var modified: Int64 = 0
    
    @objc public dynamic var deleted: Bool = false
    
    @objc public dynamic var updated: Bool = false
    
    @objc public dynamic var id: String? = ""
    
    @objc public dynamic var companyId: String? = ""
    
}
