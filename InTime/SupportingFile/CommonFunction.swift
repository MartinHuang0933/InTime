//
//  CommonFunction.swift
//  W3MusicPlayer
//
//  Created by Mac on 2020/5/25.
//  Copyright © 2020 Martin. All rights reserved.
//

import UIKit

class CommonFunction: NSObject {

    static let sharedInstance = CommonFunction()
    
    func setLabelShadow(label:UILabel)
    {
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width:5, height: 5)
        label.layer.shadowOpacity = 0.1
        label.layer.borderColor = UIColor(white: 0, alpha: 0.1).cgColor
    }
}
