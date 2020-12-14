//
//  HomeViewController.swift
//  InTime
//
//  Created by Mac on 2020/11/6.
//  Copyright © 2020 Martin. All rights reserved.
//

import UIKit
//import BATabBarController

class HomeViewController: UIViewController {

    let baTabBarController = BATabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTabBar()
    }
    
    func initTabBar(){
        let vc1 = TimeViewController()
        let vc2 = SettingViewController()
        let nav = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        let option1 = NSMutableAttributedString(string: "每日倒數")
        option1.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: option1.length))
        
        option1.addAttribute(.font, value: UIFont(name: "Chalkduster", size: 18.0)! , range: NSRange(location: 0, length: option1.length))
        let tabBarItem  = BATabBarItem(image: UIImage(named: "tab_clock_selected")!, selectedImage: UIImage(named: "tab_clock_unselected")!, title: option1)
        
        let option2 = NSMutableAttributedString(string: "設定")
        option2.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: option2.length))
        let tabBarItem2 = BATabBarItem(image: UIImage(named: "tab_setting_selected")!, selectedImage: UIImage(named: "tab_setting_unselected")!, title: option2)

        baTabBarController.viewControllers = [nav, nav2]
        baTabBarController.tabBarItems = [tabBarItem, tabBarItem2]
        baTabBarController.delegate = self
        baTabBarController.tabBarBackgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2274509804, blue: 0.2980392157, alpha: 1)
        baTabBarController.tabBarItemStrokeColor = #colorLiteral(red: 0.9568627451, green: 0.6446316604, blue: 0.1247735781, alpha: 1)
        
        self.view.addSubview(baTabBarController.view)
    }
}

extension HomeViewController: BATabBarControllerDelegate {
    func tabBarController(_ tabBarController: BATabBarController, didSelect: UIViewController) {
//        print("Delegate success!");
    }
}
