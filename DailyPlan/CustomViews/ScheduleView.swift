//
//  ScheduleView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 05.02.2025.
//

import SwiftUI

struct ScheduleView: View {
    
    @Binding private var schedule: Schedule
    @State private var isPickerPresented: Bool
    
    private let color: Color
    
    init(color: Color,
         schedule: Binding<Schedule>) {
        self._schedule = schedule
        self.color = color
        isPickerPresented = false
    }
    
    var body: some View {
        HStack(spacing: 0) {
            
            Text("Schedule")
                
            Spacer(minLength: 0)
            
            buttonDate(selectedDate())
            
            buttonTime(selectedStart())
                .padding(.leading, 10)
            
            Text(":")
                .padding(.horizontal, 2)
            
            buttonTime(selectedEnd())
        }
        .frame(height: 60)
        .font(Font.taskText)
        .padding(.horizontal, 8)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 16)
                .stroke(color)
        })
        .onChange(of: schedule.date) { _, _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isPickerPresented.toggle()
            }
        }
        .onChange(of: schedule.start) { _, _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isPickerPresented.toggle()
            }
        }
        .onChange(of: schedule.end) { _, _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isPickerPresented.toggle()
            }
        }
        .popover(isPresented: $isPickerPresented, attachmentAnchor: .point(.topLeading),
                 arrowEdge: .bottom) {
            DatePicker(
                "",
                selection: .constant(Date()),
                displayedComponents: .hourAndMinute)
            .datePickerStyle(.graphical)
            .presentationCompactAdaptation(.popover)
            .frame(width: 330)
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
        Button {
            
        } label: {
            Text(date)
                .frame(width: 120, height: 32)
                .foregroundStyle(.ypBlack)
                .background(.ypMilk)
                .clipShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    isPickerPresented.toggle()
                }
        }
    }
    
    func buttonTime(_ time: String) -> some View {
        Button {
            
        } label: {
            Text(time)
                .frame(width: 70, height: 32)
                .foregroundStyle(.ypBlack)
                .background(.ypMilk)
                .clipShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    isPickerPresented.toggle()
                }
        }
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
