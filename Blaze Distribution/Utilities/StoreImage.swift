import Foundation
import UIKit

public class StoreImage {
    
    open class func saveImage(image: UIImage, fileName: String, _ compressionQuality: CGFloat) -> Bool {
        guard let data = UIImageJPEGRepresentation(image, compressionQuality) ?? UIImagePNGRepresentation(image) else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent(fileName)!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    open class func getSavedImage(name: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(name).path)
        }
        return nil
    }
    
    open class func deleteSavedImage(name: String) throws {
        let fileManager = FileManager.default
        
        if let dir = try? FileManager.default.url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: false) {
            try fileManager.removeItem(atPath: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(name).path)
        }
    }
}
