//
//  ModelAssets.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelAssets:ModelBase{
    @objc public dynamic var iconUrl:String?
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelAsset = ModelAssets()
        modelAsset.iconUrl = self.iconUrl
        return modelAsset
    }
}
