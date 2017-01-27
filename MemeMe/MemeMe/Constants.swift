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


struct AlertConstants {
    static let title = "사진 소스 선택"
    static let message = "사진을 가져올 소스를 선택해 주세요."
    static let successMessage = "이미지를 성공적으로 가져왔습니다."
    static let emptyMessage = "저장된 사진이 없습니다."
    static let library = "라이브러리"
    static let photoAlbum = "사진앨범"
    static let confirm = "확인"
    static let cancel = "취소"
}
