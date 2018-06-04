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
class ModelLogin : DBModel{
   @objc dynamic var accessToken : String?      = ""
   @objc dynamic var assetAccessToken : String? = ""
   @objc dynamic var employee : ModelEmployee?
   @objc dynamic var loginTime : Int            = 0
   @objc dynamic var expirationTime : Int       = 0
   @objc dynamic var sessionId : String         = ""
   @objc dynamic var company : ModelCompany?         = ModelCompany()
   @objc dynamic var assignedShop : ModelAssignedShop?
   //@objc dynamic var newDevice : Bool           = false
   @objc dynamic var assignedTerminal : ModelAssignedTerminal?
   @objc dynamic var appType : String?          = ""
   @objc dynamic var appTarget : String?        = ""
                 //var shops                      = List<Shops>()
    enum CodingKeys: String, CodingKey {
        
        case accessToken = "accessToken"
        case assetAccessToken = "assetAccessToken"
        //case employee = "employee"
        case loginTime = "loginTime"
        case expirationTime = "expirationTime"
        case sessionId = "sessionId"
        case company = "company"
       // case shops = "shops"
        case assignedShop = "assignedShop"
       // case newDevice = "newDevice"
        case assignedTerminal = "assignedTerminal"
        case appType = "appType"
        case appTarget = "appTarget"
    }
    
    convenience init(accessToken : String?,assetAccessToken : String?,employee : ModelEmployee?,loginTime : Int?,expirationTime : Int?,sessionId : String?,company : ModelCompany?,shops : List<ModelShops>,assignedShop : ModelAssignedShop?,assignedTerminal : ModelAssignedTerminal?,appType : String?,appTarget : String?){
        self.init()
        self.accessToken = accessToken
        self.assetAccessToken = assetAccessToken
       // self.employee = employee ?? Employee()
        self.loginTime = loginTime!
        self.expirationTime = expirationTime!
        self.sessionId = sessionId!
        self.company = company
       // self.shops = shops
        self.assignedShop = assignedShop
        //self.newDevice = newDevice!
        self.assignedTerminal = assignedTerminal
        self.appType = appType
        self.appTarget = appTarget
    }
    
   convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        let assetAccessToken = try values.decodeIfPresent(String.self, forKey: .assetAccessToken)
       // let employee = try values.decodeIfPresent(Employee.self, forKey: .employee)
        let loginTime = try values.decodeIfPresent(Int.self, forKey: .loginTime)
        let expirationTime = try values.decodeIfPresent(Int.self, forKey: .expirationTime)
        let sessionId = try values.decodeIfPresent(String.self, forKey: .sessionId)
        let company = try values.decodeIfPresent(ModelCompany.self, forKey: .company)
        //let shops = try values.decode([Shops].self, forKey: .shops)
        let assignedShop = try values.decodeIfPresent(ModelAssignedShop.self, forKey: .assignedShop)
        //  let newDevice = try values.decodeIfPresent(Bool.self, forKey: .newDevice)
        let assignedTerminal = try values.decodeIfPresent(ModelAssignedTerminal.self, forKey: .assignedTerminal)
            
        let appType = try values.decodeIfPresent(String.self, forKey: .appType)
        let appTarget = try values.decodeIfPresent(String.self, forKey: .appTarget)
        let shopsList = List<ModelShops>()
           // shopsList.append(objectsIn: shops)
    
    
    
    
        self.init(accessToken: accessToken, assetAccessToken: assetAccessToken, employee: nil, loginTime: loginTime, expirationTime: expirationTime, sessionId: sessionId, company: company, shops: shopsList, assignedShop: assignedShop, assignedTerminal: assignedTerminal, appType: appType, appTarget: appTarget)
    
    }
    

    
}

class ModelShops :DBModel {
   @objc dynamic var id : String?
   @objc dynamic var created : Int = 0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var shortIdentifier : String? = ""
   @objc dynamic var name : String? = ""
   @objc dynamic var shopType : String? = ""
   @objc dynamic var address : ModelAddres?
   @objc dynamic var phoneNumber : String? = ""
   @objc dynamic var emailAdress : String? = ""
   @objc dynamic var license : String? = ""
   @objc dynamic var enableDeliveryFee : Bool = false
   @objc dynamic var deliveryFee : Int = 0
   @objc dynamic var taxOrder : String? = ""
   @objc dynamic var taxInfo : TaxInfo?
   @objc dynamic var showWalkInQueue : Bool = false
   @objc dynamic var showDeliveryQueue : Bool = false
   @objc dynamic var showOnlineQueue : Bool = false
   @objc dynamic var enableCashInOut : Bool = false
   @objc dynamic var timeZone : String? = ""
   @objc dynamic var latitude : Int = 0
   @objc dynamic var longitude : Int = 0
   @objc dynamic var active : Bool = false
   @objc dynamic var snapshopTime : Int = 0
   @objc dynamic var defaultCountry : String? = ""
  // @objc dynamic var onlineStoreInfo : OnlineStoreInfo?
                 var deliveryFees = List<ModelDeliveryFees>()
   @objc dynamic var enableSaleLogout : Bool = false
                 var assets = List<ModelAsset>()
   @objc dynamic var enableBCCReceipt : Bool = false
   @objc dynamic var bccEmailAddress : String? = ""
   @objc dynamic var enableGPSTracking : Bool = false
   @objc dynamic var receivingInventoryId : String? = ""
   @objc dynamic var defaultPinTimeout : Int = 0
   @objc dynamic var showSpecialQueue : Bool = false
                 var emailList = List<String>()
   @objc dynamic var enableLowInventoryEmail : Bool = false
   @objc dynamic var restrictedViews : Bool = false
   @objc dynamic var emailMessage : String? = ""
   @objc dynamic var taxRoundOffType : String? = ""
   @objc dynamic var enforceCashDrawers : Bool = false
   @objc dynamic var useAssignedEmployee : Bool = false
   @objc dynamic var showProductByAvailableQuantity : Bool = false
   @objc dynamic var autoCashDrawer : Bool = false
   @objc dynamic var numAllowActiveTrans : Int = 0
   @objc dynamic var requireValidRecDate : Bool = false
   @objc dynamic var enableDeliverySignature : Bool = false
   @objc dynamic var restrictIncomingOrderNotifications : Bool = false
                 var restrictedNotificationTerminals = List<String>()
   @objc dynamic var roundOffType : String? = ""
   @objc dynamic var roundUpMessage : String? = ""
   @objc dynamic var shopEntityType : String? = ""
   @objc dynamic var membersCountSyncDate : Int = 0
   @objc dynamic var enableCannabisLimit : Bool = false
   @objc dynamic var useComplexTax : Bool = false
                 var taxTables = List<ModelTaxTables>()
   @objc dynamic var enableExciseTax : Bool = false
   @objc dynamic var exciseTaxType : String? = ""
                 var marketingSources = List<String>()
                 var productsTag = List<String>()
   @objc dynamic var logo : ModelLogo?
   @objc dynamic var hubId : String? = ""
   @objc dynamic var hubName : String? = ""
   @objc dynamic var enableOnFleet : Bool = false
   @objc dynamic var onFleetApiKey : String? = ""
   @objc dynamic var onFleetOrganizationId : String? = ""
   @objc dynamic var onFleetOrganizationName : String? = ""
   @objc dynamic var emailAttachment : ModelEmailAttachment?
                 //var receiptInfo = List<ReceiptInfo>()
   @objc dynamic var enablePinForCashDrawer : Bool = false
   @objc dynamic var checkoutType : String? = ""
   @objc dynamic var enableMetrc : Bool = false
   @objc dynamic var enableDeliveryMessaging : Bool = false
   @objc dynamic var exciseTaxInfo : ModelExciseTaxInfo?
   @objc dynamic var timezoneOffsetInMinutes : Int = 0
   @objc dynamic var defaultPinTimeoutDuration : Int = 0
    
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
        //case onlineStoreInfo = "onlineStoreInfo"
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
        //case receiptInfo = "receiptInfo"
        case enablePinForCashDrawer = "enablePinForCashDrawer"
        case checkoutType = "checkoutType"
        case enableMetrc = "enableMetrc"
        case enableDeliveryMessaging = "enableDeliveryMessaging"
        case exciseTaxInfo = "exciseTaxInfo"
        case timezoneOffsetInMinutes = "timezoneOffsetInMinutes"
        case defaultPinTimeoutDuration = "defaultPinTimeoutDuration"
    }
    
    convenience init(id : String?,created : Int, modified : Int,deleted : Bool,updated : Bool,companyId : String?,shortIdentifier : String?,name : String?,shopType : String?,address : ModelAddres?,phoneNumber : String?,emailAdress : String?,license : String?,enableDeliveryFee : Bool,deliveryFee : Int,taxOrder : String?,taxInfo : TaxInfo?, showWalkInQueue : Bool,showDeliveryQueue : Bool,showOnlineQueue : Bool,enableCashInOut : Bool,timeZone : String?,latitude : Int,longitude : Int,active : Bool,snapshopTime : Int,defaultCountry : String?,deliveryFees : List<ModelDeliveryFees>,enableSaleLogout : Bool,assets : List<ModelAsset>,enableBCCReceipt : Bool ,bccEmailAddress : String?,enableGPSTracking : Bool,receivingInventoryId : String?,defaultPinTimeout : Int,showSpecialQueue : Bool,emailList : List<String>,enableLowInventoryEmail : Bool,restrictedViews : Bool,emailMessage : String?,taxRoundOffType : String?,enforceCashDrawers : Bool,useAssignedEmployee : Bool,showProductByAvailableQuantity : Bool,autoCashDrawer : Bool,numAllowActiveTrans : Int,requireValidRecDate : Bool,enableDeliverySignature : Bool,restrictIncomingOrderNotifications : Bool,restrictedNotificationTerminals : List<String>,roundOffType : String?,roundUpMessage : String?,shopEntityType : String?,membersCountSyncDate : Int ,enableCannabisLimit : Bool,useComplexTax : Bool,taxTables : List<ModelTaxTables>,enableExciseTax : Bool,exciseTaxType : String?,marketingSources : List<String>,productsTag : List<String>,logo : ModelLogo?,hubId : String?,hubName : String?,enableOnFleet : Bool,onFleetApiKey : String?,onFleetOrganizationId : String?,onFleetOrganizationName : String?,emailAttachment : ModelEmailAttachment?,enablePinForCashDrawer : Bool,checkoutType : String?,enableMetrc : Bool,enableDeliveryMessaging : Bool,exciseTaxInfo : ModelExciseTaxInfo?,timezoneOffsetInMinutes : Int,defaultPinTimeoutDuration : Int){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.shortIdentifier = shortIdentifier
        self.name = name
        self.shopType = shopType
        self.address = address
        self.phoneNumber = phoneNumber
        self.emailAdress = emailAdress
        self.license = license
        self.enableDeliveryFee = enableDeliveryFee
        self.deliveryFee = deliveryFee
        self.taxOrder = taxOrder
        self.taxInfo = taxInfo
        self.showWalkInQueue = showWalkInQueue
        self.showDeliveryQueue = showDeliveryQueue
        self.showOnlineQueue = showOnlineQueue
        self.enableCashInOut = enableCashInOut
        self.timeZone = timeZone
        self.latitude = latitude
        self.longitude = longitude
        self.active = active
        self.snapshopTime = snapshopTime
        self.defaultCountry = defaultCountry
       // self.onlineStoreInfo = onlineStoreInfo
        self.deliveryFees = deliveryFees
        self.enableSaleLogout = enableSaleLogout
        self.assets = assets
        self.enableBCCReceipt = enableBCCReceipt
        self.bccEmailAddress = bccEmailAddress
        self.enableGPSTracking = enableGPSTracking
        self.receivingInventoryId = receivingInventoryId
        self.defaultPinTimeout = defaultPinTimeout
        self.showSpecialQueue = showSpecialQueue
        self.emailList = emailList
        self.enableLowInventoryEmail = enableLowInventoryEmail
        self.restrictedViews = restrictedViews
        self.emailMessage = emailMessage
        self.taxRoundOffType = taxRoundOffType
        self.enforceCashDrawers = enforceCashDrawers
        self.useAssignedEmployee = useAssignedEmployee
        self.showProductByAvailableQuantity = showProductByAvailableQuantity
        self.autoCashDrawer = autoCashDrawer
        self.numAllowActiveTrans = numAllowActiveTrans
        self.requireValidRecDate = requireValidRecDate
        self.enableDeliverySignature = enableDeliverySignature
        self.restrictIncomingOrderNotifications = restrictIncomingOrderNotifications
        self.roundOffType = roundOffType
        self.roundUpMessage = roundUpMessage
        self.shopEntityType = shopEntityType
        self.membersCountSyncDate = membersCountSyncDate
        self.enableCannabisLimit = enableCannabisLimit
        self.useComplexTax = useComplexTax
        self.taxTables = taxTables
        self.enableExciseTax = enableExciseTax
        self.exciseTaxType = exciseTaxType
        self.marketingSources = marketingSources
        self.productsTag = productsTag
        self.logo = logo
        self.hubId = hubId
        self.hubName = hubName
        self.enableOnFleet = enableOnFleet
        self.onFleetApiKey = onFleetApiKey
        self.onFleetOrganizationId = onFleetOrganizationId
        self.onFleetOrganizationName = onFleetOrganizationName
        self.emailAttachment = emailAttachment
       // self.receiptInfo = receiptInfo
        self.enablePinForCashDrawer = enablePinForCashDrawer
        self.checkoutType = checkoutType
        self.enableMetrc = enableMetrc
        self.enableDeliveryMessaging = enableDeliveryMessaging
        self.exciseTaxInfo = exciseTaxInfo
        self.timezoneOffsetInMinutes = timezoneOffsetInMinutes
        self.defaultPinTimeoutDuration = defaultPinTimeoutDuration
        
    }
   convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decodeIfPresent(String.self, forKey: .id)
        let created = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        let shortIdentifier = try values.decodeIfPresent(String.self, forKey: .shortIdentifier)
        let name = try values.decodeIfPresent(String.self, forKey: .name)
        let shopType = try values.decodeIfPresent(String.self, forKey: .shopType)
        let address = try values.decodeIfPresent(ModelAddres.self, forKey: .address)
        let phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        let emailAdress = try values.decodeIfPresent(String.self, forKey: .emailAdress)
        let license = try values.decodeIfPresent(String.self, forKey: .license)
        let enableDeliveryFee = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryFee)
        let deliveryFee = try values.decodeIfPresent(Int.self, forKey: .deliveryFee)
        let taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
        let taxInfo = try values.decodeIfPresent(TaxInfo.self, forKey: .taxInfo)
        let showWalkInQueue = try values.decodeIfPresent(Bool.self, forKey: .showWalkInQueue)
        let showDeliveryQueue = try values.decodeIfPresent(Bool.self, forKey: .showDeliveryQueue)
        let showOnlineQueue = try values.decodeIfPresent(Bool.self, forKey: .showOnlineQueue)
        let enableCashInOut = try values.decodeIfPresent(Bool.self, forKey: .enableCashInOut)
        let timeZone = try values.decodeIfPresent(String.self, forKey: .timeZone)
        let latitude = try values.decodeIfPresent(Int.self, forKey: .latitude)
        let longitude = try values.decodeIfPresent(Int.self, forKey: .longitude)
        let active = try values.decodeIfPresent(Bool.self, forKey: .active)
        let snapshopTime = try values.decodeIfPresent(Int.self, forKey: .snapshopTime)
        let defaultCountry = try values.decodeIfPresent(String.self, forKey: .defaultCountry)
       // let onlineStoreInfo = try values.decodeIfPresent(OnlineStoreInfo.self, forKey: .onlineStoreInfo)
        let deliveryFees = try values.decode([ModelDeliveryFees].self, forKey: .deliveryFees)
        let enableSaleLogout = try values.decodeIfPresent(Bool.self, forKey: .enableSaleLogout)
        let assets = try values.decode([ModelAsset].self, forKey: .assets)
        let enableBCCReceipt = try values.decodeIfPresent(Bool.self, forKey: .enableBCCReceipt)
        let bccEmailAddress = try values.decodeIfPresent(String.self, forKey: .bccEmailAddress)
        let enableGPSTracking = try values.decodeIfPresent(Bool.self, forKey: .enableGPSTracking)
        let receivingInventoryId = try values.decodeIfPresent(String.self, forKey: .receivingInventoryId)
        let defaultPinTimeout = try values.decodeIfPresent(Int.self, forKey: .defaultPinTimeout)
        let showSpecialQueue = try values.decodeIfPresent(Bool.self, forKey: .showSpecialQueue)
        let emailList = try values.decode([String].self, forKey: .emailList)
        let enableLowInventoryEmail = try values.decodeIfPresent(Bool.self, forKey: .enableLowInventoryEmail)
        let restrictedViews = try values.decodeIfPresent(Bool.self, forKey: .restrictedViews)
        let emailMessage = try values.decodeIfPresent(String.self, forKey: .emailMessage)
        let taxRoundOffType = try values.decodeIfPresent(String.self, forKey: .taxRoundOffType)
        let enforceCashDrawers = try values.decodeIfPresent(Bool.self, forKey: .enforceCashDrawers)
        let useAssignedEmployee = try values.decodeIfPresent(Bool.self, forKey: .useAssignedEmployee)
        let showProductByAvailableQuantity = try values.decodeIfPresent(Bool.self, forKey: .showProductByAvailableQuantity)
        let autoCashDrawer = try values.decodeIfPresent(Bool.self, forKey: .autoCashDrawer)
        let numAllowActiveTrans = try values.decodeIfPresent(Int.self, forKey: .numAllowActiveTrans)
        let requireValidRecDate = try values.decodeIfPresent(Bool.self, forKey: .requireValidRecDate)
        let enableDeliverySignature = try values.decodeIfPresent(Bool.self, forKey: .enableDeliverySignature)
        let restrictIncomingOrderNotifications = try values.decodeIfPresent(Bool.self, forKey: .restrictIncomingOrderNotifications)
        let restrictedNotificationTerminals = try values.decode([String].self, forKey: .restrictedNotificationTerminals)
        let roundOffType = try values.decodeIfPresent(String.self, forKey: .roundOffType)
        let roundUpMessage = try values.decodeIfPresent(String.self, forKey: .roundUpMessage)
        let shopEntityType = try values.decodeIfPresent(String.self, forKey: .shopEntityType)
        let membersCountSyncDate = try values.decodeIfPresent(Int.self, forKey: .membersCountSyncDate)
        let enableCannabisLimit = try values.decodeIfPresent(Bool.self, forKey: .enableCannabisLimit)
        let useComplexTax = try values.decodeIfPresent(Bool.self, forKey: .useComplexTax)
        let taxTables = try values.decode([ModelTaxTables].self, forKey: .taxTables)
        let enableExciseTax = try values.decodeIfPresent(Bool.self, forKey: .enableExciseTax)
        let exciseTaxType = try values.decodeIfPresent(String.self, forKey: .exciseTaxType)
        let marketingSources = try values.decode([String].self, forKey: .marketingSources)
        let productsTag = try values.decode([String].self, forKey: .productsTag)
        let logo = try values.decodeIfPresent(ModelLogo.self, forKey: .logo)
        let hubId = try values.decodeIfPresent(String.self, forKey: .hubId)
        let hubName = try values.decodeIfPresent(String.self, forKey: .hubName)
        let enableOnFleet = try values.decodeIfPresent(Bool.self, forKey: .enableOnFleet)
        let onFleetApiKey = try values.decodeIfPresent(String.self, forKey: .onFleetApiKey)
        let onFleetOrganizationId = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationId)
        let onFleetOrganizationName = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationName)
        let emailAttachment = try values.decodeIfPresent(ModelEmailAttachment.self, forKey: .emailAttachment)
        //let receiptInfo = try values.decode([ReceiptInfo].self, forKey: .receiptInfo)
        let enablePinForCashDrawer = try values.decodeIfPresent(Bool.self, forKey: .enablePinForCashDrawer)
        let checkoutType = try values.decodeIfPresent(String.self, forKey: .checkoutType)
        let enableMetrc = try values.decodeIfPresent(Bool.self, forKey: .enableMetrc)
        let enableDeliveryMessaging = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryMessaging)
        let exciseTaxInfo = try values.decodeIfPresent(ModelExciseTaxInfo.self, forKey: .exciseTaxInfo)
        let timezoneOffsetInMinutes = try values.decodeIfPresent(Int.self, forKey: .timezoneOffsetInMinutes)
        let defaultPinTimeoutDuration = try values.decodeIfPresent(Int.self, forKey: .defaultPinTimeoutDuration)
        let assetsList = List<ModelAsset>()
        let emailListList = List<String>()
        let taxTablesList = List<ModelTaxTables>()
        let marketingSourcesList = List<String>()
        let productsTagList = List<String>()
        let deliveryFeesList = List<ModelDeliveryFees>()
        let restrictedNotificationTerminalsList = List<String>()
        let receiptInfoList = List<ModelReceiptInfo>()
            assetsList.append(objectsIn: assets)
            emailListList.append(objectsIn: emailList)
            taxTablesList.append(objectsIn: taxTables)
            marketingSourcesList.append(objectsIn: marketingSources)
            productsTagList.append(objectsIn: productsTag)
            deliveryFeesList.append(objectsIn: deliveryFees)
            restrictedNotificationTerminalsList.append(objectsIn: restrictedNotificationTerminals)
            //receiptInfoList.append(objectsIn: receiptInfo)





    
    
    self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, shortIdentifier: shortIdentifier, name: name, shopType: shopType, address: address, phoneNumber: phoneNumber, emailAdress: emailAdress, license: license, enableDeliveryFee: enableDeliveryFee!, deliveryFee: deliveryFee!, taxOrder: taxOrder, taxInfo: taxInfo, showWalkInQueue: showWalkInQueue!, showDeliveryQueue: showDeliveryQueue!, showOnlineQueue: showOnlineQueue!, enableCashInOut: enableCashInOut!, timeZone: timeZone, latitude: latitude!, longitude: longitude!, active: active!, snapshopTime: snapshopTime!, defaultCountry: defaultCountry, deliveryFees: deliveryFeesList, enableSaleLogout: enableSaleLogout!, assets: assetsList, enableBCCReceipt: enableBCCReceipt!, bccEmailAddress: bccEmailAddress, enableGPSTracking: enableGPSTracking!, receivingInventoryId: receivingInventoryId, defaultPinTimeout: defaultPinTimeout!, showSpecialQueue: showSpecialQueue!, emailList: emailListList, enableLowInventoryEmail: enableLowInventoryEmail!, restrictedViews: restrictedViews!, emailMessage: emailMessage, taxRoundOffType: taxRoundOffType, enforceCashDrawers: enforceCashDrawers!, useAssignedEmployee: useAssignedEmployee!, showProductByAvailableQuantity: showProductByAvailableQuantity!, autoCashDrawer: autoCashDrawer!, numAllowActiveTrans: numAllowActiveTrans!, requireValidRecDate: requireValidRecDate!, enableDeliverySignature: enableDeliverySignature!, restrictIncomingOrderNotifications: restrictIncomingOrderNotifications!, restrictedNotificationTerminals: restrictedNotificationTerminalsList, roundOffType: roundOffType, roundUpMessage: roundUpMessage, shopEntityType: shopEntityType, membersCountSyncDate: membersCountSyncDate!, enableCannabisLimit: enableCannabisLimit!, useComplexTax: useComplexTax!, taxTables: taxTablesList, enableExciseTax: enableExciseTax!, exciseTaxType: exciseTaxType, marketingSources: marketingSourcesList, productsTag: productsTagList, logo: logo, hubId: hubId, hubName: hubName, enableOnFleet: enableOnFleet!, onFleetApiKey: onFleetApiKey, onFleetOrganizationId: onFleetOrganizationId, onFleetOrganizationName: onFleetOrganizationName, emailAttachment: emailAttachment,  enablePinForCashDrawer: enablePinForCashDrawer!, checkoutType: checkoutType, enableMetrc: enableMetrc!, enableDeliveryMessaging: enableDeliveryMessaging!, exciseTaxInfo: exciseTaxInfo!, timezoneOffsetInMinutes: timezoneOffsetInMinutes!, defaultPinTimeoutDuration: defaultPinTimeoutDuration!)
    }
    
}


class ModelAddres: DBModel{
   @objc dynamic var id : String?        = " "
   @objc dynamic var  created : Int      = 0
   @objc dynamic var modified : Int      = 0
   @objc dynamic var deleted : Bool      = false
   @objc dynamic var updated : Bool      = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var address : String?   = ""
   @objc dynamic var city : String?      = ""
   @objc dynamic var state : String?     = " "
   @objc dynamic var zipCode : String?   = ""
   @objc dynamic var country : String?   = " "
    
    convenience init(id : String? = nil,created : Int?,modified : Int?,deleted : Bool?,updated : Bool?,companyId : String?,address : String?,city : String?,state : String?,zipCode : String?,country : String?){
        self.init()
        self.id = id
        self.created = created!
        self.modified = modified!
        self.deleted = deleted!
        self.updated = updated!
        self.companyId = companyId
        self.address = address
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.country = country
    }
    
    
    enum CodingKeys: String, CodingKey {

        case id        = "id"
        case created   = "created"
        case modified  = "modified"
        case deleted   = "deleted"
        case updated   = "updated"
        case companyId = "companyId"
        case address   = "address"
        case city      = "city"
        case state     = "state"
        case zipCode   = "zipCode"
        case country   = "country"
    }

   convenience required init(from decoder: Decoder) throws {
        let values    = try decoder.container(keyedBy: CodingKeys.self)
        let id        = try values.decodeIfPresent(String.self, forKey: .id)
        let created   = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified  = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted   = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated   = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        let address   = try values.decodeIfPresent(String.self, forKey: .address)
        let city      = try values.decodeIfPresent(String.self, forKey: .city)
        let state     = try values.decodeIfPresent(String.self, forKey: .state)
        let zipCode   = try values.decodeIfPresent(String.self, forKey: .zipCode)
        let country   = try values.decodeIfPresent(String.self, forKey: .country)
    
        self.init(id: id, created: created, modified: modified, deleted: deleted, updated: updated, companyId: companyId, address: address, city: city, state: state, zipCode: zipCode, country: country)
      
    }
    
}

class ModelAsset : DBModel {
   @objc dynamic  var id : String?       = ""
   @objc dynamic var created : Int       = 0
   @objc dynamic var modified : Int      = 0
   @objc dynamic var deleted : Bool      = false
   @objc dynamic var updated : Bool      = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var name : String?      = ""
   @objc dynamic var key : String?       = ""
   @objc dynamic var type : String?      = ""
   @objc dynamic var publicURL : String? = ""
   @objc dynamic var active : Bool       = false
   @objc dynamic var priority : Int      = 0
   @objc dynamic var secured : Bool      = false
   @objc dynamic var thumbURL : String?  = ""
   @objc dynamic var mediumURL : String? = ""
   @objc dynamic var largeURL : String?  = ""
   @objc dynamic var assetType : String? = ""
    
    enum CodingKeys: String, CodingKey {
        
        case id        = "id"
        case created   = "created"
        case modified  = "modified"
        case deleted   = "deleted"
        case updated   = "updated"
        case companyId = "companyId"
        case name      = "name"
        case key       = "key"
        case type      = "type"
        case publicURL = "publicURL"
        case active    = "active"
        case priority  = "priority"
        case secured   = "secured"
        case thumbURL  = "thumbURL"
        case mediumURL = "mediumURL"
        case largeURL  = "largeURL"
        case assetType = "assetType"
    }
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,name : String?,key : String?,type : String?,publicURL : String?,active : Bool,priority : Int,secured : Bool,thumbURL : String?,mediumURL : String?,largeURL : String?,assetType : String?){
        self.init()
        self.id        = id
        self.created   = created
        self.modified  = modified
        self.deleted   = deleted
        self.updated   = updated
        self.companyId = companyId
        self.name      = name
        self.key       = key
        self.type      = type
        self.publicURL = publicURL
        self.active    = active
        self.priority  = priority
        self.secured   = secured
        self.thumbURL  = thumbURL
        self.mediumURL = mediumURL
        self.largeURL  = largeURL
        self.assetType = assetType
        
    }
    
   convenience required init(from decoder: Decoder) throws {
        let values    = try decoder.container(keyedBy: CodingKeys.self)
        let id        = try values.decodeIfPresent(String.self, forKey: .id)
        let created   = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified  = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted   = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated   = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        let name      = try values.decodeIfPresent(String.self, forKey: .name)
        let key       = try values.decodeIfPresent(String.self, forKey: .key)
        let type      = try values.decodeIfPresent(String.self, forKey: .type)
        let publicURL = try values.decodeIfPresent(String.self, forKey: .publicURL)
        let active    = try values.decodeIfPresent(Bool.self, forKey: .active)
        let priority  = try values.decodeIfPresent(Int.self, forKey: .priority)
        let secured   = try values.decodeIfPresent(Bool.self, forKey: .secured)
        let thumbURL  = try values.decodeIfPresent(String.self, forKey: .thumbURL)
        let mediumURL = try values.decodeIfPresent(String.self, forKey: .mediumURL)
        let largeURL  = try values.decodeIfPresent(String.self, forKey: .largeURL)
        let assetType = try values.decodeIfPresent(String.self, forKey: .assetType)
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, name: name, key: key, type: type, publicURL: publicURL, active: active!, priority: priority!, secured: secured!, thumbURL: thumbURL, mediumURL: mediumURL, largeURL: largeURL, assetType: assetType)
    }
    
}

class ModelAssignedShop :DBModel {
   @objc dynamic  var id : String?                              = ""
   @objc dynamic  var created : Int                             = 0
   @objc dynamic  var modified : Int                            = 0
   @objc dynamic  var deleted : Bool                            = false
   @objc dynamic  var updated : Bool                            = false
   @objc dynamic  var companyId : String?                       = ""
   @objc dynamic  var shortIdentifier : String?                 = ""
   @objc dynamic  var name : String?                            = ""
   @objc dynamic  var shopType : String?                        = ""
   @objc dynamic  var address : ModelAddres?
   @objc dynamic  var phoneNumber : String?                     = ""
   @objc dynamic  var emailAdress : String?                     = ""
   @objc dynamic  var license : String?                         = ""
   @objc dynamic  var enableDeliveryFee : Bool                  = false
   @objc dynamic  var deliveryFee : Int                         = 0
   @objc dynamic  var taxOrder : String?                        = ""
   @objc dynamic  var taxInfo : TaxInfo?
   @objc dynamic  var showWalkInQueue : Bool                    = false
   @objc dynamic  var showDeliveryQueue : Bool                  = false
   @objc dynamic  var showOnlineQueue : Bool                    = false
   @objc dynamic  var enableCashInOut : Bool                    = false
   @objc dynamic  var timeZone : String?                        = ""
   @objc dynamic  var latitude : Double                         = 0.0
   @objc dynamic  var longitude : Double                        = 0.0
   @objc dynamic  var active : Bool                             = false
   @objc dynamic  var snapshopTime : Int                        = 0
   @objc dynamic  var defaultCountry : String?                  = ""
   @objc dynamic  var onlineStoreInfo : ModelOnlineStoreInfo?
                  var deliveryFees  = List<ModelDeliveryFees>()
   @objc dynamic  var enableSaleLogout : Bool                   = false
                  var assets = List<ModelAsset>()
   @objc dynamic  var enableBCCReceipt : Bool                   = false
   @objc dynamic  var bccEmailAddress : String?                 = ""
   @objc dynamic  var enableGPSTracking : Bool                  = false
   @objc dynamic  var receivingInventoryId : String?            = ""
   @objc dynamic  var defaultPinTimeout : Int                   = 0
   @objc dynamic  var showSpecialQueue : Bool                   = false
                  var emailList = List<String>()
   @objc dynamic  var enableLowInventoryEmail : Bool            = false
   @objc dynamic  var restrictedViews : Bool                    = false
   @objc dynamic  var emailMessage : String?                    = ""
   @objc dynamic  var taxRoundOffType : String?                 = ""
   @objc dynamic  var enforceCashDrawers : Bool                 = false
   @objc dynamic  var useAssignedEmployee : Bool                = false
   @objc dynamic  var showProductByAvailableQuantity : Bool     = false
   @objc dynamic  var autoCashDrawer : Bool                     = false
   @objc dynamic  var numAllowActiveTrans : Int                 = 0
   @objc dynamic  var requireValidRecDate : Bool                = false
   @objc dynamic  var enableDeliverySignature : Bool            = false
   @objc dynamic  var restrictIncomingOrderNotifications : Bool = false
                  var restrictedNotificationTerminals = List<String>()
   @objc dynamic  var roundOffType : String?                    = ""
   @objc dynamic  var roundUpMessage : String?                  = ""
   @objc dynamic  var shopEntityType : String?                  = ""
   @objc dynamic  var membersCountSyncDate : Int                = 0
   @objc dynamic  var enableCannabisLimit : Bool                = false
   @objc dynamic  var useComplexTax : Bool                      = false
                  var taxTables = List<ModelTaxTables>()
   @objc dynamic  var enableExciseTax : Bool                    = false
   @objc dynamic  var exciseTaxType : String?                   = ""
                  var marketingSources = List<String>()
                  var productsTag = List<String>()
   @objc dynamic  var logo : ModelLogo?
   @objc dynamic  var hubId : String?                           = ""
   @objc dynamic  var hubName : String?                         = ""
   @objc dynamic  var enableOnFleet : Bool                      = false
   @objc dynamic  var onFleetApiKey : String?                   = ""
   @objc dynamic  var onFleetOrganizationId : String?           = ""
   @objc dynamic  var onFleetOrganizationName : String?         = ""
   @objc dynamic  var emailAttachment : ModelEmailAttachment?
                  //var receiptInfo = List<ReceiptInfo>()
   @objc dynamic  var enablePinForCashDrawer : Bool             = false
   @objc dynamic  var checkoutType : String?                    = ""
   @objc dynamic  var enableMetrc : Bool                        = false
   @objc dynamic  var enableDeliveryMessaging : Bool            = false
   @objc dynamic  var exciseTaxInfo : ModelExciseTaxInfo?
   @objc dynamic  var timezoneOffsetInMinutes : Int             = 0
   @objc dynamic  var defaultPinTimeoutDuration : Int           = 0
    
    enum CodingKeys: String, CodingKey {
        
        case id                                 = "id"
        case created                            = "created"
        case modified                           = "modified"
        case deleted                            = "deleted"
        case updated                            = "updated"
        case companyId                          = "companyId"
        case shortIdentifier                    = "shortIdentifier"
        case name                               = "name"
        case shopType                           = "shopType"
        case address                            = "address"
        case phoneNumber                        = "phoneNumber"
        case emailAdress                        = "emailAdress"
        case license                            = "license"
        case enableDeliveryFee                  = "enableDeliveryFee"
        case deliveryFee                        = "deliveryFee"
        case taxOrder                           = "taxOrder"
        case taxInfo                            = "taxInfo"
        case showWalkInQueue                    = "showWalkInQueue"
        case showDeliveryQueue                  = "showDeliveryQueue"
        case showOnlineQueue                    = "showOnlineQueue"
        case enableCashInOut                    = "enableCashInOut"
        case timeZone                           = "timeZone"
        case latitude                           = "latitude"
        case longitude                          = "longitude"
        case active                             = "active"
        case snapshopTime                       = "snapshopTime"
        case defaultCountry                     = "defaultCountry"
        case onlineStoreInfo                    = "onlineStoreInfo"
        case deliveryFees                       = "deliveryFees"
        case enableSaleLogout                   = "enableSaleLogout"
        case assets                             = "assets"
        case enableBCCReceipt                   = "enableBCCReceipt"
        case bccEmailAddress                    = "bccEmailAddress"
        case enableGPSTracking                  = "enableGPSTracking"
        case receivingInventoryId               = "receivingInventoryId"
        case defaultPinTimeout                  = "defaultPinTimeout"
        case showSpecialQueue                   = "showSpecialQueue"
        case emailList                          = "emailList"
        case enableLowInventoryEmail            = "enableLowInventoryEmail"
        case restrictedViews                    = "restrictedViews"
        case emailMessage                       = "emailMessage"
        case taxRoundOffType                    = "taxRoundOffType"
        case enforceCashDrawers                 = "enforceCashDrawers"
        case useAssignedEmployee                = "useAssignedEmployee"
        case showProductByAvailableQuantity     = "showProductByAvailableQuantity"
        case autoCashDrawer                     = "autoCashDrawer"
        case numAllowActiveTrans                = "numAllowActiveTrans"
        case requireValidRecDate                = "requireValidRecDate"
        case enableDeliverySignature            = "enableDeliverySignature"
        case restrictIncomingOrderNotifications = "restrictIncomingOrderNotifications"
        case restrictedNotificationTerminals    = "restrictedNotificationTerminals"
        case roundOffType                       = "roundOffType"
        case roundUpMessage                     = "roundUpMessage"
        case shopEntityType                     = "shopEntityType"
        case membersCountSyncDate               = "membersCountSyncDate"
        case enableCannabisLimit                = "enableCannabisLimit"
        case useComplexTax                      = "useComplexTax"
        case taxTables                          = "taxTables"
        case enableExciseTax                    = "enableExciseTax"
        case exciseTaxType                      = "exciseTaxType"
        case marketingSources                   = "marketingSources"
        case productsTag                        = "productsTag"
        case logo                               = "logo"
        case hubId                              = "hubId"
        case hubName                            = "hubName"
        case enableOnFleet                      = "enableOnFleet"
        case onFleetApiKey                      = "onFleetApiKey"
        case onFleetOrganizationId              = "onFleetOrganizationId"
        case onFleetOrganizationName            = "onFleetOrganizationName"
        case emailAttachment                    = "emailAttachment"
        //case receiptInfo                        = "receiptInfo"
        case enablePinForCashDrawer             = "enablePinForCashDrawer"
        case checkoutType                       = "checkoutType"
        case enableMetrc                        = "enableMetrc"
        case enableDeliveryMessaging            = "enableDeliveryMessaging"
        case exciseTaxInfo                      = "exciseTaxInfo"
        case timezoneOffsetInMinutes            = "timezoneOffsetInMinutes"
        case defaultPinTimeoutDuration          = "defaultPinTimeoutDuration"
    }
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,shortIdentifier : String?,name : String?,shopType : String?,address : ModelAddres?,phoneNumber : String?,emailAdress : String?,license : String?,enableDeliveryFee : Bool,deliveryFee : Int,taxOrder : String?,taxInfo : TaxInfo?,showWalkInQueue : Bool,showDeliveryQueue : Bool,showOnlineQueue : Bool,enableCashInOut : Bool,timeZone : String?,latitude : Double,longitude : Double,active : Bool,snapshopTime : Int,defaultCountry : String?,onlineStoreInfo : ModelOnlineStoreInfo?,deliveryFees : List<ModelDeliveryFees>,enableSaleLogout : Bool,assets : List<ModelAsset>,enableBCCReceipt : Bool,bccEmailAddress : String?,enableGPSTracking : Bool,receivingInventoryId : String?,defaultPinTimeout : Int,showSpecialQueue : Bool,emailList : List<String>,enableLowInventoryEmail : Bool,restrictedViews : Bool,emailMessage : String?,taxRoundOffType : String?, enforceCashDrawers : Bool,useAssignedEmployee : Bool,showProductByAvailableQuantity : Bool,autoCashDrawer : Bool,numAllowActiveTrans : Int,requireValidRecDate : Bool,enableDeliverySignature : Bool,restrictIncomingOrderNotifications : Bool,restrictedNotificationTerminals : List<String>,roundOffType : String?,roundUpMessage : String?,shopEntityType : String?,membersCountSyncDate : Int,enableCannabisLimit : Bool,useComplexTax : Bool,taxTables : List<ModelTaxTables>,enableExciseTax : Bool,exciseTaxType : String?,marketingSources : List<String>,productsTag : List<String>,logo : ModelLogo?,hubId : String?,hubName : String?,enableOnFleet : Bool,onFleetApiKey : String?,onFleetOrganizationId : String?,onFleetOrganizationName : String?,emailAttachment : ModelEmailAttachment?,enablePinForCashDrawer : Bool,checkoutType : String?,enableMetrc : Bool,enableDeliveryMessaging : Bool,exciseTaxInfo : ModelExciseTaxInfo?,timezoneOffsetInMinutes : Int,defaultPinTimeoutDuration : Int){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted  = deleted
        self.updated = updated
        self.companyId = companyId
        self.shortIdentifier = shortIdentifier
        self.name = name
        self.shopType = shopType
        self.address = address
        self.phoneNumber = phoneNumber
        self.emailAdress = emailAdress
        self.license = license
        self.enableDeliveryFee = enableDeliveryFee
        self.deliveryFee = deliveryFee
        self.taxOrder = taxOrder
        self.taxInfo = taxInfo
        self.showWalkInQueue = showWalkInQueue
        self.showDeliveryQueue = showDeliveryQueue
        self.showOnlineQueue = showOnlineQueue
        self.enableCashInOut = enableCashInOut
        self.timeZone = timeZone
        self.latitude = latitude
        self.longitude = longitude
        self.active = active
        self.snapshopTime = snapshopTime
        self.defaultCountry = defaultCountry
        self.onlineStoreInfo = onlineStoreInfo
        self.deliveryFee = deliveryFee
        self.enableSaleLogout = enableSaleLogout
        self.assets = assets
        self.enableBCCReceipt = enableBCCReceipt
        self.bccEmailAddress = bccEmailAddress
        self.enableGPSTracking = enableGPSTracking
        self.receivingInventoryId = receivingInventoryId
        self.defaultPinTimeout = defaultPinTimeout
        self.showSpecialQueue = showSpecialQueue
        self.emailList = emailList
        self.enableLowInventoryEmail = enableLowInventoryEmail
        self.restrictedViews = restrictedViews
        self.emailMessage = emailMessage
        self.taxRoundOffType = taxRoundOffType
        self.enforceCashDrawers = enforceCashDrawers
        self.useAssignedEmployee = useAssignedEmployee
        self.showProductByAvailableQuantity = showProductByAvailableQuantity
        self.autoCashDrawer = autoCashDrawer
        self.numAllowActiveTrans = numAllowActiveTrans
        self.requireValidRecDate = requireValidRecDate
        self.enableDeliverySignature = enableDeliverySignature
        self.restrictIncomingOrderNotifications = restrictIncomingOrderNotifications
        self.restrictedNotificationTerminals = restrictedNotificationTerminals
        self.roundOffType = roundOffType
        self.roundUpMessage = roundUpMessage
        self.shopEntityType = shopEntityType
        self.membersCountSyncDate = membersCountSyncDate
        self.enableCannabisLimit = enableCannabisLimit
        self.useComplexTax = useComplexTax
        self.taxTables = taxTables
        self.enableExciseTax = enableExciseTax
        self.exciseTaxType = exciseTaxType
        self.marketingSources = marketingSources
        self.productsTag = productsTag
        self.logo = logo
        self.hubId = hubId
        self.hubName = hubName
        self.enableOnFleet = enableOnFleet
        self.onFleetApiKey = onFleetApiKey
        self.onFleetOrganizationId = onFleetOrganizationId
        self.onFleetOrganizationName = onFleetOrganizationName
        self.emailAttachment = emailAttachment
       // self.receiptInfo = receiptInfo
        self.enablePinForCashDrawer = enablePinForCashDrawer
        self.checkoutType = checkoutType
        self.enableMetrc = enableMetrc
        self.enableDeliveryMessaging = enableDeliveryMessaging
        self.exciseTaxInfo = exciseTaxInfo
        self.timezoneOffsetInMinutes = timezoneOffsetInMinutes
        self.defaultPinTimeoutDuration = defaultPinTimeoutDuration
        
    }
    
   convenience required init(from decoder: Decoder) throws {
        let values                             = try decoder.container(keyedBy: CodingKeys.self)
        let id                                 = try values.decodeIfPresent(String.self, forKey: .id)
        let created                            = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified                           = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted                            = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated                            = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId                          = try values.decodeIfPresent(String.self, forKey: .companyId)
        let shortIdentifier                    = try values.decodeIfPresent(String.self, forKey: .shortIdentifier)
        let name                               = try values.decodeIfPresent(String.self, forKey: .name)
        let shopType                           = try values.decodeIfPresent(String.self, forKey: .shopType)
        let address                            = try values.decodeIfPresent(ModelAddres.self, forKey: .address)
        let phoneNumber                        = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        let emailAdress                        = try values.decodeIfPresent(String.self, forKey: .emailAdress)
        let license                            = try values.decodeIfPresent(String.self, forKey: .license)
        let enableDeliveryFee                  = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryFee)
        let deliveryFee                        = try values.decodeIfPresent(Int.self, forKey: .deliveryFee)
        let taxOrder                           = try values.decodeIfPresent(String.self, forKey: .taxOrder)
        let taxInfo                            = try values.decodeIfPresent(TaxInfo.self, forKey: .taxInfo)
        let showWalkInQueue                    = try values.decodeIfPresent(Bool.self, forKey: .showWalkInQueue)
        let showDeliveryQueue                  = try values.decodeIfPresent(Bool.self, forKey: .showDeliveryQueue)
        let showOnlineQueue                    = try values.decodeIfPresent(Bool.self, forKey: .showOnlineQueue)
        let enableCashInOut                    = try values.decodeIfPresent(Bool.self, forKey: .enableCashInOut)
        let timeZone                           = try values.decodeIfPresent(String.self, forKey: .timeZone)
        let latitude                           = try values.decodeIfPresent(Double.self, forKey: .latitude)
        let longitude                          = try values.decodeIfPresent(Double.self, forKey: .longitude)
        let active                             = try values.decodeIfPresent(Bool.self, forKey: .active)
        let snapshopTime                       = try values.decodeIfPresent(Int.self, forKey: .snapshopTime)
        let defaultCountry                     = try values.decodeIfPresent(String.self, forKey: .defaultCountry)
        let onlineStoreInfo                    = try values.decodeIfPresent(ModelOnlineStoreInfo.self, forKey: .onlineStoreInfo)
        let deliveryFees                       = try values.decode([ModelDeliveryFees].self, forKey: .deliveryFees)
        let enableSaleLogout                   = try values.decodeIfPresent(Bool.self, forKey: .enableSaleLogout)
        let assets                             = try values.decode([ModelAsset].self, forKey: .assets)
        let enableBCCReceipt                   = try values.decodeIfPresent(Bool.self, forKey: .enableBCCReceipt)
        let bccEmailAddress                    = try values.decodeIfPresent(String.self, forKey: .bccEmailAddress)
        let enableGPSTracking                  = try values.decodeIfPresent(Bool.self, forKey: .enableGPSTracking)
        let receivingInventoryId               = try values.decodeIfPresent(String.self, forKey: .receivingInventoryId)
        let defaultPinTimeout                  = try values.decodeIfPresent(Int.self, forKey: .defaultPinTimeout)
        let showSpecialQueue                   = try values.decodeIfPresent(Bool.self, forKey: .showSpecialQueue)
        let emailList                          = try values.decode([String].self, forKey: .emailList)
        let enableLowInventoryEmail            = try values.decodeIfPresent(Bool.self, forKey: .enableLowInventoryEmail)
        let restrictedViews                    = try values.decodeIfPresent(Bool.self, forKey: .restrictedViews)
        let emailMessage                       = try values.decodeIfPresent(String.self, forKey: .emailMessage)
        let taxRoundOffType                    = try values.decodeIfPresent(String.self, forKey: .taxRoundOffType)
        let enforceCashDrawers                 = try values.decodeIfPresent(Bool.self, forKey: .enforceCashDrawers)
        let useAssignedEmployee                = try values.decodeIfPresent(Bool.self, forKey: .useAssignedEmployee)
        let showProductByAvailableQuantity     = try values.decodeIfPresent(Bool.self, forKey: .showProductByAvailableQuantity)
        let autoCashDrawer                     = try values.decodeIfPresent(Bool.self, forKey: .autoCashDrawer)
        let numAllowActiveTrans                = try values.decodeIfPresent(Int.self, forKey: .numAllowActiveTrans)
        let requireValidRecDate                = try values.decodeIfPresent(Bool.self, forKey: .requireValidRecDate)
        let enableDeliverySignature            = try values.decodeIfPresent(Bool.self, forKey: .enableDeliverySignature)
        let restrictIncomingOrderNotifications = try values.decodeIfPresent(Bool.self, forKey: .restrictIncomingOrderNotifications)
        let restrictedNotificationTerminals    = try values.decode([String].self, forKey: .restrictedNotificationTerminals)
        let roundOffType                       = try values.decodeIfPresent(String.self, forKey: .roundOffType)
        let roundUpMessage                     = try values.decodeIfPresent(String.self, forKey: .roundUpMessage)
        let shopEntityType                     = try values.decodeIfPresent(String.self, forKey: .shopEntityType)
        let membersCountSyncDate               = try values.decodeIfPresent(Int.self, forKey: .membersCountSyncDate)
        let enableCannabisLimit                = try values.decodeIfPresent(Bool.self, forKey: .enableCannabisLimit)
        let useComplexTax                      = try values.decodeIfPresent(Bool.self, forKey: .useComplexTax)
        let taxTables                          = try values.decode([ModelTaxTables].self, forKey: .taxTables)
        let enableExciseTax                    = try values.decodeIfPresent(Bool.self, forKey: .enableExciseTax)
        let exciseTaxType                      = try values.decodeIfPresent(String.self, forKey: .exciseTaxType)
        let marketingSources                   = try values.decode([String].self, forKey: .marketingSources)
        let productsTag                        = try values.decode([String].self, forKey: .productsTag)
        let logo                               = try values.decodeIfPresent(ModelLogo.self, forKey: .logo)
        let hubId                              = try values.decodeIfPresent(String.self, forKey: .hubId)
        let hubName                            = try values.decodeIfPresent(String.self, forKey: .hubName)
        let enableOnFleet                      = try values.decodeIfPresent(Bool.self, forKey: .enableOnFleet)
        let onFleetApiKey                      = try values.decodeIfPresent(String.self, forKey: .onFleetApiKey)
        let onFleetOrganizationId              = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationId)
        let onFleetOrganizationName            = try values.decodeIfPresent(String.self, forKey: .onFleetOrganizationName)
        let emailAttachment                    = try values.decodeIfPresent(ModelEmailAttachment.self, forKey: .emailAttachment)
        //let receiptInfo                        = try values.decode([ReceiptInfo].self, forKey: .receiptInfo)
        let enablePinForCashDrawer             = try values.decodeIfPresent(Bool.self, forKey: .enablePinForCashDrawer)
        let checkoutType                       = try values.decodeIfPresent(String.self, forKey: .checkoutType)
        let enableMetrc                        = try values.decodeIfPresent(Bool.self, forKey: .enableMetrc)
        let enableDeliveryMessaging            = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryMessaging)
        let exciseTaxInfo                      = try values.decodeIfPresent(ModelExciseTaxInfo.self, forKey: .exciseTaxInfo)
        let timezoneOffsetInMinutes            = try values.decodeIfPresent(Int.self, forKey: .timezoneOffsetInMinutes)
        let defaultPinTimeoutDuration          = try values.decodeIfPresent(Int.self, forKey: .defaultPinTimeoutDuration)
    
        let assetsList = List<ModelAsset>()
        let emailListList = List<String>()
        let taxTablesList = List<ModelTaxTables>()
        let marketingSourcesList = List<String>()
        let productsTagList = List<String>()
        let deliveryFeesList = List<ModelDeliveryFees>()
        let restrictedNotificationTerminalsList = List<String>()
        let receiptInfoList = List<ModelReceiptInfo>()
        assetsList.append(objectsIn: assets)
        emailListList.append(objectsIn: emailList)
        taxTablesList.append(objectsIn: taxTables)
        marketingSourcesList.append(objectsIn: marketingSources)
        productsTagList.append(objectsIn: productsTag)
        deliveryFeesList.append(objectsIn: deliveryFees)
        restrictedNotificationTerminalsList.append(objectsIn: restrictedNotificationTerminals)
       // receiptInfoList.append(objectsIn: receiptInfo)
    
    
    
    self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, shortIdentifier: shortIdentifier, name: name, shopType: shopType, address: address, phoneNumber: phoneNumber, emailAdress: emailAdress, license: license, enableDeliveryFee: enableDeliveryFee!, deliveryFee: deliveryFee!, taxOrder: taxOrder, taxInfo: taxInfo, showWalkInQueue: showWalkInQueue!, showDeliveryQueue: showDeliveryQueue!, showOnlineQueue: showOnlineQueue!, enableCashInOut: enableCashInOut!, timeZone: timeZone,latitude:latitude!,longitude:longitude!, active: active!, snapshopTime: snapshopTime!, defaultCountry: defaultCountry, onlineStoreInfo: onlineStoreInfo, deliveryFees: deliveryFeesList, enableSaleLogout: enableSaleLogout!, assets: assetsList, enableBCCReceipt: enableBCCReceipt!, bccEmailAddress: bccEmailAddress, enableGPSTracking: enableGPSTracking!, receivingInventoryId: receivingInventoryId, defaultPinTimeout: defaultPinTimeout!, showSpecialQueue: showSpecialQueue!, emailList: emailListList, enableLowInventoryEmail: enableLowInventoryEmail!, restrictedViews: restrictedViews!, emailMessage: emailMessage, taxRoundOffType: taxRoundOffType, enforceCashDrawers: enforceCashDrawers!, useAssignedEmployee: useAssignedEmployee!, showProductByAvailableQuantity: showProductByAvailableQuantity!, autoCashDrawer: autoCashDrawer!, numAllowActiveTrans: numAllowActiveTrans!, requireValidRecDate: requireValidRecDate!, enableDeliverySignature: enableDeliverySignature!, restrictIncomingOrderNotifications: restrictIncomingOrderNotifications!, restrictedNotificationTerminals: restrictedNotificationTerminalsList, roundOffType: roundOffType, roundUpMessage: roundUpMessage, shopEntityType: shopEntityType, membersCountSyncDate: membersCountSyncDate!, enableCannabisLimit: enableCannabisLimit!, useComplexTax: useComplexTax!, taxTables: taxTablesList, enableExciseTax: enableExciseTax!, exciseTaxType: exciseTaxType, marketingSources: marketingSourcesList, productsTag: productsTagList, logo: logo, hubId: hubId, hubName: hubName, enableOnFleet: enableOnFleet!, onFleetApiKey: onFleetApiKey, onFleetOrganizationId: onFleetOrganizationId, onFleetOrganizationName: onFleetOrganizationName, emailAttachment: emailAttachment, enablePinForCashDrawer: enablePinForCashDrawer!, checkoutType: checkoutType, enableMetrc: enableMetrc!, enableDeliveryMessaging: enableDeliveryMessaging!, exciseTaxInfo: exciseTaxInfo, timezoneOffsetInMinutes: timezoneOffsetInMinutes!, defaultPinTimeoutDuration: defaultPinTimeoutDuration!)
    
    }
    
}

class TaxInfo : DBModel{
   @objc dynamic var id : String? = ""
   @objc dynamic var created : Int = 0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var cityTax : Double = 0.0
   @objc dynamic var stateTax : Double = 0.0
   @objc dynamic var federalTax : Double = 0.0
    
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
    
    convenience init(id : String?, created : Int,modified : Int,deleted : Bool,updated : Bool,cityTax : Double,stateTax : Double,federalTax : Double){
        self.init()
        self.id         = id
        self.created    = created
        self.modified   = modified
        self.deleted    = deleted
        self.updated    = updated
        self.cityTax    = cityTax
        self.stateTax   = stateTax
        self.federalTax = federalTax
    }
    
   convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decodeIfPresent(String.self, forKey: .id)
        let created = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let cityTax = try values.decodeIfPresent(Double.self, forKey: .cityTax)
        let stateTax = try values.decodeIfPresent(Double.self, forKey: .stateTax)
        let federalTax = try values.decodeIfPresent(Double.self, forKey: .federalTax)
        
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, cityTax: cityTax!, stateTax: stateTax!, federalTax: federalTax!)
    }
    
}


class ModelStateTax :DBModel{
   @objc dynamic var id : String? = ""
   @objc dynamic var created : Int = 0
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
    
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,shopId : String?,dirty : Bool,taxRate : Double,compound : Bool,active : Bool,territory : String?,activeExciseTax : Bool,taxOrder : String?){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.shopId = shopId
        self.dirty = dirty
        self.taxRate = taxRate
        self.compound = compound
        self.active = active
        self.territory = territory
        self.activeExciseTax = activeExciseTax
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
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, shopId: shopId, dirty: dirty!, taxRate: taxRate!, compound: compound!, active: active!, territory: territory, activeExciseTax: activeExciseTax!, taxOrder: taxOrder)
    }
    
}


class ModelAssignedTerminal : DBModel{
    @objc dynamic var id : String?                  = ""
    @objc dynamic var created : Int                 = 0
    @objc dynamic var modified : Int                = 0
    @objc dynamic var deleted : Bool                = false
    @objc dynamic var updated : Bool                = false
    @objc dynamic var companyId : String?           = ""
    @objc dynamic var shopId : String?              = ""
    @objc dynamic var dirty : Bool                  = false
    @objc dynamic var active : Bool                 = false
    @objc dynamic var deviceId : String?            = ""
    @objc dynamic var name : String?                = ""
    @objc dynamic var deviceModel : String?         = ""
    @objc dynamic var deviceVersion : String?       = ""
    @objc dynamic var deviceName : String?          = ""
    @objc dynamic var appVersion : String?          = ""
    @objc dynamic var deviceToken : String?         = ""
    @objc dynamic var deviceType : String?          = ""
    @objc dynamic var assignedInventoryId : String? = ""
    @objc dynamic var cvAccountId : String?         = ""
    @objc dynamic var currentEmployeeId : String?   = ""
                  var terminalLocations = List<ModelTerminalLocations>()
    
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
    convenience init (id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,shopId : String?,dirty : Bool,active : Bool,deviceId : String?,name : String?,deviceModel : String?,deviceVersion : String?,deviceName : String?,appVersion : String?,deviceToken : String?,deviceType : String?,assignedInventoryId : String?,cvAccountId : String?,currentEmployeeId : String?,terminalLocations : List<ModelTerminalLocations>){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.shopId = shopId
        self.dirty = dirty
        self.active = active
        self.deviceId = deviceId
        self.name = name
        self.deviceModel = deviceModel
        self.deviceVersion = deviceVersion
        self.deviceName = deviceName
        self.appVersion = appVersion
        self.deviceToken = deviceToken
        self.deviceType = deviceType
        self.assignedInventoryId = assignedInventoryId
        self.cvAccountId = cvAccountId
        self.currentEmployeeId = currentEmployeeId
        self.terminalLocations = terminalLocations
        
        
        
    }
  convenience  required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decodeIfPresent(String.self, forKey: .id)
        let created = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        let shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        let dirty = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        let active = try values.decodeIfPresent(Bool.self, forKey: .active)
        let deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        let name = try values.decodeIfPresent(String.self, forKey: .name)
        let deviceModel = try values.decodeIfPresent(String.self, forKey: .deviceModel)
        let deviceVersion = try values.decodeIfPresent(String.self, forKey: .deviceVersion)
        let deviceName = try values.decodeIfPresent(String.self, forKey: .deviceName)
        let appVersion = try values.decodeIfPresent(String.self, forKey: .appVersion)
        let deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
        let deviceType = try values.decodeIfPresent(String.self, forKey: .deviceType)
        let assignedInventoryId = try values.decodeIfPresent(String.self, forKey: .assignedInventoryId)
        let cvAccountId = try values.decodeIfPresent(String.self, forKey: .cvAccountId)
        let currentEmployeeId = try values.decodeIfPresent(String.self, forKey: .currentEmployeeId)
        let terminalLocations = try values.decode([ModelTerminalLocations].self, forKey: .terminalLocations)
        let terminalLocationsList = List<ModelTerminalLocations>()
            terminalLocationsList.append(objectsIn: terminalLocations)
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, shopId: shopId, dirty: dirty!, active: active!, deviceId: deviceId, name: name, deviceModel: deviceModel, deviceVersion: deviceVersion, deviceName: deviceName, appVersion: appVersion, deviceToken: deviceToken, deviceType: deviceType, assignedInventoryId: assignedInventoryId, cvAccountId: cvAccountId, currentEmployeeId: currentEmployeeId, terminalLocations: terminalLocationsList)
    }
}

class ModelCityTax :DBModel{
   @objc dynamic var id : String?           = ""
   @objc dynamic var created : Int          = 0
   @objc dynamic var modified : Int         = 0
   @objc dynamic var deleted : Bool         = false
   @objc dynamic var updated : Bool         = false
   @objc dynamic var companyId : String?    = ""
   @objc dynamic var shopId : String?       = ""
   @objc dynamic var dirty : Bool           = false
   @objc dynamic var taxRate : Double       = 0.0
   @objc dynamic var compound : Bool        = false
   @objc dynamic var active : Bool          = false
   @objc dynamic var territory : String?    = ""
   @objc dynamic var activeExciseTax : Bool = false
   @objc dynamic var taxOrder : String?     = ""
    
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
    
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,shopId : String?,dirty : Bool,taxRate : Double,compound : Bool,active : Bool,territory : String?,activeExciseTax : Bool,taxOrder : String?){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.shopId = shopId
        self.dirty = dirty
        self.taxRate = taxRate
        self.compound = compound
        self.active = active
        self.territory = territory
        self.activeExciseTax = activeExciseTax
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
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, shopId: shopId, dirty: dirty!, taxRate: taxRate!, compound: compound!, active: active!, territory: territory, activeExciseTax: activeExciseTax!, taxOrder: taxOrder)
    
    }
    
}

class ModelCompany : DBModel {
    @objc dynamic var id : String?                  = ""
    @objc dynamic var created : Int                 = 0
    @objc dynamic var modified : Int                = 0
    @objc dynamic var deleted : Bool                = false
    @objc dynamic var updated : Bool                = false
    @objc dynamic var membersShareOption : String?  = ""
    @objc dynamic var isId : String?                = ""
    @objc dynamic var name : String?                = ""
    @objc dynamic var phoneNumber : String?         = ""
    @objc dynamic var email : String?               = ""
    @objc dynamic var address : ModelAddres?            = ModelAddres()
    @objc dynamic var logoURL : String?             = ""
    @objc dynamic var supportEmail : String?        = ""
    @objc dynamic var showNameWithLogo : Bool       = false
    @objc dynamic var active : Bool                 = false
    @objc dynamic var website : String?             = ""
    @objc dynamic var productSKU : String?          = ""
    @objc dynamic var queueUrl : String?            = ""
    @objc dynamic var preferredEmailColor : String? = ""
    @objc dynamic var pricingOpt : String?          = ""
    @objc dynamic var enableLoyalty : Bool          = false
    @objc dynamic var dollarToPointRatio : Int      = 0
    @objc dynamic var duration : Int                = 0
    @objc dynamic var portalUrl : String?           = ""
    @objc dynamic var businessLocation : String?    = ""
    @objc dynamic var fax : String?                 = ""
    @objc dynamic var primaryContact : ModelPrimaryContact?
    @objc dynamic var taxId : String?               = ""
    @objc dynamic var loyaltyAccrueOpt : String?    = ""
    
    
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
    
    convenience init(id : String?,created : Int?,modified : Int?,deleted : Bool?,updated : Bool?,membersShareOption : String?,isId : String?,name : String?,phoneNumber : String?,email : String?,address : ModelAddres?,logoURL : String?,supportEmail : String?,showNameWithLogo : Bool?,active : Bool?,website : String?,productSKU : String?,queueUrl : String?,preferredEmailColor : String?,pricingOpt : String?,enableLoyalty : Bool?,dollarToPointRatio : Int?,duration : Int?,portalUrl : String?,businessLocation : String?,fax : String?,primaryContact : ModelPrimaryContact?,taxId : String?,loyaltyAccrueOpt : String?){
        self.init()
        self.id = id
        self.created = created!
        self.modified = modified!
        self.deleted = deleted!
        self.updated = updated!
        self.membersShareOption = membersShareOption
        self.isId = isId
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.logoURL = logoURL
        self.supportEmail = supportEmail
        self.showNameWithLogo = showNameWithLogo!
        self.active = active!
        self.website = website
        self.productSKU = productSKU
        self.queueUrl = queueUrl
        self.preferredEmailColor = preferredEmailColor
        self.pricingOpt = pricingOpt
        self.enableLoyalty = enableLoyalty!
        self.dollarToPointRatio = dollarToPointRatio!
        self.duration = duration != nil ? duration! : 0
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
        let address = try values.decodeIfPresent(ModelAddres.self, forKey: .address)
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
        let primaryContact = try values.decodeIfPresent(ModelPrimaryContact.self, forKey: .primaryContact)
        let taxId = try values.decodeIfPresent(String.self, forKey: .taxId)
        let loyaltyAccrueOpt = try values.decodeIfPresent(String.self, forKey: .loyaltyAccrueOpt)
        self.init(id: id, created: created, modified: modified, deleted: deleted, updated: updated, membersShareOption: membersShareOption, isId: isId, name: name, phoneNumber: phoneNumber, email: email, address: address, logoURL: logoURL, supportEmail: supportEmail, showNameWithLogo: showNameWithLogo, active: active, website: website, productSKU: productSKU, queueUrl: queueUrl, preferredEmailColor: preferredEmailColor, pricingOpt: pricingOpt, enableLoyalty: enableLoyalty, dollarToPointRatio: dollarToPointRatio, duration: duration, portalUrl: portalUrl, businessLocation: businessLocation, fax: fax, primaryContact: primaryContact, taxId: taxId, loyaltyAccrueOpt: loyaltyAccrueOpt)
    }
    
}

class ModelCountyTax :DBModel{
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

class ModelDeliveryFees : DBModel{
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

class ModelEmailAttachment :DBModel {
   
   @objc dynamic var id : String?   = ""
   @objc dynamic var created : Int  =  0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var name : String? = ""
   @objc dynamic var key : String? = ""
   @objc dynamic var type : String? = ""
   @objc dynamic var publicURL : String? = ""
   @objc dynamic var active : Bool = false
   @objc dynamic var priority : Int = 0
   @objc dynamic var secured : Bool = false
   @objc dynamic var thumbURL : String? = ""
   @objc dynamic var mediumURL : String? = ""
   @objc dynamic var largeURL : String? = ""
   @objc dynamic var assetType : String? = ""
    
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
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,name : String?,key : String?,type : String?,publicURL : String?,active : Bool,priority : Int,secured : Bool,thumbURL : String?,mediumURL : String?,largeURL : String?,assetType : String?){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.name = name
        self.key = key
        self.type = type
        self.publicURL = publicURL
        self.active = active
        self.priority = priority
        self.secured = secured
        self.thumbURL = thumbURL
        self.mediumURL = mediumURL
        self.largeURL = largeURL
        self.assetType = assetType
    }
    
   convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decodeIfPresent(String.self, forKey: .id)
        let created = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        let name = try values.decodeIfPresent(String.self, forKey: .name)
        let key = try values.decodeIfPresent(String.self, forKey: .key)
        let type = try values.decodeIfPresent(String.self, forKey: .type)
        let publicURL = try values.decodeIfPresent(String.self, forKey: .publicURL)
        let active = try values.decodeIfPresent(Bool.self, forKey: .active)
        let priority = try values.decodeIfPresent(Int.self, forKey: .priority)
        let secured = try values.decodeIfPresent(Bool.self, forKey: .secured)
        let thumbURL = try values.decodeIfPresent(String.self, forKey: .thumbURL)
        let mediumURL = try values.decodeIfPresent(String.self, forKey: .mediumURL)
        let largeURL = try values.decodeIfPresent(String.self, forKey: .largeURL)
        let assetType = try values.decodeIfPresent(String.self, forKey: .assetType)
        self.init(id: id, created: created!, modified: modified!, deleted:deleted!, updated: updated!, companyId: companyId, name: name, key: key, type: type, publicURL: publicURL, active: active!, priority: priority!, secured: secured!, thumbURL: thumbURL, mediumURL: mediumURL, largeURL: largeURL, assetType: assetType)
    }
    
}

class ModelEmployee :DBModel {
   @objc dynamic var id : String?                   = ""
   @objc dynamic var created : Int                  = 0
   @objc dynamic var modified : Int                 = 0
   @objc dynamic var deleted : Bool                 = false
   @objc dynamic var updated : Bool                 = false
   @objc dynamic var companyId : String?            = ""
   @objc dynamic var firstName : String?            = ""
   @objc dynamic var lastName : String?             = ""
   @objc dynamic var pin : String?                  = ""
   @objc dynamic var roleId : String?               = ""
   @objc dynamic var email : String?                = ""
   @objc dynamic var password : String?             = ""
   @objc dynamic var driversLicense : String?       = ""
   @objc dynamic var dlExpirationDate : String?     = ""
   @objc dynamic var vehicleMake : String?          = ""
   var notes                                        = List<ModelNotes>()
   var shops                                        = List<String>()
   @objc dynamic var disabled : Bool                = false
   @objc dynamic var phoneNumber : String?          = ""
   @objc dynamic var assignedInventoryId : String?  = ""
   @objc dynamic var assignedTerminalId : String?   = ""
   @objc dynamic var address : ModelAddres?
   @objc dynamic var timecardId : String?           = ""
   @objc dynamic var timeCard : ModelTimeCard?
   @objc dynamic var role : ModelRole?
   @objc dynamic var canApplyCustomDiscount : Bool  = false
   @objc dynamic var insuranceExpireDate : Int      = 0
   @objc dynamic var insuranceCompanyName : String? = ""
   @objc dynamic var policyNumber : String?         = ""
   @objc dynamic var registrationExpireDate : Int   = 0
   @objc dynamic var vehiclePin : String?           = ""
   @objc dynamic var vinNo : String?                = ""
   var employeeOnFleetInfoList                      = List<ModelEmployeeOnFleetInfoList>()
                 var appAccessList = List<String>()
    
    enum CodingKeys: String, CodingKey {
        
        case id                      = "id"
        case created                 = "created"
        case modified                = "modified"
        case deleted                 = "deleted"
        case updated                 = "updated"
        case companyId               = "companyId"
        case firstName               = "firstName"
        case lastName                = "lastName"
        case pin                     = "pin"
        case roleId                  = "roleId"
        case email                   = "email"
        case password                = "password"
        case driversLicense          = "driversLicense"
        case dlExpirationDate        = "dlExpirationDate"
        case vehicleMake             = "vehicleMake"
        case notes                   = "notes"
        case shops                   = "shops"
        case disabled                = "disabled"
        case phoneNumber             = "phoneNumber"
        case assignedInventoryId     = "assignedInventoryId"
        case assignedTerminalId      = "assignedTerminalId"
        case address                 = "address"
        case timecardId              = "timecardId"
        case timeCard                = "timeCard"
        case role                    = "role"
        case canApplyCustomDiscount  = "canApplyCustomDiscount"
        case insuranceExpireDate     = "insuranceExpireDate"
        case insuranceCompanyName    = "insuranceCompanyName"
        case policyNumber            = "policyNumber"
        case registrationExpireDate  = "registrationExpireDate"
        case vehiclePin              = "vehiclePin"
        case vinNo                   = "vinNo"
        case employeeOnFleetInfoList = "employeeOnFleetInfoList"
        case appAccessList           = "appAccessList"
    }
    convenience init(id : String?,created : Int?,modified : Int?,deleted : Bool,updated : Bool,companyId : String?,firstName : String?,lastName : String?,pin : String?,roleId : String?,email : String?,password : String?,driversLicense : String?, dlExpirationDate : String?,vehicleMake : String?,notes : List<ModelNotes>,shops : List<String>,disabled : Bool,phoneNumber : String?,assignedInventoryId : String?,assignedTerminalId : String?,address : ModelAddres?,timecardId : String?,timeCard : ModelTimeCard?,role : ModelRole?,canApplyCustomDiscount : Bool,insuranceExpireDate : Int?,insuranceCompanyName : String?,policyNumber : String?,registrationExpireDate : Int,vehiclePin : String?,vinNo : String?,employeeOnFleetInfoList : List<ModelEmployeeOnFleetInfoList>,appAccessList : List<String>){
        self.init()
        self.id                      = id
        self.created                 =  created  != nil ? created!  : 0
        self.modified                =  modified != nil ? modified! : 0
        self.deleted                 = deleted
        self.companyId               = companyId
        self.firstName               = firstName
        self.lastName                = lastName
        self.pin                     = pin
        self.roleId                  = roleId
        self.email                   = email
        self.password                = password
        self.driversLicense          = driversLicense
        self.dlExpirationDate        = dlExpirationDate
        self.vehicleMake             = vehicleMake
        self.notes                   = notes
        self.shops                   = shops
        self.disabled                = disabled
        self.phoneNumber             = phoneNumber
        self.assignedInventoryId     = assignedInventoryId
        self.assignedTerminalId      = assignedTerminalId
        self.address                 = address
        self.timecardId              = timecardId
        self.timeCard                = timeCard
        self.role                    = role
        self.canApplyCustomDiscount  = canApplyCustomDiscount
        self.insuranceExpireDate     = insuranceExpireDate != nil ? insuranceExpireDate! : 0
        self.insuranceCompanyName    = insuranceCompanyName
        self.policyNumber            = policyNumber
        self.registrationExpireDate  = registrationExpireDate
        self.vehiclePin              = vehiclePin
        self.vinNo                   = vinNo
        self.employeeOnFleetInfoList = employeeOnFleetInfoList
        self.appAccessList           = appAccessList
    }
   convenience  required init(from decoder: Decoder) throws {
        let values                      = try decoder.container(keyedBy: CodingKeys.self)
        let id                          = try values.decodeIfPresent(String.self, forKey: .id)
        let created                     = try values.decodeIfPresent(Int.self, forKey: .created) ?? 0
        let modified                    = try values.decodeIfPresent(Int.self, forKey: .modified) ?? 0
        let deleted                     = try values.decodeIfPresent(Bool.self, forKey: .deleted) ?? false
        let updated                     = try values.decodeIfPresent(Bool.self, forKey: .updated) ?? false
        let companyId                   = try values.decodeIfPresent(String.self, forKey: .companyId)
        let firstName                   = try values.decodeIfPresent(String.self, forKey: .firstName)
        let lastName                    = try values.decodeIfPresent(String.self, forKey: .lastName)
        let pin                         = try values.decodeIfPresent(String.self, forKey: .pin)
        let roleId                      = try values.decodeIfPresent(String.self, forKey: .roleId)
        let email                       = try values.decodeIfPresent(String.self, forKey: .email)
        let password                    = try values.decodeIfPresent(String.self, forKey: .password)
        let driversLicense              = try values.decodeIfPresent(String.self, forKey: .driversLicense)
        let dlExpirationDate            = try values.decodeIfPresent(String.self, forKey: .dlExpirationDate)
        let vehicleMake                 = try values.decodeIfPresent(String.self, forKey: .vehicleMake)
        let notes                       = try values.decode([ModelNotes].self, forKey: .notes)
        let shops                       = try values.decode([String].self, forKey: .shops)
        let disabled                    = try values.decodeIfPresent(Bool.self, forKey: .disabled) ?? false
        let phoneNumber                 = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        let assignedInventoryId         = try values.decodeIfPresent(String.self, forKey: .assignedInventoryId)
        let assignedTerminalId          = try values.decodeIfPresent(String.self, forKey: .assignedTerminalId)
        let address                     = try values.decodeIfPresent(ModelAddres.self, forKey: .address)
        let timecardId                  = try values.decodeIfPresent(String.self, forKey: .timecardId)
        let timeCard                    = try values.decodeIfPresent(ModelTimeCard.self, forKey: .timeCard)
        let role                        = try values.decodeIfPresent(ModelRole.self, forKey: .role)
        let canApplyCustomDiscount      = try values.decodeIfPresent(Bool.self, forKey: .canApplyCustomDiscount)
        let insuranceExpireDate         = try values.decodeIfPresent(Int.self, forKey: .insuranceExpireDate) ?? 0
        let insuranceCompanyName        = try values.decodeIfPresent(String.self, forKey: .insuranceCompanyName)
        let policyNumber                = try values.decodeIfPresent(String.self, forKey: .policyNumber)
        let registrationExpireDate      = try values.decodeIfPresent(Int.self, forKey: .registrationExpireDate) ?? 0
        let vehiclePin                  = try values.decodeIfPresent(String.self, forKey: .vehiclePin)
        let vinNo                       = try values.decodeIfPresent(String.self, forKey: .vinNo)
        let employeeOnFleetInfoList     = try values.decode([ModelEmployeeOnFleetInfoList].self, forKey: .employeeOnFleetInfoList)
        let appAccessList               = try values.decode([String].self, forKey: .appAccessList)
        let notesList                   = List<ModelNotes>()
        let shopsList                   = List<String>()
        let employeeOnFleetInfoListList = List<ModelEmployeeOnFleetInfoList>()
        let appAccessListList           = List<String>()
            notesList.append(objectsIn: notes)
            employeeOnFleetInfoListList.append(objectsIn: employeeOnFleetInfoList)
            appAccessListList.append(objectsIn: appAccessList)
            shopsList.append(objectsIn: shops)
    
    
    self.init(id: id, created: created, modified: modified, deleted: deleted, updated: updated, companyId: companyId, firstName: firstName, lastName: lastName, pin: pin, roleId: roleId, email: email, password: password, driversLicense: driversLicense, dlExpirationDate: dlExpirationDate, vehicleMake: vehicleMake, notes: notesList, shops: shopsList, disabled: disabled, phoneNumber: phoneNumber, assignedInventoryId: assignedInventoryId, assignedTerminalId: assignedTerminalId, address: address, timecardId: timecardId, timeCard: timeCard, role: role, canApplyCustomDiscount: canApplyCustomDiscount!, insuranceExpireDate: insuranceExpireDate, insuranceCompanyName: insuranceCompanyName, policyNumber: policyNumber, registrationExpireDate: registrationExpireDate, vehiclePin: vehiclePin, vinNo: vinNo, employeeOnFleetInfoList: employeeOnFleetInfoListList, appAccessList: appAccessListList)
    }
    
}

class ModelEmployeeOnFleetInfoList : DBModel {
  @objc dynamic var shopId : String? = ""
  @objc dynamic var onFleetWorkerId : String? = ""
                var onFleetTeamList  = List<String>()
    
    enum CodingKeys: String, CodingKey {
        
        case shopId = "shopId"
        case onFleetWorkerId = "onFleetWorkerId"
        case onFleetTeamList = "onFleetTeamList"
    }
    convenience init(shopId : String?,onFleetWorkerId : String?,onFleetTeamList : List<String>){
        self.init()
        self.shopId = shopId
        self.onFleetWorkerId = onFleetWorkerId
        self.onFleetTeamList = onFleetTeamList
        
    }
   convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
        let onFleetWorkerId = try values.decodeIfPresent(String.self, forKey: .onFleetWorkerId)
        let onFleetTeamList = try values.decode([String].self, forKey: .onFleetTeamList)
        let onFleetTeamListList = List<String>()
            onFleetTeamListList.append(objectsIn: onFleetTeamList)
        self.init(shopId: shopId, onFleetWorkerId: onFleetWorkerId, onFleetTeamList: onFleetTeamListList)
    }
    
}

class ModelExciseTaxInfo : DBModel {
   @objc dynamic var id : String?      = ""
   @objc dynamic var created : Int     = 0
   @objc dynamic var modified : Int    = 0
   @objc dynamic var deleted : Bool    = false
   @objc dynamic var updated : Bool    = false
   @objc dynamic var state : String?   = ""
   @objc dynamic var country : String? = ""
   @objc dynamic var stateMarkUp : Int = 0
   @objc dynamic var exciseTax : Int   = 0
    
    enum CodingKeys: String, CodingKey {
        
        case id          = "id"
        case created     = "created"
        case modified    = "modified"
        case deleted     = "deleted"
        case updated     = "updated"
        case state       = "state"
        case country     = "country"
        case stateMarkUp = "stateMarkUp"
        case exciseTax   = "exciseTax"
    }
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,state : String?,country : String?,stateMarkUp : Int,exciseTax : Int){
        self.init()
        
        self.id          = id
        self.created     = created
        self.modified    = modified
        self.deleted     = deleted
        self.updated     = updated
        self.state       = state
        self.country     = country
        self.stateMarkUp = stateMarkUp
        self.exciseTax   = exciseTax
    }
   convenience required init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        let id          = try values.decodeIfPresent(String.self, forKey: .id)
        let created     = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified    = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted     = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated     = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let state       = try values.decodeIfPresent(String.self, forKey: .state)
        let country     = try values.decodeIfPresent(String.self, forKey: .country)
        let stateMarkUp = try values.decodeIfPresent(Int.self, forKey: .stateMarkUp)
        let exciseTax   = try values.decodeIfPresent(Int.self, forKey: .exciseTax)
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, state: state, country: country, stateMarkUp: stateMarkUp!, exciseTax: exciseTax!)
    }
    
}

class ModelFederalTax : DBModel{
   @objc dynamic var id : String? = ""
   @objc dynamic var created : Int = 0
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
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,shopId : String?,dirty : Bool,taxRate : Double,compound : Bool,active : Bool,territory : String?,activeExciseTax : Bool,taxOrder : String?){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.shopId = shopId
        self.dirty = dirty
        self.taxRate = taxRate
        self.compound = compound
        self.active = active
        self.territory = territory
        self.activeExciseTax = activeExciseTax
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
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, shopId: shopId, dirty: dirty!, taxRate: taxRate!, compound: compound!, active: active!, territory: territory, activeExciseTax: activeExciseTax!, taxOrder: taxOrder)
    
    }
    
}

class ModelLogo :DBModel{
   @objc dynamic var id : String? = ""
   @objc dynamic var created : Int = 0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var name : String? = ""
   @objc dynamic var key : String? = ""
   @objc dynamic var type : String? = ""
   @objc dynamic var publicURL : String? = ""
   @objc dynamic var active : Bool = false
   @objc dynamic var priority : Int = 0
   @objc dynamic var secured : Bool = false
   @objc dynamic var thumbURL : String? = ""
   @objc dynamic var mediumURL : String? = ""
   @objc dynamic var largeURL : String? = ""
   @objc dynamic var assetType : String? = ""
    
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
    
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,name : String?,key : String?,type : String?,publicURL : String?,active : Bool,priority : Int,secured : Bool,thumbURL : String?,mediumURL : String?,largeURL : String?,assetType : String?){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.name = name
        self.key = key
        self.type = type
        self.publicURL = publicURL
        self.active = active
        self.priority = priority
        self.secured = secured
        self.thumbURL = thumbURL
        self.mediumURL = mediumURL
        self.largeURL = largeURL
        self.assetType = assetType
        
    }
   convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decodeIfPresent(String.self, forKey: .id)
        let created = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        let name = try values.decodeIfPresent(String.self, forKey: .name)
        let key = try values.decodeIfPresent(String.self, forKey: .key)
        let type = try values.decodeIfPresent(String.self, forKey: .type)
        let publicURL = try values.decodeIfPresent(String.self, forKey: .publicURL)
        let active = try values.decodeIfPresent(Bool.self, forKey: .active)
        let priority = try values.decodeIfPresent(Int.self, forKey: .priority)
        let secured = try values.decodeIfPresent(Bool.self, forKey: .secured)
        let thumbURL = try values.decodeIfPresent(String.self, forKey: .thumbURL)
        let mediumURL = try values.decodeIfPresent(String.self, forKey: .mediumURL)
        let largeURL = try values.decodeIfPresent(String.self, forKey: .largeURL)
        let assetType = try values.decodeIfPresent(String.self, forKey: .assetType)
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, name: name, key: key, type: type, publicURL: publicURL, active: active!, priority: priority!, secured: secured!, thumbURL: thumbURL, mediumURL: mediumURL, largeURL: largeURL, assetType: assetType)
    }
    
}

class ModelNotes :DBModel {
   @objc dynamic var id : String? = ""
   @objc dynamic var created : Int = 0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var writerId : String? = ""
   @objc dynamic var writerName : String? = ""
   @objc dynamic var message : String? = ""
    
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
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,writerId : String?,writerName : String?,message : String?){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.writerId = writerId
        self.writerName = writerName
        self.message = message
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decodeIfPresent(String.self, forKey: .id)
        let created = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let writerId = try values.decodeIfPresent(String.self, forKey: .writerId)
        let writerName = try values.decodeIfPresent(String.self, forKey: .writerName)
        let message = try values.decodeIfPresent(String.self, forKey: .message)
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, writerId: writerId, writerName: writerName, message: message)
    }
    
}

class ModelOnlineStoreInfo : DBModel {
   @objc dynamic var id : String? = ""
   @objc dynamic var created : Int = 0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var shopId : String? = ""
   @objc dynamic var dirty : Bool = false
   @objc dynamic var enableStorePickup : Bool = false
   @objc dynamic var enableDelivery : Bool = false
   @objc dynamic var enableOnlineShipment : Bool = false
   @objc dynamic var enableProductReviews : Bool = false
   @objc dynamic var colorTheme : String = ""
   @objc dynamic var defaultETA : Int = 0
   @objc dynamic var pageOneMessageTitle : String = " "
   @objc dynamic var pageOneMessageBody : String = " "
   @objc dynamic var submissionMessage : String = ""
   @objc dynamic var cartMinimum : Int = 0
   @objc dynamic var cartMinType : String? = ""
   @objc dynamic var enabled : Bool = false
   @objc dynamic var websiteOrigins : String? = ""
   @objc dynamic var supportEmail : String? = ""
   @objc dynamic var enableOnlinePOS : Bool = false
   @objc dynamic var enableDeliveryAreaRestrictions : Bool = false
                 var restrictedZipCodes = List<String>()
   @objc dynamic var useCustomETA : Bool = false
   @objc dynamic var customMessageETA : String? = ""
   @objc dynamic var storeHexColor : String? = ""
   @objc dynamic var viewType : String? = ""
   @objc dynamic var enableInventory : Bool = false
   @objc dynamic var enableInventoryType : String? = ""
   @objc dynamic var activeInventoryId : String? = ""
   @objc dynamic var enableHtmlText : Bool = false
   @objc dynamic var htmlText : String? = ""
   @objc dynamic var websiteUrl : String? = ""
    
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
    
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,shopId : String?,dirty : Bool,enableStorePickup : Bool,enableDelivery : Bool,enableOnlineShipment : Bool,enableProductReviews : Bool,colorTheme : String,defaultETA : Int,pageOneMessageTitle : String,pageOneMessageBody : String,submissionMessage : String,cartMinimum : Int,cartMinType : String?,enabled : Bool,websiteOrigins : String?,supportEmail : String,enableOnlinePOS : Bool,enableDeliveryAreaRestrictions : Bool,restrictedZipCodes:List<String>,useCustomETA : Bool,customMessageETA : String?,storeHexColor : String?,viewType : String?,enableInventory : Bool,enableInventoryType : String?,activeInventoryId : String?,enableHtmlText : Bool,htmlText : String?,websiteUrl : String?){
        self.init()
    }
   convenience required init(from decoder: Decoder) throws {
        let values                         = try decoder.container(keyedBy: CodingKeys.self)
        let id                             = try values.decodeIfPresent(String.self, forKey: .id)
        let created                        = try values.decodeIfPresent(Int.self, forKey: .created) ?? 0
        let modified                       = try values.decodeIfPresent(Int.self, forKey: .modified) ?? 0
        let deleted                        = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated                        = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId                      = try values.decodeIfPresent(String.self, forKey: .companyId)
        let shopId                         = try values.decodeIfPresent(String.self, forKey: .shopId)
        let dirty                          = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        let enableStorePickup              = try values.decodeIfPresent(Bool.self, forKey: .enableStorePickup)
        let enableDelivery                 = try values.decodeIfPresent(Bool.self, forKey: .enableDelivery)
        let enableOnlineShipment           = try values.decodeIfPresent(Bool.self, forKey: .enableOnlineShipment)
        let enableProductReviews           = try values.decodeIfPresent(Bool.self, forKey: .enableProductReviews)
        let colorTheme                     = try values.decodeIfPresent(String.self, forKey: .colorTheme)
        let defaultETA                     = try values.decodeIfPresent(Int.self, forKey: .defaultETA) ?? 0
        let pageOneMessageTitle            = try values.decodeIfPresent(String.self, forKey: .pageOneMessageTitle)
        let pageOneMessageBody             = try values.decodeIfPresent(String.self, forKey: .pageOneMessageBody)
        let submissionMessage              = try values.decodeIfPresent(String.self, forKey: .submissionMessage)
        let cartMinimum                    = try values.decodeIfPresent(Int.self, forKey: .cartMinimum) ?? 0
        let cartMinType                    = try values.decodeIfPresent(String.self, forKey: .cartMinType)
        let enabled                        = try values.decodeIfPresent(Bool.self, forKey: .enabled)
        let websiteOrigins                 = try values.decodeIfPresent(String.self, forKey: .websiteOrigins)
        let supportEmail                   = try values.decodeIfPresent(String.self, forKey: .supportEmail)
        let enableOnlinePOS                = try values.decodeIfPresent(Bool.self, forKey: .enableOnlinePOS)
        let enableDeliveryAreaRestrictions = try values.decodeIfPresent(Bool.self, forKey: .enableDeliveryAreaRestrictions)
        let restrictedZipCodes             = try values.decode([String].self, forKey: .restrictedZipCodes)
        let useCustomETA                   = try values.decodeIfPresent(Bool.self, forKey: .useCustomETA)
        let customMessageETA               = try values.decodeIfPresent(String.self, forKey: .customMessageETA)
        let storeHexColor                  = try values.decodeIfPresent(String.self, forKey: .storeHexColor)
        let viewType                       = try values.decodeIfPresent(String.self, forKey: .viewType)
        let enableInventory                = try values.decodeIfPresent(Bool.self, forKey: .enableInventory)
        let enableInventoryType            = try values.decodeIfPresent(String.self, forKey: .enableInventoryType)
        let activeInventoryId              = try values.decodeIfPresent(String.self, forKey: .activeInventoryId)
        let enableHtmlText                 = try values.decodeIfPresent(Bool.self, forKey: .enableHtmlText)
        let htmlText                       = try values.decodeIfPresent(String.self, forKey: .htmlText)
        let websiteUrl                     = try values.decodeIfPresent(String.self, forKey: .websiteUrl)
        let restrictedZipCodesList         = List<String>()
            restrictedZipCodesList.append(objectsIn: restrictedZipCodes)
    self.init(id: id, created: created, modified: modified, deleted: deleted!, updated: updated!, companyId: companyId, shopId: shopId, dirty: dirty!, enableStorePickup: enableStorePickup!, enableDelivery: enableDelivery!, enableOnlineShipment: enableOnlineShipment!, enableProductReviews: enableProductReviews!, colorTheme: colorTheme!, defaultETA: defaultETA, pageOneMessageTitle: pageOneMessageTitle!, pageOneMessageBody: pageOneMessageBody!, submissionMessage: submissionMessage!, cartMinimum: cartMinimum, cartMinType: cartMinType, enabled: enabled!, websiteOrigins: websiteOrigins, supportEmail: supportEmail!, enableOnlinePOS: enableOnlinePOS!, enableDeliveryAreaRestrictions: enableDeliveryAreaRestrictions!, restrictedZipCodes: restrictedZipCodesList, useCustomETA: useCustomETA!, customMessageETA: customMessageETA, storeHexColor: storeHexColor, viewType: viewType, enableInventory: enableInventory!, enableInventoryType: enableInventoryType, activeInventoryId: activeInventoryId, enableHtmlText: enableHtmlText!, htmlText: htmlText, websiteUrl: websiteUrl)
    
    }
    
}

class ModelPrimaryContact : DBModel{
   @objc dynamic var name : String?    = ""
   @objc dynamic var email : String?   = ""
   @objc dynamic var contact : String? = ""
   var address : ModelAddres?              = nil
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case email = "email"
        case contact = "contact"
        case address = "address"
    }
    
    convenience  init(name : String?,email : String?,contact : String?,address : ModelAddres?) {
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
        let address = try values.decodeIfPresent(ModelAddres.self, forKey: .address)
        self.init(name: name, email: email, contact: contact, address: address)
    }
    
}

class ModelReceiptInfo : DBModel {
    @objc dynamic var id : String?                     = ""
    @objc dynamic var created : Int                    = 0
    @objc dynamic var modified : Int                   = 0
    @objc dynamic var deleted : Bool                   = false
    @objc dynamic var updated : Bool                   = false
    @objc dynamic var companyId : String?              = ""
    @objc dynamic var shopId : String?                 = ""
    @objc dynamic var dirty : Bool                     = false
    @objc dynamic var receiptType : String?            = ""
    @objc dynamic var enableMemberName : Bool          = false
    @objc dynamic var enableMemberId : Bool            = false
    @objc dynamic var enableMemberAddress : Bool       = false
    @objc dynamic var enableShopAddress : Bool         = false
    @objc dynamic var enableShopPhoneNo : Bool         = false
    @objc dynamic var enableIncludeItemInSKU : Bool    = false
    @objc dynamic var enableExciseTaxAsItem : Bool     = false
    @objc dynamic var enableMemberLoyaltyPoints : Bool = false
    @objc dynamic var enableNotes : Bool               = false
    @objc dynamic var freeText : String?               = ""
    @objc dynamic var enabledFreeText : Bool           = false
    @objc dynamic var enabledBottomFreeText : Bool     = false
    
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
    
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,shopId : String?,dirty : Bool,receiptType : String?,enableMemberName : Bool,enableMemberId : Bool,enableMemberAddress : Bool,enableShopAddress : Bool,enableShopPhoneNo : Bool,enableIncludeItemInSKU : Bool,enableExciseTaxAsItem : Bool,enableMemberLoyaltyPoints : Bool,enableNotes : Bool ,freeText : String?,enabledFreeText : Bool,enabledBottomFreeText : Bool){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.shopId = shopId
        self.dirty = dirty
        self.receiptType = receiptType
        self.enableMemberName = enableMemberName
        self.enableMemberId = enableMemberId
        self.enableMemberAddress = enableMemberAddress
        self.enableShopAddress = enableShopAddress
        self.enableShopPhoneNo = enableShopPhoneNo
        self.enableIncludeItemInSKU = enableIncludeItemInSKU
        self.enableExciseTaxAsItem = enableExciseTaxAsItem
        self.enableMemberLoyaltyPoints = enableMemberLoyaltyPoints
        self.enableNotes = enableNotes
        self.freeText = freeText
        self.enabledFreeText = enabledFreeText
        self.enabledBottomFreeText = enabledBottomFreeText
        
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
       let receiptType = try values.decodeIfPresent(String.self, forKey: .receiptType)
       let enableMemberName = try values.decodeIfPresent(Bool.self, forKey: .enableMemberName)
       let enableMemberId = try values.decodeIfPresent(Bool.self, forKey: .enableMemberId)
       let enableMemberAddress = try values.decodeIfPresent(Bool.self, forKey: .enableMemberAddress)
       let enableShopAddress = try values.decodeIfPresent(Bool.self, forKey: .enableShopAddress)
       let enableShopPhoneNo = try values.decodeIfPresent(Bool.self, forKey: .enableShopPhoneNo)
       let enableIncludeItemInSKU = try values.decodeIfPresent(Bool.self, forKey: .enableIncludeItemInSKU)
       let enableExciseTaxAsItem = try values.decodeIfPresent(Bool.self, forKey: .enableExciseTaxAsItem)
       let enableMemberLoyaltyPoints = try values.decodeIfPresent(Bool.self, forKey: .enableMemberLoyaltyPoints)
       let enableNotes = try values.decodeIfPresent(Bool.self, forKey: .enableNotes)
       let freeText = try values.decodeIfPresent(String.self, forKey: .freeText)
       let enabledFreeText = try values.decodeIfPresent(Bool.self, forKey: .enabledFreeText)
       let enabledBottomFreeText = try values.decodeIfPresent(Bool.self, forKey: .enabledBottomFreeText)
    
    self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId!, shopId: shopId!, dirty: dirty!, receiptType: receiptType!, enableMemberName: enableMemberName!, enableMemberId: enableMemberId!, enableMemberAddress: enableMemberAddress!, enableShopAddress: enableShopAddress!, enableShopPhoneNo: enableShopPhoneNo!, enableIncludeItemInSKU: enableIncludeItemInSKU!, enableExciseTaxAsItem: enableExciseTaxAsItem!, enableMemberLoyaltyPoints: enableMemberLoyaltyPoints!, enableNotes: enableNotes!, freeText: freeText, enabledFreeText: enabledFreeText!, enabledBottomFreeText: enabledBottomFreeText!)
    }
    
}

class ModelRole :DBModel{
   @objc dynamic var id : String?   = ""
   @objc dynamic var created : Int  = 0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var companyId : String? = ""
                 var permissions = List<String>()
   @objc dynamic var name : String? = ""
    
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
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,permissions : List<String>,name : String?){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.permissions = permissions
        self.name = name
    }
    
    
   convenience required init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         let id = try values.decodeIfPresent(String.self, forKey: .id)
         let created = try values.decodeIfPresent(Int.self, forKey: .created)
         let modified = try values.decodeIfPresent(Int.self, forKey: .modified)
         let deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
         let updated = try values.decodeIfPresent(Bool.self, forKey: .updated)
         let companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
         let permissions = try values.decode([String].self, forKey: .permissions)
         let name = try values.decodeIfPresent(String.self, forKey: .name)
         let permissionsList = List<String>()
             permissionsList.append(objectsIn: permissions)
         self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId!, permissions: permissionsList, name: name)
    
    
    }
    
}

class ModelSessions :DBModel{
   @objc dynamic var id : String? = ""
   @objc dynamic var created : Int = 0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var shopId : String? = ""
   @objc dynamic var dirty : Bool = false
   @objc dynamic var terminalId : String? = ""
   @objc dynamic var employeeId : String? = ""
   @objc dynamic var timeCardId : String? = ""
   @objc dynamic var startTime : Int = 0
   @objc dynamic var endTime : Int = 0
    
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
        self.created = created!
        self.modified = modified!
        self.deleted = deleted!
        self.updated = updated!
        self.companyId = companyId
        self.shopId = shopId
        self.dirty = dirty!
        self.terminalId = terminalId
        self.employeeId = employeeId
        self.timeCardId = timeCardId
        self.startTime = startTime!
        self.endTime = endTime!
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

class ModelTaxTables : DBModel {
   @objc dynamic var id : String?   = ""
   @objc dynamic var created : Int  = 0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var shopId : String? = ""
   @objc dynamic var dirty : Bool = false
   @objc dynamic var name : String? = ""
   @objc dynamic var active : Bool = false
   @objc dynamic var taxType : String? = ""
   @objc dynamic var taxOrder : String? = ""
   @objc dynamic var consumerType : String? = ""
   @objc dynamic var cityTax : ModelCityTax?
   @objc dynamic var countyTax : ModelCountyTax?
   @objc dynamic var stateTax : ModelStateTax?
   @objc dynamic var federalTax : ModelFederalTax?
    
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
    
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,shopId : String?,dirty : Bool,name : String?,active : Bool,taxType : String?,taxOrder : String?,consumerType : String?,cityTax : ModelCityTax?,countyTax : ModelCountyTax?,stateTax : ModelStateTax?,federalTax : ModelFederalTax?){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated = updated
        self.companyId = companyId
        self.shopId = shopId
        self.dirty = dirty
        self.name = name
        self.federalTax = federalTax
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
        let name = try values.decodeIfPresent(String.self, forKey: .name)
        let active = try values.decodeIfPresent(Bool.self, forKey: .active)
        let taxType = try values.decodeIfPresent(String.self, forKey: .taxType)
        let taxOrder = try values.decodeIfPresent(String.self, forKey: .taxOrder)
        let consumerType = try values.decodeIfPresent(String.self, forKey: .consumerType)
        let cityTax = try values.decodeIfPresent(ModelCityTax.self, forKey: .cityTax)
        let countyTax = try values.decodeIfPresent(ModelCountyTax.self, forKey: .countyTax)
        let stateTax = try values.decodeIfPresent(ModelStateTax.self, forKey: .stateTax)
        let federalTax = try values.decodeIfPresent(ModelFederalTax.self, forKey: .federalTax)
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, shopId: shopId, dirty: dirty!, name: name, active: active!, taxType: taxType, taxOrder: taxOrder, consumerType: consumerType, cityTax: cityTax, countyTax: countyTax, stateTax: stateTax, federalTax: federalTax)
    }
    
}

class ModelTerminalLocations :DBModel {
     @objc dynamic var id : String?    = ""
     @objc dynamic var created : Int = 0
     @objc dynamic var modified : Int = 0
     @objc dynamic var deleted : Bool = false
     @objc dynamic var updated : Bool = false
     @objc dynamic var companyId : String? = ""
     @objc dynamic var shopId : String? = ""
     @objc dynamic var dirty : Bool = false
     @objc dynamic var terminalId : String? = ""
     @objc dynamic var employeeId : String? = ""
     @objc dynamic var timeCardId : String? = ""
     @objc dynamic var deviceId : String? = ""
     @objc dynamic var name : String? = ""
                   var loc = List<Int>()
    
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
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,shopId : String?,dirty : Bool,terminalId : String?,employeeId : String?,timeCardId : String?,deviceId : String?,name : String?, loc : List<Int>){
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
        self.deviceId = deviceId
        self.name = name
        self.loc = loc
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
        let deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
        let name = try values.decodeIfPresent(String.self, forKey: .name)
        let loc = try values.decode([Int].self, forKey: .loc)
        let locList = List<Int>()
            locList.append(objectsIn: loc)
    self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, shopId: shopId, dirty: dirty!, terminalId: terminalId, employeeId: employeeId, timeCardId: timeCardId, deviceId: deviceId, name: name, loc: locList)
    }
    
}

class ModelTimeCard :DBModel {
   @objc dynamic var id : String? = ""
   @objc dynamic var created : Int = 0
   @objc dynamic var modified : Int = 0
   @objc dynamic var deleted : Bool = false
   @objc dynamic var updated : Bool = false
   @objc dynamic var companyId : String? = ""
   @objc dynamic var shopId : String? = ""
   @objc dynamic var dirty : Bool = false
   @objc dynamic var employeeId : String? = ""
   @objc dynamic var clockInTime : Int = 0
   @objc dynamic var clockOutTime : Int = 0
   @objc dynamic var clockin : Bool = false
                 var sessions = List<ModelSessions>()
    
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
    
    convenience init(id : String?,created : Int,modified : Int,deleted : Bool,updated : Bool,companyId : String?,shopId : String?,dirty : Bool,employeeId : String?,clockInTime : Int,clockOutTime : Int,clockin : Bool,sessions:List<ModelSessions>){
        self.init()
        self.id = id
        self.created = created
        self.modified = modified
        self.deleted = deleted
        self.updated   = updated
        self.companyId = companyId
        self.shopId = shopId
        self.dirty = dirty
        self.employeeId = employeeId
        self.clockInTime = clockInTime
        self.clockOutTime = clockOutTime
        self.clockin = clockin
        
    }
    
  convenience required init(from decoder: Decoder) throws {
        let values       = try decoder.container(keyedBy: CodingKeys.self)
        let id           = try values.decodeIfPresent(String.self, forKey: .id)
        let created      = try values.decodeIfPresent(Int.self, forKey: .created)
        let modified     = try values.decodeIfPresent(Int.self, forKey: .modified)
        let deleted      = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        let updated      = try values.decodeIfPresent(Bool.self, forKey: .updated)
        let companyId    = try values.decodeIfPresent(String.self, forKey: .companyId)
        let shopId       = try values.decodeIfPresent(String.self, forKey: .shopId)
        let dirty        = try values.decodeIfPresent(Bool.self, forKey: .dirty)
        let employeeId   = try values.decodeIfPresent(String.self, forKey: .employeeId)
        let clockInTime  = try values.decodeIfPresent(Int.self, forKey: .clockInTime)
        let clockOutTime = try values.decodeIfPresent(Int.self, forKey: .clockOutTime)
        let clockin      = try values.decodeIfPresent(Bool.self, forKey: .clockin)
        let  sessions    = try values.decode([ModelSessions].self, forKey: .sessions)

        let sessionsList = List<ModelSessions>()
            sessionsList.append(objectsIn: sessions)
    
        self.init(id: id, created: created!, modified: modified!, deleted: deleted!, updated: updated!, companyId: companyId, shopId: shopId, dirty: dirty!, employeeId: employeeId, clockInTime: clockInTime!, clockOutTime: clockOutTime!, clockin: clockin!, sessions: sessionsList)
    
    }
    

    
}
