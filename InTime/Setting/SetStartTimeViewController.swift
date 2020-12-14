//
//  SetStartTimeViewController.swift
//  InTime
//
//  Created by Mac on 2020/12/9.
//  Copyright © 2020 Martin. All rights reserved.
//

import UIKit
import SwiftDate
import AudioToolbox

class SetStartTimeViewController: UIViewController
{
    @IBOutlet weak var mainDatePicker: UIDatePicker!
    @IBOutlet weak var hintText: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.1176470588, blue: 0.1921568627, alpha: 1)
        self.title = "每日起始時間"
        confirmBtn.cornerRadius = 10;
        
        let stratTime = UserDefaults().value(forKey: .user) as? Date
        if stratTime == nil {
            let formatter = DateFormatter()
            formatter.dateFormat = "aaa hh:mm"
            let startOfDay = DateInRegion().dateAtStartOf(.day)
            let dateString = startOfDay.date.toString(.custom("aaa hh:mm"))
            let fromDateTime = formatter.date(from: dateString)
            mainDatePicker.date = fromDateTime!
        }else{
            mainDatePicker.date = stratTime!
        }
    
        mainDatePicker.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.168627451, blue: 0.2470588235, alpha: 1)
        mainDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        mainDatePicker.setValue(0.8, forKeyPath: "alpha")
        mainDatePicker.locale = Locale(identifier: "zh_TW")
        setHintTextWithDate(mainDatePicker.date)
    }
    
    @IBAction func dateOnChange(_ sender: UIDatePicker)
    {
        setHintTextWithDate(sender.date)
        UserDefaults().setValue(sender.date, forKey: .user)
        NotificationCenter.default.post(name: .startTime, object: nil, userInfo:nil)
    }
    
    func setHintTextWithDate(_ date:Date)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "aaa hh:mm"
        formatter.amSymbol = "上午"
        formatter.pmSymbol = "下午"
        let dateString = formatter.string(from: date)
        hintText.text = "您的一天將從 \(dateString) 開始計算";
    }
}
