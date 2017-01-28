//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by 남상욱 on 2017. 1. 27..
//  Copyright © 2017년 nam. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

private let reuseIdentifier = "SentMemeCollectionViewCell"

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        
        // the size of the main view, wihich is dependent upon screen size.
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        // 행 또는 열 내의 Item 사이의 공간을 제어합니다.
        flowLayout.minimumInteritemSpacing = space
        // 행 또는 열 사이의 공간을 제어합니다.
        flowLayout.minimumLineSpacing = space
        // cell(item) 사이즈를 제어합니다.
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    
    // MARK: View Controller Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
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
    
    
    // MARK: UICollectionViewDataSource
    
    /*
     override func numberOfSections(in collectionView: UICollectionView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     */
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let memes = realm.objects(Meme.self)
        
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SentMemeCellConstants.collectionView, for: indexPath) as! MemeCollectionViewCell
        
        let memes = realm.objects(Meme.self)
        let meme = memes[(indexPath as NSIndexPath).row]
        
        
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        //file Path 추가하여 생성
        let pickedImageFilePath = URL(fileURLWithPath: documentDirectoryPath)
        let memedImageURL = pickedImageFilePath.appendingPathComponent(meme.memedImage)
        
        cell.memedImageView?.image = UIImage(contentsOfFile: memedImageURL.path)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Grab the MemeDetailViewController from Storyboard
        let memeDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: WithIdentifierConstants.memeDetailViewController) as! MemeDetailViewController
        
        let memes = realm.objects(Meme.self)
        let meme = memes[(indexPath as NSIndexPath).row]
        
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        //file Path 추가하여 생성
        let pickedImageFilePath = URL(fileURLWithPath: documentDirectoryPath)
        let memedImageURL = pickedImageFilePath.appendingPathComponent(meme.memedImage)
        
        //Populate view controller with data from the selected item
        memeDetailViewController.memedImage = UIImage(contentsOfFile: memedImageURL.path)
        
        // Present the view controller using navigation
        navigationController?.pushViewController(memeDetailViewController, animated: true)
    }
}
