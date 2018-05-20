import Foundation

public enum EnvironmentType:String {
    case DEBUG  = "DEBUG"
    case DEV    = "DEV"
    case STAGE  = "STAGE"
    case PROD   = "PROD"
}

public enum SERVERTYPE:String {
    case LOCALSERVER  = "LOCALSERVER"
    case DEVSERVER    = "DEVSERVER"
    case STAGESERVER  = "STAGESERVER"
    case PRODSERVER   = "PRODSERVER"
}

open class Environment:NSObject {
    open var appUrl:String!                 = API_PROD_URL;
    open var type:EnvironmentType           = EnvironmentType.PROD
    open var gaTrackingId:String!           = nil
    open var pusherKey:String!              = nil
    open var pusherChannelPrefix:String!    = nil
    open var timeoutDurationSeconds:Int     = 5 // In Minutes
}

private let _sharedConfig:DistributionConfig  = DistributionConfig()

open class DistributionConfig:NSObject {
    open var environment:Environment!   = nil
    open var settings:NSDictionary!     = nil
    open var bypass:Bool                = false
    
    open class func sharedInstance()->DistributionConfig!{
        return _sharedConfig;
    }
    
    override init() {
        super.init();
        self.load()
    }
    
    fileprivate func load() {
        _ = ProcessInfo.processInfo.environment
        environment = Environment()
        
        // if this is local, then let's override
        let filePath = Bundle.main.path(forResource: "environment", ofType: "json")
        let data = FileManager.default.contents(atPath: filePath!)
        
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data!, options : .allowFragments) as? [String:Any]{
                
                // Override
                if let env = jsonArray["env"] as! String? {
                    environment.type = EnvironmentType(rawValue: env)!
                    
                    switch(environment.type) {
                    case EnvironmentType.DEBUG:
                        environment.gaTrackingId        = nil
                        environment.pusherChannelPrefix = nil
                        environment.pusherKey           = nil
                        break;
                    case EnvironmentType.DEV:
                        environment.gaTrackingId        = nil
                        environment.pusherChannelPrefix = nil
                        environment.pusherKey           = nil
                        break;
                    case EnvironmentType.PROD:
                        environment.gaTrackingId        = nil
                        environment.pusherChannelPrefix = nil
                        environment.pusherKey           = nil
                        break;
                    case EnvironmentType.STAGE:
                        environment.gaTrackingId        = nil
                        environment.pusherChannelPrefix = nil
                        environment.pusherKey           = nil
                        break;
                    }
                }
                
                if let server = jsonArray["server"] as! String? {
                    
                    let serverType = SERVERTYPE(rawValue: server)!
                    
                    switch(serverType) {
                    case SERVERTYPE.LOCALSERVER:
                        environment.appUrl              = API_LOCAL_URL;
                        break;
                    case SERVERTYPE.DEVSERVER:
                        environment.appUrl              = API_DEV_URL;
                        break;
                    case SERVERTYPE.STAGESERVER:
                        environment.appUrl              = API_STAGE_URL;
                        break;
                    case SERVERTYPE.PRODSERVER:
                        environment.appUrl              = API_PROD_URL;
                        break;
                    }
                    
                }
                
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    open func getAppUrl()->String! {
        return environment.appUrl
    }
    open func getPusherKey()->String {
        return environment.pusherKey!
    }
    
    open func getPusherChannelPrefix()->String {
        return environment.pusherChannelPrefix!
    }
}
