//
//  PopoverDatePicker.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 12.02.2025.
//

import SwiftUI

struct PopoverDatePicker: View {
    
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
            .onTapGesture {
                togglePresentation()
            }
            .onChange(of: selection) {
                togglePresentation()
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

#Preview {
    @Previewable @State var selection = Date()
    
    PopoverDatePicker(selection: $selection,
                          direction: .up)
}

private extension PopoverDatePicker {
    func togglePresentation() {
        if shouldPresent == false,
           isPresented?.wrappedValue == false ||
            isPresented == nil {
            shouldPresent = true
            isPresented?.wrappedValue = true
        } else {
            shouldPresent = false
            isPresented?.wrappedValue = false
        }
    }
}
