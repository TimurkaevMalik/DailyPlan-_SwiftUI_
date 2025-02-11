//
//  ScheduleView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 05.02.2025.
//

import SwiftUI

struct ScheduleView: View {
    
    @Binding private var schedule: Schedule
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
    }
    
    var body: some View {
        HStack(spacing: 6) {
            HStack(spacing: 0) {
                
                Spacer(minLength: 0)
                
                buttonDate(selectedDate())
                
                Spacer(minLength: 0)
                
                buttonTime(selectedStart(),
                           shouldPresent: $isStartTimePresented)
                .padding(.leading, 8)
                
                Text(":")
                    .padding(.horizontal, 2)
                
                buttonTime(selectedEnd(),
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
        .onChange(of: schedule.date) { _, _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isDatePickerPresented.toggle()
            }
        }
        .onChange(of: schedule.start) { _, _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isDatePickerPresented.toggle()
            }
        }
        .onChange(of: schedule.end) { _, _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isDatePickerPresented.toggle()
            }
        }
        
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
    func buttonDate(_ date: String) -> some View {
        Text(date)
            .frame(width: 120, height: 32)
            .foregroundStyle(isMarked ? .ypBlack : .messGrayUltraDark)
            .background(.ypMilk)
            .clipShape(.rect(cornerRadius: 10))
            .onTapGesture {
                isDatePickerPresented.toggle()
            }
            .popover(isPresented: $isDatePickerPresented) {
                DatePicker(
                    "",
                    selection: .constant(Date()),
                    displayedComponents: .date)
                .datePickerStyle(.graphical)
                .presentationCompactAdaptation(.popover)
                .frame(width: 330)
            }
    }
    
    func buttonTime(_ time: String, shouldPresent: Binding<Bool>) -> some View {
            Text(time)
                .frame(width: 70, height: 32)
                .foregroundStyle(isMarked ? .ypBlack : .messGrayUltraDark)
                .background(.ypMilk)
                .clipShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    shouldPresent.wrappedValue.toggle()
                }
                .popover(isPresented: shouldPresent) {}
    }
}

private extension ScheduleView  {
    func selectedDate() -> String {
        return dateString(from: schedule.date ?? Date())
    }
    
    func selectedStart() -> String {
        return timeString(from: schedule.start ?? Date())
    }
    
    func selectedEnd() -> String {
        return timeString(from: schedule.end ?? Date())
    }
    
    func dateString(from date: Date) -> String {
        DateFormatManager.shared.dateString(from: date)
    }
    
    func timeString(from date: Date) -> String {
        DateFormatManager.shared.timeString(from: date)
    }
}
