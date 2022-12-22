//
//  StatsSwiftUI.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 12/8/22.
//

import SwiftUI
import Charts

struct StatsSwiftUI: View {
    var body: some View {
        ZStack{
            Chart {
                BarMark(x: .value("RecycleDay", "Monday"), y: .value("status", 500))
                BarMark(x: .value("RecycleDay", "Tuesday"), y: .value("status", 400))
                BarMark(x: .value("RecycleDay", "Wednesday"), y: .value("status", 600))
                BarMark(x: .value("RecycleDay", "Thuresday"), y: .value("status", 700))
                BarMark(x: .value("RecycleDay", "Friday"), y: .value("status", 200))
            }
        }
        
    }
}

struct StatsSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        StatsSwiftUI()
    }
}
