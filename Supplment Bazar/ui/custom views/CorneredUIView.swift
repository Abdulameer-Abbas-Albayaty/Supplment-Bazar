//
//  CorneredUIView.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/23/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import UIKit
class CorneredUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = UIColor.secondaryBackground
        layer.cornerRadius = 16
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
    }
    
}

class CircularUIView: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.cornerRadius = frame.height / 2
    }
}

class TopCorneredUIView: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.shadowOffset = CGSize(width: -8, height: -8)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.2
        
        DispatchQueue.main.async {
            self.roundCorners(corners: [.topLeft, .topRight], radius: 32)
        }
    }
    
}

class SiccorUIView: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.shadowOffset = CGSize(width: -8, height: -8)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.2
        
        DispatchQueue.main.async {
            self.roundCorners(corners: [.topLeft, .bottomRight], radius: 16)
        }
    }
    
}

class CornerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func setupUI() {
        layer.cornerRadius = 16
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
    }
    
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
