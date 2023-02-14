//
//  HoursChartsSwiftUIView.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/10/23.
//

import SwiftUI
import Charts

struct ChartViewModel: Identifiable {
    var id = UUID()
    var hour: String
    var temp: Int64
}


struct HoursChartsSwiftUIView: View {
    
    var data: [ChartViewModel] = []
    
    var body: some View {
        Text("Почасовая температура")
        Chart(data) {
            LineMark(
                x: .value("Hour", $0.hour),
                y: .value("Temp", $0.temp)
            )
            PointMark(
                x: .value("Hour", $0.hour),
                y: .value("Temp", $0.temp)
            )
        }
        .frame(height: 100)
        .foregroundColor(.red)
        
     }
}

//struct HoursChartsSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        HoursChartsSwiftUIView()
//    }
//}
