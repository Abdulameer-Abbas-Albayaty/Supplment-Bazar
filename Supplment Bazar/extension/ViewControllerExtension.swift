//
//  ViewControllerExtension.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 5/24/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showCanclableAlert(_ title:String, _ message: String?, _ actions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(_ title:String, _ message: String?, _ actions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
           for action in actions {
               alert.addAction(action)
           }
        }
        present(alert, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    
    func changeRoot() {
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.window?.rootViewController = self
        }
    }
    
//    func userDefaultLogout() {
//        UserUD.logout()
//        CustomerInfoUD.logout()
//        ChatUserUD.logout()
//    }
//    
//    func forceLogout() {
//        userDefaultLogout()
//        let okAction = UIAlertAction(title: "ok".getLocalized(), style: .destructive) { (_) in
//            Navigator.toTips().changeRoot()
//        }
//        self.showAlert("session_expired".getLocalized(), "session_expired_details".getLocalized(), [okAction])
//    }
//    
//    func logout() {
//        userDefaultLogout()
//        Navigator.toTips().changeRoot()
//    }
    
}
