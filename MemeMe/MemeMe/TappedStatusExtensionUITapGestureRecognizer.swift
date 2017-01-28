//
//  TappedStatusExtensionUITapGestureRecognizer.swift
//  MemeMe
//
//  Created by 남상욱 on 2017. 1. 28..
//  Copyright © 2017년 nam. All rights reserved.
//

import UIKit

extension UITapGestureRecognizer {
    func tapStatus(_ status : Bool) -> Bool{
        print("tapStatus: ", status)
        return !status
    }
}
