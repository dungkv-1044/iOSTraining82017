//
//  TimelineCommentContainerView.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class TimelineCommentContainerView: BaseViewController, UISearchBarDelegate {

    var timelineCommentTVC: TimelineCommentTableViewController?
    var selectedIndexPath: Int?
    @IBOutlet private weak var bottomWriteCommentConstant: NSLayoutConstraint!
    @IBOutlet private var mySearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TimelineTableViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        guard let i = selectedIndexPath else {
            return
        }
        print(i)
    }
    func dismissKeyboard() {
        mySearchBar.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(TimelineCommentContainerView.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == SegueIdentifier.gotoTimelineCommentTVC {
            timelineCommentTVC = segue.destination as? TimelineCommentTableViewController
            guard let selectedIndexPath = selectedIndexPath else {
                return
            }
            timelineCommentTVC?.selectedIndexPath = selectedIndexPath
        }
    }
    @IBAction private func backButtonTapped(_ sender: UIBarButtonItem) {
        if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
    }
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.bottomWriteCommentConstant.constant = (keyboardSize.height - 49)
            }
        }
    }
    func showWriteComment() {
        self.bottomWriteCommentConstant.constant = 0
    }
    
    // MARK : Search Bar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.mySearchBar.endEditing(true)
    }
    
}
extension TimelineCommentContainerView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        showWriteComment()
        return true
    }
}
