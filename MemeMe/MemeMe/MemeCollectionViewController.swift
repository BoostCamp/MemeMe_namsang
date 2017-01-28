//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by 남상욱 on 2017. 1. 27..
//  Copyright © 2017년 nam. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SentMemeCollectionViewCell"

class MemeCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
      
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
        print("viewWillAppear in MemeCollectionViewController")
      
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear in MemeCollectionViewController")
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear in MemeCollectionViewController")
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear in MemeCollectionViewController")
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
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SentMemeCellConstants.collectionView, for: indexPath) as! MemeCollectionViewCell

        let meme = memes[(indexPath as NSIndexPath).row]
        cell.memedImageView.image = meme.memedImage
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Grab the MemeDetailViewController from Storyboard
        let memeDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: WithIdentifierConstants.memeDetailViewController) as! MemeDetailViewController
        
        //Populate view controller with data from the selected item
        memeDetailViewController.memedImage = memes[(indexPath as NSIndexPath).row].memedImage as UIImage
        
        // Present the view controller using navigation
        navigationController?.pushViewController(memeDetailViewController, animated: true)
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
