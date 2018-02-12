//
//  CoinProfile.swift
//  TheCryptoDraft
//
//  Created by admin on 2/12/18.
//  Copyright © 2018 esohjay. All rights reserved.
//

import Foundation

class CoinProfile {
    private(set) var profileName: String
//    private(set) var coinValuePair: [Coin:Int]
//    private(set) var valueCoinPair: [Int:Coin]
//    private(set) var coinsInPortfolio: [Coin]
//    private(set) var cashRemaining: Double
    
    init?(profileName: String, coinPortfolio: [Coin:Int]) {
        self.profileName = profileName
    }
}

