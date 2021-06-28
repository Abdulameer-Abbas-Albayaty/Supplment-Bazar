//
//  BananAuthNavigation.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/23/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import UIKit

class DizneyAuthNavigation: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.shadowImage = UIImage()
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = UIColor.textPrimary
//        navigationBar.titleTextAttributes =  [.foregroundColor: UIColor.white]
//        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.backgroundColor = UIColor.background
//        navigationBar.barTintColor = UIColor.textPrimary
                
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
//            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.shadowColor = UIColor.clear
            navBarAppearance.shadowImage = UIImage()
            navBarAppearance.backgroundColor = UIColor.background
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
}
