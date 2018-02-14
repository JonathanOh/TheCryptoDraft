//
//  CoinSelectionVC.swift
//  TheCryptoDraft
//
//  Created by admin on 2/12/18.
//  Copyright © 2018 esohjay. All rights reserved.
//

import UIKit

class CoinSelectionVC: UIViewController {
    let topInfoView = UIView()
    let budgetLabel = UILabel()
    let optionsTableView = UITableView()
    let optionsTableText = ["Select Coin", "Select Purchase Amount"]
    var coinProfile: CoinProfile?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coin Selection"
        view.backgroundColor = COLORS.LightGrayBackground
        optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "addCoinCell")
        // Do any additional setup after loading the view.
        setupNavigationBar()
        
        view.addSubview(optionsTableView)
        view.addSubview(topInfoView)
        budgetRemainingView()
        setupOptionsTableView()
    }

    func setupNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Coin", style: .plain, target: self, action: #selector(saveTapped))
    }
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func saveTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func budgetRemainingView() {
        topInfoView.backgroundColor = .white

        topInfoView.constrainTopTo(anchor: view.topAnchor, constant: 0)
        topInfoView.constrainLeftTo(anchor: view.leftAnchor)
        topInfoView.constrainRightTo(anchor: view.rightAnchor)
        topInfoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
    
    func setupOptionsTableView() {
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.isScrollEnabled = false
        
        optionsTableView.constrainTopTo(anchor: topInfoView.bottomAnchor)
        optionsTableView.constrainLeftTo(anchor: view.leftAnchor)
        optionsTableView.constrainRightTo(anchor: view.rightAnchor)
        optionsTableView.constrainHeightTo(dimension: view.heightAnchor, multiplier: 0.3)
    }
}

extension CoinSelectionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addCoinCell", for: indexPath) as UITableViewCell
        let cellLabel = UILabel()
        cellLabel.text = optionsTableText[indexPath.row]
        cellLabel.font = FONTS.BoldHelveticaNeue16
        cellLabel.textColor = COLORS.DarkGrayText
        cell.addSubview(cellLabel)
        cellLabel.constrainHeightTo(dimension: cell.heightAnchor, multiplier: 0.8)
        cellLabel.constrainWidthTo(dimension: cell.widthAnchor, multiplier: 0.8)
        cellLabel.constrainLeftTo(anchor: cell.leftAnchor, constant: 15)
        cellLabel.constrainCenterYTo(anchor: cell.centerYAnchor)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.15
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let fadeInPickerView = FadeInPickerView()
        guard let applicationWindow = UIApplication.shared.keyWindow else { return }
        applicationWindow.addSubview(fadeInPickerView)
        fadeInPickerView.constrainTopTo(anchor: applicationWindow.topAnchor)
        fadeInPickerView.constrainRightTo(anchor: applicationWindow.rightAnchor)
        fadeInPickerView.constrainBottomTo(anchor: applicationWindow.bottomAnchor)
        fadeInPickerView.constrainLeftTo(anchor: applicationWindow.leftAnchor)
        view.layoutIfNeeded()
        fadeInPickerView.animateScrollingTable(shouldScrollIn: true)
    }
}
extension CoinSelectionVC: UITableViewDelegate {}
