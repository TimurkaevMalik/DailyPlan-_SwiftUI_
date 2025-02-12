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
                
                buttonDate($date)
                
                Spacer(minLength: 0)
                
                buttonTime($startTime,
                           shouldPresent: $isStartTimePresented)
                .padding(.leading, 8)
                
                Text(":")
                    .padding(.horizontal, 2)
                
                buttonTime($endTime,
                           shouldPresent: $isEndTimePresented)
                .padding(.trailing, 10)
            }
            .frame(height: 60)
            .padding(.horizontal, 8)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(color)
            })
            
            CheckMarkButton(color: .ypWarmYellow,
                            isDone: $isMarked)
        }
        .onChange(of: isMarked) {
            if isMarked == false {
                setDefaultValuesForDates()
            }
        }
        .onChange(of: date) {
            setSchedule()
            isDatePickerPresented.toggle()
        }
        .onChange(of: startTime) {
            setSchedule()
        }
        .onChange(of: endTime) {
            setSchedule()
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
    func buttonDate(_ date: Binding<Date>) -> some View {
        Text(dateString(from: date.wrappedValue))
            .frame(width: 120, height: 32)
            .foregroundStyle(isMarked ? .ypBlack : .messGrayUltraDark)
            .background(.ypMilk)
            .clipShape(.rect(cornerRadius: 10))
            .onTapGesture {
                if isMarked {
                    isDatePickerPresented.toggle()
                }
            }
            .popover(isPresented: $isDatePickerPresented) {
                DatePicker(
                    "",
                    selection: $date,
                    displayedComponents: .date)
                .datePickerStyle(.graphical)
                .presentationCompactAdaptation(.popover)
                .frame(width: 330)
            }
    }
    
    func buttonTime(_ time: Binding<Date>, shouldPresent: Binding<Bool>) -> some View {
        Text(timeString(from: time.wrappedValue))
            .frame(width: 70, height: 32)
            .foregroundStyle(isMarked ? .ypBlack : .messGrayUltraDark)
            .background(.ypMilk)
            .clipShape(.rect(cornerRadius: 10))
            .onTapGesture {
                if isMarked {
                    shouldPresent.wrappedValue.toggle()
                }
            }
            .popover(isPresented: shouldPresent) {
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
    }
    
    func setSchedule() {
        schedule = Schedule(date: date, start: startTime, end: endTime)
    }
}
