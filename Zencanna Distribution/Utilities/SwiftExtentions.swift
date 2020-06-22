//
//  SwiftExtentions.swift
//  shopperspick Distribution
//
//  Created by Apple on 20/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import Foundation
import UIKit
import KSToastView
import Kingfisher

extension Bundle {
    
    var releaseVersionNumber: String? {
        
        get{
            return infoDictionary?["CFBundleShortVersionString"] as? String
        }
    }
    
    var releaseBuildNumber: String? {
        
        get{
            return infoDictionary?["CFBundleVersion"] as? String
        }
    }
}

extension UIViewController {
    
    public func showToast(_ message: String? ) {
        KSToastView.ks_showToast(message)
        
    }
    
    public func showAlert(title: String?, message: String?, closure: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                closure()
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    public func showAlert(title: String?, message: String?, actions:[UIAlertActionStyle], closure: @escaping (UIAlertActionStyle) -> Void){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        //Add Multiple actions
        for userAction in actions{
            let Actiontitle = (userAction == UIAlertActionStyle.default) ? "Yes" : "Cancel"
            alert.addAction(UIAlertAction(title: Actiontitle , style: userAction, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    closure(.default)
                case .cancel:
                    print("cancel")
                    closure(.cancel)
                    
                case .destructive:
                    print("destructive")
                    
                }}))
        }
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension UINavigationController {
    
    func popViewControllers(controllersToPop: Int, animated: Bool) {
        if viewControllers.count > controllersToPop {
            popToViewController(viewControllers[viewControllers.count - (controllersToPop + 1)], animated: animated)
        } else {
            print("Trying to pop \(controllersToPop) view controllers but navigation controller contains only \(viewControllers.count) controllers in stack")
        }
    }
}

public extension UIImageView {
    public func imageFromUrl(_ urlString: String) {
        if let url = URL(string: urlString) {
            self.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(0.7))])
        }
    }
    
    public func tintImageColor(color : UIColor) {
        self.image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.tintColor = color
    }
    
    public func imageFromSecureURL(_ securedURL:URL?, placeHolder:String? = nil) {
        let modifier = AnyModifier { request in
            var r = request
            if let sURL = securedURL {
                if sURL.absoluteString.contains("connect-files-public") {
                    return r
                }
            }
            if let sessionToken = UtilityUserDefaults.sharedInstance().getToken() {
                // requestModifier will be called before image download request made.
                let sessionData = "Token \(sessionToken)"
                r.setValue(sessionData, forHTTPHeaderField: "Authorization")
                
            }
            
            return r
        }
        var placeHolderImage:UIImage?
        if let ph = placeHolder {
            placeHolderImage = UIImage(named: ph)
        }
        self.kf.setImage(with: securedURL, placeholder: placeHolderImage, options: [.requestModifier(modifier),.transition(ImageTransition.fade(0.7))])
    }
}

extension UIView {
    
    @IBInspectable var setShadowcolor: UIColor? {
        get {
            return layer.shadowColor.map(UIColor.init)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var setShadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var setShadowOffSet: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset.height = newValue.height
            layer.shadowOffset.width = newValue.width
        }
    }
    
    @IBInspectable var setShadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var setCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var setBorderColor: UIColor? {
        get {
            return layer.borderColor.map(UIColor.init)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var setBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    func addBorder(edge: UIRectEdge, color: UIColor, margins: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutAttribute.height,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutAttribute.height,
                                                multiplier: 1, constant: 1))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.bottom,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.leading,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.leading,
                                              multiplier: 1, constant: margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.trailing,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.trailing,
                                              multiplier: 1, constant: margins))
    }

    
}

extension UIColor{
    static let APPGreenColor = UIColor(hex :"0A8441")
   
    //Hex color
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
