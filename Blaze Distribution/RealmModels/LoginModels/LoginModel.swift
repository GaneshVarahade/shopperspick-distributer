//
//  LoginModel.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 07/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class LoginModel:ModelBase {

    @objc public dynamic var accessToken: String?             = ""
    @objc public dynamic var assetAccessToken: String?          = ""
    @objc public dynamic var employee:EmployeeModel?            = EmployeeModel()
    @objc public dynamic var assignedShop:AssignedShopModel?    = AssignedShopModel()
    @objc public dynamic var assignedTerminal:AssignedTerminalModel? = AssignedTerminalModel()
    @objc public dynamic var appType:String?
    @objc public dynamic var appTarget:String?
    @objc public dynamic var sessionId:String?
    var   shops = List<ShopsModel>()
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let loginModel               = LoginModel()
        loginModel.id               = "001"
        loginModel.accessToken      = self.accessToken
        loginModel.appTarget        = self.appTarget
        loginModel.appType          = self.appType
        loginModel.assetAccessToken = self.assetAccessToken
        loginModel.employee         = self.employee
        loginModel.assignedShop     = self.assignedShop
        loginModel.sessionId        = self.sessionId
        loginModel.assignedTerminal = self.assignedTerminal
        for shop in self.shops {
            loginModel.shops.append(shop.copy() as! ShopsModel)
        }
        return loginModel
    }
    
}

public class EmployeeModel:ModelBase{
    @objc public dynamic var firstName: String? = ""
    @objc public dynamic var lastName: String?  = ""
    @objc public dynamic var pin: String?       = ""
    @objc public dynamic var roleId:String?     = ""
    open override dynamic class func primaryKey() -> String? {
        return "id"
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let employeeModel       = EmployeeModel()
        employeeModel.id        = self.id
        employeeModel.firstName = self.firstName
        employeeModel.lastName  = self.lastName
        employeeModel.pin       = self.pin
        employeeModel.roleId    = self.roleId
        return employeeModel
    }
}

public class AssignedShopModel:ModelBase{
    @objc public dynamic var shopType: String?    = ""
    @objc public dynamic var name: String         = ""
    @objc public dynamic var phoneNumber: String? = ""
    @objc public dynamic var emailAdress:String?  = ""
    @objc public dynamic var address:AddressModel?
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let assignedShopModel         = AssignedShopModel()
        assignedShopModel.id          = self.id
        assignedShopModel.shopType    = self.shopType
        assignedShopModel.name        = self.name
        assignedShopModel.phoneNumber = self.phoneNumber
        assignedShopModel.emailAdress = self.emailAdress
        assignedShopModel.address     = self.address
        return assignedShopModel
    }
    
}

public class AssignedTerminalModel:ModelBase{
    @objc public dynamic var shopId: String?              = ""
    @objc public dynamic var active: Bool                 = false
    @objc public dynamic var assignedInventoryId: String? = ""
    @objc public dynamic var currentEmployeeId:String?    = ""
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let assignedTerminalModel                 = AssignedTerminalModel()
        assignedTerminalModel.id                  = self.id
        assignedTerminalModel.shopId              = self.shopId
        assignedTerminalModel.active              = self.active
        assignedTerminalModel.assignedInventoryId = self.assignedInventoryId
        assignedTerminalModel.currentEmployeeId   = self.currentEmployeeId
        return assignedTerminalModel
    }
}

public class AddressModel:ModelBase{
    @objc public dynamic var address: String? = ""
    @objc public dynamic var city: String     = ""
    @objc public dynamic var state: String?   = ""
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
       
        let addressModel     = AddressModel()
        addressModel.id      = self.id
        addressModel.address = self.address
        addressModel.city    = self.city
        addressModel.state   = self.state
    
        return addressModel
    }
}
public class ShopsModel:ModelBase{
    @objc public dynamic var name:String? = ""
    @objc public dynamic var shopType:String? = ""
    @objc public dynamic var appTarget:String? = ""
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone?) -> Any {
        let shopsModel = ShopsModel()
        shopsModel.id  = self.id
        shopsModel.name = self.name
        shopsModel.appTarget = self.appTarget
        shopsModel.shopType = self.shopType
        return shopsModel
    }
}
