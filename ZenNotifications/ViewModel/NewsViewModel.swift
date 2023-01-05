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
        @Published var showError = false
        
        private let alpacaService = AlpacaService()
        
        init(){

        }
        
        func fetchNews(){
            
            alpacaService.getnews(){result in
                switch result{
                case.success(let newsResponse):self.newsResponse = newsResponse
                
                case .failure(let error):
                    if error == .errorDecodingData{
                        self.showError = true
                    }
                    if error == .invalidURL {
                        self.showError = true
                    }
                }}

            //completion: {(newsResponse) in self.newsResponse = newsResponse}
        }
    }
}
