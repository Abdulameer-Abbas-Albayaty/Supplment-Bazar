//
//  ColorExtensions.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/9/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import UIKit

extension UIColor {
    static let primary = UIColor(named: "primary") ?? .green
    static let primaryDark = UIColor(named: "primary-dark") ?? .green
    
    // background
    static let background = UIColor(named: "background") ?? .white
    static let secondaryBackground = UIColor(named: "cell_background") ?? .green
    
    static let navColor = UIColor(named: "nav_color") ?? .green
    static let lineColor = UIColor(named: "lineColor") ?? .gray
    
    // texts
    static let textPrimary = UIColor(named: "text_primary") ?? .blue
    static let textSecondary = UIColor(named: "text_secondary") ?? .blue
    
    static let secondaryButton = UIColor(named: "secondary-button") ?? .blue
    
    static let whiteButton = UIColor(named: "white_button") ?? .white
}
