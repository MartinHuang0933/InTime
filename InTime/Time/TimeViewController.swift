//
//  TimeViewController.swift
//  InTime
//
//  Created by Mac on 2020/11/6.
//  Copyright © 2020 Martin. All rights reserved.
//

import UIKit
import SwiftDate

class TimeViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayCountLabel: UILabel!
    @IBOutlet weak var centerTime: UILabel!
    var timer: Timer?
    var circleDuration: Double?
    var circle :TimerCircleView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // 基本設定
        TimeZone.ReferenceType.default = TimeZone(identifier: "Asia/Taipei")!
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.1176470588, blue: 0.1921568627, alpha: 1)

        // 更新文字 & 設置Timer
        refreshTimeText()
        startTimer()
        
        // 畫時間圖形
        circle = TimerCircleView(frame: CGRect(), duration: self.circleDuration!)
        view.addSubview(circle!);
        circle!.snp.makeConstraints { (make) in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.centerY.equalTo(centerTime)
            make.height.equalTo(400)
        }
        
        // 監聽每日起始時間是否被更動
        NotificationCenter.default.addObserver(forName: .startTime , object: nil, queue: nil) {(notification) in
        
            // 計算新的起始時間，更新文字 & 圖形
            if var stratTime = UserDefaults().value(forKey: .user) as? Date
            {
                // 更新倒數時間 - 圖形
                stratTime.year = Date().year
                stratTime.month = Date().month
                stratTime.day = Date().day
                
                let diffDate:DateComponents = stratTime-Date()
                var daysec : Int?
                if(stratTime > Date()){
                    daysec = diffDate.hour!*3600 + diffDate.minute!*60 + diffDate.second!
                }else{
                    daysec = 86400 + diffDate.hour!*3600 + diffDate.minute!*60 + diffDate.second!
                }
                self.circle?.duration = Double(daysec!)
                self.circle?.updateCircleLayer()
                
                // 更新倒數時間 - 文字
                self.refreshTimeText()
            }
        }
    }
    
    @objc func refreshTimeText()
    {
        let nowDate = Date().localDate()
        var endOfDay : Date
        
        // 依據每日起始時間計算顯示文字
        if var stratTime = UserDefaults().value(forKey: .user) as? Date
        {
            // 有設定每日起始時間
            stratTime.year = Date().year
            stratTime.month = Date().month
            stratTime.day = Date().day
            
            // 若起始時間小現在時間，則+1天去扣回
            if(stratTime>Date()){
                endOfDay = Date().date2TaipeiDate(date: stratTime)
            }else{
                stratTime.day = stratTime.day + 1
                endOfDay = Date().date2TaipeiDate(date: stratTime)
            }
        }
        else
        {
            // 無設定每日起始時間 , 預設為午夜12點
            endOfDay = Date().dateAtEndOf(.day)
        }
        
        // 計算相差時間
        let time = Date().compareCurrntTime(start: nowDate, end: endOfDay)
        let hourText = String(format: "%02d", time.hour)
        let minuteText = String(format: "%02d", time.minute)
        self.centerTime.text = "\(hourText):\(minuteText)"
        self.dateLabel.text = nowDate.toFormat("yyyy.MM.dd")
        self.circleDuration = Double(time.hour*3600 + time.minute*60 + time.second)

        // 計算今天倒數時間
        let lastDay = nowDate.dateAtEndOf(.year)
        let diffComponents = Calendar.current.dateComponents([.day], from: nowDate, to: lastDay)
        let lastDayCount = diffComponents.day
        self.dayCountLabel.text = "今年倒數第\(lastDayCount!)天"
    }

    func startTimer()
    {
        // 計算離下次更新的秒數 , 並設置Timer
        let nowDate = Date()
        let nowSecond = nowDate.getCalendar().component(.second, from: Date().localDate())
        var loopTime = Double(60-nowSecond)
        loopTime = 1
        self.timer = Timer.scheduledTimer(timeInterval: loopTime, target: self, selector: #selector(uptadeTimer), userInfo: nil, repeats: false)
    }

    @objc func uptadeTimer()
    {
        // 每60s更新一次文字
        if self.timer != nil
        {
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(uptadeTimer), userInfo: nil, repeats: false)
        }
        NotificationCenter.default.post(name: .timerRefresh , object: nil, userInfo:nil)
        refreshTimeText()
        self.circle?.duration = self.circleDuration!
        self.circle?.updateCircleLayer()
    }
}

/*
 
 

 
 */
