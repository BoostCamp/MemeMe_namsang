//
//  DateExtension.swift
//  MemeMe
//
//  Created by 남상욱 on 2017. 1. 28..
//  Copyright © 2017년 nam. All rights reserved.
//

import Foundation

extension Date {
    //dateFormatter에 맞게 String 타입으로 반환
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
