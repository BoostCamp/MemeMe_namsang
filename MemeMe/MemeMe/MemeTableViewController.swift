//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by 남상욱 on 2017. 1. 27..
//  Copyright © 2017년 nam. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    
    var memes: [Meme]!
    var memesCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad in MemeTableViewController")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // set delegate
        self.tableView.delegate = self
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    
    // MARK: View Controller Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear in MemeTableViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       
        if (memesCount != appDelegate.memes.count){
            memes = appDelegate.memes
            memesCount = memes.count
            tableView?.reloadData()
        }
        enableEditButton(memesItems: memesCount)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear in MemeTableViewController")
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear in MemeTableViewController")
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear in MemeTableViewController")
        super.viewDidDisappear(animated)
    }
    
    
/*
        func sendUpdateIndexpath(index: Int) {
            print("sendUpdateIndexpath: ", index)
            let insertionIndexPath = IndexPath(row: index - 1 , section: 0)
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: [insertionIndexPath], with: .automatic)
            self.tableView!.endUpdates()
        }
*/

    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return memes.count
    //    }
    
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memesCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...

        let cell = tableView.dequeueReusableCell(withIdentifier: SentMemeCellConstants.tableView, for: indexPath) as! MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.memedImageView?.image = meme.memedImage
        cell.topLabel?.text = meme.topText
        cell.bottomLabel?.text = meme.bottomText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Grab the MemeDetailViewController from Storyboard
        let memeDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: WithIdentifierConstants.memeDetailViewController) as! MemeDetailViewController
        
        //Populate view controller with data from the selected item
        memeDetailViewController.memedImage = memes[(indexPath as NSIndexPath).row].memedImage as UIImage
        
        // Present the view controller using navigation
        navigationController?.pushViewController(memeDetailViewController, animated: true)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the row from the data  source
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            memes.remove(at: indexPath.row) //memes 오브젝트 배열에서 선택한 인덱스 삭제
          
            appDelegate.memes = memes // appDelegate의 shared model에서도 삭제
            memesCount -= 1
            enableEditButton(memesItems: memesCount)
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
            
}
