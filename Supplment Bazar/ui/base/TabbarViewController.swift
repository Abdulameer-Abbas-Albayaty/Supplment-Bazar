//
//  TabbarViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 09/06/2021.
//

import UIKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.secondaryBackground
        tabBar.tintColor = UIColor.primary
        self.delegate = self

        if UserUD.isLogin && CustomerInfoUD.isEmpty() {
            NetworkEngine.makeRequestWithBody(url: AuthURL.profile, method: .get, body: Optional<Int>.none) { (res:GenericAPIResponse<ProfileResponse>?, error) in
                if let _ = error {
                    return
                }
                CustomerInfoUD.setData(mobile: res?.data?.phone_number, name: res?.data?.name)
            }
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let nav = viewController as? UINavigationController {
            if (nav.topViewController is ProfileViewController) && !UserUD.isLogin {
                present(Navigator.toAuth(), animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
}

struct ProfileResponse: Decodable {
    let name: String
    let phone_number: String
}
