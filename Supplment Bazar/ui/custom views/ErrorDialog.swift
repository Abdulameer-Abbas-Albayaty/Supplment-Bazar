//
//  ErrorDialog.swift
//  Dizney
//
//  Created by Ameer on 01/02/2021.
//

import UIKit

class ErrorDialog: UIView {
    
    fileprivate let error : UILabel = {
        let label = UILabel()
        return label
    }()
    
    fileprivate let hideViewTime: TimeInterval = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        backgroundColor = UIColor.secondaryBackground
        layer.cornerRadius = 16
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 2, height: 2)
        addSubview(error)
        error.translatesAutoresizingMaskIntoConstraints = false
        error.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        error.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        error.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        error.numberOfLines = 2
        error.textAlignment = .center
        hideView()
    }
    
    func addToView(view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 24).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setError(messgae: String) {
        self.isHidden = false
        error.text = messgae
        hideViewAfter()
    }
    
    fileprivate func hideView() {
        self.isHidden = true
    }
    
    fileprivate func hideViewAfter() {
        Timer.scheduledTimer(withTimeInterval: hideViewTime, repeats: false) { (_) in
            self.hideView()
        }
    }
    
}

class MapDialog: UIView {
    
    fileprivate let error : UILabel = {
        let label = UILabel()
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        backgroundColor = UIColor.secondaryBackground
        layer.cornerRadius = 16
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 2, height: 2)
        addSubview(error)
        error.translatesAutoresizingMaskIntoConstraints = false
        error.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        error.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        error.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        error.numberOfLines = 2
        error.textAlignment = .center
        hideView()
    }
    
    func addToView(view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 24).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setLocation(messgae: String) {
        self.isHidden = false
        error.text = messgae
    }
    
    func hideView() {
        self.isHidden = true
    }
    
    func show() {
        self.isHidden = false
    }
    
}
