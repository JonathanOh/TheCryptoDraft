//
//  AddACoinLastCell.swift
//  TheCryptoDraft
//
//  Created by admin on 2/12/18.
//  Copyright © 2018 esohjay. All rights reserved.
//

import UIKit

class AddACoinLastCell: UITableViewCell {
    static let addACoinLastCellIdentifier = "addACoinReuse"
    let addACoinLabel = UILabel()
    let plusLabel = UILabel()
    func setupCell() {
        addACoinLabel.text = "Add Coin"
        addACoinLabel.font = FONTS.BoldHelveticaNeue16
        addACoinLabel.textColor = COLORS.DarkGrayText
        //addACoinLabel.textAlignment = .center
        addSubview(addACoinLabel)
        addACoinLabel.constrainWidthTo(dimension: widthAnchor, multiplier: 0.4)
        addACoinLabel.constrainHeightTo(dimension: heightAnchor, multiplier: 0.3)
        addACoinLabel.constrainLeftTo(anchor: leftAnchor, constant: 20)
        addACoinLabel.constrainCenterYTo(anchor: centerYAnchor)
        
        plusLabel.text = "+"
        plusLabel.textColor = COLORS.TCDBlue
        addSubview(plusLabel)
        plusLabel.constrainWidthTo(dimension: widthAnchor, multiplier: 0.1)
        plusLabel.constrainHeightTo(dimension: widthAnchor, multiplier: 0.1)
        plusLabel.constrainCenterYTo(anchor: centerYAnchor)
        plusLabel.constrainRightTo(anchor: rightAnchor)
    }
}
