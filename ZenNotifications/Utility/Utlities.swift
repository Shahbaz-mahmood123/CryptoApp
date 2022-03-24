//
//  Utlities.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-23.
//

import Foundation

class Utilities{
    
    func convertDoubleToCurrency(amount: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: amount))!
    }

    func convertStringToCurrency(amount: String) -> String{
        let response = (amount as NSString).doubleValue
        return convertDoubleToCurrency(amount: response)
    }

    func convertCurrencyToDouble(input: String) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        return numberFormatter.number(from: input)?.doubleValue
    }


}
