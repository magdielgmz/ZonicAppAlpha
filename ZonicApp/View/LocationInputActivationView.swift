//
//  LocationInputActivationView.swift
//  ZonicApp
//
//  Created by MagdielG on 02/05/20.
//  Copyright © 2020 Magdiel Gómez. All rights reserved.
//

import UIKit

protocol LocationInputActivationViewDelegate: class{
    func presentLocationInputView()
}

class LocationInputActivationView: UIView{
    
    //MARK: - Properties
    
    weak var delegate: LocationInputActivationViewDelegate?
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Where to?"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .rgb(red: 135, green: 121, blue: 121)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageUI = UIImageView()
        imageUI.image = #imageLiteral(resourceName: "lupa")
        return imageUI        
    }()
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addShadow()
        
        addSubview(imageView)
        imageView.anchor(paddingTop: 10)
        imageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        imageView.setDimensions(height: 25, width: 24.34)

        
        addSubview(indicatorView)
        indicatorView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)
        indicatorView.setDimensions(height: 8, width: 8)
        indicatorView.alpha = 0

        addSubview(placeholderLabel)
        placeholderLabel.centerY(inView: self, leftAnchor: indicatorView.rightAnchor, paddingLeft: 20)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentLocationInputView))
        addGestureRecognizer(tap)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func presentLocationInputView(){
        delegate?.presentLocationInputView()
    }
    
    
}
