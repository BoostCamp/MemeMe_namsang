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
        memes = appDelegate.memes
        tableView?.reloadData()
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
        // #warning Incomplete implementation, return the number of rows
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        return memes.count
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
        print(indexPath.row)
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
            memes.remove(at: indexPath.row)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.memes = memes
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditorViewController" {
            if let editiorViewController = segue.destination as? EditorViewController {
//                editiorViewController.delegate = self
            }
        }
    }
    
            
}
