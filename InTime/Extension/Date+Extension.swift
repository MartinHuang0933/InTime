//
//  DateExtension.swift
//  Timely
//
//  Created by Mac on 2020/6/18.
//  Copyright © 2020 Martin. All rights reserved.
//

import Foundation

extension Date {
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }

    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
    
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
    func compareCurrntTime(start:Date,end:Date) -> (hour:String, minute:String)
    {
        let nowdate = Date().localDate()
        var hour : Int!
        var minute : Int!
        
//        if compareStartDate.hour!<0 || compareStartDate.minute!<0
//        {
//            hour = compareStartDate.hour!
//            minute = abs(compareStartDate.minute!)
//        }
//        else
//        {
            let compareEndDate = getCalendar().dateComponents([.hour, .minute], from: nowdate, to: end)
            hour = compareEndDate.hour!
            minute = compareEndDate.minute! + 1
            if minute == 60 {
                hour += 1
                minute = 0
            }
//        }
        let hourText = String(format: "%02d", hour)
        let minuteText = String(format: "%02d", minute)
        return (hour:hourText, minute:minuteText)
    }
}
