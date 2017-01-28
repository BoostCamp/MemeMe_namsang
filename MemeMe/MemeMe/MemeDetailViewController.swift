//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by 남상욱 on 2017. 1. 28..
//  Copyright © 2017년 nam. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    var memedImage: UIImage?
    var imageTapStatus: Bool? // 이미지 탭 여부
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = memedImage
        detailImageView.isUserInteractionEnabled = true
        imageTapStatus = false
        
        let tapGestrueOfdetailImageView = UITapGestureRecognizer(target: self, action: #selector(hideNavigatorBar))
        detailImageView.addGestureRecognizer(tapGestrueOfdetailImageView)
        // Do any additional setup after loading the view.
    }

    // MARK: general function

    
    func hideNavigatorBar(sender: UITapGestureRecognizer){

        if let status = imageTapStatus {
            
            let tap = sender.tapStatus(status)
            switch tap {
            case true:
                self.imageTapStatus = tap
                changeUIToState(true)
            case false:
                self.imageTapStatus = tap
                changeUIToState(false)
            }
        }
    }
    
    func changeUIToState(_ tap : Bool){
        if tap {
            self.view.backgroundColor = UIColor.black
            self.navigationController?.isNavigationBarHidden = true // navigation bar hide
            UIApplication.shared.isStatusBarHidden = true // status bar hide
        } else {
            self.view.backgroundColor = UIColor.white
            self.navigationController?.isNavigationBarHidden = false // navigation bar show
            UIApplication.shared.isStatusBarHidden = false // status bar show
        }
    }
}


