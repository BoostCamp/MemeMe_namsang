//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by 남상욱 on 2017. 1. 27..
//  Copyright © 2017년 nam. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class MemeTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    
    // MARK: View Controller Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        let memes = realm.objects(Meme.self)
        tableView?.reloadData()
        enableEditButton(memesItems: memes.count)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let memes = realm.objects(Meme.self)

        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SentMemeCellConstants.tableView, for: indexPath) as! MemeTableViewCell
        
        let memes = realm.objects(Meme.self)
        let meme = memes[(indexPath as NSIndexPath).row]
        
        
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        //file Path 추가하여 생성
        let pickedImageFilePath = URL(fileURLWithPath: documentDirectoryPath)
        let memedImageURL = pickedImageFilePath.appendingPathComponent(meme.memedImage)
        
        cell.memedImageView?.image = UIImage(contentsOfFile: memedImageURL.path)
        //extension Date
        let createdDate = meme.createDate as Date
        cell.createdDateLabel?.text = createdDate.toString()
        cell.topLabel?.text = meme.topText
        cell.bottomLabel?.text = meme.bottomText
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the row from the data  source
         
            let memes = realm.objects(Meme.self)
            let meme = memes[(indexPath as NSIndexPath).row]
            try! realm.write {
                realm.delete(meme)
            }
            enableEditButton(memesItems: memes.count)
            //테이블 뷰에서 삭제
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    // MARK: general fucntions
    
    // Disable/Enable the edit button
    func enableEditButton(memesItems count : Int){
        // 삭제할 항목이 있을 때만 editButtonItem 활성화
        editButtonItem.isEnabled = (count > 0) ? true : false
        // 삭제할 항목이 없을 때 editing 종료
        if count == 0{
            setEditing(false, animated: true)
        }
    }
}
