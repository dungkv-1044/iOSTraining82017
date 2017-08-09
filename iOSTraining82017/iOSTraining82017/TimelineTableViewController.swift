//
//  TimelineTableViewController.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import os.log
class TimelineTableViewController: UITableViewController {
    
    var indexPathReturned: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
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
        cell.delegate = self
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
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "TimelineCommentContainer" {
            guard let timelineComment = segue.destination as? TimelineCommentContainerView else {
                return
            }
            timelineComment.selectedIndexPath = indexPathReturned
        }
        
    }
    @IBAction func unwindToTimeline(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? UpdateStatusViewController, let post = sourceViewController.post {
            DataServices.shared.posts.insert(post, at: 0)
            tableView.reloadData()
        }
    }
}
extension TimelineTableViewController : NewfeedItemProtocol {
    func returnIndexPath(selectedIndexPath: Int?) {
        if selectedIndexPath != nil {
            indexPathReturned = selectedIndexPath
        }
    }
}
