//
//  ExtensionUIViewController.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
extension UIViewController {
    
    static func getViewControllerFromStoryboard(_ storyboardName: String) -> UIViewController {
        let identifier = String(describing: self)
        return self.getViewControllerWithIdentifier(identifier, storyboardName: storyboardName)
    }
    
    static func getNavigationControllerFromStoryboard(_ storyboardName: String) -> UIViewController {
        let identifier = String(describing: self) + "Nav"
        return self.getViewControllerWithIdentifier(identifier, storyboardName: storyboardName)
    }
    
    static func getViewControllerWithIdentifier(_ identifier: String, storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}

extension UIViewController {
    func showAlertMessage(title: String, message: String, titleAction: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: titleAction, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension UIViewController {
    func runAnimate() {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
