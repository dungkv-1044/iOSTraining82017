//
//  TimelineCommentContainerView.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class TimelineCommentContainerView: UIViewController {

    var timelineCommentTVC : TimelineCommentTableViewController?
    var selectedIndexPath : Int?
    
    @IBOutlet private weak var bottomWriteCommentConstant: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(TimelineCommentContainerView.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "TimelineCommentTVC" {
            timelineCommentTVC = segue.destination as? TimelineCommentTableViewController
            guard let selectedIndexPath = selectedIndexPath else {
                return
            }
            timelineCommentTVC?.selectedIndexPath = selectedIndexPath
        }
    }
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
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

}
extension TimelineCommentContainerView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        showWriteComment()
        return true
    }
    
}
