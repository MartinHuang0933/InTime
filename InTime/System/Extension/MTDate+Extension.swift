//
//  DateExtension.swift
//  Timely
//
//  Created by Mac on 2020/6/18.
//  Copyright © 2020 Martin. All rights reserved.
//

import Foundation

extension Date
{
    /**
     將Date轉換為台北時區
     */
    func date2TaipeiDate(date:Date) -> Date
    {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: date))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: date) else {return Date()}
        return localDate
    }
    
    /**
     取得當地時間
     */
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        return localDate
    }
    
    /**
     將Date轉換為輸入格式的文字
     */
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        let resultdate = formatter.string(from: date)
        return resultdate
    }
    
    func getCalendar() -> Calendar {
        // *** create calendar object ***
        var calendar = Calendar.current
        // *** define calendar components to use as well Timezone to UTC ***
        calendar.timeZone = TimeZone(identifier: "Asia/Taipei")!
        return calendar
    }
    func getHour() -> String {
        let number = getCalendar().component(.hour, from: Date())
        return String(format: "%02d", number)
    }
    func getMinute() -> String {
        let number = getCalendar().component(.minute, from: Date())
        return String(format: "%02d", number)
    }
    func getSecond() -> String {
        let number = getCalendar().component(.second, from: Date())
        return String(format: "%02d", number)
    }
    
    /**
     取得輸入Date與現在時間相差的時分(返回文字)
     */
    func compareCurrntTime(start:Date,end:Date) -> (hour:Int, minute:Int , second:Int)
    {
        var hour : Int , minute : Int , second : Int
        
        let compareEndDate = getCalendar().dateComponents([.hour, .minute, .second], from: start, to: end)
        hour = compareEndDate.hour!
        minute = compareEndDate.minute! + 1
        second = compareEndDate.second!
        
        if minute == 60 {
            hour += 1
            minute = 0
            second = 0
        }
        
        return (hour:hour, minute:minute, second:second)
    }
    
    func getFinalDayOfYear() -> Int
    {
        let nowYear = self.year
        if (nowYear % 4) == 0 && (nowYear % 100) != 0 || (nowYear % 400) == 0 {
            return 366;
        } else {
            return 365;
        }
    }
}
