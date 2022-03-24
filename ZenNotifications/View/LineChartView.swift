//
//  LineChartView.swift
//  ZenNotifications
//
//  Created by Shahbaz Mahmmod on 2022-03-24.
//

import SwiftUI
import SwiftUICharts

struct LineChartView: View {
    var body: some View {
        LineView(data: [12, 16, 19, 34, 55, 66, 0], title: "testing")
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView()
    }
}
