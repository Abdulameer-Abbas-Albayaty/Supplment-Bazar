//
//  UserUd.swift
//  Dizney
//
//  Created by Ameer on 1/4/21.
//

import Foundation

class UserUD {
    
    struct UserDefaultKeys {
        static let loginKey = "loginKey"
        static let token = "tokenKey"
        static let refreshToken = "refreshTokenKey"
        static let notiTokenSentKey = "notiTokenSentKey"
        static let notificationTokenKey = "notificationTokenKey"
        
        static let isTipsShown = "isTipsShownKey"
    }
    
    static let shared = UserDefaults.standard
    
    static var isLogin: Bool {
        get { shared.object(forKey: UserDefaultKeys.loginKey) as? Bool ?? false }
        set { shared.set(newValue, forKey: UserDefaultKeys.loginKey) }
    }
    
    static var token: String? {
        get { shared.object(forKey: UserDefaultKeys.token) as? String ?? nil }
        set { shared.set(newValue, forKey: UserDefaultKeys.token) }
    }
    
    static var refreshToken: String? {
        get { shared.object(forKey: UserDefaultKeys.refreshToken) as? String ?? nil }
        set { shared.set(newValue, forKey: UserDefaultKeys.refreshToken) }
    }
    
    static var notiTokenSent: String? {
        get { shared.object(forKey: UserDefaultKeys.notiTokenSentKey) as? String  }
        set { shared.set(newValue, forKey: UserDefaultKeys.notiTokenSentKey) }
    }
    
    static var notificationToken: String? {
        get { shared.object(forKey: UserDefaultKeys.notificationTokenKey) as? String ?? nil }
        set { shared.set(newValue, forKey: UserDefaultKeys.notificationTokenKey) }
    }
    
    static var isTipsShown: Bool {
        get { shared.object(forKey: UserDefaultKeys.isTipsShown) as? Bool ?? false }
        set { shared.set(newValue, forKey: UserDefaultKeys.isTipsShown) }
    }
    
    static func logout() {
        UserUD.isLogin = false
        UserUD.token = nil
        UserUD.refreshToken = nil
        UserUD.notiTokenSent = nil
    }
    
}
