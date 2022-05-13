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
    @Binding var crypto: String

    
    var body: some View {
        
        HStack{
            LineView(data: vm.setLineChartData(data: vm.fetchBarData(currentCrypto: checkCurrentCrypto(crypto: crypto))), title: "Monthly")
        }
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
            .preferredColorScheme(.dark)
    }
}


func checkCurrentCrypto(crypto: String)-> String{
    var currentCrypto: String
    if(crypto == "BTC"){
        currentCrypto = "BTCUSD"
    }else{
        currentCrypto = "ETHUSD"
    }
    return currentCrypto
}
