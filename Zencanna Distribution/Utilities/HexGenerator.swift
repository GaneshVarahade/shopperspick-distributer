//
//  HexGenerator.swift
//  Dispensary
//
//  Created by pankaj on 02/04/18.
//  Copyright © 2018 420connect. All rights reserved.
//

import Foundation
open class HexGenerator {
    
    private static var hexGenerator:HexGenerator = {
       let hexGen = HexGenerator()
        return hexGen
    }()
    
    public class func sharedInstance() -> HexGenerator {
        return hexGenerator
    }
    
    open func generate() -> String{
        
        let baseIntA = Int(arc4random() % 65535)
        let baseIntB = Int(arc4random() % 65535)
        let baseIntC = Int(arc4random() % 65535)
        let baseIntD = Int(arc4random() % 65535)
        let str = String(format: "%06X%06X%06X%06X", baseIntA, baseIntB, baseIntC, baseIntD)
        
        return str.localizedLowercase
        
    }
}
