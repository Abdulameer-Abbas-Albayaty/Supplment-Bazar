//
//  BananNaivigation.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 5/1/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import UIKit

class DizneyNavigation: UINavigationController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        navigationBar.prefersLargeTitles = true
        
        navigationBar.tintColor = UIColor.primary
        
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textPrimary]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.textPrimary]
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.textPrimary]
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.textPrimary]
            navBarAppearance.shadowColor = UIColor.clear
            navBarAppearance.shadowImage = UIImage()
            navBarAppearance.backgroundImage = UIImage()
            navBarAppearance.backgroundColor = UIColor.clear
            navBarAppearance.backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
}
