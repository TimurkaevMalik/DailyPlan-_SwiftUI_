//
//  ScheduleView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 05.02.2025.
//

import SwiftUI

struct ScheduleView: View {
    
    @Binding private var schedule: Schedule
    @State private var date: Date?
    @State private var start: Date?
    @State private var end: Date?
    
    private let color: Color
    
    init(color: Color,
         schedule: Binding<Schedule>) {
        self._schedule = schedule
        self.color = color
    }
    
    var body: some View {
        HStack {
            Text("Schedule")
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Text("Schedule")
            }

            Button {
                
            } label: {
                Text("Schedule")
            }
            
            Button {
                
            } label: {
                Text("Schedule")
            }
        }
        .frame(height: 60)
        .font(Font.taskText)
        .padding(.horizontal, 8)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 16)
                .stroke(color)
        })
    }
}

#Preview {
    ScheduleView(color: .ypWarmYellow,
                 schedule: .constant(Schedule(
                    date: nil,
                    start: nil,
                    end: nil)))
}

private extension ScheduleView  {
    func dateString() -> String {
        return timeStringFrom(date: date ?? Date())
    }
    
    func startTimeString() -> String {
        return timeStringFrom(date: start ?? Date())
    }
    
    func endTimeString() -> String {
        return timeStringFrom(date: end ?? Date())
    }
    
    func stringFromDate(_ date: Date) -> String {
        CustomDateFormatter.string(from: date)
    }
    
    func timeStringFrom(date: Date) -> String {
        CustomDateFormatter.timeString(from: date)
    }
}


//DatePicker(
//    "",
//    selection: .constant(.distantFuture),
//    displayedComponents: .date)
//.frame(width: 80)
//
//DatePicker(
//    "",
//    selection: .constant(.distantFuture),
//    displayedComponents: .hourAndMinute)
//.frame(width: 80)
//
//DatePicker(
//    "",
//    selection: .constant(.distantFuture),
//    displayedComponents: .hourAndMinute)
//.frame(width: 80)
