//
//  CustomLabel.swift
//  Dizney
//
//  Created by Ameer on 1/8/21.
//

import UIKit

class CategoryLabel: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = UIColor.primary
        textColor = UIColor.white
        textAlignment = .center
        layer.cornerRadius = (frame.height / 2) - 8
        clipsToBounds = true
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
    }
    
}

class SpecialLabel: BoundryLabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = UIColor.primary
        textColor = UIColor.white
        textAlignment = .center
    }
}

class BoundryLabel: UILabel {
 
    override var intrinsicContentSize: CGSize {
        let size = super.frame
        return CGSize(width: size.width + 24, height: size.height + 8)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
}
