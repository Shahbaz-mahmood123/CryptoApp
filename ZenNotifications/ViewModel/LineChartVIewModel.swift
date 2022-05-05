//
//  LineChartVIewModel.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-24.
//

import Foundation

extension LineChartView{
    class LineChartViewModel: ObservableObject{
        @Published var barData = [BarResponse]()
        private let alpacaService = AlpacaService()
        @Published var lineData: [Double] = []
        
        init(){
            lineData = setLineChartData(data: fetchBarData())
        }
        
        func fetchBarData() -> [BarResponse]{
            alpacaService.getBars(completion:{(barData) in self.barData = [barData]})
            return barData
        }

        func setLineChartData(data: [BarResponse]) -> [Double]{
            var graphData: [Double] = []
            for i in data{
                for j in i.bars{
                    graphData.append(j.closePrice)
                }
            }
            return graphData
        }
            
//            .task{
//                do{
//                try await alpacaService.getLineChartData()
//                }catch{
//                    print("Error", error)
//                }
//            }

    }
}
