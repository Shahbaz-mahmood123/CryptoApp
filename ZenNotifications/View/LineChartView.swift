//
//  LineChartView.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-24.
//

import SwiftUI
import SwiftUICharts

struct LineChartView: View {
    
    @StateObject var vm = LineChartViewModel()
    
    var body: some View {
        HStack{
            LineView(data: vm.setLineChartData(data: vm.barData), title: "Monthly")
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
