//
//  CoinProfileCell.swift
//  TheCryptoDraft
//
//  Created by admin on 2/12/18.
//  Copyright © 2018 esohjay. All rights reserved.
//

import UIKit

class CoinProfileCell: UITableViewCell {
    static let identifier = "coinProfileReuse"
    let cellHeight: Int = 75
    let profileNameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: CoinProfileCell.identifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(profileName: String) {
        profileNameLabel.text = profileName
        addSubview(profileNameLabel)
        profileNameLabel.constrainHeightTo(dimension: heightAnchor, multiplier: 0.5)
        profileNameLabel.constrainWidthTo(dimension: widthAnchor, multiplier: 0.5)
        profileNameLabel.constrainCenterXTo(anchor: centerXAnchor)
        profileNameLabel.constrainCenterYTo(anchor: centerYAnchor)
    }
    
}
