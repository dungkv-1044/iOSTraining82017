//
//  ProfileTableViewController.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/16/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    @IBOutlet private weak var bgrProfile: UIImageView!
    @IBOutlet private weak var avaImage: UIImageView!
    @IBOutlet private weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataServices.shared.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewfeedItem", for: indexPath) as! NewfeedItemTableViewCell
        let post = DataServices.shared.posts[indexPath.row]
        cell.configureCell(post: post, indexPath: indexPath)
        cell.layoutIfNeeded()
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    //MARK: Cache cell height and return estimatedHeight
    fileprivate var tableViewEstimateHeightCaches = [String: CGFloat]()
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // get height of cell, and cache in array
        let eheight = cell.bounds.height
        let key = self.getKeyCachedAtIndexPath(indexPath: indexPath)
        self.tableViewEstimateHeightCaches[key] = eheight
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // get estimate height in cached array
        let key = self.getKeyCachedAtIndexPath(indexPath: indexPath)
        if let eHeight = self.tableViewEstimateHeightCaches[key] {
            return eHeight
        }
        // create estimate height
        return UITableViewAutomaticDimension
    }
    func getKeyCachedAtIndexPath(indexPath: IndexPath) -> String {
        return "\(indexPath.section)-\(indexPath.row)" // add thêm id object
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    @IBAction func unwindToProfile(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? UpdateProfileViewController {
            if let data = UserDefaults.standard.data(forKey: "user"),
                let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? User {
                bgrProfile.image = user.backgroundImage
                avaImage.image = user.avatarImage
                name.text = user.userName
               
            }
           
            
        }
    }

}
