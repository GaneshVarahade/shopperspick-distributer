import Foundation

public enum EventBusEventType : String {
    case SYNCDATA = "SYNCDATA"
   
}


private let _eventBus:EventBus = EventBus()
open class EventBus {
    
    open class func sharedBus() -> EventBus {
        return _eventBus;
    }
    
    open func subscribe(_ subscriber:AnyObject, selector:Selector, eventType:EventBusEventType) {
        NotificationCenter.default.addObserver(subscriber, selector: selector, name: NSNotification.Name(rawValue: eventType.rawValue), object: nil)
    }
    open func unsubscribe(_ subscriber:AnyObject, eventType:EventBusEventType) {
        NotificationCenter.default.removeObserver(subscriber, name: NSNotification.Name(rawValue: eventType.rawValue), object: nil)
    }
    
    open func publish(_ eventType:EventBusEventType, data:[String:AnyObject]? = nil) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: eventType.rawValue), object: nil, userInfo: data)
    }
    
    open func publishMain(_ eventType:EventBusEventType, data:[String:AnyObject]? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name(rawValue: eventType.rawValue), object: nil, userInfo: data)
        }
    }
    
    open func unsubscribeAllTags(_ subscriber:AnyObject) {
        NotificationCenter.default.removeObserver(subscriber)
    }
}
