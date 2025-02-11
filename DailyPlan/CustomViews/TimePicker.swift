//
//  TimePicker.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 11.02.2025.
//

import SwiftUI

struct TimePicker: View {
    
    @Binding private var time: Date
    @State private var hoursSelection: Int
    @State private var minutesSelection: Int
    
    var hours: Int {
        hoursSelection % 24
    }
    private var minutes: Int {
        minutesSelection % 60
    }
    
    init(time: Binding<Date>) {
        hoursSelection = 300
        minutesSelection = 300
        _time = time
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Picker("", selection: $hoursSelection) {
                ForEach(0..<600) {
                    Text(String(format: "%02d",
                                $0 % 24))
                }
            }
            .frame(width: 100)
            
            Picker("", selection: $minutesSelection) {
                ForEach(0..<600) {
                    Text(String(format: "%02d",
                                $0 % 60))
                }
            }
            .frame(width: 100)
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
        setTime()
    }
    
    private func hoursValueChanged() {
        hoursSelection = 288 + hoursSelection % 24
        setTime()
    }
    
    private func setTime() {
        time = Calendar.current.date(bySettingHour: hours, minute: minutes, second: 0, of: Date()) ?? Date()
        
        print(DateFormatManager.shared.timeString(from: time))
    }
}

#Preview {
    TimePicker(time: .constant(.now))
}
