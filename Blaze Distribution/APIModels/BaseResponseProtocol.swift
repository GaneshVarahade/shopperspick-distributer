import Foundation

public protocol BaseResponseModel:Decodable{
    var id:String?{get set}
    var created: Int?{get set}
    var modified: Int?{get set}
    var deleted: Bool?{get set}
    var updated: Bool?{get set}
    var companyId:String?{get set}
}
