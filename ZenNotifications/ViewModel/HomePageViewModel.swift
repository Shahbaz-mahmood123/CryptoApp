//
//  HomePageViewModel.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-12.
//

import Foundation
import Combine

extension Homepage {
    class HomePageViewModel: ObservableObject {
        @Published var dailyOpenClose: DailyOpenClose?
        @Published var cryptoResponse = CryptoResponse.self
        @Published var exchangeRate: ExchangeRate?
        @Published var dailyData: HistoricalDailyData?
        @Published var marketStatus: CurrentMarketStatus?
      
        @Published var cryptoData: CryptoResponse?
        @Published var previousDayDailyOpenClose: DailyOpenClose?
        
        init(){
            fetchDailyOpenClose()
            fetchPreviousDailyOpenClose()
            fetchHomePageData()
           
        }
        //TODO:  Figure out the best way to get data from model, feel like calling the function from init is not ideal, also maybe i should have the thread the function is running on in the viewmodel rather than the networking class
        func fetchDailyOpenClose(){
            let date = Date()
            let currentDate = date.getFormattedDateString(format: "YYYY-MM-dd")
            
            PolygonService().getDailyOpenClose(date:currentDate ,completion: {(dailyOpenClose) in self.dailyOpenClose = dailyOpenClose})
        }

        func fetchPreviousDailyOpenClose(){
            let date = Date().dayBefore
            let currentDate = date.getFormattedDateString(format: "YYYY-MM-dd")
            
            PolygonService().getDailyOpenClose(date:currentDate ,completion: {(previousDayDailyOpenClose) in self.previousDayDailyOpenClose = previousDayDailyOpenClose})
        }
        
        func fetchHomePageData(){
            //AlpacaService().getnews(completion: {(newsResponse) in self.newsResponse = newsResponse})
            
//            AlphaVantageService().getExchangeRate(cryptoSymbol: "BTC", completion: {(exchangeRate) in self.exchangeRate = self.exchangeRate})
            
            PolygonService().getCryptoData(completion:{(cryptoData) in self.cryptoData = cryptoData})
            
            PolygonService().getCurrentMarketStatus(completion: {(marketStatus) in self.marketStatus = marketStatus})
            
            AlphaVantageService().getHistoricalDataDaily(completion: {(dailyData) in self.dailyData = dailyData})
        }
        


    }
}
