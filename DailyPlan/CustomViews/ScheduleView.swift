//
//  ScheduleView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 05.02.2025.
//

import SwiftUI

struct ScheduleView: View {
    
    @Binding private var schedule: Schedule
    @State private var day: Date
    @State private var startTime: Date
    @State private var endTime: Date
    @State private var clearButtonState: Visibility
    @State private var isStartTimePresented: Bool
    @State private var isEndTimePresented: Bool
    
    private let defaultDate: Date
    private var color: Color
    
    init(color: Color,
         schedule: Binding<Schedule>) {
        
        self._schedule = schedule
        self.color = color
        clearButtonState = .hidden
        isStartTimePresented = false
        isEndTimePresented = false
        
        defaultDate = Calendar.current.date(bySettingHour: 12, minute: 00, second: 0, of: Date()) ?? Date()
        
        day = defaultDate
        startTime = defaultDate
        endTime = defaultDate
    }
    
    var body: some View {
        HStack(spacing: 0) {
            PopoverDatePicker(
                selection: $day,
                direction: .up)
            .padding(.leading, clearButtonState == .hidden ? 18 : 0)
            
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
        .onChange(of: isStartTimePresented, { _, newValue in
            setStartTimeByDate()
            
            if isStartTimePresented == false {
                setClearButtonState()
            }
        })
        .onChange(of: isEndTimePresented) {
            setEndTimeByDate()
            
            if isEndTimePresented == false {
                setClearButtonState()
            }
        }
        .onChange(of: day) {
            setSchedule()
        }
        .onChange(of: startTime) {
            if isStartTimePresented {
                setSchedule()
            }
        }
        .onChange(of: endTime) {
            if isEndTimePresented {
                setSchedule()
            }
        }
    }
}

#if DEBUG
#Preview {
    @Previewable
    @State var schedule: Schedule = Schedule()
    
    ScheduleView(color: .ypWarmYellow,
                 schedule: $schedule)
    .padding(.horizontal)
    .onChange(of: schedule) { oldValue, newValue in
        print("I CHANGED")
    }
}
#endif

private extension ScheduleView {
    var clearButtonModifier: some ViewModifier {
        ToggleVisibilityButton(
            state: clearButtonState,
            image: Image(systemName: "arrow.uturn.backward.square"),
            color: color,
            action: {
                setDefaultSchedule()
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
        } else if schedule.start == nil,
                  schedule.end == nil,
                  clearButtonState == .visible {
            
            withAnimation {
                clearButtonState = .hidden
            }
        }
    }
    
    func setDividerColor() -> Color {
        if schedule.start != nil,
           schedule.end != nil {
            return .ypBlack
        } else {
            return .ypGray
        }
    }
    
    func setColorBy(_ dateValue: Date?) -> Color {
        if dateValue != nil {
            return .ypBlack
        } else {
            return .messGrayUltraDark
        }
    }
    
    func setDefaultSchedule() {
        day = defaultDate
        startTime = defaultDate
        endTime = defaultDate
        
        schedule.day = defaultDate
        schedule.start = nil
        schedule.end = nil
    }
    
    func setSchedule() {
        schedule.day = day
        
        if schedule.start != nil,
           schedule.end != nil {
            
            setStartTimeByDate()
            setEndTimeByDate()
        
        } else if schedule.start != nil,
                  schedule.end == nil {
           
            setStartTimeByDate()
            
        } else if schedule.end != nil,
                  schedule.start == nil {
            
            setEndTimeByDate()
        }
    }
    
    func setStartTimeByDate() {
        let startHour = startTime.get(.hour)
        let startMinute = startTime.get(.minute)
        
        let startDate = Calendar.current.date(
            bySettingHour: startHour,
            minute: startMinute,
            second: 0,
            of: schedule.day) ?? Date()
        
        schedule.start = startDate
    }
    
    func setEndTimeByDate() {
        let endHour = endTime.get(.hour)
        let endMinute = endTime.get(.minute)
        
        let endDate = Calendar.current.date(
            bySettingHour: endHour,
            minute: endMinute,
            second: 0,
            of: schedule.day) ?? Date()
        
        schedule.end = endDate
    }
}
