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
    
    enum TextFieldType: Int {
        case top
        case bottom
    }
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Attribute 설정 및 center-aligned 적용
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
    
    
    
    // MARK: View Controller Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        // UIKeyboardWillShow, UIKeyboardWillHide이벤트 통지 가입 (NSNotification.Name)
        subscribeToKeyboardNotifications()
        
        //Disabling the Camera Button
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // UIKeyboardWillShow, UIKeyboardWillHide이벤트 통지 해제 (NSNotification.Name)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    
    // MARK: PickerImage functions
    
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
                    // dismiss하면 crash...
                    // self.dismiss(animated: true, completion: nil)
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
            imagePickerView.image = pickedImageFromImagePickerController
        }else{
            print("Optional binding Error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func keyboardWillShow(_ notification:Notification){
        // 아래 TextField에서 입력 시에, 키보드 높이만큼 view 의 offset을 move
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification:Notification){
        // keyboard가 hide될 때, view 의 offset을 복귀
        // 0으로 해도 결과는 같으나, 아래 TextField 입력 할때 오프셋을 변경했으니 조건 추가.
        if bottomTextField.isFirstResponder{
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        //NSNotification에는 딕셔너리 형태의 userInfo 프로퍼티가 있습니다. userInfo 프로퍼티를 이용하여 키보드의 위치와 크기를 가져올 수 있습니다.
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        // 옵저버 해제
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
    }
    
    
    // MARK: general function
    
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

extension ViewController : UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // 텍스트 필드에 입력을 시작하려 할 때.
        print("textFieldShouldBeginEditing called")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 텍스트 필드에 입력을 시작.
        print("textFieldDidBeginEditing called")
        // TODO List : When a user taps inside a textfield, the default text should clear
        // TODO List : Be sure to remove default text only, not user entered text.
       
        if let content = textField.text {
            // TextField의 기본 text가 "TOP", "BOTTOM"일때 내용을 clear 해줍니다.
            if content == DefaultTextOfTextField.top && textField.tag == TextFieldType.top.rawValue {
                textField.text = ""
            } else if content == DefaultTextOfTextField.bottom && textField.tag == TextFieldType.bottom.rawValue {
                textField.text = ""
            }
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // 텍스트필드의 수정이 완료되려 할 때 호출
        print("textFieldShouldEndEditing called.")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Editing is Done
        // 텍스트 필드의 수정이 완료됐을 때 호출
        print("textFieldDidEndEditing called")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Enter was pressed
        print("textFieldShouldReturn called.")
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 텍스트필드에 입력이 될 때마다 호출
        print("textField called.")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // 텍스트필드의 clear button을 눌렀을 때
        print("textFieldShouldClear")
        return true
    }
}
