//
//  StartViewController.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class StartViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // check app
        self.checkApp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Setup View
    
    // MARK: - Actions
    
    // MARK: - Call Api
    
    // MARK: - Functions
    private func checkApp() {
        if isLogged() == false {
            self.perform(#selector(StartViewController.gotoLogin), with: nil, afterDelay: 1)
        } else {
            self.perform(#selector(StartViewController.gotoMainApp), with: nil, afterDelay: 1)
        }
        
    }
    func isLogged() -> Bool {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultKey.tokenValue) else {return false}
        guard let tokenValue = NSKeyedUnarchiver.unarchiveObject(with: data) as? Token else {return false}
        guard tokenValue.accessToken != nil else {return false}
        return true
    }
    func gotoLogin() {
        let userSettingVC = SignInViewController.getViewControllerFromStoryboard(Storyboard.User.name)
        self.present(userSettingVC, animated: true, completion: nil)
    }
    
    func gotoMainApp() {
        self.mainTabBarViewController?.setupMainApp()
    }

}
