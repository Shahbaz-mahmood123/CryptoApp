//
//  LineChartView.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-24.
//

import SwiftUI
import SwiftUICharts

struct LineChartView: View {
    @ObservedObject var viewModel = LineChartViewModel()
    
    var body: some View {
        HStack{
        LineView(data: [12,15,61,18,45,2,15,68], title: "Monthly")
        }
//        HStack{
//        List(viewModel.barData){ data in
//            Text(data.symbol)
//        }
//        }
    }

}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView()
            .preferredColorScheme(.dark)
    }
}
