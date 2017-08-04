//
//  CustomTextField.swift
//  iOSTraining82017
//
//  Created by Dung on 8/3/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
@IBDesignable class CustomTextField: UITextField {
    
    @IBInspectable var isCornerRadius : Bool = false {
        didSet {
            if isCornerRadius {
                self.layer.cornerRadius  = self.frame.height / 2
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = borderWidth
           
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
    
}
