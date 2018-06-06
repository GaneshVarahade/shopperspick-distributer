//
//  ModelSignature.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelSignature:ModelBase{
    
    @objc public dynamic var name:String?
    public override func copy(with zone:NSZone? = nil) -> Any {
        
        let modelSignature = ModelSignature()
        modelSignature.name = self.name
        return modelSignature
    }
}
