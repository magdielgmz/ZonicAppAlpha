//
//  LocationInputView.swift
//  ZonicApp
//
//  Created by MagdielG on 04/05/20.
//  Copyright © 2020 Magdiel Gómez. All rights reserved.
//

import UIKit

protocol LocationInputViewDelegate: class{
    func dismissLocationInputView()
}

class LocationInputView: UIView, UITextFieldDelegate {

    // MARK: - Properties
    var user: User? {
        didSet {titleLabel.text = user?.fullname}
    }
    
     weak var delegate: LocationInputViewDelegate?

    
    private let backButton: UIButton = {
        let button =  UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal),  for: .normal)
        button.addTarget(self, action: #selector(handleBackTappen), for: .touchUpInside)
        return button
        
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let starLocationIndicatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let linkView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let destinationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var startingLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Current Location"
        tf.backgroundColor = .rgb(red: 233, green: 232, blue: 232)
        tf.layer.cornerRadius = 5
        tf.isEnabled = false
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 40, width: 8)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    private lazy var destinationLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter destination"
        tf.layer.cornerRadius = 5
        tf.backgroundColor = .lightGray
        tf.returnKeyType = .search
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 40, width: 8)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addShadow()
        backgroundColor = .white
        
        addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 25, paddingLeft: 12, width: 24, height: 25)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: backButton)
        titleLabel.centerX(inView: self)
        
        addSubview(startingLocationTextField)
        startingLocationTextField.anchor(top: backButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 40, paddingRight: 40,height: 30)
        
        addSubview(destinationLocationTextField)
        destinationLocationTextField.anchor(top: startingLocationTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 40, paddingRight: 40 ,height: 30)
        
        
        addSubview(starLocationIndicatorView)
        starLocationIndicatorView.centerY(inView: startingLocationTextField, leftAnchor: leftAnchor, paddingLeft: 20)
        starLocationIndicatorView.setDimensions(height: 6, width: 6)
        starLocationIndicatorView.layer.cornerRadius = 6 / 2
        
        addSubview(destinationIndicatorView)
        destinationIndicatorView.centerY(inView: destinationLocationTextField, leftAnchor: leftAnchor, paddingLeft: 20)
        destinationIndicatorView.setDimensions(height: 6, width: 6)
        
        
        addSubview(linkView)
        linkView.centerX(inView: starLocationIndicatorView)
        linkView.anchor(top: starLocationIndicatorView.bottomAnchor, bottom: destinationIndicatorView.topAnchor, paddingTop: 4, paddingBottom: 4, width: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Selectors
    
    @objc func handleBackTappen() {
        delegate?.dismissLocationInputView()
    }
    
    
}
