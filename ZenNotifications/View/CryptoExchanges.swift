//
//  CryptoExchanges.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-21.
//

import SwiftUI
import WebKit


struct CryptoExchanges: View {
    @ObservedObject private var viewModel = CryptoExchangeViewModel()
    private let utility = Utilities()
    var body: some View {
        NavigationView{
            List(viewModel.recentTrades, id: \.id){ trade in
                ForEach(trade.trades, id: \.tradeId){ trades in
                    Section{
                        HStack{
                            Text("Trade price")
                            Spacer()
                            Text("Trade Size")
                        }
                        HStack{
                            Text(utility.convertDoubleToCurrency(amount: trades.tradePrice))
                            Spacer()
                            Text(String(trades.tradeSize))
                        }
                    } header: {
                        HStack{
                            Text(trades.exchange)
                            Spacer()
                            Text(trades.timestamp)
                        }
                    }
                    
                }
            }
        }.navigationBarTitle("Recent Trades")
    }
}

struct CryptoExchanges_Previews: PreviewProvider {
    static var previews: some View {
        CryptoExchanges()
    }
}

