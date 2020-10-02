//
//  LocationCell.swift
//  ZonicApp
//
//  Created by MagdielG on 06/05/20.
//  Copyright © 2020 Magdiel Gómez. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    //MARK: - Properties
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BalooRegular", size: 14)
        label.text = "123 Main Street"
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "BalooRegular", size: 14)
        label.text = "123 Main Street, Washintong, DC"
        label.textColor = .lightGray
        return label
    }()
    
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
