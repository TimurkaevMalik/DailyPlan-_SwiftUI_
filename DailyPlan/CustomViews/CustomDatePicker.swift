//
//  CustomDatePicker.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 12.02.2025.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding private var selection: Date
    @State private var shouldPresent: Bool
    private var isPresented: Binding<Bool>?
    private let arrowEdge: Edge
    
    init(selection: Binding<Date>,
         direction: PopoverDirection,
         isPresented: Binding<Bool>? = nil) {
        self.isPresented = isPresented
        self._selection = selection
        shouldPresent = false
        
        switch direction {
        case .up:
            arrowEdge = .bottom
        case .down:
            arrowEdge = .top
        }
    }
    
    var body: some View {
        Text(DateFormatManager.shared.dateString(from: selection))
            .frame(width: 120, height: 32)
            .background(.ypMilk)
            .clipShape(.rect(cornerRadius: .regularCornerRadius))
            .onChange(of: shouldPresent, {
                if shouldPresent == false {
                    setPresentationState(false)
                }
            })
            .onTapGesture {
                setPresentationState(true)
            }
            .popover(isPresented: $shouldPresent,
                     arrowEdge: arrowEdge) {
                DatePicker(
                    "",
                    selection: $selection,
                    displayedComponents: .date)
                .datePickerStyle(.graphical)
                .presentationCompactAdaptation(.popover)
                .frame(width: .graphicalPickerWidth)
            }
    }
}

#if DEBUG
#Preview {
    @Previewable @State var selection = Date()
    
    CustomDatePicker(selection: $selection,
                          direction: .up)
}
#endif

private extension CustomDatePicker {
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
