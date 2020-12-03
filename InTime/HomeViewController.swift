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
//        let vc3 = SettingViewController()
        let nav = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        let option1 = NSMutableAttributedString(string: "Feed")
        option1.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: option1.length))
        let tabBarItem  = BATabBarItem(image: UIImage(named: "icon1_unselected")!, selectedImage: UIImage(named: "icon1_selected")!, title: option1)
        let tabBarItem2 = BATabBarItem(image: UIImage(named: "icon2_unselected")!, selectedImage: UIImage(named: "icon2_selected")!, title: option1)
//        let tabBarItem3 = BATabBarItem(image: UIImage(named: "icon3_unselected")!, selectedImage: UIImage(named: "icon3_selected")!, title: option1)

        baTabBarController.viewControllers = [nav, nav2]
        baTabBarController.tabBarItems = [tabBarItem, tabBarItem2]
        baTabBarController.delegate = self
        baTabBarController.tabBarBackgroundColor = #colorLiteral(red: 0.1764705882, green: 0.2274509804, blue: 0.2980392157, alpha: 1)
        baTabBarController.tabBarItemStrokeColor = #colorLiteral(red: 0.9568627451, green: 0.6352941176, blue: 0.3803921569, alpha: 1)
        
        self.view.addSubview(baTabBarController.view)
    }
}

extension HomeViewController: BATabBarControllerDelegate {
    func tabBarController(_ tabBarController: BATabBarController, didSelect: UIViewController) {
        print("Delegate success!");
    }
}
