//
//  Meme.swift
//  MemeMe
//
//  Created by 남상욱 on 2017. 1. 27..
//  Copyright © 2017년 nam. All rights reserved.
//

import UIKit
import RealmSwift

// Meme model
class Meme: Object {
    
    dynamic var topText = ""
    dynamic var bottomText = ""
    dynamic var originalImage = ""
    dynamic var memedImage = ""
    dynamic var createDate = NSDate()
    
    override static func primaryKey() -> String? {
        
        return "originalImage"
    }
}

