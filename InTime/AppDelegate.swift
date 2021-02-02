//
//  AppDelegate.swift
//  InTime
//
//  Created by Mac on 2020/11/6.
//  Copyright © 2020 Martin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftDate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor(red: 12/255, green: 30/255, blue: 49/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        
        // init Firebase
        FirebaseApp.configure()
        
        Auth.auth().signInAnonymously() { (authResult, error) in 
            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
        }
        
        if #available(iOS 13, *) {
            // do only pure app launch stuff, not interface stuff
        } else {
            self.window = UIWindow()
            let vc = HomeViewController()
            self.window!.rootViewController = vc
            self.window!.makeKeyAndVisible()
            self.window!.backgroundColor = .red
            
//            let window = UIApplication.shared.windows.first
//            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc : UIViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as UIViewController
//            window?.makeKeyAndVisible()
//            window?.rootViewController = vc
        }
        return true
        
        
        
//        let regionNY = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.chineseTaiwan)
        
//        let tz = (components.timeZone ?? Zones.current.toTimezone())
//        let cal = (components.calendar ?? Calendars.gregorian.toCalendar())
//        let loc = (cal.locale ?? Locales.current.toLocale())
        
//        let regionNY = Region(calendar: Calendars.gregorian, zone: Zones.americaAdak, locale: Locales.englishAmericanSamoa)
        
//        SwiftDate.defaultRegion = Region.local
//        SwiftDate.defaultRegion = regionNY
        
//        Date.setDefaultRegion(Date.defaultRegion)
//        let rome = Region(calendar: Calendars.gregorian, zone: Zones.asiaTaipei, locale: Locales.chineseTaiwan)
//        SwiftDate.defaultRegion = rome
        
//        print(Date().localDate())
//        print(Date().localDate().dateAtEndOf(.day))
//        print(Date().localDate().dateAtEndOf(.day).date)
//        
//        print("-----")
//        
//        print(Date().toISO())
//        print(Date().dateAtEndOf(.day))
//        print(Date().dateAtEndOf(.day).date)
        
//        print(Date())
//        print(DateInRegion())
//        print(DateInRegion().toISO().toDate()!)
        
//        let regionNY = Region(calendar: Calendars.gregorian, zone: Zones.asiaTaipei, locale: Locales.chineseTaiwan)
//        let nowInNY = DateInRegion(Date(),region:regionNY)
//        print(nowInNY.date)
        
        
//        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
