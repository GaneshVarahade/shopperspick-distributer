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

    @objc public var accessToken: String?             = ""
    @objc public var assetAccessToken: String?          = ""
    @objc public var employee:EmployeeModel?            = EmployeeModel()
    @objc public var assignedShop:AssignedShopModel?    = AssignedShopModel()
    @objc public var assignedTerminal:AssignedTerminalModel? = AssignedTerminalModel()
    @objc public var appType:String?
    @objc public var appTarget:String?
    @objc public var sessionId:String?
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
        return loginModel
    }
    
}

public class EmployeeModel:ModelBase{
    @objc public var firstName: String? = ""
    @objc public var lastName: String?  = ""
    @objc public var pin: String?       = ""
    @objc public var roleId:String?     = ""
    open override class func primaryKey() -> String? {
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
    @objc public var shopType: String?    = ""
    @objc public var name: String         = ""
    @objc public var phoneNumber: String? = ""
    @objc public var emailAdress:String?  = ""
    @objc public var address:AddressModel?
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
    @objc public var shopId: String?              = ""
    @objc public var active: Bool                 = false
    @objc public var assignedInventoryId: String? = ""
    @objc public var currentEmployeeId:String?    = ""
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
    @objc public var address: String? = ""
    @objc public var city: String     = ""
    @objc public var state: String?   = ""
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
