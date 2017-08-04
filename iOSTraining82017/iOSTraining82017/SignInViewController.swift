//
//  ViewController.swift
//  iOSTraining82017
//
//  Created by Nguyen Phong on 8/3/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var email: CustomTextField!
    @IBOutlet weak var password: CustomTextField!
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = email.text, let password = password.text else {
            return
        }
        if email.isEmpty || password.isEmpty {
            showAlertMessage(title: "Wrong input format", message: "Email and Password must be filled.", titleAction: "Close")
            return
        }
        if Helper.isValidTextLength(email: email, password: password) {
            if Helper.isValidEmail(email: email) == EmailValidationResult.EmailValid {
                let mainTabBar = storyBoard.instantiateViewController(withIdentifier: "MainTabBar")
                self.present(mainTabBar, animated: true, completion: nil)
            } else {
                showAlertMessage(title: "Wrong email format", message: "Invalid email format. Please input a correct email.", titleAction: "Close")
            }
            
        } else {
            showAlertMessage(title: "Wrong input format", message: "Email and Password must be greater than 6 chacracters", titleAction: "Close")
        }
    }
    //MARK: private function
    private func showAlertMessage(title: String, message:String, titleAction: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: titleAction, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


