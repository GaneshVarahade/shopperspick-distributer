//
//  File.swift
//  Blaze Distribution
//
//  Created by Apple on 10/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelSignatureAsset:ModelBase{
    @objc public dynamic var name:String? = ""
    @objc public dynamic var key:String? = ""
    @objc public dynamic var type:String?  = ""
    @objc public dynamic var publicURL:String?  = ""
    @objc public dynamic var active:Bool = false
    @objc public dynamic var secured:Bool = false
    @objc public dynamic var thumbURL:String? = ""
    @objc public dynamic var mediumURL:String? = ""
    @objc public dynamic var largeURL:String? = ""
    @objc public dynamic var assetType:String? = ""
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelSignature          = ModelSignatureAsset()
        modelSignature.id           = self.id
        modelSignature.name         = self.name
        modelSignature.type   = self.type
        modelSignature.publicURL = self.publicURL
        modelSignature.active = self.active
        modelSignature.secured     = self.secured
        modelSignature.thumbURL  = self.thumbURL
        modelSignature.mediumURL = self.mediumURL
        modelSignature.largeURL     = self.largeURL
        modelSignature.assetType     = self.assetType
        modelSignature.key = self.key
        return modelSignature
    }
    
    public override var description: String {
        return "name: \(name), largeURL: \(largeURL)"
    }
}

