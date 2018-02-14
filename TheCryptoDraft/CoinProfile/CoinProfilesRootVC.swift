//
//  CoinProfilesRootVC.swift
//  TheCryptoDraft
//
//  Created by admin on 2/9/18.
//  Copyright © 2018 esohjay. All rights reserved.
//

import UIKit

class CoinProfilesRootVC: BaseVC {
    
    let noCoinTextLabel = UILabel()
    let coinProfileTable = UITableView()
    var usersCoinProfiles: [CoinProfile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinProfileTable.register(CoinProfileCell.self, forCellReuseIdentifier: CoinProfileCell.identifier)
        setupNavigationBar()
        setupCoinProfileTable()
//        // MAKE REQUEST FOR EXISTING COIN PROFILES?  Create a request object
//        // if 0 coinprofiles
//        showNoCoinProfileText()
//        // if >0 coinprofiles
    }
    
    func setupNavigationBar() {
        UINavigationController.setupNavigationControllerWith(title: "Coin Profiles", navigationController: navigationController)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTapped))
    }
    
    func setupCoinProfileTable() {
        coinProfileTable.delegate = self
        coinProfileTable.dataSource = self
        
        view.addSubview(coinProfileTable)
        coinProfileTable.constrainFullyToSuperView()
        
        if usersCoinProfiles.isEmpty {
            coinProfileTable.isHidden = true
            showNoCoinProfileText()
        } else {
            coinProfileTable.isHidden = false
        }

    }
    
    func showNoCoinProfileText() {
        noCoinTextLabel.textAlignment = .center
        noCoinTextLabel.lineBreakMode = .byWordWrapping
        noCoinTextLabel.numberOfLines = 0
        noCoinTextLabel.textColor = COLORS.DarkGrayText
        noCoinTextLabel.text = "Add a coin profile by tapping \"+\" on the top right."
        
        view.addSubview(noCoinTextLabel)
        noCoinTextLabel.constrainWidthTo(dimension: view.widthAnchor, multiplier: 0.6)
        noCoinTextLabel.constrainHeightTo(dimension: view.heightAnchor, multiplier: 0.25)
        noCoinTextLabel.constrainCenterXTo(anchor: view.centerXAnchor)
        noCoinTextLabel.constrainCenterYTo(anchor: view.centerYAnchor)
    }
    
    func updateCoinProfileTable() {
        if usersCoinProfiles.isEmpty {
            coinProfileTable.isHidden = true
            noCoinTextLabel.isHidden = false
        } else {
            coinProfileTable.isHidden = false
            noCoinTextLabel.isHidden = true
            coinProfileTable.reloadData()
        }
    }
    
    @objc func addTapped() {
        print("+ Tapped")
        let coinProfileNamingAlertController = UIAlertController(title: "Coin Profile", message: "Enter a Profile Name", preferredStyle: .alert)
        coinProfileNamingAlertController.addTextField { textField in
            textField.placeholder = "Enter Coin Profile Name"
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { [weak self] alert in
            // TODO: text validation.  Ensure characters only and character length is in between 1-20?
            if let coinProfileName = coinProfileNamingAlertController.textFields?[0].text {
                print(coinProfileName)
                let coinProfileSetupVC = CoinProfileSetupVC()
                coinProfileSetupVC.coinProfileDelegate = self
                coinProfileSetupVC.coinProfile = CoinProfile(profileName: coinProfileName, coinPortfolio: [:], startingBudget: 100000)
                self?.navigationController?.pushViewController(coinProfileSetupVC, animated: true)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        coinProfileNamingAlertController.addAction(submitAction)
        coinProfileNamingAlertController.addAction(cancelAction)
        present(coinProfileNamingAlertController, animated: true, completion: nil)
    }
}

extension CoinProfilesRootVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinProfileSetupVC = CoinProfileSetupVC()
        coinProfileSetupVC.coinProfileDelegate = self
        coinProfileSetupVC.editMode = true
        coinProfileSetupVC.coinProfile = usersCoinProfiles[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(coinProfileSetupVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            usersCoinProfiles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        if usersCoinProfiles.isEmpty { updateCoinProfileTable() }
    }
}

extension CoinProfilesRootVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersCoinProfiles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinProfileCell.identifier) as? CoinProfileCell else { return UITableViewCell() }
        cell.setupCell(profileName: usersCoinProfiles[indexPath.row].profileName)
        return cell
    }
}

extension CoinProfilesRootVC: CoinProfileDelegate {
    func coinProfileWasCreated(profile: CoinProfile) {
        print(profile.profileName)
        usersCoinProfiles.append(profile)
        updateCoinProfileTable()
    }
}

