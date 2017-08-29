//
//  TimelineTableViewController.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import os.log
class TimelineTableViewController: UITableViewController, UISearchBarDelegate {
    var indexPathReturned: Int?
    var posts: [Post] = []
    var currentPage = 0
    var totalPage = 10
    var isNeedLoadmore: Bool {
        return currentPage < totalPage
    }
    
    @IBOutlet private var mySearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TimelineTableViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        registerCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        if posts.count == 0 {
            tableView.reloadData()
        }
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        mySearchBar.endEditing(true)
    }
    func fetchTimelineFromAPI() {
        DataServices.shared.requestAllPost { [weak self] (result) in
            guard let strongSelf = self else {return}
            guard let _posts = result else {return}
            strongSelf.posts += _posts
            strongSelf.tableView.reloadData()
            strongSelf.currentPage += 1
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DataServices.shared.cancelRequest()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func registerCell() {
       self.tableView.registerNibCellBy(indentifier: ReuseView.newfeedItem)
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return isNeedLoadmore ? posts.count + 1 : posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case posts.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseView.loadMoreCell, for: indexPath)
            fetchTimelineFromAPI()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseView.newfeedItem, for: indexPath) as? NewfeedItemTableViewCell
            let post = posts[indexPath.row]
            cell?.configureCell(post: post, indexPath: indexPath)
            cell?.delegate = self
            cell?.layoutIfNeeded()
            return cell!
        }
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
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    @IBAction private func unwindToTimeline(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? UpdateStatusViewController, let post = sourceViewController.post {
            DataServices.shared.posts.insert(post, at: 0)
            tableView.reloadData()
        }
    }
    
    // MARK : Search Bar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.mySearchBar.endEditing(true)
    }
}
extension TimelineTableViewController : NewfeedItemProtocol {
    func returnIndexPath(selectedIndexPath: Int?) {
        if selectedIndexPath != nil {
            let timelineComment = TimelineCommentContainerView.getViewControllerFromStoryboard(Storyboard.Timeline.name)
            if let c = timelineComment as? TimelineCommentContainerView {
                c.selectedIndexPath = selectedIndexPath
                self.navigationController?.pushViewController(c, animated: true)
            }
            
        }
    }
}
