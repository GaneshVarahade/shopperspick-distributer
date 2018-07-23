//
//  ModelProductTransfer.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelProductTransfer:ModelBase{
    @objc public dynamic var name:String?          = ""
    @objc public dynamic var transferAmount:Double = 0.0
    @objc public dynamic var expectedTotal:Double  = 0.0
    public override func copy(with zone:NSZone?    = nil) -> Any {
        
        let modelProductTransfer            = ModelProductTransfer()
        modelProductTransfer.name           = self.name
        modelProductTransfer.transferAmount = self.transferAmount
        modelProductTransfer.expectedTotal  = self.expectedTotal
        return modelProductTransfer
    }
}
