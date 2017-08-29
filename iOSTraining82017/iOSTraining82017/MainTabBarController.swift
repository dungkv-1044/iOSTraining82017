//
//  MainTabBar.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - Varialbes
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // setup
        self.setupStartApp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.view.alpha = 0.0
        // setup view
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedIndex = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // animate when appear
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 1.0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup View
    private func setupView() {
        
    }
    
    func hideTabbar(hide: Bool?, animated: Bool = false) {
        self.tabBar.isHidden = hide ?? false
    }
    
    // MARK: - Actions
    
    // MARK: - Call Api
    
    // MARK: - Functions
    private func setupStartApp() {
        let startViewController = StartViewController.getViewControllerFromStoryboard(Storyboard.Main.name)
        // set list childs controller to tabbar
        let controllers = [startViewController]
        self.viewControllers = controllers
        self.hideTabbar(hide: true)
    }
    
    func setupMainApp() {
        // Timeline
        let navigationTimeline = UIStoryboard(name: Storyboard.Timeline.name, bundle: nil).instantiateInitialViewController()!
        let tabBarItemTimeline =  UITabBarItem(title: TabBarTitle.timeline, image: #imageLiteral(resourceName: "icon-home_page_filled"), tag: 10)
        navigationTimeline.tabBarItem = tabBarItemTimeline
        // User
        let navigationUser = UIStoryboard(name: Storyboard.User.name, bundle: nil).instantiateInitialViewController()!
        let tabBarItemUser =  UITabBarItem(title: TabBarTitle.profile, image: #imageLiteral(resourceName: "icon-edit_user_filled"), tag: 20)
        navigationUser.tabBarItem = tabBarItemUser
        // More
        let navigationMore = UIStoryboard(name: Storyboard.More.name, bundle: nil).instantiateInitialViewController()!
        let tabBarItemMore =  UITabBarItem(tabBarSystemItem: .more, tag: 30)
        navigationMore.tabBarItem = tabBarItemMore
        
        // set list childs controller to tabbar
        let controllers = [navigationTimeline, navigationUser, navigationMore]
        self.viewControllers = controllers
        self.hideTabbar(hide: false)
    }

}
