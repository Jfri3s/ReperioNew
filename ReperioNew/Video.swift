//
//  Video.swift
//  ReperioNew
//
//  Created by Jeremiah Fries on 8/25/16.
//  Copyright © 2016 Om. All rights reserved.
//

import UIKit

class SafejsonObject: NSObject {
    
    override func setValue(value: AnyObject?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.characters.first!).uppercaseString
        
        let range = key.startIndex...key.startIndex.advancedBy(0)
        
        let selectorString = key.stringByReplacingCharactersInRange(range, withString: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.respondsToSelector(selector)
        
        if !responds {
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    
}

class Video: SafejsonObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var hoursLeftOnPromo: NSNumber? 
    
    var duration: NSNumber? 
    var channel: Channel?
    
    
    override func setValue(value: AnyObject?, forKey key: String) {
     
        if key == "channel" {
            //custome channel setup 
            self.channel = Channel()
            self.channel?.setValuesForKeysWithDictionary(value as! [String: AnyObject])
            
        } else {
            super.setValue(value, forKey: key)

        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dictionary)
    }
    
    
}

class Channel: SafejsonObject {
    var name: String?
    var profile_image_name: String?
    
    
}


