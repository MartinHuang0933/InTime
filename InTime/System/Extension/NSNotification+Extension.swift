//
//  NSNotification+Extension.swift
//  InTime
//
//  Created by Mac on 2020/12/11.
//  Copyright © 2020 Martin. All rights reserved.
//

import Foundation

extension NSNotification.Name
{
    static var timerRefresh = NSNotification.Name(rawValue: "MT_Notification_Timer_Refresh")
    static var startTime = NSNotification.Name(rawValue: "MT_Notification_StartTime_Update")
}
