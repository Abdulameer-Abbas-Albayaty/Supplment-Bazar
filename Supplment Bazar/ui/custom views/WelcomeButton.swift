//
//  WelcomeButton.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/11/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import UIKit

class WelcomeButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = UIColor.white
        setTitleColor(UIColor.white, for: .normal)
        setAttributedTitle(NSAttributedString(string: currentTitle ?? "", attributes: [.font : AppFont.button, .foregroundColor: UIColor.textPrimary]), for: .normal)
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 1, height: 1)

        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }

}
