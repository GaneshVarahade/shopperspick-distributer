//
//  ModelLocation.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelLocation:ModelBase{
    
    @objc public dynamic var shop:ShopsModel?
    @objc public dynamic var inventory:ModelInventory?
    public override func copy(with zone:NSZone? = nil) -> Any {
        let modelLocation       = ModelLocation()
        modelLocation.shop      = self.shop
        modelLocation.inventory = self.inventory
        return modelLocation
    }
}
