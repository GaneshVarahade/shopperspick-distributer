open class PlatformError : BaseResponseModel {
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var errorType:String?
    public var errorCode:Int?
    public var message:String?
    public var link:String?
    public var details:String?
    public var currentCompany:String?
   
}
