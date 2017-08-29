//
//  ViewController.swift
//  iOSTraining82017
//
//  Created by Nguyen Phong on 8/3/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
class SignInViewController: BaseViewController {
    @IBOutlet private weak var email: CustomTextField!
    @IBOutlet private weak var password: CustomTextField!
    @IBOutlet private weak var btnLogin: CustomButton!
    @IBOutlet private weak var btnRegister: UIButton!
    @IBOutlet private weak var btnPassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DataServices.shared.cancelRequest()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = email.text, let password = password.text else {
            return
        }
        configUI(isActive: false)
        if validateInputField(email: email, password: password) == true {
            doLogin(email: email, password: password)
        } else {
            configUI(isActive: true)
        }
    }
    private func doLogin(email: String, password: String) {
        DataServices.shared.login(username: email, password: password) { [weak self] (boolValue) in
            guard let strongSelf = self else { return }
            if boolValue == true {
                strongSelf.mainTabBarViewController?.setupMainApp()
                strongSelf.dismiss(animated: true, completion: nil)
            } else {
                strongSelf.showAlertMessage(title: LoginError.titleLoginFail, message: LoginError.messageLoginFail, titleAction: LoginError.actionTitle)
                strongSelf.configUI(isActive: true)
            }
        }
    }
    private func configUI(isActive: Bool?) {
        guard let isActive = isActive else {
            return
        }
        self.btnLogin.isEnabled = isActive
        self.btnPassword.isEnabled = isActive
        self.btnRegister.isEnabled = isActive
        self.email.isEnabled = isActive
        self.password.isEnabled = isActive
    }
}
extension SignInViewController {
    // MARK: Validate Input Field
    func validateInputField(email: String, password: String) -> Bool {
        var flag = false
        if email.isEmpty || password.isEmpty {
            showAlertMessage(title: LoginError.titleWrongInputType, message: LoginError.messageMustFilled, titleAction: LoginError.actionTitle)
            flag = false
        }
        if Helper.isValidTextLength(email: email, password: password) {
            if Helper.isValidEmail(email: email) == EmailValidationResult.emailValid {
                flag = true
            } else {
                showAlertMessage(title: LoginError.titleWrongInputType, message: LoginError.messageInvalid, titleAction: LoginError.actionTitle)
            }
        } else {
            showAlertMessage(title: LoginError.titleWrongInputType, message: LoginError.messageMustGreater, titleAction: LoginError.actionTitle)
        }
        return flag
    }
}
