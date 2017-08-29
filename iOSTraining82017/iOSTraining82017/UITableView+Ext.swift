//
//  ExtensionUITableView.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
extension UITableView {
    
    func registerNibCellBy(indentifier: String) {
        self.register(UINib(nibName: indentifier, bundle: nil), forCellReuseIdentifier: indentifier)
    }
    
    func registerNibHeaderViewBy(indentifier: String) {
        self.register(UINib(nibName: indentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: indentifier)
    }
    
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
