//
//  Number+Extension.swift
//  CarsList
//
//  Created by MacBook Air on 18.10.2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import Foundation

    func separatedNumber(_ number: Int) -> String {
        let itIsANumber = number as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        return formatter.string(from: itIsANumber)!
    }

