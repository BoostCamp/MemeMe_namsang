//
//  Constants.swift
//  MemeMe
//
//  Created by 남상욱 on 2017. 1. 26..
//  Copyright © 2017년 nam. All rights reserved.
//

import UIKit


struct DefaultTextOfTextField {
    static let top: String = "TOP"
    static let bottom: String = "BOTTOM"
}

struct SentMemeCellConstants {
    static let tableView: String = "CellOfTableView"
    static let collectionView: String = "CellOfCollectionView"
}

struct WithIdentifierConstants {
    static let memeDetailViewController: String = "MemeDetailViewController"
}

struct CameraAccessAlert {
    static let title: String = "카메라 접근 승인 필요"
    static let message: String = "'설정(앱) - MemeMe - 카메라' 접근을 허용 해주세요."
    static let confirm: String = "확인"
}

struct PhotoAccessAlert {
    static let title: String = "사진 접근 승인 필요"
    static let message: String = "'설정(앱) - MemeMe - 사진' 접근을 허용 해주세요."
    static let confirm: String = "확인"
}
