//
//  BananButton.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/9/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import UIKit

class DizneyButton: UIButton {
    
    let activityIndicator = UIActivityIndicatorView()
    private lazy var buttonString: NSAttributedString? = nil
    private var attributes: [NSAttributedString.Key: Any]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButton()
    }
    
    func changeTextColor(color: UIColor) {
        attributes = [.font : AppFont.button ,NSAttributedString.Key.foregroundColor: color]
        buttonString = NSAttributedString(string: currentTitle ?? "", attributes: attributes)
        setAttributedTitle(buttonString, for: .normal)
    }
    
    fileprivate func setupButton() {
        backgroundColor = UIColor.primary
        setTitleColor(UIColor.white, for: .normal)
        attributes = [.font : AppFont.button ,NSAttributedString.Key.foregroundColor: UIColor.white]
        buttonString = NSAttributedString(string: currentTitle ?? "", attributes: attributes)
        setAttributedTitle(buttonString, for: .normal)
        
        layer.cornerRadius = self.frame.height / 2
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 2, height: 2)
        
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        
        setupIndicator()
    }
    
    func setTitle(title:String) {
        let t = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(t, for: .normal)
    }
    
    fileprivate func setupIndicator() {
        activityIndicator.style = .white
        activityIndicator.frame = self.bounds
        activityIndicator.hidesWhenStopped = true
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.stopAnimating()
    }
    
    func showActivityIndicator() {
        setTitle(nil, for: .normal)
        setAttributedTitle(nil, for: .normal)
        activityIndicator.startAnimating()
        self.isEnabled = false
    }
    
    func hideActivityIndicator() {
        setAttributedTitle(buttonString, for: .normal)
        activityIndicator.stopAnimating()
        self.isEnabled = true
    }

}

class WhiteButton: UIButton {
    
    let activityIndicator = UIActivityIndicatorView()
    private lazy var buttonString: NSAttributedString? = nil
    private var attributes: [NSAttributedString.Key: Any]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButton()
    }
    
    fileprivate func setupButton() {
        backgroundColor = UIColor.whiteButton
        setTitleColor(UIColor.white, for: .normal)
        attributes = [.font : AppFont.button ,NSAttributedString.Key.foregroundColor: UIColor.textPrimary]
        buttonString = NSAttributedString(string: currentTitle ?? "", attributes: attributes)
        setAttributedTitle(buttonString, for: .normal)
        
        layer.cornerRadius = self.frame.height / 2
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 2, height: 2)
        
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        
        setupIndicator()
    }
    
    func setTitle(title:String) {
        let t = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(t, for: .normal)
    }
    
    fileprivate func setupIndicator() {
        activityIndicator.style = .white
        activityIndicator.frame = self.bounds
        activityIndicator.hidesWhenStopped = true
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.stopAnimating()
    }
    
    func showActivityIndicator() {
        setTitle(nil, for: .normal)
        setAttributedTitle(nil, for: .normal)
        activityIndicator.startAnimating()
        self.isEnabled = false
    }
    
    func hideActivityIndicator() {
        setAttributedTitle(buttonString, for: .normal)
        activityIndicator.stopAnimating()
        self.isEnabled = true
    }

}


class CircularButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButton()
    }
    
    fileprivate func setupButton() {
        backgroundColor = UIColor.primary
        
        layer.cornerRadius = self.frame.height / 2
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 4, height: 4)
        
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
    }
    
}

class PlusMinusButton: UIButton {
    
    let activityIndicator = UIActivityIndicatorView()
    private lazy var buttonString: NSAttributedString? = nil
    private var attributes: [NSAttributedString.Key: Any]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButton()
    }
    
    fileprivate func setupButton() {
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }

}
