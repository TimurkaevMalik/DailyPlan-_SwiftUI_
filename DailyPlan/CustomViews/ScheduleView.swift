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
    @State private var categoriesButtonState: Visibility
    @State private var isDatePickerPresented: Bool
    @State private var isStartTimePresented: Bool
    @State private var isEndTimePresented: Bool
    
    private var color: Color
    
    init(color: Color,
         schedule: Binding<Schedule>) {
        
        self._schedule = schedule
        self.color = color
        categoriesButtonState = .hidden
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
            HStack(spacing: 0) {
                PopoverDatePicker(selection: $date,
                                  direction: .up,
                                  isPresented: $isDatePickerPresented)
                .padding(.leading, categoriesButtonState == .hidden ? 18 : 0)
                .foregroundStyle(
                    setColorBy(schedule.date))
                
                Spacer(minLength: 0)
                
                PopoverTimePicker(
                    time: $startTime,
                    direction: .up,
                    isPresented: $isStartTimePresented)
                .foregroundStyle(
                    setColorBy(schedule.start))
                
                Text(":")
                    .padding(.horizontal, 2)
                
                PopoverTimePicker(
                    time: $endTime,
                    direction: .up,
                    isPresented: $isEndTimePresented)
                .foregroundStyle(
                    setColorBy(schedule.end))
                .padding(.trailing, categoriesButtonState == .hidden ? 8 : 0)
            }
            .frame(height: 60)
            .padding(.horizontal, 12)
            .overlay(content: {
                RoundedRectangle(cornerRadius: .regularCornerRadius)
                    .stroke(color)
            })
            
            storedCategoriesButton
        }
        .onChange(of: isDatePickerPresented) { _, newValue in
            schedule.date = date
            
            if newValue == false {
                setClearButtonState()
            }
        }
        .onChange(of: isStartTimePresented, { _, newValue in
            schedule.start = startTime
            
            if newValue == false {
                setClearButtonState()
            }
        })
        .onChange(of: isEndTimePresented) { _, newValue in
            schedule.end = endTime
            
            if newValue == false {
                setClearButtonState()
            }
        }
        .onChange(of: date) {
            schedule.date = date
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
    
    var storedCategoriesButton: some View {
        
        let width = CGSize.checkMarkButton.width

        let customView = Image(systemName: "arrow.uturn.backward.square")
            .resizable()
            .frame(width: 26, height: 26)
            .foregroundStyle(.ypGray)
            .frame(width: categoriesButtonState == .hidden ? 0 : width,
                   height: .mediumHeight)
            .clipped()
            .overlay(content: {
                RoundedRectangle(cornerRadius: .regularCornerRadius)
                    .stroke(color)
            })
            .padding(.leading, categoriesButtonState == .hidden ? 0 : 6)
            .onTapGesture {
                if categoriesButtonState == .visible {
                    resetDates()
                    setClearButtonState()
                }
            }
        
        return customView
    }
}

private extension ScheduleView  {
    func setClearButtonState() {
        if schedule.date != nil ||
           schedule.start != nil ||
           schedule.end != nil,
           categoriesButtonState == .hidden {
            withAnimation {
                categoriesButtonState = .visible
            }
        } else
        if schedule.date == nil,
           schedule.start == nil,
           schedule.end == nil,
           categoriesButtonState == .visible {
            withAnimation {
                categoriesButtonState = .hidden
            }
        }
    }
    
    func resetDates() {
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
