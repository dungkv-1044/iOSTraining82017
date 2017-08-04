//
//  ExtensionString.swift
//  iOSTraining82017
//
//  Created by Dung on 8/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

extension SignInViewController : UITextFieldDelegate {
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
   
}
