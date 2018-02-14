//
//  FadeInPickerView.swift
//  TheCryptoDraft
//
//  Created by admin on 2/13/18.
//  Copyright © 2018 esohjay. All rights reserved.
//

import UIKit

// Hot to use: Initialize FadeInPickerView and addSubview to UIApplication.shared.keyWindow.
// Next, you must call animateScrollTable(shouldScrollIn: true)
// set the scrollingTableView.delegate and .datasource to control information flow

class FadeInPickerView: UIView {
    
    //Variables to set for scrolling picker view
    var slideInViewLeftLabelText: String?
    var slideInViewCenterLabelText: String?
    
    let scrollingTableView = UITableView()
    private let animationDuration: Double = 0.25
    private let fadedView = UIView()
    private let viewToSlideIn = UIView()
    private let halfHeightOfScreen = UIScreen.main.bounds.height/2
    private var viewToSlideInTopAnchorConstraint: NSLayoutConstraint?
    init() {
        super.init(frame: .zero)
        setupFadedView()
        triggerFadeAnimation(shouldFadeIn: true)
        setupScrollingInTableView()
    }
    
    func setupFadedView() {
        fadedView.translatesAutoresizingMaskIntoConstraints = false
        fadedView.isUserInteractionEnabled = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapFadedScreen))
        fadedView.addGestureRecognizer(tapGestureRecognizer)
        fadedView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        fadedView.alpha = 0
        addSubview(fadedView)
        fadedView.constrainFullyToSuperView()
    }
    
    @objc func didTapFadedScreen() {
        triggerFadeAnimation(shouldFadeIn: false)
        animateScrollingTable(shouldScrollIn: false)
    }
    
    func triggerFadeAnimation(shouldFadeIn: Bool) {
        UIView.animate(withDuration: animationDuration, animations: { [weak self] in
            self?.fadedView.alpha = shouldFadeIn ? 1 : 0
        }) { [weak self] (complete) in
            self?.fadedView.isUserInteractionEnabled = true
            if !shouldFadeIn { self?.removeFromSuperview() }
        }
    }
    
    func setupScrollingInTableView() {
        viewToSlideIn.backgroundColor = .white
        addSubview(viewToSlideIn)
        viewToSlideInTopAnchorConstraint = viewToSlideIn.constrainTopTo(anchor: bottomAnchor)
        viewToSlideIn.constrainLeftTo(anchor: leftAnchor)
        viewToSlideIn.constrainRightTo(anchor: rightAnchor)
        viewToSlideIn.heightAnchor.constraint(equalToConstant: halfHeightOfScreen).isActive = true
        
        let headerView = UIView()
        headerView.backgroundColor = COLORS.TCDBlue
        viewToSlideIn.addSubview(headerView)
        headerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        headerView.constrainLeftTo(anchor: viewToSlideIn.leftAnchor)
        headerView.constrainRightTo(anchor: viewToSlideIn.rightAnchor)
        headerView.constrainTopTo(anchor: viewToSlideIn.topAnchor)
        
        viewToSlideIn.addSubview(scrollingTableView)
        scrollingTableView.constrainTopTo(anchor: headerView.bottomAnchor)
        scrollingTableView.constrainLeftTo(anchor: viewToSlideIn.leftAnchor)
        scrollingTableView.constrainRightTo(anchor: viewToSlideIn.rightAnchor)
        scrollingTableView.constrainBottomTo(anchor: viewToSlideIn.bottomAnchor)
    }
    
    func animateScrollingTable(shouldScrollIn: Bool) {
        layoutIfNeeded()
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.viewToSlideInTopAnchorConstraint?.constant = shouldScrollIn ? -weakSelf.halfHeightOfScreen : 0
            weakSelf.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
