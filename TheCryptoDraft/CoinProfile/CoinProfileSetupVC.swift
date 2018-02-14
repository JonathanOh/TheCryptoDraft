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
    var coinProfile: CoinProfile?
    var editMode: Bool = false
    
    let topInfoView = UIView()
    let budgetLabel = UILabel()
    let coinSelectionTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = coinProfile?.profileName
        setupNavigationBar()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(coinSelectionTableView)
        view.addSubview(topInfoView)
        registerCells()
        setupCoinSelectionTableView()
        setupTopInfoView()
    }
    
    func registerCells() {
        coinSelectionTableView.register(AddACoinLastCell.self, forCellReuseIdentifier: AddACoinLastCell.addACoinLastCellIdentifier)
    }
    
    func setupTopInfoView() {
        topInfoView.backgroundColor = .white

        topInfoView.constrainTopTo(anchor: view.topAnchor, constant: 0)
        topInfoView.constrainLeftTo(anchor: view.leftAnchor)
        topInfoView.constrainRightTo(anchor: view.rightAnchor)
        topInfoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //view.layoutIfNeeded()
        topInfoView.layer.shadowColor = UIColor.black.cgColor
        topInfoView.layer.shadowOpacity = 1
        topInfoView.layer.shadowOffset = CGSize.zero
        topInfoView.layer.shadowRadius = 2
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(floatLiteral: coinProfile?.remainingBudget ?? 0))
        budgetLabel.text = "$\(formattedNumber ?? "") remaining budget"
        budgetLabel.textColor = COLORS.DarkGrayText
        budgetLabel.font = FONTS.BoldHelveticaNeue18
        budgetLabel.textAlignment = .center
        topInfoView.addSubview(budgetLabel)
        budgetLabel.constrainWidthTo(dimension: topInfoView.widthAnchor, multiplier: 0.9)
        budgetLabel.constrainHeightTo(dimension: topInfoView.heightAnchor, multiplier: 0.5)
        budgetLabel.constrainCenterXTo(anchor: topInfoView.centerXAnchor)
        budgetLabel.constrainCenterYTo(anchor: topInfoView.centerYAnchor)
    }
    func setupCoinSelectionTableView() {
        coinSelectionTableView.delegate = self
        coinSelectionTableView.dataSource = self
        coinSelectionTableView.constrainTopTo(anchor: topInfoView.bottomAnchor, constant: 0)
        coinSelectionTableView.constrainRightTo(anchor: view.rightAnchor)
        coinSelectionTableView.constrainLeftTo(anchor: view.leftAnchor)
        coinSelectionTableView.constrainBottomTo(anchor: view.bottomAnchor)
    }
    
    func setupNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: editMode ? "Back" : "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: editMode ? "Update" : "Submit", style: .plain, target: self, action: #selector(submitTapped))
    }
    
    @objc func cancelTapped() {
        print("cancel tapped")
        navigationController?.popViewController(animated: true)
    }
    @objc func submitTapped() {
        print("submit tapped")
        guard let coinProfile = coinProfile else {
            print("SOMETHING FUCKED")
            return
        }
        if !editMode { // Only create a new profile when we are not in edit mode.
            coinProfileDelegate?.coinProfileWasCreated(profile: coinProfile)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension CoinProfileSetupVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let totalCoinsInPortfolio: Int = coinProfile?.coinsInPortfolio.count ?? 0
        let isLastCell = indexPath.row == totalCoinsInPortfolio
        if isLastCell {
            let coinSelectionVC = CoinSelectionVC()
            coinSelectionVC.coinProfile = coinProfile
            navigationController?.pushViewController(coinSelectionVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true
        )
    }
}
extension CoinProfileSetupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let totalCoinsInPortfolio: Int = coinProfile?.coinsInPortfolio.count ?? 0
        let isLastCell = indexPath.row == totalCoinsInPortfolio
        if isLastCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddACoinLastCell.addACoinLastCellIdentifier) as? AddACoinLastCell else { return UITableViewCell() }
            cell.setupCell()
            return cell
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let totalCoinsInPortfolio = coinProfile?.coinsInPortfolio.count ?? 0
        return totalCoinsInPortfolio + 1 // + 1 because last cell will always be utilized to add another coin
    }
}
