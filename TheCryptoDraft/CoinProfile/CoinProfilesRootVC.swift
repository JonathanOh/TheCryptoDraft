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
        setupNavigationBar()
        // MAKE REQUEST FOR EXISTING COIN PROFILES?  Create a request object
        // if 0 coinprofiles
        showNoCoinProfileText()
        // if >0 coinprofiles
    }
    
    func setupNavigationBar() {
        UINavigationController.setupNavigationControllerWith(title: "Coin Profiles", navigationController: navigationController)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTapped))
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
    
    @objc func addTapped() {
        print("+ Tapped")
        let coinProfileNamingAlertController = UIAlertController(title: "Coin Profile", message: "Enter a Profile Name", preferredStyle: .alert)
        coinProfileNamingAlertController.addTextField { textField in
            textField.placeholder = "Enter Coin Profile Name"
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { [weak self] alert in
            if let coinProfileName = coinProfileNamingAlertController.textFields?[0].text {
                print(coinProfileName)
                let coinProfileSetupVC = CoinProfileSetupVC()
                coinProfileSetupVC.title = coinProfileName
                self?.navigationController?.pushViewController(coinProfileSetupVC, animated: true)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        coinProfileNamingAlertController.addAction(submitAction)
        coinProfileNamingAlertController.addAction(cancelAction)
        present(coinProfileNamingAlertController, animated: true, completion: nil)
    }
}

