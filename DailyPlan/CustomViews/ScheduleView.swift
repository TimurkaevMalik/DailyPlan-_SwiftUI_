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
    @State private var clearButtonState: Visibility
    @State private var isDatePickerPresented: Bool
    @State private var isStartTimePresented: Bool
    @State private var isEndTimePresented: Bool
    
    private var color: Color
    
    init(color: Color,
         schedule: Binding<Schedule>) {
        
        self._schedule = schedule
        self.color = color
        clearButtonState = .hidden
        isDatePickerPresented = false
        isStartTimePresented = false
        isEndTimePresented = false
        
        let defaultDate = Calendar.current.date(bySettingHour: 12, minute: 00, second: 0, of: Date()) ?? Date()
        
        date = defaultDate
        startTime = defaultDate
        endTime = defaultDate
    }
    
    var body: some View {
        HStack(spacing: 0) {
            PopoverDatePicker(selection: $date,
                              direction: .up,
                              isPresented: $isDatePickerPresented)
            .padding(.leading, clearButtonState == .hidden ? 18 : 0)
//            .foregroundStyle(
//                setColorBy(schedule.start ||
//                           schedule.end))
            
            Spacer(minLength: 0)
            
            PopoverTimePicker(
                time: $startTime,
                direction: .up,
                isPresented: $isStartTimePresented)
            .foregroundStyle(
                setColorBy(schedule.start))
            
            Text(":")
                .foregroundStyle(setDividerColor())
                .padding(.horizontal, 2)
            
            PopoverTimePicker(
                time: $endTime,
                direction: .up,
                isPresented: $isEndTimePresented)
            .foregroundStyle(
                setColorBy(schedule.end))
            .padding(.trailing, clearButtonState == .hidden ? 8 : 0)
        }
        .frame(height: 60)
        .padding(.horizontal, 12)
        .overlay(content: {
            RoundedRectangle(cornerRadius: .regularCornerRadius)
                .stroke(color)
        })
        .modifier(clearButtonModifier)
        .onChange(of: isDatePickerPresented) {
//            schedule.date = date
//            
//            if isDatePickerPresented == false {
//                setClearButtonState()
//            }
        }
        .onChange(of: isStartTimePresented, { _, newValue in
            schedule.start = startTime
            
            if isStartTimePresented == false {
                setClearButtonState()
            }
        })
        .onChange(of: isEndTimePresented) {
            schedule.end = endTime
            
            if isEndTimePresented == false {
                setClearButtonState()
            }
        }
        .onChange(of: date) {
//            let startDate = Calendar.current.date(bySettingHour: sta, minute: 00, second: 0, of: Date()) ?? Date()
//            let endDate =
//            schedule.date = date
            
        }
        .onChange(of: startTime) {
            schedule.start = startTime
        }
        .onChange(of: endTime) {
            schedule.end = endTime
        }
    }
}

#Preview {
    @Previewable
    @State var schedule: Schedule = Schedule()
    
    ScheduleView(color: .ypWarmYellow,
                 schedule: $schedule)
    .padding(.horizontal)
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
    
    var clearButtonModifier: some ViewModifier {
        ToggleVisibilityButton(
            state: clearButtonState,
            image: Image(systemName: "arrow.uturn.backward.square"),
            color: color,
            action: {
                resetDates()
                setClearButtonState()
            })
    }
}

private extension ScheduleView  {
    func setClearButtonState() {
        if schedule.start != nil ||
            schedule.end != nil,
           clearButtonState == .hidden {
            withAnimation {
                clearButtonState = .visible
            }
        } else
        if schedule.start == nil,
           schedule.end == nil,
           clearButtonState == .visible {
            withAnimation {
                clearButtonState = .hidden
            }
        }
    }
    
    func setDividerColor() -> Color {
        if schedule.start != nil,
           schedule.end != nil { .ypBlack
        } else {
            .ypGray
        }
    }
    
    func dateForSchedule() {
        if schedule.start != nil,
           schedule.end != nil {
            
//            let startDate = Calendar.current.date(
//                bySettingHour: startTime,
//                minute: 00,
//                second: 0,
//                of: date) ?? Date()
            
//            let endDate = Calendar.current.date(
//                bySettingHour: endTime,
//                minute: 00,
//                second: 0,
//                of: date) ?? Date()
            
//            schedule.start = startDate
//            schedule.end = endDate
        } else if schedule.start != nil {
            
        } else if schedule.end != nil {
            
        }
    }
    
    func resetDates() {
        let defaultDate = Calendar.current.date(
            bySettingHour: 12,
            minute: 00,
            second: 0,
            of: Date()) ?? Date()
        
        date = defaultDate
        startTime = defaultDate
        endTime = defaultDate
        
        schedule.start = nil
        schedule.end = nil
    }
    
    func setScheduleToNil() {
        schedule = Schedule(start: nil, end: nil)
    }
    
    func setColorBy(_ dateValue: Date?) -> Color {
        if dateValue != nil {
            return .ypBlack
        } else {
            return .messGrayUltraDark
        }
    }
}
