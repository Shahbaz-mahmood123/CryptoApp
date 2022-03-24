//
//  NewsViewModel.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-21.
//

import Foundation

extension ImageSlider {
    
    class NewsViewModel: ObservableObject{
        
        @Published var newsResponse: NewsResponse?
        @Published var exchangeResponse: ExchangeResponse?
        
        private let alpacaService = AlpacaService()
        
        init(){
            fetchNews()
        }
        
        func fetchNews(){
            alpacaService.getnews(completion: {(newsResponse) in self.newsResponse = newsResponse})
        }
    }
}
