//
//  ViewControllerExtension.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 5/24/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

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

}

extension UIViewController {
    
    func forceLogout() {
        UserUD.logout()
        CustomerInfoUD.logout()
        let okAction = UIAlertAction(title: "ok".getLocalized(), style: .destructive) { (_) in
            Navigator.toTabs().changeRoot()
        }
        self.showAlert("session_expired".getLocalized(), "session_expired_details".getLocalized(), [okAction])
    }
    
    func logout() {
        UserUD.logout()
        CustomerInfoUD.logout()
        Navigator.toTabs().changeRoot()
    }
    
    func startWaiting() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setForegroundColor(.primary)
        SVProgressHUD.setBackgroundColor(UIColor.primary.withAlphaComponent(0.5))
        SVProgressHUD.setRingThickness(3)
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                SVProgressHUD.setDefaultStyle(.dark)
            } else {
                SVProgressHUD.setDefaultStyle(.light)
            }
        }
        SVProgressHUD.setFont(AppFont.title)
        SVProgressHUD.show(withStatus: "waiting".getLocalized())
    }
    
    func endWaiting() {
        SVProgressHUD.dismiss()
    }

    
}
