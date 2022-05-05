//
//  CryptoExchangeViewModel.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-21.
//

import Foundation

extension CryptoExchanges{
    class CryptoExchangeViewModel: ObservableObject{
        @Published var ftxuExchangeResponse = [ExchangeResponse]()
        @Published var ersxExchangeResponse = [ExchangeResponse]()
        @Published var cbseExchangeResponse: ExchangeResponse?
        @Published var barData: BarResponse?
        @Published var recentTrades = [RecentTradeResponse]()
        
        private let alpacaService = AlpacaService()
        
        init(){
            fetchExchangeData()
            fetchBarData()
            fetchRecentTrades()
        }
        
        func fetchExchangeData(){
         //   let exchanges = ["FTXU","ERSX", "CBSE"]
//            for exchange in exchanges{
            alpacaService.getExchangePrice(exchange: "FTXU", completion: {(ftxuExchangeResponse) in self.ftxuExchangeResponse = [ftxuExchangeResponse]})
            
            alpacaService.getExchangePrice(exchange: "ERSX", completion: {(ersxExchangeResponse) in self.ersxExchangeResponse = [ersxExchangeResponse]})
            
            alpacaService.getExchangePrice(exchange: "CBSE", completion: {(cbseExchangeResponse) in self.cbseExchangeResponse = cbseExchangeResponse})
 
        }
        func fetchBarData(){
            alpacaService.getBars(completion:{(barData) in self.barData = barData})
        }
        func fetchRecentTrades(){
            alpacaService.getRecentTrades(completion: {(recentTrades) in self.recentTrades = [recentTrades]})
        }
        func fetchRecentTradesAsync(){
            
        }
    }
}
