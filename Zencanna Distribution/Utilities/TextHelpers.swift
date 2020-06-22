import Foundation

open class TextHelpers {    
    open class func toBooleanText(_ state:Bool) -> String {
        return state ? "Yes" : "No"
    }
    
    
    open class func toBooleanActiveText(_ state:Bool) -> String {
        return state ? "Active" : "Inactive"
    }
    
    open class func stringOrEmpty(_ str:String?) -> String {
        if let string : String = str {
            return string
        }
        
        return ""
    }
    
    open class func isEmpty(_ str:String?) -> Bool {
        if str?.isEmpty ?? true {
            return true
        }
        return false
    }
}
