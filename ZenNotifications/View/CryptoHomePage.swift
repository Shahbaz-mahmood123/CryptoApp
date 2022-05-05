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
    @State private var selection = 0
    @ObservedObject private var viewModel = CryptoHomePageViewModel()
    
    var body: some View {
        GeometryReader{ geometryReader in
            
            TabView(selection: $selection){
                Text("Hello").tag(0)
                Text("World").tag(1)
            }.tabViewStyle(PageTabViewStyle())
        }
    }
}

struct CryptoHomePage_Previews: PreviewProvider {
    static var previews: some View {
        CryptoHomePage()
    }
}
