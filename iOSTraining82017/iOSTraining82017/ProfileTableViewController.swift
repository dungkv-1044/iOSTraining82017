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
        registerCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func registerCell() {
        self.tableView.registerNibCellBy(indentifier: ReuseView.newfeedItem)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataServices.shared.posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseView.newfeedItem, for: indexPath) as? NewfeedItemTableViewCell
        let post = DataServices.shared.posts[indexPath.row]
        cell?.configureCell(post: post, indexPath: indexPath)
        cell?.layoutIfNeeded()
        return cell!
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    // MARK: Cache cell height and return estimatedHeight
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

    @IBAction private func unwindToProfile(sender: UIStoryboardSegue) {
        if sender.source is UpdateProfileViewController {
            if let data = UserDefaults.standard.data(forKey: UserDefaultKey.user),
                let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? User {
                bgrProfile.image = user.backgroundImage
                avaImage.image = user.avatarImage
                name.text = user.userName
            }
        }
    }
}
