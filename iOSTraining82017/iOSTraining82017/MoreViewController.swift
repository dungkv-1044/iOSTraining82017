//
//  MoreViewController.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/31/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController {

    @IBOutlet private weak var lbVersion: UILabel!
    @IBOutlet private weak var lbStatus: UILabel!
    @IBOutlet private weak var lbUpdateRequired: UILabel!
    @IBOutlet private weak var gActivity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAppInfo()
        // Do any additional setup after loading the view.
    }
    func fetchAppInfo() {
        DataServices.shared.requestAppInfo { [weak self] (appInfo) in
            guard let strongSelf = self else {return}
            guard let _appInfo = appInfo else {return}
            strongSelf.lbVersion.text = _appInfo.currentVersion
            strongSelf.lbStatus.text = _appInfo.status
            if let udR = _appInfo.updateRequired {
                strongSelf.lbUpdateRequired.text = "\(udR)"
            }
            strongSelf.gActivity.stopAnimating()
            strongSelf.gActivity.hidesWhenStopped = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction private func btnSignOut(_ sender: UIButton) {
        UserDefaults.standard.set(nil, forKey: UserDefaultKey.tokenValue)
        let userSettingVC = SignInViewController.getViewControllerFromStoryboard(Storyboard.User.name)
        self.present(userSettingVC, animated: true, completion: nil)
    }

}
