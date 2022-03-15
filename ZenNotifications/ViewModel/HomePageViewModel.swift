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
        
        init(){
            fetchDailyOpenClose()
        }
        //TODO:  Figure out the best way to get data from model, feel like calling the function from init is not ideal, also maybe i should have the thread the function is running on in the viewmodel rather than the networking class
        func fetchDailyOpenClose(){
            PolygonService().getDailyOpenClose(completion: {(dailyOpenClose) in self.dailyOpenClose = dailyOpenClose})
        }
    

    }
}
