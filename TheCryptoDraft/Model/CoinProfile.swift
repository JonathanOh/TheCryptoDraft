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
    private(set) var coinValuePair = [Coin:Double]()
    private(set) var valueCoinPair = [Double:Coin]()
    private(set) var coinsInPortfolio: [Coin] = []
    private(set) var startingBudget: Double
    var budgetInUse: Double {
        var budgetInUse: Double = 0
        for (key, _) in valueCoinPair {
            budgetInUse += key
        }
        return budgetInUse
    }
    var remainingBudget: Double {
        return startingBudget - budgetInUse
    }
    
    init?(profileName: String, coinPortfolio: [Coin:Double], startingBudget: Double) {
        self.startingBudget = startingBudget
        self.profileName = profileName
        self.coinValuePair = coinPortfolio
        var coinBudgetArray: [Double] = []
        for (key, value) in coinPortfolio {
            coinBudgetArray.append(value)
            valueCoinPair[value] = key
        }
        coinBudgetArray.sort()
        if coinBudgetArray.count > 0 {
            for index in stride(from: coinBudgetArray.count - 1, through: 0, by: 1) {
                coinsInPortfolio.append(valueCoinPair[coinBudgetArray[index]]!)
            }
        }
    }
}

