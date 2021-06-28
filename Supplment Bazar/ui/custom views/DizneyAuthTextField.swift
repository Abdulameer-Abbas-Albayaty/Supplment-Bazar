//
//  BananAuthTextField.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/14/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import UIKit

class DizneyAuthTextField: UITextField {
    
    @IBInspectable var image: UIImage? {
        didSet {
            updateView()
        }
    }
    
    var padding : UIEdgeInsets?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        font = AppFont.textField
        textColor = UIColor.textPrimary        
        borderStyle = .none
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor

        backgroundColor = UIColor.clear
        padding = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 16)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding!)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding!)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding!)
    }
    
    func updateView() {
        if let image = image {
            leftViewMode = UITextField.ViewMode.always

            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            view.addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = UIColor.lightGray
            imageView.frame = CGRect(x: padding?.left ?? 10, y: 0, width: 20, height: 20)
            imageView.center = view.center
            leftView = view
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }

}
