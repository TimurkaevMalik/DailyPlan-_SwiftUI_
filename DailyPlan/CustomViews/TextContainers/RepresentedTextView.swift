//
//  RepresentedTextView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 01.02.2025.
//

import SwiftUI

struct RepresentedTextView: UIViewRepresentable {
    
    @Binding private var text: String
    @State private var state: TextViewState

    private let placeHolder: String
    private let linesNumber: Int
    
    init(text: Binding<String>,
         placeHolder: String,
         linesNumber: Int) {
        self._text = text
        self.placeHolder = placeHolder
        self.linesNumber = linesNumber
        
        if text.wrappedValue.isEmpty {
            state = .empty
        } else {
            state = .notEmpty
        }
    }
    
    func makeUIView(context: Context) -> UITextView { let textView = UITextView()
    
        textView.delegate = context.coordinator
        textView.font = .systemFont(ofSize: 20, weight: .regular)
        ///TODO: custom inset for containers
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .init(top: 8, left: 10, bottom: 0, right: 10)
        textView.textContainer.maximumNumberOfLines = linesNumber
        textView.backgroundColor = .clear
        if text.isEmpty {
            textView.textColor = .ypGray
            textView.text = placeHolder
        }
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if state == .notEmpty {
            uiView.textColor = .ypBlack
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text,
                           state: $state,
                           placeHolder: placeHolder)
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        
        @Binding private var text: String
        @Binding private var state: TextViewState

        private let placeHolder: String
        
        init(text: Binding<String>, state: Binding<TextViewState>, placeHolder: String) {
            self._text = text
            self._state = state
            self.placeHolder = placeHolder
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            
            if state == .empty {
                state = .notEmpty
                textView.text = ""
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            textView.textColor = .ypBlack
            text = textView.text
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            
            let finalText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if finalText.isEmpty {
                state = .empty
                textView.textColor = .ypGray
                textView.text = placeHolder
            } else {
                text = finalText
            }
        }
    }
    
    enum TextViewState {
        case notEmpty
        case empty
    }
}

#Preview {
    RepresentedTextView(
        text: .constant(""),
        placeHolder: "Placeholder",
        linesNumber: 5)
}
