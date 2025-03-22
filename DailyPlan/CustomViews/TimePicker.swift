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
    @State private var shouldPresent: Bool
    private var isPresented: Binding<Bool>?
    private let arrowEdge: Edge
    
    private var hours: Int {
        hoursSelection % 24
    }
    private var minutes: Int {
        minutesSelection % 60
    }
    
    init(time: Binding<Date>,
         direction: PopoverDirection,
         isPresented: Binding<Bool>? = nil) {
        self.isPresented = isPresented
        _time = time
        shouldPresent = false
        
        let hour = time.wrappedValue.get(.hour)
        let minute = time.wrappedValue.get(.minute)
        
        hoursSelection = 288 + hour
        minutesSelection = 300 + minute
        
        switch direction {
        case .up:
            arrowEdge = .bottom
        case .down:
            arrowEdge = .top
        }
    }
    
    var body: some View {
        Text(timeString(from: time))
            .frame(width: 70, height: 32)
            .background(.ypMilk)
            .clipShape(.rect(cornerRadius: .regularCornerRadius))
            .onChange(of: hoursSelection) {
                setTimeBySelectionValue()
            }
            .onChange(of: minutesSelection) {
                setTimeBySelectionValue()
            }
            .onChange(of: time, {
                setSelectionValueByTime()
            })
            .onChange(of: shouldPresent) {
                if !shouldPresent {
                    setPresentationState(shouldPresent)
                }
            }
            .onTapGesture {
                setPresentationState(!shouldPresent)
            }
            .popover(isPresented: $shouldPresent,
                     arrowEdge: arrowEdge) {
                timeWheelView
                    .presentationCompactAdaptation(.popover)
            }
    }
}

#if DEBUG
#Preview {
    @Previewable
    @State var time = Calendar.current.date(bySettingHour: 12, minute: 00, second: 0, of: Date()) ?? Date()
    @Previewable
    @State var isPresented: Bool = false
    
    TimePicker(time: $time,
               direction: .down,
               isPresented: $isPresented)
}
#endif

private extension TimePicker {
    var timeWheelView: some View {
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
    }
}

private extension TimePicker {
    func setSelectionValueByTime() {
        let minutes = time.get(.minute)
        let hour = time.get(.hour)
        
        minutesSelection = 300 + minutes % 60
        hoursSelection = 288 + hour % 24
    }
    
    func setTimeBySelectionValue() {
        minutesSelection = 300 + minutesSelection % 60
        hoursSelection = 288 + hoursSelection % 24
        
        time = Calendar.current.date(bySettingHour: hours, minute: minutes, second: 0, of: Date()) ?? Date()
    }
    
    func timeString(from date: Date) -> String {
        DateFormatManager.shared.timeString(from: date)
    }
    
    func setPresentationState(_ bool: Bool) {
        if bool == true {
            shouldPresent = true
            isPresented?.wrappedValue = true
        } else {
            shouldPresent = false
            isPresented?.wrappedValue = false
        }
    }
}
