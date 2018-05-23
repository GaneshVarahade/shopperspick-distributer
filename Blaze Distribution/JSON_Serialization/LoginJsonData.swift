//
//  LoginJsonData.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 23/05/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

struct LoginJsonData:Codable{
    
    let accessToken : String?
    let assetAccessToken : String?
    let employee : Employee?
    let loginTime : Int?
    let expirationTime : Int?
    let sessionId : String?
    let company : Company?
    let shops : [Shops]?
    let assignedShop : AssignedShop?
    let newDevice : Bool?
    let assignedTerminal : AssignedTerminal?
    let appType : String?
    let appTarget : String?
    
    enum CodingKeys: String, CodingKey {
        
        case accessToken = "accessToken"
        case assetAccessToken = "assetAccessToken"
        case employee
        case loginTime = "loginTime"
        case expirationTime = "expirationTime"
        case sessionId = "sessionId"
        case company
        case shops = "shops"
        case assignedShop
        case newDevice = "newDevice"
        case assignedTerminal
        case appType = "appType"
        case appTarget = "appTarget"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        assetAccessToken = try values.decodeIfPresent(String.self, forKey: .assetAccessToken)
        employee = try Employee(from: decoder)
        loginTime = try values.decodeIfPresent(Int.self, forKey: .loginTime)
        expirationTime = try values.decodeIfPresent(Int.self, forKey: .expirationTime)
        sessionId = try values.decodeIfPresent(String.self, forKey: .sessionId)
        company = try Company(from: decoder)
        shops = try values.decodeIfPresent([Shops].self, forKey: .shops)
        assignedShop = try AssignedShop(from: decoder)
        newDevice = try values.decodeIfPresent(Bool.self, forKey: .newDevice)
        assignedTerminal = try AssignedTerminal(from: decoder)
        appType = try values.decodeIfPresent(String.self, forKey: .appType)
        appTarget = try values.decodeIfPresent(String.self, forKey: .appTarget)
    }
    
}

struct Employee : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let firstName : String?
    let lastName : String?
    let pin : String?
    let roleId : String?
    let email : String?
    let password : String?
    let driversLicense : String?
    let dlExpirationDate : String?
    let vehicleMake : String?
    let notes : [Notes]?
    let shops : [String]?
    let disabled : Bool?
    let phoneNumber : String?
    let assignedInventoryId : String?
    let assignedTerminalId : String?
    let address : Address?
    let timecardId : String?
    let timeCard : TimeCard?
    let role : Role?
    let canApplyCustomDiscount : Bool?
    let insuranceExpireDate : Int?
    let insuranceCompanyName : String?
    let policyNumber : String?
    let registrationExpireDate : Int?
    let vehiclePin : String?
    let vinNo : String?
    let employeeOnFleetInfoList : [EmployeeOnFleetInfoList]?
    let appAccessList : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case firstName = "firstName"
        case lastName = "lastName"
        case pin = "pin"
        case roleId = "roleId"
        case email = "email"
        case password = "password"
        case driversLicense = "driversLicense"
        case dlExpirationDate = "dlExpirationDate"
        case vehicleMake = "vehicleMake"
        case notes = "notes"
        case shops = "shops"
        case disabled = "disabled"
        case phoneNumber = "phoneNumber"
        case assignedInventoryId = "assignedInventoryId"
        case assignedTerminalId = "assignedTerminalId"
        case address
        case timecardId = "timecardId"
        case timeCard
        case role
        case canApplyCustomDiscount = "canApplyCustomDiscount"
        case insuranceExpireDate = "insuranceExpireDate"
        case insuranceCompanyName = "insuranceCompanyName"
        case policyNumber = "policyNumber"
        case registrationExpireDate = "registrationExpireDate"
        case vehiclePin = "vehiclePin"
        case vinNo = "vinNo"
        case employeeOnFleetInfoList = "employeeOnFleetInfoList"
        case appAccessList = "appAccessList"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        pin = try values.decodeIfPresent(String.self, forKey: .pin)
        roleId = try values.decodeIfPresent(String.self, forKey: .roleId)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        driversLicense = try values.decodeIfPresent(String.self, forKey: .driversLicense)
        dlExpirationDate = try values.decodeIfPresent(String.self, forKey: .dlExpirationDate)
        vehicleMake = try values.decodeIfPresent(String.self, forKey: .vehicleMake)
        notes = try values.decodeIfPresent([Notes].self, forKey: .notes)
        shops = try values.decodeIfPresent([String].self, forKey: .shops)
        disabled = try values.decodeIfPresent(Bool.self, forKey: .disabled)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        assignedInventoryId = try values.decodeIfPresent(String.self, forKey: .assignedInventoryId)
        assignedTerminalId = try values.decodeIfPresent(String.self, forKey: .assignedTerminalId)
        address = try Address(from: decoder)
        timecardId = try values.decodeIfPresent(String.self, forKey: .timecardId)
        timeCard = try TimeCard(from: decoder)
        role = try Role(from: decoder)
        canApplyCustomDiscount = try values.decodeIfPresent(Bool.self, forKey: .canApplyCustomDiscount)
        insuranceExpireDate = try values.decodeIfPresent(Int.self, forKey: .insuranceExpireDate)
        insuranceCompanyName = try values.decodeIfPresent(String.self, forKey: .insuranceCompanyName)
        policyNumber = try values.decodeIfPresent(String.self, forKey: .policyNumber)
        registrationExpireDate = try values.decodeIfPresent(Int.self, forKey: .registrationExpireDate)
        vehiclePin = try values.decodeIfPresent(String.self, forKey: .vehiclePin)
        vinNo = try values.decodeIfPresent(String.self, forKey: .vinNo)
        employeeOnFleetInfoList = try values.decodeIfPresent([EmployeeOnFleetInfoList].self, forKey: .employeeOnFleetInfoList)
        appAccessList = try values.decodeIfPresent([String].self, forKey: .appAccessList)
    }
    
}

struct Address : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let address : String?
    let city : String?
    let state : String?
    let zipCode : String?
    let country : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case address = "address"
        case city = "city"
        case state = "state"
        case zipCode = "zipCode"
        case country = "country"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        zipCode = try values.decodeIfPresent(String.self, forKey: .zipCode)
        country = try values.decodeIfPresent(String.self, forKey: .country)
    }
    
}

struct Assets : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let name : String?
    let key : String?
    let type : String?
    let publicURL : String?
    let active : Bool?
    let priority : Int?
    let secured : Bool?
    let thumbURL : String?
    let mediumURL : String?
    let largeURL : String?
    let assetType : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case name = "name"
        case key = "key"
        case type = "type"
        case publicURL = "publicURL"
        case active = "active"
        case priority = "priority"
        case secured = "secured"
        case thumbURL = "thumbURL"
        case mediumURL = "mediumURL"
        case largeURL = "largeURL"
        case assetType = "assetType"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        publicURL = try values.decodeIfPresent(String.self, forKey: .publicURL)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        priority = try values.decodeIfPresent(Int.self, forKey: .priority)
        secured = try values.decodeIfPresent(Bool.self, forKey: .secured)
        thumbURL = try values.decodeIfPresent(String.self, forKey: .thumbURL)
        mediumURL = try values.decodeIfPresent(String.self, forKey: .mediumURL)
        largeURL = try values.decodeIfPresent(String.self, forKey: .largeURL)
        assetType = try values.decodeIfPresent(String.self, forKey: .assetType)
    }
    
}

struct AssignedShop : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shortIdentifier : String?
    let name : String?
    let shopType : String?
    let address : Address?
    let phoneNumber : String?
    let emailAdress : String?
    let license : String?
    let enableDeliveryFee : Bool?
    let deliveryFee : Int?
    let taxOrder : String?
    let taxInfo : TaxInfo?
    let showWalkInQueue : Bool?
    let showDeliveryQueue : Bool?
    let showOnlineQueue : Bool?
    let enableCashInOut : Bool?
    let timeZone : String?
    let latitude : Int?
    let longitude : Int?
    let active : Bool?
    let snapshopTime : Int?
    let defaultCountry : String?
    let onlineStoreInfo : OnlineStoreInfo?
    let deliveryFees : [DeliveryFees]?
    let enableSaleLogout : Bool?
    let assets : [Assets]?
    let enableBCCReceipt : Bool?
    let bccEmailAddress : String?
    let enableGPSTracking : Bool?
    let receivingInventoryId : String?
    let defaultPinTimeout : Int?
    let showSpecialQueue : Bool?
    let emailList : [String]?
    let enableLowInventoryEmail : Bool?
    let restrictedViews : Bool?
    let emailMessage : String?
    let taxRoundOffType : String?
    let enforceCashDrawers : Bool?
    let useAssignedEmployee : Bool?
    let showProductByAvailableQuantity : Bool?
    let autoCashDrawer : Bool?
    let numAllowActiveTrans : Int?
    let requireValidRecDate : Bool?
    let enableDeliverySignature : Bool?
    let restrictIncomingOrderNotifications : Bool?
    let restrictedNotificationTerminals : [String]?
    let roundOffType : String?
    let roundUpMessage : String?
    let shopEntityType : String?
    let membersCountSyncDate : Int?
    let enableCannabisLimit : Bool?
    let useComplexTax : Bool?
    let taxTables : [TaxTables]?
    let enableExciseTax : Bool?
    let exciseTaxType : String?
    let marketingSources : [String]?
    let productsTag : [String]?
    let logo : Logo?
    let hubId : String?
    let hubName : String?
    let enableOnFleet : Bool?
    let onFleetApiKey : String?
    let onFleetOrganizationId : String?
    let onFleetOrganizationName : String?
    let emailAttachment : EmailAttachment?
    let receiptInfo : [ReceiptInfo]?
    let enablePinForCashDrawer : Bool?
    let checkoutType : String?
    let enableMetrc : Bool?
    let enableDeliveryMessaging : Bool?
    let exciseTaxInfo : ExciseTaxInfo?
    let timezoneOffsetInMinutes : Int?
    let defaultPinTimeoutDuration : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shortIdentifier = "shortIdentifier"
        case name = "name"
        case shopType = "shopType"
        case address
        case phoneNumber = "phoneNumber"
        case emailAdress = "emailAdress"
        case license = "license"
        case enableDeliveryFee = "enableDeliveryFee"
        case deliveryFee = "deliveryFee"
        case taxOrder = "taxOrder"
        case taxInfo
        case showWalkInQueue = "showWalkInQueue"
        case showDeliveryQueue = "showDeliveryQueue"
        case showOnlineQueue = "showOnlineQueue"
        case enableCashInOut = "enableCashInOut"
        case timeZone = "timeZone"
        case latitude = "latitude"
        case longitude = "longitude"
        case active = "active"
        case snapshopTime = "snapshopTime"
        case defaultCountry = "defaultCountry"
        case onlineStoreInfo
        case deliveryFees = "deliveryFees"
        case enableSaleLogout = "enableSaleLogout"
        case assets = "assets"
        case enableBCCReceipt = "enableBCCReceipt"
        case bccEmailAddress = "bccEmailAddress"
        case enableGPSTracking = "enableGPSTracking"
        case receivingInventoryId = "receivingInventoryId"
        case defaultPinTimeout = "defaultPinTimeout"
        case showSpecialQueue = "showSpecialQueue"
        case emailList = "emailList"
        case enableLowInventoryEmail = "enableLowInventoryEmail"
        case restrictedViews = "restrictedViews"
        case emailMessage = "emailMessage"
        case taxRoundOffType = "taxRoundOffType"
        case enforceCashDrawers = "enforceCashDrawers"
        case useAssignedEmployee = "useAssignedEmployee"
        case showProductByAvailableQuantity = "showProductByAvailableQuantity"
        case autoCashDrawer = "autoCashDrawer"
        case numAllowActiveTrans = "numAllowActiveTrans"
        case requireValidRecDate = "requireValidRecDate"
        case enableDeliverySignature = "enableDeliverySignature"
        case restrictIncomingOrderNotifications = "restrictIncomingOrderNotifications"
        case restrictedNotificationTerminals = "restrictedNotificationTerminals"
        case roundOffType = "roundOffType"
        case roundUpMessage = "roundUpMessage"
        case shopEntityType = "shopEntityType"
        case membersCountSyncDate = "membersCountSyncDate"
        case enableCannabisLimit = "enableCannabisLimit"
        case useComplexTax = "useComplexTax"
        case taxTables = "taxTables"
        case enableExciseTax = "enableExciseTax"
        case exciseTaxType = "exciseTaxType"
        case marketingSources = "marketingSources"
        case productsTag = "productsTag"
        case logo
        case hubId = "hubId"
        case hubName = "hubName"
        case enableOnFleet = "enableOnFleet"
        case onFleetApiKey = "onFleetApiKey"
        case onFleetOrganizationId = "onFleetOrganizationId"
        case onFleetOrganizationName = "onFleetOrganizationName"
        case emailAttachment
        case receiptInfo = "receiptInfo"
        case enablePinForCashDrawer = "enablePinForCashDrawer"
        case checkoutType = "checkoutType"
        case enableMetrc = "enableMetrc"
        case enableDeliveryMessaging = "enableDeliveryMessaging"
        case exciseTaxInfo
        case timezoneOffsetInMinutes = "timezoneOffsetInMinutes"
        case defaultPinTimeoutDuration = "defaultPinTimeoutDuration"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shortIdentifier = try values.decodeIfPresent(String.self, forKey: .shortIdentifier)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        shopType = try values.decodeIfPresent(String.self, forKey: .shopType)
        address = try Address(from: decoder)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        emailAdress = try values.decodeIfPresent(String.self, forKey: .emailAdress)
        license = try values.decodeIfPresent(String.self, forKey: .license)
        enableDeliveryFee = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryFee)
        deliveryFee = try values.decodeIfPresent(Int.self, forKey: .deliveryFee)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
        taxInfo = try TaxInfo(from: decoder)
        showWalkInQueue = try values.decodeIfPresent(Bool.self, forKey: .showWalkInQueue)
        showDeliveryQueue = try values.decodeIfPresent(Bool.self, forKey: .showDeliveryQueue)
        showOnlineQueue = try values.decodeIfPresent(Bool.self, forKey: .showOnlineQueue)
        enableCashInOut = try values.decodeIfPresent(Bool.self, forKey: .enableCashInOut)
        timeZone = try values.decodeIfPresent(String.self, forKey: .timeZone)
        latitude = try values.decodeIfPresent(Int.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Int.self, forKey: .longitude)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        snapshopTime = try values.decodeIfPresent(Int.self, forKey: .snapshopTime)
        defaultCountry = try values.decodeIfPresent(String.self, forKey: .defaultCountry)
        onlineStoreInfo = try OnlineStoreInfo(from: decoder)
        deliveryFees = try values.decodeIfPresent([DeliveryFees].self, forKey: .deliveryFees)
        enableSaleLogout = try values.decodeIfPresent(Bool.self, forKey: .enableSaleLogout)
        assets = try values.decodeIfPresent([Assets].self, forKey: .assets)
        enableBCCReceipt = try values.decodeIfPresent(Bool.self, forKey: .enableBCCReceipt)
        bccEmailAddress = try values.decodeIfPresent(String.self, forKey: .bccEmailAddress)
        enableGPSTracking = try values.decodeIfPresent(Bool.self, forKey: .enableGPSTracking)
        receivingInventoryId = try values.decodeIfPresent(String.self, forKey: .receivingInventoryId)
        defaultPinTimeout = try values.decodeIfPresent(Int.self, forKey: .defaultPinTimeout)
        showSpecialQueue = try values.decodeIfPresent(Bool.self, forKey: .showSpecialQueue)
        emailList = try values.decodeIfPresent([String].self, forKey: .emailList)
        enableLowInventoryEmail = try values.decodeIfPresent(Bool.self, forKey: .enableLowInventoryEmail)
        restrictedViews = try values.decodeIfPresent(Bool.self, forKey: .restrictedViews)
        emailMessage = try values.decodeIfPresent(String.self, forKey: .emailMessage)
        taxRoundOffType = try values.decodeIfPresent(String.self, forKey: .taxRoundOffType)
        enforceCashDrawers = try values.decodeIfPresent(Bool.self, forKey: .enforceCashDrawers)
        useAssignedEmployee = try values.decodeIfPresent(Bool.self, forKey: .useAssignedEmployee)
        showProductByAvailableQuantity = try values.decodeIfPresent(Bool.self, forKey: .showProductByAvailableQuantity)
        autoCashDrawer = try values.decodeIfPresent(Bool.self, forKey: .autoCashDrawer)
        numAllowActiveTrans = try values.decodeIfPresent(Int.self, forKey: .numAllowActiveTrans)
        requireValidRecDate = try values.decodeIfPresent(Bool.self, forKey: .requireValidRecDate)
        enableDeliverySignature = try values.decodeIfPresent(Bool.self, forKey: .enableDeliverySignature)
        restrictIncomingOrderNotifications = try values.decodeIfPresent(Bool.self, forKey: .restrictIncomingOrderNotifications)
        restrictedNotificationTerminals = try values.decodeIfPresent([String].self, forKey: .restrictedNotificationTerminals)
        roundOffType = try values.decodeIfPresent(String.self, forKey: .roundOffType)
        roundUpMessage = try values.decodeIfPresent(String.self, forKey: .roundUpMessage)
        shopEntityType = try values.decodeIfPresent(String.self, forKey: .shopEntityType)
        membersCountSyncDate = try values.decodeIfPresent(Int.self, forKey: .membersCountSyncDate)
        enableCannabisLimit = try values.decodeIfPresent(Bool.self, forKey: .enableCannabisLimit)
        useComplexTax = try values.decodeIfPresent(Bool.self, forKey: .useComplexTax)
        taxTables = try values.decodeIfPresent([TaxTables].self, forKey: .taxTables)
        enableExciseTax = try values.decodeIfPresent(Bool.self, forKey: .enableExciseTax)
        exciseTaxType = try values.decodeIfPresent(String.self, forKey: .exciseTaxType)
        marketingSources = try values.decodeIfPresent([String].self, forKey: .marketingSources)
        productsTag = try values.decodeIfPresent([String].self, forKey: .productsTag)
        logo = try Logo(from: decoder)
        hubId = try values.decodeIfPresent(String.self, forKey: .hubId)
        hubName = try values.decodeIfPresent(String.self, forKey: .hubName)
        enableOnFleet = try values.decodeIfPresent(Bool.self, forKey: .enableOnFleet)
        onFleetApiKey = try values.decodeIfPresent(String.self, forKey: .onFleetApiKey)
        onFleetOrganizationId = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationId)
        onFleetOrganizationName = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationName)
        emailAttachment = try EmailAttachment(from: decoder)
        receiptInfo = try values.decodeIfPresent([ReceiptInfo].self, forKey: .receiptInfo)
        enablePinForCashDrawer = try values.decodeIfPresent(Bool.self, forKey: .enablePinForCashDrawer)
        checkoutType = try values.decodeIfPresent(String.self, forKey: .checkoutType)
        enableMetrc = try values.decodeIfPresent(Bool.self, forKey: .enableMetrc)
        enableDeliveryMessaging = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryMessaging)
        exciseTaxInfo = try ExciseTaxInfo(from: decoder)
        timezoneOffsetInMinutes = try values.decodeIfPresent(Int.self, forKey: .timezoneOffsetInMinutes)
        defaultPinTimeoutDuration = try values.decodeIfPresent(Int.self, forKey: .defaultPinTimeoutDuration)
    }
    
}

struct AssignedTerminal : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shopId : String?
    let dirty : Bool?
    let active : Bool?
    let deviceId : String?
    let name : String?
    let deviceModel : String?
    let deviceVersion : String?
    let deviceName : String?
    let appVersion : String?
    let deviceToken : String?
    let deviceType : String?
    let assignedInventoryId : String?
    let cvAccountId : String?
    let currentEmployeeId : String?
    let terminalLocations : [TerminalLocations]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shopId = "shopId"
        case dirty = "dirty"
        case active = "active"
        case deviceId = "deviceId"
        case name = "name"
        case deviceModel = "deviceModel"
        case deviceVersion = "deviceVersion"
        case deviceName = "deviceName"
        case appVersion = "appVersion"
        case deviceToken = "deviceToken"
        case deviceType = "deviceType"
        case assignedInventoryId = "assignedInventoryId"
        case cvAccountId = "cvAccountId"
        case currentEmployeeId = "currentEmployeeId"
        case terminalLocations = "terminalLocations"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        deviceModel = try values.decodeIfPresent(String.self, forKey: .deviceModel)
        deviceVersion = try values.decodeIfPresent(String.self, forKey: .deviceVersion)
        deviceName = try values.decodeIfPresent(String.self, forKey: .deviceName)
        appVersion = try values.decodeIfPresent(String.self, forKey: .appVersion)
        deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
        deviceType = try values.decodeIfPresent(String.self, forKey: .deviceType)
        assignedInventoryId = try values.decodeIfPresent(String.self, forKey: .assignedInventoryId)
        cvAccountId = try values.decodeIfPresent(String.self, forKey: .cvAccountId)
        currentEmployeeId = try values.decodeIfPresent(String.self, forKey: .currentEmployeeId)
        terminalLocations = try values.decodeIfPresent([TerminalLocations].self, forKey: .terminalLocations)
    }
    
}

struct CityTax : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shopId : String?
    let dirty : Bool?
    let taxRate : Int?
    let compound : Bool?
    let active : Bool?
    let territory : String?
    let activeExciseTax : Bool?
    let taxOrder : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shopId = "shopId"
        case dirty = "dirty"
        case taxRate = "taxRate"
        case compound = "compound"
        case active = "active"
        case territory = "territory"
        case activeExciseTax = "activeExciseTax"
        case taxOrder = "taxOrder"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        taxRate = try values.decodeIfPresent(Int.self, forKey: .taxRate)
        compound = try values.decodeIfPresent(Bool.self, forKey: .compound)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        territory = try values.decodeIfPresent(String.self, forKey: .territory)
        activeExciseTax = try values.decodeIfPresent(Bool.self, forKey: .activeExciseTax)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
    }
    
}

struct Company : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let membersShareOption : String?
    let isId : String?
    let name : String?
    let phoneNumber : String?
    let email : String?
    let address : Address?
    let logoURL : String?
    let supportEmail : String?
    let showNameWithLogo : Bool?
    let active : Bool?
    let website : String?
    let productSKU : String?
    let queueUrl : String?
    let preferredEmailColor : String?
    let pricingOpt : String?
    let enableLoyalty : Bool?
    let dollarToPointRatio : Int?
    let duration : Int?
    let portalUrl : String?
    let businessLocation : String?
    let fax : String?
    let primaryContact : PrimaryContact?
    let taxId : String?
    let loyaltyAccrueOpt : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case membersShareOption = "membersShareOption"
        case isId = "isId"
        case name = "name"
        case phoneNumber = "phoneNumber"
        case email = "email"
        case address
        case logoURL = "logoURL"
        case supportEmail = "supportEmail"
        case showNameWithLogo = "showNameWithLogo"
        case active = "active"
        case website = "website"
        case productSKU = "productSKU"
        case queueUrl = "queueUrl"
        case preferredEmailColor = "preferredEmailColor"
        case pricingOpt = "pricingOpt"
        case enableLoyalty = "enableLoyalty"
        case dollarToPointRatio = "dollarToPointRatio"
        case duration = "duration"
        case portalUrl = "portalUrl"
        case businessLocation = "businessLocation"
        case fax = "fax"
        case primaryContact
        case taxId = "taxId"
        case loyaltyAccrueOpt = "loyaltyAccrueOpt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        membersShareOption = try values.decodeIfPresent(String.self, forKey: .membersShareOption)
        isId = try values.decodeIfPresent(String.self, forKey: .isId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        address = try Address(from: decoder)
        logoURL = try values.decodeIfPresent(String.self, forKey: .logoURL)
        supportEmail = try values.decodeIfPresent(String.self, forKey: .supportEmail)
        showNameWithLogo = try values.decodeIfPresent(Bool.self, forKey: .showNameWithLogo)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        productSKU = try values.decodeIfPresent(String.self, forKey: .productSKU)
        queueUrl = try values.decodeIfPresent(String.self, forKey: .queueUrl)
        preferredEmailColor = try values.decodeIfPresent(String.self, forKey: .preferredEmailColor)
        pricingOpt = try values.decodeIfPresent(String.self, forKey: .pricingOpt)
        enableLoyalty = try values.decodeIfPresent(Bool.self, forKey: .enableLoyalty)
        dollarToPointRatio = try values.decodeIfPresent(Int.self, forKey: .dollarToPointRatio)
        duration = try values.decodeIfPresent(Int.self, forKey: .duration)
        portalUrl = try values.decodeIfPresent(String.self, forKey: .portalUrl)
        businessLocation = try values.decodeIfPresent(String.self, forKey: .businessLocation)
        fax = try values.decodeIfPresent(String.self, forKey: .fax)
        primaryContact = try PrimaryContact(from: decoder)
        taxId = try values.decodeIfPresent(String.self, forKey: .taxId)
        loyaltyAccrueOpt = try values.decodeIfPresent(String.self, forKey: .loyaltyAccrueOpt)
    }
    
}
struct CountyTax : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shopId : String?
    let dirty : Bool?
    let taxRate : Int?
    let compound : Bool?
    let active : Bool?
    let territory : String?
    let activeExciseTax : Bool?
    let taxOrder : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shopId = "shopId"
        case dirty = "dirty"
        case taxRate = "taxRate"
        case compound = "compound"
        case active = "active"
        case territory = "territory"
        case activeExciseTax = "activeExciseTax"
        case taxOrder = "taxOrder"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        taxRate = try values.decodeIfPresent(Int.self, forKey: .taxRate)
        compound = try values.decodeIfPresent(Bool.self, forKey: .compound)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        territory = try values.decodeIfPresent(String.self, forKey: .territory)
        activeExciseTax = try values.decodeIfPresent(Bool.self, forKey: .activeExciseTax)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
    }
    
}

struct DeliveryFees : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let enabled : Bool?
    let subTotalThreshold : Int?
    let fee : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case enabled = "enabled"
        case subTotalThreshold = "subTotalThreshold"
        case fee = "fee"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
        subTotalThreshold = try values.decodeIfPresent(Int.self, forKey: .subTotalThreshold)
        fee = try values.decodeIfPresent(Int.self, forKey: .fee)
    }
    
}

struct EmailAttachment : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let name : String?
    let key : String?
    let type : String?
    let publicURL : String?
    let active : Bool?
    let priority : Int?
    let secured : Bool?
    let thumbURL : String?
    let mediumURL : String?
    let largeURL : String?
    let assetType : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case name = "name"
        case key = "key"
        case type = "type"
        case publicURL = "publicURL"
        case active = "active"
        case priority = "priority"
        case secured = "secured"
        case thumbURL = "thumbURL"
        case mediumURL = "mediumURL"
        case largeURL = "largeURL"
        case assetType = "assetType"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        publicURL = try values.decodeIfPresent(String.self, forKey: .publicURL)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        priority = try values.decodeIfPresent(Int.self, forKey: .priority)
        secured = try values.decodeIfPresent(Bool.self, forKey: .secured)
        thumbURL = try values.decodeIfPresent(String.self, forKey: .thumbURL)
        mediumURL = try values.decodeIfPresent(String.self, forKey: .mediumURL)
        largeURL = try values.decodeIfPresent(String.self, forKey: .largeURL)
        assetType = try values.decodeIfPresent(String.self, forKey: .assetType)
    }
    
}

struct EmployeeOnFleetInfoList : Codable {
    let shopId : String?
    let onFleetWorkerId : String?
    let onFleetTeamList : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case shopId = "shopId"
        case onFleetWorkerId = "onFleetWorkerId"
        case onFleetTeamList = "onFleetTeamList"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        onFleetWorkerId = try values.decodeIfPresent(String.self, forKey: .onFleetWorkerId)
        onFleetTeamList = try values.decodeIfPresent([String].self, forKey: .onFleetTeamList)
    }
    
}
struct ExciseTaxInfo : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let state : String?
    let country : String?
    let stateMarkUp : Int?
    let exciseTax : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case state = "state"
        case country = "country"
        case stateMarkUp = "stateMarkUp"
        case exciseTax = "exciseTax"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        stateMarkUp = try values.decodeIfPresent(Int.self, forKey: .stateMarkUp)
        exciseTax = try values.decodeIfPresent(Int.self, forKey: .exciseTax)
    }
    
}

struct FederalTax : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shopId : String?
    let dirty : Bool?
    let taxRate : Int?
    let compound : Bool?
    let active : Bool?
    let territory : String?
    let activeExciseTax : Bool?
    let taxOrder : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shopId = "shopId"
        case dirty = "dirty"
        case taxRate = "taxRate"
        case compound = "compound"
        case active = "active"
        case territory = "territory"
        case activeExciseTax = "activeExciseTax"
        case taxOrder = "taxOrder"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        taxRate = try values.decodeIfPresent(Int.self, forKey: .taxRate)
        compound = try values.decodeIfPresent(Bool.self, forKey: .compound)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        territory = try values.decodeIfPresent(String.self, forKey: .territory)
        activeExciseTax = try values.decodeIfPresent(Bool.self, forKey: .activeExciseTax)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
    }
    
}
struct Logo : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let name : String?
    let key : String?
    let type : String?
    let publicURL : String?
    let active : Bool?
    let priority : Int?
    let secured : Bool?
    let thumbURL : String?
    let mediumURL : String?
    let largeURL : String?
    let assetType : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case name = "name"
        case key = "key"
        case type = "type"
        case publicURL = "publicURL"
        case active = "active"
        case priority = "priority"
        case secured = "secured"
        case thumbURL = "thumbURL"
        case mediumURL = "mediumURL"
        case largeURL = "largeURL"
        case assetType = "assetType"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        publicURL = try values.decodeIfPresent(String.self, forKey: .publicURL)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        priority = try values.decodeIfPresent(Int.self, forKey: .priority)
        secured = try values.decodeIfPresent(Bool.self, forKey: .secured)
        thumbURL = try values.decodeIfPresent(String.self, forKey: .thumbURL)
        mediumURL = try values.decodeIfPresent(String.self, forKey: .mediumURL)
        largeURL = try values.decodeIfPresent(String.self, forKey: .largeURL)
        assetType = try values.decodeIfPresent(String.self, forKey: .assetType)
    }
    
}

struct Notes : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let writerId : String?
    let writerName : String?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case writerId = "writerId"
        case writerName = "writerName"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        writerId = try values.decodeIfPresent(String.self, forKey: .writerId)
        writerName = try values.decodeIfPresent(String.self, forKey: .writerName)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
}

struct OnlineStoreInfo : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shopId : String?
    let dirty : Bool?
    let enableStorePickup : Bool?
    let enableDelivery : Bool?
    let enableOnlineShipment : Bool?
    let enableProductReviews : Bool?
    let colorTheme : String?
    let defaultETA : Int?
    let pageOneMessageTitle : String?
    let pageOneMessageBody : String?
    let submissionMessage : String?
    let cartMinimum : Int?
    let cartMinType : String?
    let enabled : Bool?
    let websiteOrigins : String?
    let supportEmail : String?
    let enableOnlinePOS : Bool?
    let enableDeliveryAreaRestrictions : Bool?
    let restrictedZipCodes : [String]?
    let useCustomETA : Bool?
    let customMessageETA : String?
    let storeHexColor : String?
    let viewType : String?
    let enableInventory : Bool?
    let enableInventoryType : String?
    let activeInventoryId : String?
    let enableHtmlText : Bool?
    let htmlText : String?
    let websiteUrl : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shopId = "shopId"
        case dirty = "dirty"
        case enableStorePickup = "enableStorePickup"
        case enableDelivery = "enableDelivery"
        case enableOnlineShipment = "enableOnlineShipment"
        case enableProductReviews = "enableProductReviews"
        case colorTheme = "colorTheme"
        case defaultETA = "defaultETA"
        case pageOneMessageTitle = "pageOneMessageTitle"
        case pageOneMessageBody = "pageOneMessageBody"
        case submissionMessage = "submissionMessage"
        case cartMinimum = "cartMinimum"
        case cartMinType = "cartMinType"
        case enabled = "enabled"
        case websiteOrigins = "websiteOrigins"
        case supportEmail = "supportEmail"
        case enableOnlinePOS = "enableOnlinePOS"
        case enableDeliveryAreaRestrictions = "enableDeliveryAreaRestrictions"
        case restrictedZipCodes = "restrictedZipCodes"
        case useCustomETA = "useCustomETA"
        case customMessageETA = "customMessageETA"
        case storeHexColor = "storeHexColor"
        case viewType = "viewType"
        case enableInventory = "enableInventory"
        case enableInventoryType = "enableInventoryType"
        case activeInventoryId = "activeInventoryId"
        case enableHtmlText = "enableHtmlText"
        case htmlText = "htmlText"
        case websiteUrl = "websiteUrl"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        enableStorePickup = try values.decodeIfPresent(Bool.self, forKey: .enableStorePickup)
        enableDelivery = try values.decodeIfPresent(Bool.self, forKey: .enableDelivery)
        enableOnlineShipment = try values.decodeIfPresent(Bool.self, forKey: .enableOnlineShipment)
        enableProductReviews = try values.decodeIfPresent(Bool.self, forKey: .enableProductReviews)
        colorTheme = try values.decodeIfPresent(String.self, forKey: .colorTheme)
        defaultETA = try values.decodeIfPresent(Int.self, forKey: .defaultETA)
        pageOneMessageTitle = try values.decodeIfPresent(String.self, forKey: .pageOneMessageTitle)
        pageOneMessageBody = try values.decodeIfPresent(String.self, forKey: .pageOneMessageBody)
        submissionMessage = try values.decodeIfPresent(String.self, forKey: .submissionMessage)
        cartMinimum = try values.decodeIfPresent(Int.self, forKey: .cartMinimum)
        cartMinType = try values.decodeIfPresent(String.self, forKey: .cartMinType)
        enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
        websiteOrigins = try values.decodeIfPresent(String.self, forKey: .websiteOrigins)
        supportEmail = try values.decodeIfPresent(String.self, forKey: .supportEmail)
        enableOnlinePOS = try values.decodeIfPresent(Bool.self, forKey: .enableOnlinePOS)
        enableDeliveryAreaRestrictions = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryAreaRestrictions)
        restrictedZipCodes = try values.decodeIfPresent([String].self, forKey: .restrictedZipCodes)
        useCustomETA = try values.decodeIfPresent(Bool.self, forKey: .useCustomETA)
        customMessageETA = try values.decodeIfPresent(String.self, forKey: .customMessageETA)
        storeHexColor = try values.decodeIfPresent(String.self, forKey: .storeHexColor)
        viewType = try values.decodeIfPresent(String.self, forKey: .viewType)
        enableInventory = try values.decodeIfPresent(Bool.self, forKey: .enableInventory)
        enableInventoryType = try values.decodeIfPresent(String.self, forKey: .enableInventoryType)
        activeInventoryId = try values.decodeIfPresent(String.self, forKey: .activeInventoryId)
        enableHtmlText = try values.decodeIfPresent(Bool.self, forKey: .enableHtmlText)
        htmlText = try values.decodeIfPresent(String.self, forKey: .htmlText)
        websiteUrl = try values.decodeIfPresent(String.self, forKey: .websiteUrl)
    }
    
}

struct PrimaryContact : Codable {
    let name : String?
    let email : String?
    let contact : String?
    let address : Address?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case email = "email"
        case contact = "contact"
        case address
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        contact = try values.decodeIfPresent(String.self, forKey: .contact)
        address = try Address(from: decoder)
    }
    
}

struct ReceiptInfo : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shopId : String?
    let dirty : Bool?
    let receiptType : String?
    let enableMemberName : Bool?
    let enableMemberId : Bool?
    let enableMemberAddress : Bool?
    let enableShopAddress : Bool?
    let enableShopPhoneNo : Bool?
    let enableIncludeItemInSKU : Bool?
    let enableExciseTaxAsItem : Bool?
    let enableMemberLoyaltyPoints : Bool?
    let enableNotes : Bool?
    let freeText : String?
    let enabledFreeText : Bool?
    let enabledBottomFreeText : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shopId = "shopId"
        case dirty = "dirty"
        case receiptType = "receiptType"
        case enableMemberName = "enableMemberName"
        case enableMemberId = "enableMemberId"
        case enableMemberAddress = "enableMemberAddress"
        case enableShopAddress = "enableShopAddress"
        case enableShopPhoneNo = "enableShopPhoneNo"
        case enableIncludeItemInSKU = "enableIncludeItemInSKU"
        case enableExciseTaxAsItem = "enableExciseTaxAsItem"
        case enableMemberLoyaltyPoints = "enableMemberLoyaltyPoints"
        case enableNotes = "enableNotes"
        case freeText = "freeText"
        case enabledFreeText = "enabledFreeText"
        case enabledBottomFreeText = "enabledBottomFreeText"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        receiptType = try values.decodeIfPresent(String.self, forKey: .receiptType)
        enableMemberName = try values.decodeIfPresent(Bool.self, forKey: .enableMemberName)
        enableMemberId = try values.decodeIfPresent(Bool.self, forKey: .enableMemberId)
        enableMemberAddress = try values.decodeIfPresent(Bool.self, forKey: .enableMemberAddress)
        enableShopAddress = try values.decodeIfPresent(Bool.self, forKey: .enableShopAddress)
        enableShopPhoneNo = try values.decodeIfPresent(Bool.self, forKey: .enableShopPhoneNo)
        enableIncludeItemInSKU = try values.decodeIfPresent(Bool.self, forKey: .enableIncludeItemInSKU)
        enableExciseTaxAsItem = try values.decodeIfPresent(Bool.self, forKey: .enableExciseTaxAsItem)
        enableMemberLoyaltyPoints = try values.decodeIfPresent(Bool.self, forKey: .enableMemberLoyaltyPoints)
        enableNotes = try values.decodeIfPresent(Bool.self, forKey: .enableNotes)
        freeText = try values.decodeIfPresent(String.self, forKey: .freeText)
        enabledFreeText = try values.decodeIfPresent(Bool.self, forKey: .enabledFreeText)
        enabledBottomFreeText = try values.decodeIfPresent(Bool.self, forKey: .enabledBottomFreeText)
    }
    
}

struct Role : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let permissions : [String]?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case permissions = "permissions"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        permissions = try values.decodeIfPresent([String].self, forKey: .permissions)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
struct Sessions : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shopId : String?
    let dirty : Bool?
    let terminalId : String?
    let employeeId : String?
    let timeCardId : String?
    let startTime : Int?
    let endTime : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shopId = "shopId"
        case dirty = "dirty"
        case terminalId = "terminalId"
        case employeeId = "employeeId"
        case timeCardId = "timeCardId"
        case startTime = "startTime"
        case endTime = "endTime"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        terminalId = try values.decodeIfPresent(String.self, forKey: .terminalId)
        employeeId = try values.decodeIfPresent(String.self, forKey: .employeeId)
        timeCardId = try values.decodeIfPresent(String.self, forKey: .timeCardId)
        startTime = try values.decodeIfPresent(Int.self, forKey: .startTime)
        endTime = try values.decodeIfPresent(Int.self, forKey: .endTime)
    }
    
}

struct Shops : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shortIdentifier : String?
    let name : String?
    let shopType : String?
    let address : Address?
    let phoneNumber : String?
    let emailAdress : String?
    let license : String?
    let enableDeliveryFee : Bool?
    let deliveryFee : Int?
    let taxOrder : String?
    let taxInfo : TaxInfo?
    let showWalkInQueue : Bool?
    let showDeliveryQueue : Bool?
    let showOnlineQueue : Bool?
    let enableCashInOut : Bool?
    let timeZone : String?
    let latitude : Int?
    let longitude : Int?
    let active : Bool?
    let snapshopTime : Int?
    let defaultCountry : String?
    let onlineStoreInfo : OnlineStoreInfo?
    let deliveryFees : [DeliveryFees]?
    let enableSaleLogout : Bool?
    let assets : [Assets]?
    let enableBCCReceipt : Bool?
    let bccEmailAddress : String?
    let enableGPSTracking : Bool?
    let receivingInventoryId : String?
    let defaultPinTimeout : Int?
    let showSpecialQueue : Bool?
    let emailList : [String]?
    let enableLowInventoryEmail : Bool?
    let restrictedViews : Bool?
    let emailMessage : String?
    let taxRoundOffType : String?
    let enforceCashDrawers : Bool?
    let useAssignedEmployee : Bool?
    let showProductByAvailableQuantity : Bool?
    let autoCashDrawer : Bool?
    let numAllowActiveTrans : Int?
    let requireValidRecDate : Bool?
    let enableDeliverySignature : Bool?
    let restrictIncomingOrderNotifications : Bool?
    let restrictedNotificationTerminals : [String]?
    let roundOffType : String?
    let roundUpMessage : String?
    let shopEntityType : String?
    let membersCountSyncDate : Int?
    let enableCannabisLimit : Bool?
    let useComplexTax : Bool?
    let taxTables : [TaxTables]?
    let enableExciseTax : Bool?
    let exciseTaxType : String?
    let marketingSources : [String]?
    let productsTag : [String]?
    let logo : Logo?
    let hubId : String?
    let hubName : String?
    let enableOnFleet : Bool?
    let onFleetApiKey : String?
    let onFleetOrganizationId : String?
    let onFleetOrganizationName : String?
    let emailAttachment : EmailAttachment?
    let receiptInfo : [ReceiptInfo]?
    let enablePinForCashDrawer : Bool?
    let checkoutType : String?
    let enableMetrc : Bool?
    let enableDeliveryMessaging : Bool?
    let exciseTaxInfo : ExciseTaxInfo?
    let timezoneOffsetInMinutes : Int?
    let defaultPinTimeoutDuration : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shortIdentifier = "shortIdentifier"
        case name = "name"
        case shopType = "shopType"
        case address
        case phoneNumber = "phoneNumber"
        case emailAdress = "emailAdress"
        case license = "license"
        case enableDeliveryFee = "enableDeliveryFee"
        case deliveryFee = "deliveryFee"
        case taxOrder = "taxOrder"
        case taxInfo
        case showWalkInQueue = "showWalkInQueue"
        case showDeliveryQueue = "showDeliveryQueue"
        case showOnlineQueue = "showOnlineQueue"
        case enableCashInOut = "enableCashInOut"
        case timeZone = "timeZone"
        case latitude = "latitude"
        case longitude = "longitude"
        case active = "active"
        case snapshopTime = "snapshopTime"
        case defaultCountry = "defaultCountry"
        case onlineStoreInfo
        case deliveryFees = "deliveryFees"
        case enableSaleLogout = "enableSaleLogout"
        case assets = "assets"
        case enableBCCReceipt = "enableBCCReceipt"
        case bccEmailAddress = "bccEmailAddress"
        case enableGPSTracking = "enableGPSTracking"
        case receivingInventoryId = "receivingInventoryId"
        case defaultPinTimeout = "defaultPinTimeout"
        case showSpecialQueue = "showSpecialQueue"
        case emailList = "emailList"
        case enableLowInventoryEmail = "enableLowInventoryEmail"
        case restrictedViews = "restrictedViews"
        case emailMessage = "emailMessage"
        case taxRoundOffType = "taxRoundOffType"
        case enforceCashDrawers = "enforceCashDrawers"
        case useAssignedEmployee = "useAssignedEmployee"
        case showProductByAvailableQuantity = "showProductByAvailableQuantity"
        case autoCashDrawer = "autoCashDrawer"
        case numAllowActiveTrans = "numAllowActiveTrans"
        case requireValidRecDate = "requireValidRecDate"
        case enableDeliverySignature = "enableDeliverySignature"
        case restrictIncomingOrderNotifications = "restrictIncomingOrderNotifications"
        case restrictedNotificationTerminals = "restrictedNotificationTerminals"
        case roundOffType = "roundOffType"
        case roundUpMessage = "roundUpMessage"
        case shopEntityType = "shopEntityType"
        case membersCountSyncDate = "membersCountSyncDate"
        case enableCannabisLimit = "enableCannabisLimit"
        case useComplexTax = "useComplexTax"
        case taxTables = "taxTables"
        case enableExciseTax = "enableExciseTax"
        case exciseTaxType = "exciseTaxType"
        case marketingSources = "marketingSources"
        case productsTag = "productsTag"
        case logo
        case hubId = "hubId"
        case hubName = "hubName"
        case enableOnFleet = "enableOnFleet"
        case onFleetApiKey = "onFleetApiKey"
        case onFleetOrganizationId = "onFleetOrganizationId"
        case onFleetOrganizationName = "onFleetOrganizationName"
        case emailAttachment
        case receiptInfo = "receiptInfo"
        case enablePinForCashDrawer = "enablePinForCashDrawer"
        case checkoutType = "checkoutType"
        case enableMetrc = "enableMetrc"
        case enableDeliveryMessaging = "enableDeliveryMessaging"
        case exciseTaxInfo
        case timezoneOffsetInMinutes = "timezoneOffsetInMinutes"
        case defaultPinTimeoutDuration = "defaultPinTimeoutDuration"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shortIdentifier = try values.decodeIfPresent(String.self, forKey: .shortIdentifier)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        shopType = try values.decodeIfPresent(String.self, forKey: .shopType)
        address = try Address(from: decoder)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        emailAdress = try values.decodeIfPresent(String.self, forKey: .emailAdress)
        license = try values.decodeIfPresent(String.self, forKey: .license)
        enableDeliveryFee = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryFee)
        deliveryFee = try values.decodeIfPresent(Int.self, forKey: .deliveryFee)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
        taxInfo = try TaxInfo(from: decoder)
        showWalkInQueue = try values.decodeIfPresent(Bool.self, forKey: .showWalkInQueue)
        showDeliveryQueue = try values.decodeIfPresent(Bool.self, forKey: .showDeliveryQueue)
        showOnlineQueue = try values.decodeIfPresent(Bool.self, forKey: .showOnlineQueue)
        enableCashInOut = try values.decodeIfPresent(Bool.self, forKey: .enableCashInOut)
        timeZone = try values.decodeIfPresent(String.self, forKey: .timeZone)
        latitude = try values.decodeIfPresent(Int.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Int.self, forKey: .longitude)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        snapshopTime = try values.decodeIfPresent(Int.self, forKey: .snapshopTime)
        defaultCountry = try values.decodeIfPresent(String.self, forKey: .defaultCountry)
        onlineStoreInfo = try OnlineStoreInfo(from: decoder)
        deliveryFees = try values.decodeIfPresent([DeliveryFees].self, forKey: .deliveryFees)
        enableSaleLogout = try values.decodeIfPresent(Bool.self, forKey: .enableSaleLogout)
        assets = try values.decodeIfPresent([Assets].self, forKey: .assets)
        enableBCCReceipt = try values.decodeIfPresent(Bool.self, forKey: .enableBCCReceipt)
        bccEmailAddress = try values.decodeIfPresent(String.self, forKey: .bccEmailAddress)
        enableGPSTracking = try values.decodeIfPresent(Bool.self, forKey: .enableGPSTracking)
        receivingInventoryId = try values.decodeIfPresent(String.self, forKey: .receivingInventoryId)
        defaultPinTimeout = try values.decodeIfPresent(Int.self, forKey: .defaultPinTimeout)
        showSpecialQueue = try values.decodeIfPresent(Bool.self, forKey: .showSpecialQueue)
        emailList = try values.decodeIfPresent([String].self, forKey: .emailList)
        enableLowInventoryEmail = try values.decodeIfPresent(Bool.self, forKey: .enableLowInventoryEmail)
        restrictedViews = try values.decodeIfPresent(Bool.self, forKey: .restrictedViews)
        emailMessage = try values.decodeIfPresent(String.self, forKey: .emailMessage)
        taxRoundOffType = try values.decodeIfPresent(String.self, forKey: .taxRoundOffType)
        enforceCashDrawers = try values.decodeIfPresent(Bool.self, forKey: .enforceCashDrawers)
        useAssignedEmployee = try values.decodeIfPresent(Bool.self, forKey: .useAssignedEmployee)
        showProductByAvailableQuantity = try values.decodeIfPresent(Bool.self, forKey: .showProductByAvailableQuantity)
        autoCashDrawer = try values.decodeIfPresent(Bool.self, forKey: .autoCashDrawer)
        numAllowActiveTrans = try values.decodeIfPresent(Int.self, forKey: .numAllowActiveTrans)
        requireValidRecDate = try values.decodeIfPresent(Bool.self, forKey: .requireValidRecDate)
        enableDeliverySignature = try values.decodeIfPresent(Bool.self, forKey: .enableDeliverySignature)
        restrictIncomingOrderNotifications = try values.decodeIfPresent(Bool.self, forKey: .restrictIncomingOrderNotifications)
        restrictedNotificationTerminals = try values.decodeIfPresent([String].self, forKey: .restrictedNotificationTerminals)
        roundOffType = try values.decodeIfPresent(String.self, forKey: .roundOffType)
        roundUpMessage = try values.decodeIfPresent(String.self, forKey: .roundUpMessage)
        shopEntityType = try values.decodeIfPresent(String.self, forKey: .shopEntityType)
        membersCountSyncDate = try values.decodeIfPresent(Int.self, forKey: .membersCountSyncDate)
        enableCannabisLimit = try values.decodeIfPresent(Bool.self, forKey: .enableCannabisLimit)
        useComplexTax = try values.decodeIfPresent(Bool.self, forKey: .useComplexTax)
        taxTables = try values.decodeIfPresent([TaxTables].self, forKey: .taxTables)
        enableExciseTax = try values.decodeIfPresent(Bool.self, forKey: .enableExciseTax)
        exciseTaxType = try values.decodeIfPresent(String.self, forKey: .exciseTaxType)
        marketingSources = try values.decodeIfPresent([String].self, forKey: .marketingSources)
        productsTag = try values.decodeIfPresent([String].self, forKey: .productsTag)
        logo = try Logo(from: decoder)
        hubId = try values.decodeIfPresent(String.self, forKey: .hubId)
        hubName = try values.decodeIfPresent(String.self, forKey: .hubName)
        enableOnFleet = try values.decodeIfPresent(Bool.self, forKey: .enableOnFleet)
        onFleetApiKey = try values.decodeIfPresent(String.self, forKey: .onFleetApiKey)
        onFleetOrganizationId = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationId)
        onFleetOrganizationName = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationName)
        emailAttachment = try EmailAttachment(from: decoder)
        receiptInfo = try values.decodeIfPresent([ReceiptInfo].self, forKey: .receiptInfo)
        enablePinForCashDrawer = try values.decodeIfPresent(Bool.self, forKey: .enablePinForCashDrawer)
        checkoutType = try values.decodeIfPresent(String.self, forKey: .checkoutType)
        enableMetrc = try values.decodeIfPresent(Bool.self, forKey: .enableMetrc)
        enableDeliveryMessaging = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryMessaging)
        exciseTaxInfo = try ExciseTaxInfo(from: decoder)
        timezoneOffsetInMinutes = try values.decodeIfPresent(Int.self, forKey: .timezoneOffsetInMinutes)
        defaultPinTimeoutDuration = try values.decodeIfPresent(Int.self, forKey: .defaultPinTimeoutDuration)
    }
    
}

struct StateTax : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shopId : String?
    let dirty : Bool?
    let taxRate : Int?
    let compound : Bool?
    let active : Bool?
    let territory : String?
    let activeExciseTax : Bool?
    let taxOrder : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shopId = "shopId"
        case dirty = "dirty"
        case taxRate = "taxRate"
        case compound = "compound"
        case active = "active"
        case territory = "territory"
        case activeExciseTax = "activeExciseTax"
        case taxOrder = "taxOrder"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        taxRate = try values.decodeIfPresent(Int.self, forKey: .taxRate)
        compound = try values.decodeIfPresent(Bool.self, forKey: .compound)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        territory = try values.decodeIfPresent(String.self, forKey: .territory)
        activeExciseTax = try values.decodeIfPresent(Bool.self, forKey: .activeExciseTax)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
    }
    
}

struct TaxInfo : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let cityTax : Int?
    let stateTax : Int?
    let federalTax : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case cityTax = "cityTax"
        case stateTax = "stateTax"
        case federalTax = "federalTax"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        cityTax = try values.decodeIfPresent(Int.self, forKey: .cityTax)
        stateTax = try values.decodeIfPresent(Int.self, forKey: .stateTax)
        federalTax = try values.decodeIfPresent(Int.self, forKey: .federalTax)
    }
    
}

struct TaxTables : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shopId : String?
    let dirty : Bool?
    let name : String?
    let active : Bool?
    let taxType : String?
    let taxOrder : String?
    let consumerType : String?
    let cityTax : CityTax?
    let countyTax : CountyTax?
    let stateTax : StateTax?
    let federalTax : FederalTax?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shopId = "shopId"
        case dirty = "dirty"
        case name = "name"
        case active = "active"
        case taxType = "taxType"
        case taxOrder = "taxOrder"
        case consumerType = "consumerType"
        case cityTax
        case countyTax
        case stateTax
        case federalTax
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        taxType = try values.decodeIfPresent(String.self, forKey: .taxType)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
        consumerType = try values.decodeIfPresent(String.self, forKey: .consumerType)
        cityTax = try CityTax(from: decoder)
        countyTax = try CountyTax(from: decoder)
        stateTax = try StateTax(from: decoder)
        federalTax = try FederalTax(from: decoder)
    }
    
}

struct TerminalLocations : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shopId : String?
    let dirty : Bool?
    let terminalId : String?
    let employeeId : String?
    let timeCardId : String?
    let deviceId : String?
    let name : String?
    let loc : [Int]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shopId = "shopId"
        case dirty = "dirty"
        case terminalId = "terminalId"
        case employeeId = "employeeId"
        case timeCardId = "timeCardId"
        case deviceId = "deviceId"
        case name = "name"
        case loc = "loc"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        terminalId = try values.decodeIfPresent(String.self, forKey: .terminalId)
        employeeId = try values.decodeIfPresent(String.self, forKey: .employeeId)
        timeCardId = try values.decodeIfPresent(String.self, forKey: .timeCardId)
        deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        loc = try values.decodeIfPresent([Int].self, forKey: .loc)
    }
    
}

struct TimeCard : Codable {
    let id : String?
    let created : Int?
    let modified : Int?
    let deleted : Bool?
    let updated : Bool?
    let companyId : String?
    let shopId : String?
    let dirty : Bool?
    let employeeId : String?
    let clockInTime : Int?
    let clockOutTime : Int?
    let clockin : Bool?
    let sessions : [Sessions]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created = "created"
        case modified = "modified"
        case deleted = "deleted"
        case updated = "updated"
        case companyId = "companyId"
        case shopId = "shopId"
        case dirty = "dirty"
        case employeeId = "employeeId"
        case clockInTime = "clockInTime"
        case clockOutTime = "clockOutTime"
        case clockin = "clockin"
        case sessions = "sessions"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        employeeId = try values.decodeIfPresent(String.self, forKey: .employeeId)
        clockInTime = try values.decodeIfPresent(Int.self, forKey: .clockInTime)
        clockOutTime = try values.decodeIfPresent(Int.self, forKey: .clockOutTime)
        clockin = try values.decodeIfPresent(Bool.self, forKey: .clockin)
        sessions = try values.decodeIfPresent([Sessions].self, forKey: .sessions)
    }
    
}






