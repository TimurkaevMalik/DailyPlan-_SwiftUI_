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
                
                Spacer(minLength: 0)
                
                PopoverDatePicker(selection: $date,
                                  direction: .up,
                                  isPresented: $isDatePickerPresented)
                .foregroundStyle(schedule.date != nil ? .ypBlack : .messGrayUltraDark)
                .allowsHitTesting(isMarked ? true : false)
                
                Spacer(minLength: 0)
                
                buttonTime($startTime,
                           shouldPresent: $isStartTimePresented)
                .foregroundStyle(schedule.start != nil ? .ypBlack : .messGrayUltraDark)
                .padding(.leading, 8)
                
                Text(":")
                    .padding(.horizontal, 2)
                
                buttonTime($endTime,
                           shouldPresent: $isEndTimePresented)
                .foregroundStyle(schedule.end != nil ? .ypBlack : .messGrayUltraDark)
                .padding(.trailing, 10)
            }
            .frame(height: 60)
            .padding(.horizontal, 8)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(color)
            })
            
            CheckMarkButton(color: color,
                            isDone: $isMarked)
            .setSize(.checkMarkButton)
        }
        .onChange(of: isMarked) {
            if isMarked {
                schedule.start = startTime
            } else {
                setDefaultValuesForDates()
            }
        }
        .onChange(of: isEndTimePresented) {
            if isEndTimePresented {
                schedule.end = endTime
            }
        }
        .onChange(of: isDatePickerPresented) {
            if isDatePickerPresented {
                schedule.date = date
            }
        }
        .onChange(of: date) {
//            isDatePickerPresented.toggle()
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
    ///TODO: move to extension
    struct DefaultValues {
        let date: Date
        let color: Color
        
        init() {
            color = .messGrayUltraDark
            date = Calendar.current.date(bySettingHour: 12, minute: 00, second: 0, of: Date()) ?? Date()
        }
    }
    
}

struct ScheduleView_Preview: PreviewProvider {
    @State static var schedule: Schedule = Schedule()
    
    static var previews: some View {
        ScheduleView(color: .ypWarmYellow,
                     schedule: $schedule)
    }
}

private extension ScheduleView  {
    func buttonTime(_ time: Binding<Date>, shouldPresent: Binding<Bool>) -> some View {
        Text(timeString(from: time.wrappedValue))
            .frame(width: 70, height: 32)
            .background(.ypMilk)
            .clipShape(.rect(cornerRadius: 10))
            .onTapGesture {
                if isMarked {
                    shouldPresent.wrappedValue.toggle()
                }
            }
            .popover(isPresented: shouldPresent,
                     arrowEdge: .bottom) {
                TimePicker(time: time)
                    .presentationCompactAdaptation(.popover)
            }
    }
}

private extension ScheduleView  {
    func dateString(from date: Date) -> String {
        DateFormatManager.shared.dateString(from: date)
    }
    
    func timeString(from date: Date) -> String {
        DateFormatManager.shared.timeString(from: date)
    }
    
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
}
