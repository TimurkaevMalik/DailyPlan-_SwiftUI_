//
//  ScheduleView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 05.02.2025.
//

import SwiftUI

struct ScheduleView: View {
    
    @Binding private var schedule: Schedule
    @State private var date: Date
    @State private var startTime: Date
    @State private var endTime: Date
    @State private var isDatePickerPresented: Bool
    @State private var isStartTimePresented: Bool
    @State private var isEndTimePresented: Bool
    @State private var isMarked: Bool
    private let color: Color
    
    init(color: Color,
         schedule: Binding<Schedule>) {
        
        self._schedule = schedule
        self.color = color
        isDatePickerPresented = false
        isStartTimePresented = false
        isEndTimePresented = false
        isMarked = false
        
        let defaultDate = Calendar.current.date(bySettingHour: 12, minute: 00, second: 0, of: Date()) ?? Date()
        
        date = defaultDate
        startTime = defaultDate
        endTime = defaultDate
    }
    
    var body: some View {
        HStack(spacing: 6) {
            HStack(spacing: 0) {
                PopoverDatePicker(selection: $date,
                                  direction: .up,
                                  isPresented: $isDatePickerPresented)
                .padding(.leading, 10)
                .foregroundStyle(
                    setColorBy(schedule.date))
                .allowsHitTesting(isMarked ?
                                  true : false)
                
                Spacer(minLength: 0)
                
                PopoverTimePicker(
                    time: $startTime,
                    direction: .up,
                    isPresented: $isStartTimePresented)
                .foregroundStyle(
                    setColorBy(schedule.start))
                .allowsHitTesting(isMarked ?
                                  true : false)
                
                Text(":")
                    .padding(.horizontal, 2)
                
                PopoverTimePicker(
                    time: $endTime,
                    direction: .up,
                    isPresented: $isEndTimePresented)
                .foregroundStyle(
                    setColorBy(schedule.end))
                .allowsHitTesting(isMarked ?
                                  true : false)
            }
            .frame(height: 60)
            .padding(.horizontal, 18)
            .overlay(content: {
                RoundedRectangle(cornerRadius: .mediumCornerRadius)
                    .stroke(color)
            })
            
            CheckMarkButton(color: color,
                            isDone: $isMarked)
            .setSize(.checkMarkButton)
        }
        .onChange(of: isMarked) {
            if !isMarked {
                setDefaultValuesForDates()
            }
        }
        .onChange(of: isDatePickerPresented) {
            if isDatePickerPresented {
                schedule.date = date
            }
        }
        .onChange(of: isStartTimePresented, {
            if isStartTimePresented {
                schedule.start = endTime
            }
        })
        .onChange(of: isEndTimePresented) {
            if isEndTimePresented {
                schedule.end = endTime
            }
        }
        .onChange(of: date) {
            if isMarked {
                schedule.date = date
            }
        }
        .onChange(of: startTime) {
            if isMarked {
                schedule.start = startTime
            }
        }
        .onChange(of: endTime) {
            if isMarked {
                schedule.end = endTime
            }
        }
    }
}

#Preview {
    @Previewable
    @State var schedule: Schedule = Schedule()
    
    ScheduleView(color: .ypWarmYellow,
                 schedule: $schedule)
}

private extension ScheduleView {
    struct DefaultValues {
        let date: Date
        let color: Color
        
        init() {
            color = .messGrayUltraDark
            date = Calendar.current.date(bySettingHour: 12, minute: 00, second: 0, of: Date()) ?? Date()
        }
    }
}

private extension ScheduleView  {
    func setDefaultValuesForDates() {
        let defaultDate = Calendar.current.date(bySettingHour: 12, minute: 00, second: 0, of: Date()) ?? Date()
        
        date = defaultDate
        startTime = defaultDate
        endTime = defaultDate
        
        schedule.date = nil
        schedule.start = nil
        schedule.end = nil
    }
    
    func setScheduleToNil() {
        schedule = Schedule(date: nil, start: nil, end: nil)
    }
    
    func setColorBy(_ dateValue: Date?) -> Color {
        if dateValue != nil {
            return .ypBlack
        } else {
            return .messGrayUltraDark
        }
    }
}
