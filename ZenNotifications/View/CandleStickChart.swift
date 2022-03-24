//
//  CandleStickChart.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-24.
//

import SwiftUI
import Charts

struct CandleStickChart: UIViewRepresentable{
    
    func makeUIView(context: Context) -> CandleStickChartView {
        let chart = CandleStickChartView()
        return chart
    }
    
    func updateUIView(_ uiView: CandleStickChartView, context: Context) {
        
    }
    
    func addData() -> CandleChartData{
        
        
        
        let data = CandleChartData()
        let dataSet = CandleChartDataSet()
        return data
    }
    
    typealias UIViewType = CandleStickChartView

}

struct CandleStickPreview: PreviewProvider {
    static var previews: some View {
        CandleStickChart()
    }
}


