//
//  TimePicker.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 11.02.2025.
//

import SwiftUI

struct TimePicker: View {
    
    @State var hours: Int
    @State var minutes: Int
    
    init() {
        self.hours = 0
        self.minutes = 0
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Picker("", selection: $hours) {
                ForEach(0..<24, id: \.self) { hour in
                    Text("\(hour)")
                        .tag(hour)
                }
            }
            .frame(width: 100)
            .clipped()
            Picker("", selection: $minutes) {
                ForEach(0..<60, id: \.self) { mins in
                    Text("\(mins)")
                        .tag(mins)
                }
            }
            .frame(width: 100)
            .clipped()
        }
        .pickerStyle(.wheel)
        .frame(width: 230)
    }
}

#Preview {
    TimePicker()
}
