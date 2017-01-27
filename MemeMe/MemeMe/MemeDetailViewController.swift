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
    var memedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = memedImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
