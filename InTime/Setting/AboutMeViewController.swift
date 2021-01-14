//
//  AboutMeViewController.swift
//  InTime
//
//  Created by Mac on 2020/12/14.
//  Copyright © 2020 Martin. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {

    @IBOutlet weak var appIcon: UIImageView!
    
    lazy var version : UILabel = {
        let version = UILabel(frame: .zero)
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        version.text = "Ver \(appVersion!)"
        return version
    }()
    
    lazy var name : UILabel = {
        let name = UILabel(frame: .zero)
        name.text = "Design by Martin Huang"
        return name
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.1176470588, blue: 0.1921568627, alpha: 1)
        self.title = "關於"
        
        self.view.addSubview(version);
        version.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(appIcon.snp_bottomMargin).offset(40)
        }
        
        self.view.addSubview(name);
        name.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(version.snp_bottomMargin).offset(20)
        }
    }
}
