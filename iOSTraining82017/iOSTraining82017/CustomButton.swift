//
//  CustomButton.swift
//  iOSTraining82017
//
//  Created by Dung on 8/3/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
@IBDesignable class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius  = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
}
