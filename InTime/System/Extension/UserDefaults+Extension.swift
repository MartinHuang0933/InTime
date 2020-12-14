//
//  UserDefaults+Extension.swift
//  InTime
//
//  Created by Mac on 2020/12/11.
//  Copyright © 2020 Martin. All rights reserved.
//

import Foundation

extension UserDefaults.Key {
    static var user = UserDefaults.Key(key: "User")
    static var token = UserDefaults.Key(key: "Token")
}

extension UserDefaults {
    enum Key {
        case `default`(key: String)
        init(key: String) {
            self = .default(key: key)
        }
    }
}

extension UserDefaults {
    
    func setValue(_ value: Any?, forKey key: UserDefaults.Key) {
        if case UserDefaults.Key.default(let k) = key {
            self.set(value, forKey: k)
        }
    }
    
    func set(_ value: Any?, forKey key: UserDefaults.Key) {
        if case UserDefaults.Key.default(let k) = key {
            self.set(value, forKey: k)
        }
    }
    
    func removeObject(forKey key: UserDefaults.Key) {
        if case UserDefaults.Key.default(let k) = key {
            self.removeObject(forKey: k)
        }
    }
    
    func value(forKey key: UserDefaults.Key) -> Any? {
        if case UserDefaults.Key.default(let k) = key {
            return self.value(forKey: k)
        }
        return nil
    }
    
    func string(forKey key: UserDefaults.Key) -> String? {
        if case UserDefaults.Key.default(let k) = key {
            return self.string(forKey: k)
        }
        return nil
    }
    
    func dictionary(forKey key: UserDefaults.Key) -> Dictionary<String, Any>? {
        if case UserDefaults.Key.default(let k) = key {
            return self.dictionary(forKey: k)
        }
        return nil
    }
    
    func integer(forKey key: UserDefaults.Key) -> Int {
        if case UserDefaults.Key.default(let k) = key {
            return self.integer(forKey: k)
        }
        return 0
    }
    
    func float(forKey key: UserDefaults.Key) -> Float {
        if case UserDefaults.Key.default(let k) = key {
            return self.float(forKey: k)
        }
        return 0.0
    }
    
    func double(forKey key: UserDefaults.Key) -> Double {
        if case UserDefaults.Key.default(let k) = key {
            return self.double(forKey: k)
        }
        return 0.0
    }
    
    func bool(forKey key: UserDefaults.Key) -> Bool {
        if case UserDefaults.Key.default(let k) = key {
            return self.bool(forKey: k)
        }
        return false
    }
}
