//
//  CryptoHomePage.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-24.
//

import SwiftUI

struct CryptoHomePage: View {
    @State var exchangeRates: ExchangeRate? = nil
    @State var crypto = "BTC"
    @ObservedObject private var viewModel = CryptoHomePageViewModel()
    
    var body: some View {
        GeometryReader{ geometryReader in
            
            TabView{
//                tabItem("BTC")
//                tabItem("ETH")
            }
        }
        
    }
}

struct CryptoHomePage_Previews: PreviewProvider {
    static var previews: some View {
        CryptoHomePage()
    }
}
