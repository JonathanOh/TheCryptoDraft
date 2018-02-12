//
//  CoinProfilesRootVC.swift
//  TheCryptoDraft
//
//  Created by admin on 2/9/18.
//  Copyright © 2018 esohjay. All rights reserved.
//

import UIKit

class CoinProfilesRootVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationController.setupNavigationControllerWith(title: "Coin Profiles", navigationController: navigationController)
        
        // MAKE REQUEST FOR EXISTING COIN PROFILES?  Create a request object
        // if 0 coinprofiles
        showNoCoinProfileText()
        // if >0 coinprofiles
    }
    
    func showNoCoinProfileText() {
        let noCoinTextLabel: UILabel = UILabel()
        noCoinTextLabel.textAlignment = .center
        noCoinTextLabel.lineBreakMode = .byWordWrapping
        noCoinTextLabel.numberOfLines = 0
        noCoinTextLabel.textColor = Colors.DarkGrayText
        noCoinTextLabel.text = "Add a coin profile by tapping \"+\" on the top right."
        
        view.addSubview(noCoinTextLabel)
        noCoinTextLabel.constrainWidthTo(dimension: view.widthAnchor, multiplier: 0.6)
        noCoinTextLabel.constrainHeightTo(dimension: view.heightAnchor, multiplier: 0.25)
        noCoinTextLabel.constrainCenterXTo(anchor: view.centerXAnchor)
        noCoinTextLabel.constrainCenterYTo(anchor: view.centerYAnchor)
    }
}

