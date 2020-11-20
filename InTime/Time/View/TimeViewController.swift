//
//  TimeViewController.swift
//  InTime
//
//  Created by Mac on 2020/11/6.
//  Copyright © 2020 Martin. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {
    
    @IBOutlet weak var centerTime: UILabel!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.1176470588, blue: 0.1921568627, alpha: 1)
        
        let circle = TimerCircleView()
        view.addSubview(circle);
        circle.snp.makeConstraints { (make) in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.centerY.equalTo(centerTime)
            make.height.equalTo(400)
        }
        
        refreshTimeText()
        startTimer()
    }
    
    @objc func refreshTimeText()
    {
        let date = Date();
        let nowDate = date.date2TaipeiDate(date: date);
        let nightDate = date.date2TaipeiDate(date: nowDate.endOfDay);
        let time = Date().compareCurrntTime(start: nowDate, end: nightDate)
        self.centerTime.text = "\(time.hour):\(time.minute)"
    }

    func startTimer()
    {
        let nowDate = Date()
        let nowSecond = nowDate.getCalendar().component(.second, from: Date().localDate())
        var loopTime = Double(60-nowSecond)
        loopTime = 1
        self.timer = Timer.scheduledTimer(timeInterval: loopTime, target: self, selector: #selector(uptadeTimer), userInfo: nil, repeats: false)
    }

    @objc func uptadeTimer()
    {
        if self.timer != nil
        {
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(uptadeTimer), userInfo: nil, repeats: false)
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: MT_TIMER_REFRESH), object: nil, userInfo:nil)
        refreshTimeText()
    }
}


