open class PlatformError : BaseResponseModel {
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    open var errorType:String!
    open var errorCode:Int = 0
    open var message:String!
    open var link:String!
    open var details:String!
    open var currentCompany:String!
   
}
