//
//  CoinProfileSetupVC.swift
//  TheCryptoDraft
//
//  Created by admin on 2/11/18.
//  Copyright © 2018 esohjay. All rights reserved.
//

import UIKit

protocol CoinProfileDelegate {
    func coinProfileWasCreated(profile: CoinProfile)
}

class CoinProfileSetupVC: BaseVC {
    
    var coinProfileDelegate: CoinProfileDelegate?
    var coinProfileName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitTapped))
    }
    
    @objc func cancelTapped() {
        print("cancel tapped")
        navigationController?.popViewController(animated: true)
    }
    @objc func submitTapped() {
        print("submit tapped")
        // coin profile object validation and creation
        let usersCoinProfile = CoinProfile(profileName: coinProfileName!, coinPortfolio: [.XRP:10000])
        coinProfileDelegate?.coinProfileWasCreated(profile: usersCoinProfile!)
        navigationController?.popViewController(animated: true)
    }
}
