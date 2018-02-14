//
//  Constants.swift
//  TheCryptoDraft
//
//  Created by admin on 2/11/18.
//  Copyright © 2018 esohjay. All rights reserved.
//

import UIKit

class COLORS {
    static let LightGrayBackground: UIColor = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 1)
    static let DarkGrayText: UIColor = UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1)
    static let TCDBlue: UIColor = UIColor(red: 0.0/255.0, green: 162.0/255.0, blue: 229.0/255.0, alpha: 1)//0,181,255
}

class FONTS {
    static let BoldHelveticaNeue16: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 16)!
    static let BoldHelveticaNeue18: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 18)!
}

enum Coin: String {
    case BTC
    case ETH
    case XRP
    case VEN
    case TRX
    case WTC
    case REQ
    case ICX
}
