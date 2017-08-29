//
//  ViewController.swift
//  iOSTraining82017
//
//  Created by Nguyen Phong on 8/3/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
struct LoginError {
    static let titleWrongInputType = "Wrong input format"
    static let titleLoginFail = "Username or password are incorrect."
    static let messageInvalid = "Invalid email format. Please input a correct email."
    static let messageMustFilled = "Email and Password must be filled."
    static let messageMustGreater = "Email and Password must be greater than 6 chacracters."
    static let messageLoginFail = "Username or password are incorrect."
}
class SignInViewController: UIViewController {
    @IBOutlet private weak var email: CustomTextField!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var password: CustomTextField!
    var activeField: UITextField?
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        DataServices.shared.requestJSONFromURL()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = email.text, let password = password.text else {
            return
        }
        if validateInputField(email: email, password: password) == true {
            DataServices.shared.login(username: email, password: password) { [weak self] (boolValue) in
                guard let strongSelf = self else { return }
                if boolValue == true {
                    let mainTabBar = strongSelf.storyBoard.instantiateViewController(withIdentifier: "MainTabBar")
                    strongSelf.present(mainTabBar, animated: true, completion: nil)
                } else {
                    strongSelf.showAlertMessage(title: LoginError.titleLoginFail, message: LoginError.messageLoginFail, titleAction: "Close")
                }
            }
        }
    }
    func validateInputField(email: String, password: String) -> Bool {
        var flag = false
        if email.isEmpty || password.isEmpty {
            showAlertMessage(title: LoginError.titleWrongInputType, message: LoginError.messageMustFilled, titleAction: "Close")
            flag = false
        }
        if Helper.isValidTextLength(email: email, password: password) {
            if Helper.isValidEmail(email: email) == EmailValidationResult.emailValid {
                flag = true
            } else {
                showAlertMessage(title: LoginError.titleWrongInputType, message: LoginError.messageInvalid, titleAction: "Close")
            }
        } else {
            showAlertMessage(title: LoginError.titleWrongInputType, message: LoginError.messageMustGreater, titleAction: "Close")
        }
        return flag
    }
    // MARK: private function
    private func showAlertMessage(title: String, message: String, titleAction: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: titleAction, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func deregisterFromKeyboardNotifications() {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func keyboardWasShown(notification: NSNotification) {
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if !aRect.contains(activeField.frame.origin) {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    func keyboardWillBeHidden(notification: NSNotification) {
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
}
