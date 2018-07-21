import Foundation

open class AQLog {
    
    static let TAG_SYNC:String = "SYNCDATA"
    static let TAG_HEX:String = "HEX"
    static let TAG_ARRAY_DATA:String = "ARRAY_DATA"
    static let TAG_JSON_DATA:String = "JSON_DATA"
    static let TAG_REQUEST_DATA:String = "REQUEST_DATA"
    static let TAG_RESPONSE_DATA:String = "RESPONSE_DATA"
    static let TAG_DATABASE_DATA:String = "DATABASE_DATA"
    static let TAG_SESSONDATA:String = "SESSONDATA"
    static let TAG_ERRORDATA:String = "ERRORDATA"
    
    open class func trace(_ fileName:String = #file, functionName:String = #function, line:Int = #line) {
        #if DEBUG
        print("trace: <\((fileName as NSString).lastPathComponent):\(functionName):\(line)>\n")
        #endif
    }
    
    open class func error(_ fileName:String = #file, functionName:String = #function, line:Int = #line) {
        #if DEBUG
        print("error: <\((fileName as NSString).lastPathComponent):\(functionName):\(line)>\n")
        #endif
    }
    
    open class func debug(_ fileName:String = #file, functionName:String = #function, line:Int = #line) {
        #if DEBUG
        print("debug: \(Thread.current) <\((fileName as NSString).lastPathComponent):\(functionName):\(line)>\n")
        #endif
    }
    
    open class func info(_ format:String,fileName:String = #file, functionName:String = #function,line:Int = #line) {
        #if DEBUG
        print("info: <\((fileName as NSString).lastPathComponent):\(functionName):\(line)> \(format)\n")
        #endif
    }
    
    open class func info(_ format2:NSString,fileName:String = #file, functionName:String = #function,line:Int = #line, args2:CVarArg...) {
        #if DEBUG
        let str = NSString(format: format2 as String, arguments: getVaList(args2))
        print("info: <\((fileName as NSString).lastPathComponent):\(functionName):\(line)> \(str)\n")
        #endif
    }
    
    open class func debug(tag:String,text:String,fileName:String = #file, functionName:String = #function,line:Int = #line) -> Void{
        print("LOGS: \(tag)-------------------------------------------------------------------------------")
        print("LOGS: \(tag) ")
        print("LOGS: \(tag) -- <\((fileName as NSString).lastPathComponent):\(functionName):\(line)>")
        print("LOGS: \(tag) ")
        print("LOGS: \(tag) -- \(text)")
    }
}
