//
//  CustomerInfoUD.swift
//  Dizney
//
//  Created by Ameer on 08/02/2021.
//

import Foundation

class CustomerInfoUD {
    
    struct UserDefaultKeys {
        static let mobileKey = "mobileKey"
        static let nameKey = "nameKey"
    }
    
    static let shared = UserDefaults.standard
    
    static var mobile: String? {
        get { shared.object(forKey: UserDefaultKeys.mobileKey) as? String }
        set { shared.set(newValue, forKey: UserDefaultKeys.mobileKey) }
    }
    
    static var name: String? {
        get { shared.object(forKey: UserDefaultKeys.nameKey) as? String }
        set { shared.set(newValue, forKey: UserDefaultKeys.nameKey) }
    }
    
    static func setData(mobile: String?, name: String?) {
        CustomerInfoUD.mobile = mobile
        CustomerInfoUD.name = name
    }
    
    static func isEmpty() -> Bool {
        return (CustomerInfoUD.mobile == nil && CustomerInfoUD.name == nil)
    }
    
    static func logout() {
        CustomerInfoUD.mobile = nil
        CustomerInfoUD.name = nil
    }
    
}
