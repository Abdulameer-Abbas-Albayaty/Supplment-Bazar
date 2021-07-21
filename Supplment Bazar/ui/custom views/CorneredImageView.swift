//
//  CorneredImageView.swift
//  Dizney
//
//  Created by Ameer on 1/6/21.
//

import UIKit

class CorneredImageView: UIImageView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.cornerRadius = 8
    }
    
}

class CircularImageView: UIImageView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.cornerRadius = frame.height / 2
    }
    
}
