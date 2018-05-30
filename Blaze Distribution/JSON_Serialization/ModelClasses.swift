//
//  ModelClasses.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 24/05/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
class Login : DBModel,Codable {
   @objc dynamic  var accessToken : String?     = ""
   @objc dynamic var assetAccessToken : String? = ""
   var employee : Employee?                     = nil
   @objc dynamic var loginTime : Int            = 0
   @objc dynamic var expirationTime : Int       = 0
   @objc dynamic var sessionId : String         = ""
    var company : Company?                      = Company()
    var shops : [Shops]                         = []
    var assignedShop : AssignedShop?
   //@objc dynamic var newDevice : Bool           = false
    var assignedTerminal : AssignedTerminal?
   @objc dynamic var appType : String?          = ""
   @objc dynamic var appTarget : String? = ""
    
    enum CodingKeys: String, CodingKey {
        
        case accessToken = "accessToken"
        case assetAccessToken = "assetAccessToken"
        case employee = "employee"
        case loginTime = "loginTime"
        case expirationTime = "expirationTime"
        case sessionId = "sessionId"
        case company = "company"
        case shops = "shops"
        case assignedShop = "assignedShop"
       // case newDevice = "newDevice"
        case assignedTerminal = "assignedTerminal"
        case appType = "appType"
        case appTarget = "appTarget"
    }
    
    convenience init(accessToken : String?,assetAccessToken : String?,employee : Employee?,loginTime : Int?,expirationTime : Int?,sessionId : String?,company : Company?,shops : [Shops]?,assignedShop : AssignedShop?,assignedTerminal : AssignedTerminal?,appType : String?,appTarget : String?){
        self.init()
        self.accessToken = accessToken
        self.assetAccessToken = assetAccessToken
        self.employee = employee
        self.loginTime = loginTime!
        self.expirationTime = expirationTime!
        self.sessionId = sessionId!
        self.company = company
        self.shops = shops!
        self.assignedShop = assignedShop
       // self.newDevice = newDevice!
        self.assignedTerminal = assignedTerminal
        self.appType = appType
        self.appTarget = appTarget
    }
    
   convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        let assetAccessToken = try values.decodeIfPresent(String.self, forKey: .assetAccessToken)
        let employee = try values.decodeIfPresent(Employee.self, forKey: .employee)
        let loginTime = try values.decodeIfPresent(Int.self, forKey: .loginTime)
        let expirationTime = try values.decodeIfPresent(Int.self, forKey: .expirationTime)
        let sessionId = try values.decodeIfPresent(String.self, forKey: .sessionId)
        let company = try values.decodeIfPresent(Company.self, forKey: .company)
        let shops = try values.decodeIfPresent([Shops].self, forKey: .shops)
        let assignedShop = try values.decodeIfPresent(AssignedShop.self, forKey: .assignedShop)
      //  let newDevice = try values.decodeIfPresent(Bool.self, forKey: .newDevice)
        let assignedTerminal = try values.decodeIfPresent(AssignedTerminal.self, forKey: .assignedTerminal)
            
        let appType = try values.decodeIfPresent(String.self, forKey: .appType)
        let appTarget = try values.decodeIfPresent(String.self, forKey: .appTarget)
    
    
    
        self.init(accessToken: accessToken, assetAccessToken: assetAccessToken, employee: employee, loginTime: loginTime, expirationTime: expirationTime, sessionId: sessionId, company: company, shops: shops, assignedShop: assignedShop, assignedTerminal: assignedTerminal, appType: appType, appTarget: appTarget)
    
    }
    

    
}

class Shops : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var shortIdentifier : String?
    var name : String?
    var shopType : String?
    var address : Address?
    var phoneNumber : String?
    var emailAdress : String?
    var license : String?
    var enableDeliveryFee : Bool?
    var deliveryFee : Int?
    var taxOrder : String?
    var taxInfo : TaxInfo?
    var showWalkInQueue : Bool?
    var showDeliveryQueue : Bool?
    var showOnlineQueue : Bool?
    var enableCashInOut : Bool?
    var timeZone : String?
    var latitude : Int?
    var longitude : Int?
    var active : Bool?
    var snapshopTime : Int?
    var defaultCountry : String?
    var onlineStoreInfo : OnlineStoreInfo?
    var deliveryFees : [DeliveryFees]?
    var enableSaleLogout : Bool?
    var assets : [Assets]?
    var enableBCCReceipt : Bool?
    var bccEmailAddress : String?
    var enableGPSTracking : Bool?
    var receivingInventoryId : String?
    var defaultPinTimeout : Int?
    var showSpecialQueue : Bool?
    var emailList : [String]?
    var enableLowInventoryEmail : Bool?
    var restrictedViews : Bool?
    var emailMessage : String?
    var taxRoundOffType : String?
    var enforceCashDrawers : Bool?
    var useAssignedEmployee : Bool?
    var showProductByAvailableQuantity : Bool?
    var autoCashDrawer : Bool?
    var numAllowActiveTrans : Int?
    var requireValidRecDate : Bool?
    var enableDeliverySignature : Bool?
    var restrictIncomingOrderNotifications : Bool?
    var restrictedNotificationTerminals : [String]?
    var roundOffType : String?
    var roundUpMessage : String?
    var shopEntityType : String?
    var membersCountSyncDate : Int?
    var enableCannabisLimit : Bool?
    var useComplexTax : Bool?
    var taxTables : [TaxTables]?
    var enableExciseTax : Bool?
    var exciseTaxType : String?
    var marketingSources : [String]?
    var productsTag : [String]?
    var logo : Logo?
    var hubId : String?
    var hubName : String?
    var enableOnFleet : Bool?
    var onFleetApiKey : String?
    var onFleetOrganizationId : String?
    var onFleetOrganizationName : String?
    var emailAttachment : EmailAttachment?
    var receiptInfo : [ReceiptInfo]?
    var enablePinForCashDrawer : Bool?
    var checkoutType : String?
    var enableMetrc : Bool?
    var enableDeliveryMessaging : Bool?
    var exciseTaxInfo : ExciseTaxInfo?
    var timezoneOffsetInMinutes : Int?
    var defaultPinTimeoutDuration : Int?
    
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
        case address = "address"
        case phoneNumber = "phoneNumber"
        case emailAdress = "emailAdress"
        case license = "license"
        case enableDeliveryFee = "enableDeliveryFee"
        case deliveryFee = "deliveryFee"
        case taxOrder = "taxOrder"
        case taxInfo = "taxInfo"
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
        case onlineStoreInfo = "onlineStoreInfo"
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
        case logo = "logo"
        case hubId = "hubId"
        case hubName = "hubName"
        case enableOnFleet = "enableOnFleet"
        case onFleetApiKey = "onFleetApiKey"
        case onFleetOrganizationId = "onFleetOrganizationId"
        case onFleetOrganizationName = "onFleetOrganizationName"
        case emailAttachment = "emailAttachment"
        case receiptInfo = "receiptInfo"
        case enablePinForCashDrawer = "enablePinForCashDrawer"
        case checkoutType = "checkoutType"
        case enableMetrc = "enableMetrc"
        case enableDeliveryMessaging = "enableDeliveryMessaging"
        case exciseTaxInfo = "exciseTaxInfo"
        case timezoneOffsetInMinutes = "timezoneOffsetInMinutes"
        case defaultPinTimeoutDuration = "defaultPinTimeoutDuration"
    }
    
    required init(from decoder: Decoder) throws {
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
        address = try values.decodeIfPresent(Address.self, forKey: .address)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        emailAdress = try values.decodeIfPresent(String.self, forKey: .emailAdress)
        license = try values.decodeIfPresent(String.self, forKey: .license)
        enableDeliveryFee = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryFee)
        deliveryFee = try values.decodeIfPresent(Int.self, forKey: .deliveryFee)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
        taxInfo = try values.decodeIfPresent(TaxInfo.self, forKey: .taxInfo)
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
        onlineStoreInfo = try values.decodeIfPresent(OnlineStoreInfo.self, forKey: .onlineStoreInfo)
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
        logo = try values.decodeIfPresent(Logo.self, forKey: .logo)
        hubId = try values.decodeIfPresent(String.self, forKey: .hubId)
        hubName = try values.decodeIfPresent(String.self, forKey: .hubName)
        enableOnFleet = try values.decodeIfPresent(Bool.self, forKey: .enableOnFleet)
        onFleetApiKey = try values.decodeIfPresent(String.self, forKey: .onFleetApiKey)
        onFleetOrganizationId = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationId)
        onFleetOrganizationName = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationName)
        emailAttachment = try values.decodeIfPresent(EmailAttachment.self, forKey: .emailAttachment)
        receiptInfo = try values.decodeIfPresent([ReceiptInfo].self, forKey: .receiptInfo)
        enablePinForCashDrawer = try values.decodeIfPresent(Bool.self, forKey: .enablePinForCashDrawer)
        checkoutType = try values.decodeIfPresent(String.self, forKey: .checkoutType)
        enableMetrc = try values.decodeIfPresent(Bool.self, forKey: .enableMetrc)
        enableDeliveryMessaging = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryMessaging)
        exciseTaxInfo = try values.decodeIfPresent(ExciseTaxInfo.self, forKey: .exciseTaxInfo)
        timezoneOffsetInMinutes = try values.decodeIfPresent(Int.self, forKey: .timezoneOffsetInMinutes)
        defaultPinTimeoutDuration = try values.decodeIfPresent(Int.self, forKey: .defaultPinTimeoutDuration)
    }
    
}


class Address: DBModel,Codable{
   @objc dynamic var id : String?     = ""
     dynamic  var created   = RealmOptional<Int>()
                 var modified : Int? = 0
                 var deleted : Bool?  =  false
                 var updated : Bool?  = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var address : String? = ""
   @objc dynamic var city : String? = ""
   @objc dynamic var state : String? = " "
   @objc dynamic var zipCode : String? = ""
   @objc dynamic var country : String? = " "
    
    convenience init(id : String? = nil,created : Int?,modified : Int?,deleted : Bool?,updated : Bool?,companyId : String?,address : String?,city : String?,state : String?,zipCode : String?,country : String?){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.address = address
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.country = country
    }
    
    
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

   convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decodeIfPresent(String.self, forKey: .id)
        let created = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        let address = try values.decodeIfPresent(String.self, forKey: .address)
        let city = try values.decodeIfPresent(String.self, forKey: .city)
        let state = try values.decodeIfPresent(String.self, forKey: .state)
        let zipCode = try values.decodeIfPresent(String.self, forKey: .zipCode)
        let country = try values.decodeIfPresent(String.self, forKey: .country)
        
        self.init(id: id, created: created, modified: modified, deleted: deleted, updated: updated, companyId: companyId, address: address, city: city, state: state, zipCode: zipCode, country: country)
      
    }
    
}

class Assets : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var name : String?
    var key : String?
    var type : String?
    var publicURL : String?
    var active : Bool?
    var priority : Int?
    var secured : Bool?
    var thumbURL : String?
    var mediumURL : String?
    var largeURL : String?
    var assetType : String?
    
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
    
    required init(from decoder: Decoder) throws {
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

class AssignedShop : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var shortIdentifier : String?
    var name : String?
    var shopType : String?
  //  var address : Address?
    var phoneNumber : String?
    var emailAdress : String?
    var license : String?
    var enableDeliveryFee : Bool?
    var deliveryFee : Int?
    var taxOrder : String?
    var taxInfo : TaxInfo?
    var showWalkInQueue : Bool?
    var showDeliveryQueue : Bool?
    var showOnlineQueue : Bool?
    var enableCashInOut : Bool?
    var timeZone : String?
    var latitude : Int?
    var longitude : Int?
    var active : Bool?
    var snapshopTime : Int?
    var defaultCountry : String?
    var onlineStoreInfo : OnlineStoreInfo?
    var deliveryFees : [DeliveryFees]?
    var enableSaleLogout : Bool?
    var assets : [Assets]?
    var enableBCCReceipt : Bool?
    var bccEmailAddress : String?
    var enableGPSTracking : Bool?
    var receivingInventoryId : String?
    var defaultPinTimeout : Int?
    var showSpecialQueue : Bool?
    var emailList : [String]?
    var enableLowInventoryEmail : Bool?
    var restrictedViews : Bool?
    var emailMessage : String?
    var taxRoundOffType : String?
    var enforceCashDrawers : Bool?
    var useAssignedEmployee : Bool?
    var showProductByAvailableQuantity : Bool?
    var autoCashDrawer : Bool?
    var numAllowActiveTrans : Int?
    var requireValidRecDate : Bool?
    var enableDeliverySignature : Bool?
    var restrictIncomingOrderNotifications : Bool?
    var restrictedNotificationTerminals : [String]?
    var roundOffType : String?
    var roundUpMessage : String?
    var shopEntityType : String?
    var membersCountSyncDate : Int?
    var enableCannabisLimit : Bool?
    var useComplexTax : Bool?
    var taxTables : [TaxTables]?
    var enableExciseTax : Bool?
    var exciseTaxType : String?
    var marketingSources : [String]?
    var productsTag : [String]?
    var logo : Logo?
    var hubId : String?
    var hubName : String?
    var enableOnFleet : Bool?
    var onFleetApiKey : String?
    var onFleetOrganizationId : String?
    var onFleetOrganizationName : String?
    var emailAttachment : EmailAttachment?
    var receiptInfo : [ReceiptInfo]?
    var enablePinForCashDrawer : Bool?
    var checkoutType : String?
    var enableMetrc : Bool?
    var enableDeliveryMessaging : Bool?
    var exciseTaxInfo : ExciseTaxInfo?
    var timezoneOffsetInMinutes : Int?
    var defaultPinTimeoutDuration : Int?
    
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
     //   case address = "address"
        case phoneNumber = "phoneNumber"
        case emailAdress = "emailAdress"
        case license = "license"
        case enableDeliveryFee = "enableDeliveryFee"
        case deliveryFee = "deliveryFee"
        case taxOrder = "taxOrder"
        case taxInfo = "taxInfo"
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
        case onlineStoreInfo = "onlineStoreInfo"
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
        case logo = "logo"
        case hubId = "hubId"
        case hubName = "hubName"
        case enableOnFleet = "enableOnFleet"
        case onFleetApiKey = "onFleetApiKey"
        case onFleetOrganizationId = "onFleetOrganizationId"
        case onFleetOrganizationName = "onFleetOrganizationName"
        case emailAttachment = "emailAttachment"
        case receiptInfo = "receiptInfo"
        case enablePinForCashDrawer = "enablePinForCashDrawer"
        case checkoutType = "checkoutType"
        case enableMetrc = "enableMetrc"
        case enableDeliveryMessaging = "enableDeliveryMessaging"
        case exciseTaxInfo = "exciseTaxInfo"
        case timezoneOffsetInMinutes = "timezoneOffsetInMinutes"
        case defaultPinTimeoutDuration = "defaultPinTimeoutDuration"
    }
    
    required init(from decoder: Decoder) throws {
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
     //   address = try values.decodeIfPresent(Address.self, forKey: .address)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        emailAdress = try values.decodeIfPresent(String.self, forKey: .emailAdress)
        license = try values.decodeIfPresent(String.self, forKey: .license)
        enableDeliveryFee = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryFee)
        deliveryFee = try values.decodeIfPresent(Int.self, forKey: .deliveryFee)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
        taxInfo = try values.decodeIfPresent(TaxInfo.self, forKey: .taxInfo)
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
        onlineStoreInfo = try values.decodeIfPresent(OnlineStoreInfo.self, forKey: .onlineStoreInfo)
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
        logo = try values.decodeIfPresent(Logo.self, forKey: .logo)
        hubId = try values.decodeIfPresent(String.self, forKey: .hubId)
        hubName = try values.decodeIfPresent(String.self, forKey: .hubName)
        enableOnFleet = try values.decodeIfPresent(Bool.self, forKey: .enableOnFleet)
        onFleetApiKey = try values.decodeIfPresent(String.self, forKey: .onFleetApiKey)
        onFleetOrganizationId = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationId)
        onFleetOrganizationName = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationName)
        emailAttachment = try values.decodeIfPresent(EmailAttachment.self, forKey: .emailAttachment)
        receiptInfo = try values.decodeIfPresent([ReceiptInfo].self, forKey: .receiptInfo)
        enablePinForCashDrawer = try values.decodeIfPresent(Bool.self, forKey: .enablePinForCashDrawer)
        checkoutType = try values.decodeIfPresent(String.self, forKey: .checkoutType)
        enableMetrc = try values.decodeIfPresent(Bool.self, forKey: .enableMetrc)
        enableDeliveryMessaging = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryMessaging)
        exciseTaxInfo = try values.decodeIfPresent(ExciseTaxInfo.self, forKey: .exciseTaxInfo)
        timezoneOffsetInMinutes = try values.decodeIfPresent(Int.self, forKey: .timezoneOffsetInMinutes)
        defaultPinTimeoutDuration = try values.decodeIfPresent(Int.self, forKey: .defaultPinTimeoutDuration)
    }
    
}

class TaxInfo : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var cityTax : Double?
    var stateTax : Double?
    var federalTax : Double?
    
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
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        cityTax = try values.decodeIfPresent(Double.self, forKey: .cityTax)
        stateTax = try values.decodeIfPresent(Double.self, forKey: .stateTax)
        federalTax = try values.decodeIfPresent(Double.self, forKey: .federalTax)
    }
    
}


class StateTax : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var shopId : String?
    var dirty : Bool?
    var taxRate : Double?
    var compound : Bool?
    var active : Bool?
    var territory : String?
    var activeExciseTax : Bool?
    var taxOrder : String?
    
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
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        taxRate = try values.decodeIfPresent(Double.self, forKey: .taxRate)
        compound = try values.decodeIfPresent(Bool.self, forKey: .compound)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        territory = try values.decodeIfPresent(String.self, forKey: .territory)
        activeExciseTax = try values.decodeIfPresent(Bool.self, forKey: .activeExciseTax)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
    }
    
}


class AssignedTerminal : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var shopId : String?
    var dirty : Bool?
    var active : Bool?
    var deviceId : String?
    var name : String?
    var deviceModel : String?
    var deviceVersion : String?
    var deviceName : String?
    var appVersion : String?
    var deviceToken : String?
    var deviceType : String?
    var assignedInventoryId : String?
    var cvAccountId : String?
    var currentEmployeeId : String?
    var terminalLocations : [TerminalLocations]?
    
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
    
    required init(from decoder: Decoder) throws {
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

class CityTax : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var shopId : String?
    var dirty : Bool?
    var taxRate : Double?
    var compound : Bool?
    var active : Bool?
    var territory : String?
    var activeExciseTax : Bool?
    var taxOrder : String?
    
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
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        taxRate = try values.decodeIfPresent(Double.self, forKey: .taxRate)
        compound = try values.decodeIfPresent(Bool.self, forKey: .compound)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        territory = try values.decodeIfPresent(String.self, forKey: .territory)
        activeExciseTax = try values.decodeIfPresent(Bool.self, forKey: .activeExciseTax)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
    }
    
}

class Company : DBModel,Codable {
   @objc dynamic var id : String?  = ""
    var created : Int? = 0
    var modified : Int? = 0
    var deleted : Bool? = false
    var updated : Bool? = false
   @objc dynamic var membersShareOption : String? = ""
    @objc dynamic var isId : String? = ""
   @objc dynamic var name : String? = ""
   @objc dynamic var phoneNumber : String? = ""
   @objc dynamic var email : String? = ""
    var address : Address?
   @objc dynamic var logoURL : String? = ""
   @objc dynamic var supportEmail : String? = ""
    var showNameWithLogo : Bool? = false
    var active : Bool? = false
   @objc dynamic var website : String? = ""
   @objc dynamic var productSKU : String? = ""
   @objc dynamic var queueUrl : String? = ""
   @objc dynamic var preferredEmailColor : String? = ""
   @objc dynamic var pricingOpt : String? = ""
    var enableLoyalty : Bool? = false
    var dollarToPointRatio : Int? = 0
    var duration : Int? = 0
   @objc dynamic var portalUrl : String? = ""
   @objc dynamic var businessLocation : String? = ""
   @objc dynamic var fax : String? = ""
    var primaryContact : PrimaryContact?
   @objc dynamic var taxId : String? = ""
   @objc dynamic var loyaltyAccrueOpt : String? = ""
    
    
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
        case address = "address"
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
        case primaryContact = "primaryContact"
        case taxId = "taxId"
        case loyaltyAccrueOpt = "loyaltyAccrueOpt"
    }
    
    convenience init(id : String?,created : Int?,modified : Int?,deleted : Bool?,updated : Bool?,membersShareOption : String?,isId : String?,name : String?,phoneNumber : String?,email : String?,address : Address?,logoURL : String?,supportEmail : String?,showNameWithLogo : Bool?,active : Bool?,website : String?,productSKU : String?,queueUrl : String?,preferredEmailColor : String?,pricingOpt : String?,enableLoyalty : Bool?,dollarToPointRatio : Int?,duration : Int?,portalUrl : String?,businessLocation : String?,fax : String?,primaryContact : PrimaryContact?,taxId : String?,loyaltyAccrueOpt : String?){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.membersShareOption = membersShareOption
        self.isId = isId
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.logoURL = logoURL
        self.supportEmail = supportEmail
        self.showNameWithLogo = showNameWithLogo
        self.active = active
        self.website = website
        self.productSKU = productSKU
        self.queueUrl = queueUrl
        self.preferredEmailColor = preferredEmailColor
        self.pricingOpt = pricingOpt
        self.enableLoyalty = enableLoyalty
        self.dollarToPointRatio = dollarToPointRatio
        self.duration = duration
        self.portalUrl = portalUrl
        self.businessLocation = businessLocation
        self.fax = fax
        self.primaryContact = primaryContact
        self.taxId = taxId
        self.loyaltyAccrueOpt = loyaltyAccrueOpt
    
    }
    
    convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decodeIfPresent(String.self, forKey: .id)
        let created = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let membersShareOption = try values.decodeIfPresent(String.self, forKey: .membersShareOption)
        let isId = try values.decodeIfPresent(String.self, forKey: .isId)
        let name = try values.decodeIfPresent(String.self, forKey: .name)
        let phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        let email = try values.decodeIfPresent(String.self, forKey: .email)
        let address = try values.decodeIfPresent(Address.self, forKey: .address)
        let logoURL = try values.decodeIfPresent(String.self, forKey: .logoURL)
        let supportEmail = try values.decodeIfPresent(String.self, forKey: .supportEmail)
        let showNameWithLogo = try values.decodeIfPresent(Bool.self, forKey: .showNameWithLogo)
        let active = try values.decodeIfPresent(Bool.self, forKey: .active)
        let website = try values.decodeIfPresent(String.self, forKey: .website)
        let productSKU = try values.decodeIfPresent(String.self, forKey: .productSKU)
        let queueUrl = try values.decodeIfPresent(String.self, forKey: .queueUrl)
        let preferredEmailColor = try values.decodeIfPresent(String.self, forKey: .preferredEmailColor)
        let pricingOpt = try values.decodeIfPresent(String.self, forKey: .pricingOpt)
        let enableLoyalty = try values.decodeIfPresent(Bool.self, forKey: .enableLoyalty)
        let dollarToPointRatio = try values.decodeIfPresent(Int.self, forKey: .dollarToPointRatio)
        let duration = try values.decodeIfPresent(Int.self, forKey: .duration)
        let portalUrl = try values.decodeIfPresent(String.self, forKey: .portalUrl)
        let businessLocation = try values.decodeIfPresent(String.self, forKey: .businessLocation)
        let fax = try values.decodeIfPresent(String.self, forKey: .fax)
        let primaryContact = try values.decodeIfPresent(PrimaryContact.self, forKey: .primaryContact)
        let taxId = try values.decodeIfPresent(String.self, forKey: .taxId)
        let loyaltyAccrueOpt = try values.decodeIfPresent(String.self, forKey: .loyaltyAccrueOpt)
        self.init(id: id, created: created, modified: modified, deleted: deleted, updated: updated, membersShareOption: membersShareOption, isId: isId, name: name, phoneNumber: phoneNumber, email: email, address: address, logoURL: logoURL, supportEmail: supportEmail, showNameWithLogo: showNameWithLogo, active: active, website: website, productSKU: productSKU, queueUrl: queueUrl, preferredEmailColor: preferredEmailColor, pricingOpt: pricingOpt, enableLoyalty: enableLoyalty, dollarToPointRatio: dollarToPointRatio, duration: duration, portalUrl: portalUrl, businessLocation: businessLocation, fax: fax, primaryContact: primaryContact, taxId: taxId, loyaltyAccrueOpt: loyaltyAccrueOpt)
    }
    
}

class CountyTax :DBModel,Codable {
   @objc dynamic var id : String?   = ""
   @objc dynamic var created : Int  = 0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var shopId : String? = ""
   @objc dynamic var dirty : Bool = false
   @objc dynamic var taxRate : Double = 0.0
   @objc dynamic var compound : Bool = false
   @objc dynamic var active : Bool = false
   @objc dynamic var territory : String? = ""
   @objc dynamic var activeExciseTax : Bool = false
   @objc dynamic var taxOrder : String? = ""
    
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
    
    convenience init(id : String?,created : Int?,modified : Int?,deleted : Bool?,updated : Bool?,companyId : String?,shopId : String?,dirty : Bool?,taxRate : Double?,compound : Bool?,active : Bool?,territory : String?,activeExciseTax : Bool?,taxOrder : String?){
        self.init()
        self.id = id
        self.created = created!
        self.modified = modified!
        self.deleted = deleted!
        self.updated = updated!
        self.companyId = companyId
        self.shopId = shopId
        self.dirty = dirty!
        self.taxRate = taxRate!
        self.compound = compound!
        self.active = active!
        self.territory = territory
        self.activeExciseTax = activeExciseTax!
        self.taxOrder = taxOrder
    }
    
    
   convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decodeIfPresent(String.self, forKey: .id)
        let created = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        let shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        let dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        let taxRate = try values.decodeIfPresent(Double.self, forKey: .taxRate)
        let compound = try values.decodeIfPresent(Bool.self, forKey: .compound)
        let active = try values.decodeIfPresent(Bool.self, forKey: .active)
        let territory = try values.decodeIfPresent(String.self, forKey: .territory)
        let activeExciseTax = try values.decodeIfPresent(Bool.self, forKey: .activeExciseTax)
        let taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
        self.init(id: id, created: created, modified: modified, deleted: deleted!, updated: updated!, companyId: companyId, shopId: shopId, dirty: dirty!, taxRate: taxRate, compound: compound!, active: active!, territory: territory, activeExciseTax: activeExciseTax, taxOrder: taxOrder)
    }
    
}

class DeliveryFees : DBModel,Codable{
   @objc dynamic var id : String? = ""
   @objc dynamic var created : Int = 0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var enabled : Bool = false
   @objc dynamic var subTotalThreshold : Int = 0
   @objc dynamic var fee : Double = 0
    
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
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,enabled : Bool,subTotalThreshold : Int,fee : Double){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.enabled = enabled
        self.subTotalThreshold = subTotalThreshold
        self.fee = fee
    }
    convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decodeIfPresent(String.self, forKey: .id)
        let created = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        let enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
        let subTotalThreshold = try values.decodeIfPresent(Int.self, forKey: .subTotalThreshold)
        let fee = try values.decodeIfPresent(Double.self, forKey: .fee)
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, enabled: enabled!, subTotalThreshold: subTotalThreshold!, fee: fee!)
    }
    
}

class EmailAttachment : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var name : String?
    var key : String?
    var type : String?
    var publicURL : String?
    var active : Bool?
    var priority : Int?
    var secured : Bool?
    var thumbURL : String?
    var mediumURL : String?
    var largeURL : String?
    var assetType : String?
    
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
    
    required init(from decoder: Decoder) throws {
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

class Employee : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var firstName : String?
    var lastName : String?
    var pin : String?
    var roleId : String?
    var email : String?
    var password : String?
    var driversLicense : String?
    var dlExpirationDate : String?
    var vehicleMake : String?
    var notes : [Notes]?
    var shops : [String]?
    var disabled : Bool?
    var phoneNumber : String?
    var assignedInventoryId : String?
    var assignedTerminalId : String?
    var address : Address?
    var timecardId : String?
    var timeCard : TimeCard?
    var role : Role?
    var canApplyCustomDiscount : Bool?
    var insuranceExpireDate : Int?
    var insuranceCompanyName : String?
    var policyNumber : String?
    var registrationExpireDate : Int?
    var vehiclePin : String?
    var vinNo : String?
    var employeeOnFleetInfoList : [EmployeeOnFleetInfoList]?
    var appAccessList : [String]?
    
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
        case address = "address"
        case timecardId = "timecardId"
        case timeCard = "timeCard"
        case role = "role"
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
    
    required init(from decoder: Decoder) throws {
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
        address = try values.decodeIfPresent(Address.self, forKey: .address)
        timecardId = try values.decodeIfPresent(String.self, forKey: .timecardId)
        timeCard = try values.decodeIfPresent(TimeCard.self, forKey: .timeCard)
        role = try values.decodeIfPresent(Role.self, forKey: .role)
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

class EmployeeOnFleetInfoList : Codable {
    var shopId : String?
    var onFleetWorkerId : String?
    var onFleetTeamList : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case shopId = "shopId"
        case onFleetWorkerId = "onFleetWorkerId"
        case onFleetTeamList = "onFleetTeamList"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        onFleetWorkerId = try values.decodeIfPresent(String.self, forKey: .onFleetWorkerId)
        onFleetTeamList = try values.decodeIfPresent([String].self, forKey: .onFleetTeamList)
    }
    
}

class ExciseTaxInfo : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var state : String?
    var country : String?
    var stateMarkUp : Int?
    var exciseTax : Int?
    
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
    
    required init(from decoder: Decoder) throws {
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

class FederalTax : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var shopId : String?
    var dirty : Bool?
    var taxRate : Double?
    var compound : Bool?
    var active : Bool?
    var territory : String?
    var activeExciseTax : Bool?
    var taxOrder : String?
    
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
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        taxRate = try values.decodeIfPresent(Double.self, forKey: .taxRate)
        compound = try values.decodeIfPresent(Bool.self, forKey: .compound)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        territory = try values.decodeIfPresent(String.self, forKey: .territory)
        activeExciseTax = try values.decodeIfPresent(Bool.self, forKey: .activeExciseTax)
        taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
    }
    
}

class Logo : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var name : String?
    var key : String?
    var type : String?
    var publicURL : String?
    var active : Bool?
    var priority : Int?
    var secured : Bool?
    var thumbURL : String?
    var mediumURL : String?
    var largeURL : String?
    var assetType : String?
    
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
    
    required init(from decoder: Decoder) throws {
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

class Notes : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var writerId : String?
    var writerName : String?
    var message : String?
    
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
    
    required init(from decoder: Decoder) throws {
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

class OnlineStoreInfo : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var shopId : String?
    var dirty : Bool?
    var enableStorePickup : Bool?
    var enableDelivery : Bool?
    var enableOnlineShipment : Bool?
    var enableProductReviews : Bool?
    var colorTheme : String?
    var defaultETA : Int?
    var pageOneMessageTitle : String?
    var pageOneMessageBody : String?
    var submissionMessage : String?
    var cartMinimum : Int?
    var cartMinType : String?
    var enabled : Bool?
    var websiteOrigins : String?
    var supportEmail : String?
    var enableOnlinePOS : Bool?
    var enableDeliveryAreaRestrictions : Bool?
    var restrictedZipCodes : [String]?
    var useCustomETA : Bool?
    var customMessageETA : String?
    var storeHexColor : String?
    var viewType : String?
    var enableInventory : Bool?
    var enableInventoryType : String?
    var activeInventoryId : String?
    var enableHtmlText : Bool?
    var htmlText : String?
    var websiteUrl : String?
    
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
    
    required init(from decoder: Decoder) throws {
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

class PrimaryContact : DBModel,Codable{
   @objc dynamic var name : String? = ""
   @objc dynamic var email : String? = ""
   @objc dynamic var contact : String? = ""
   var address : Address?  = nil
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case email = "email"
        case contact = "contact"
        case address = "address"
    }
    
    convenience  init(name : String?,email : String?,contact : String?,address : Address?) {
        self.init()
        self.name = name
        self.email = email
        self.contact = contact
        self.address = address
    }
    
    
    convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let name = try values.decodeIfPresent(String.self, forKey: .name)
        let email = try values.decodeIfPresent(String.self, forKey: .email)
        let contact = try values.decodeIfPresent(String.self, forKey: .contact)
        let address = try values.decodeIfPresent(Address.self, forKey: .address)
        self.init(name: name, email: email, contact: contact, address: address)
    }
    
}

class ReceiptInfo : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var shopId : String?
    var dirty : Bool?
    var receiptType : String?
    var enableMemberName : Bool?
    var enableMemberId : Bool?
    var enableMemberAddress : Bool?
    var enableShopAddress : Bool?
    var enableShopPhoneNo : Bool?
    var enableIncludeItemInSKU : Bool?
    var enableExciseTaxAsItem : Bool?
    var enableMemberLoyaltyPoints : Bool?
    var enableNotes : Bool?
    var freeText : String?
    var enabledFreeText : Bool?
    var enabledBottomFreeText : Bool?
    
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
    
    required init(from decoder: Decoder) throws {
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

class Role : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var permissions : [String]?
    var name : String?
    
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
    
    required init(from decoder: Decoder) throws {
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

class Sessions :DBModel,Codable {
   @objc dynamic var id : String? = ""
                 var created : Int? = 0
                 var modified : Int? = 0
                 var deleted : Bool? = false
                 var updated : Bool? = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var shopId : String? = ""
                 var dirty : Bool? = false
   @objc dynamic var terminalId : String? = ""
   @objc dynamic var employeeId : String? = ""
   @objc dynamic var timeCardId : String? = ""
                 var startTime : Int? = 0
                 var endTime : Int? = 0
    
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
    convenience init(id : String?,created : Int?,modified : Int?,deleted : Bool?,updated : Bool?,companyId : String?,shopId : String?,dirty : Bool?,terminalId : String?,employeeId : String?,timeCardId : String?,startTime : Int?,endTime : Int?){
        self.init()
        self.id = id
        self.created = created  
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.shopId = shopId
        self.dirty = dirty
        self.terminalId = terminalId
        self.employeeId = employeeId
        self.timeCardId = timeCardId
        self.startTime = startTime
        self.endTime = endTime
    }
    
   convenience required init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
       let id = try values.decodeIfPresent(String.self, forKey: .id)
       let created = try values.decodeIfPresent(Int.self, forKey: .created)
       let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
       let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
       let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
       let companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
       let shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
       let dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
       let terminalId = try values.decodeIfPresent(String.self, forKey: .terminalId)
       let employeeId = try values.decodeIfPresent(String.self, forKey: .employeeId)
       let timeCardId = try values.decodeIfPresent(String.self, forKey: .timeCardId)
       let startTime = try values.decodeIfPresent(Int.self, forKey: .startTime)
       let endTime = try values.decodeIfPresent(Int.self, forKey: .endTime)
        self.init(id: id, created: created, modified: modified, deleted: deleted, updated: updated, companyId: companyId, shopId: shopId, dirty: dirty, terminalId: terminalId, employeeId: employeeId, timeCardId: timeCardId, startTime: startTime, endTime: endTime)
    }
    
}

class TaxTables : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var shopId : String?
    var dirty : Bool?
    var name : String?
    var active : Bool?
    var taxType : String?
    var taxOrder : String?
    var consumerType : String?
    var cityTax : CityTax?
    var countyTax : CountyTax?
    var stateTax : StateTax?
    var federalTax : FederalTax?
    
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
        case cityTax = "cityTax"
        case countyTax = "countyTax"
        case stateTax = "stateTax"
        case federalTax = "federalTax"
    }
    
    required init(from decoder: Decoder) throws {
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
        cityTax = try values.decodeIfPresent(CityTax.self, forKey: .cityTax)
        countyTax = try values.decodeIfPresent(CountyTax.self, forKey: .countyTax)
        stateTax = try values.decodeIfPresent(StateTax.self, forKey: .stateTax) 
        federalTax = try values.decodeIfPresent(FederalTax.self, forKey: .federalTax)
    }
    
}

class TerminalLocations : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var shopId : String?
    var dirty : Bool?
    var terminalId : String?
    var employeeId : String?
    var timeCardId : String?
    var deviceId : String?
    var name : String?
    var loc : [Int]?
    
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
    
    required init(from decoder: Decoder) throws {
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

class TimeCard : Codable {
    var id : String?
    var created : Int?
    var modified : Int?
    var deleted : Bool?
    var updated : Bool?
    var companyId : String?
    var shopId : String?
    var dirty : Bool?
    var employeeId : String?
    var clockInTime : Int?
    var clockOutTime : Int?
    var clockin : Bool?
    var sessions : [Sessions]?
    
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
    
    required init(from decoder: Decoder) throws {
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
