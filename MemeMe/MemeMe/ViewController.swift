//
//  ViewController.swift
//  MemeMe
//
//  Created by 남상욱 on 2017. 1. 26..
//  Copyright © 2017년 nam. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

//UIImagePickerController를 사용하기 위해서는 UIImagePickerControllerDelegate, UINavigationControllerDelegate를 채택해야 함.

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    enum PickType: String {
        case camera = "camera"
        case album = "album"
    }
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        albumButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self // Set delegate
        imagePickerController.sourceType = .camera
        
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        print(status.rawValue)
        switch status {
        case .authorized:
            //handle authorized status
            self.present(imagePickerController, animated: true, completion: nil)
        case .denied, .restricted:
            showNotice(alertCase: PickType.camera)
            print("설정앱에서 카메라 항목을 허가해주세요.")
        case .notDetermined :
            // ask for permissions
            self.present(imagePickerController, animated: true, completion: nil)
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { granted in
                if granted == true {
                    // User granted
                    print("User granted")
                } else {
                    // User Rejected
                    print("User Rejected")
                    //                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self // Set delegate
        imagePickerController.sourceType = .photoLibrary
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            //handle authorized status
            self.present(imagePickerController, animated: true, completion: nil)
        case .denied, .restricted :
            //handle denied status
            showNotice(alertCase: PickType.album)
            print("설정앱에서 사진 항목을 허가해주세요.")
        case .notDetermined:
            // ask for permissions
            self.present(imagePickerController, animated: true, completion: nil)
            PHPhotoLibrary.requestAuthorization() { status in
                switch status {
                case .authorized:
                    print("authorized")
                case .denied, .restricted:
                    self.dismiss(animated: true, completion: nil)
                    print("denied and restricted")
                case .notDetermined:
                    print("notDetermined")
                }
            }
        }
    }
    
    
    //UIImagePickerView에서 Cancel 버튼을 눌렀을 때 호출.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        print("imagePickerControllerDidCancel called")
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImageFromImagePickerController = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            UIImageView의 비율에 맞게 pickedImage의 크기를 Scale
//            imagePickerView.contentMode = UIViewContentMode.scaleAspectFit
            
            imagePickerView.image = pickedImageFromImagePickerController
        }else{
            print("Optional binding Error")
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: general function
    
    func checkPhotoLibraryPermission() -> Bool {
        
        var checkedFlag: Bool = false
        
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            print("authorized check part.")
            checkedFlag = true
        //handle authorized status
        case .denied, .restricted :
            checkedFlag = false
            print(".denied, .restricted check part.")
        //handle denied status
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization() { status in
                switch status {
                case .authorized:
                    print(".authorized requestAuthorization part.")
                    checkedFlag = true
                case .denied, .restricted:
                    print(".denied, .restricted requestAuthorization part.")
                    checkedFlag = false
                case .notDetermined:
                    print(".notDetermined, .restricted requestAuthorization part.")
                    checkedFlag = false
                }
            }
        }
        return checkedFlag
    }
    
    func showNotice(alertCase : PickType){
        
        switch alertCase {
        case .camera:
            let alertController = UIAlertController(title: CameraAccessAlert.title, message: CameraAccessAlert.message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: CameraAccessAlert.confirm, style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        case .album:
            let alertController = UIAlertController(title: PhotoAccessAlert.title, message: PhotoAccessAlert.message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: PhotoAccessAlert.confirm, style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}

