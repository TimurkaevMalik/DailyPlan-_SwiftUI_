//
//  TimePicker.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 11.02.2025.
//

import SwiftUI

struct TimePicker: View {
    
    @State private var hoursSelection = 300
    var hours: Int { hoursSelection % 24 }
    
    @State private var minutesSelection: Int = 300
    private var minutes: Int { minutesSelection % 60 }
    @Binding var time: Date
    
    init() {
        _time = .constant(Date())
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Picker("", selection: $hoursSelection) {
                ForEach(0..<600) {
                    Text(String(format: "%02d", $0 % 24))
                }
            }
            .frame(width: 100)
            .clipped()
            Picker("", selection: $minutesSelection) {
                ForEach(0..<600) {
                    Text(String(format: "%02d", $0 % 60))
                }
            }
            .frame(width: 100)
            .clipped()
        }
        .pickerStyle(.wheel)
        .frame(width: 230)
        .onChange(of: hoursSelection) {
            hoursValueChanged()
        }
        .onChange(of: minutesSelection) {
            minutesValueChanged()
        }
    }
    
    private func minutesValueChanged() {
        minutesSelection = 300 + minutesSelection % 60
    }
    
    private func hoursValueChanged() {
        hoursSelection = 300 + hoursSelection % 24
    }
}

#Preview {
    TimePicker()
}
