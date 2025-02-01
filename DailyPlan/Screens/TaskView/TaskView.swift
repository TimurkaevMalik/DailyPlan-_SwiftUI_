//
//  TaskView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.08.2024.
//

import SwiftUI

struct TaskView: View {
    
    @State var isPopoverPresented = false
    @State private var selectedDate: Date = Date()
    @State private var tasks: [Task] = {
        let array = Task.getTasksMock()
        return array
    }()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(tasks, id: \.id) { task in
                    
                    TaskCell(task: task)
                        .padding(.vertical, 10)
                        .listRowSeparator(.visible, edges: .bottom)
                    
                    if let lastTask = tasks.last,
                       lastTask.id != task.id {
                        Divider()
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 8)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    makeMenu()
                }
                
                ToolbarItem(placement: .principal) {
                    customDatePicker()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    addTaskButton()
                }
            }
        }
    }
}

private extension TaskView {
    
    func customDatePicker() -> some View {
        Text(stringFrom(selectedDate: selectedDate))
            .frame(width: 120, height: 32)
            .background(.ypMilk)
            .clipShape(.rect(cornerRadius: 10))
            .onTapGesture {
                isPopoverPresented.toggle()
            }
            .onChange(of: selectedDate) { _, _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isPopoverPresented.toggle()
                }
                
                print(selectedDate)
                print(stringFrom(selectedDate: selectedDate))
                print()
            }
            .popover(isPresented: $isPopoverPresented, attachmentAnchor: .point(.bottom),
                     arrowEdge: .top) {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: .date)
                .datePickerStyle(.graphical)
                .presentationCompactAdaptation(.popover)
                .frame(width: 330)
            }
    }
    
    func addTaskButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "plus")
                .frame(width: 70, height: 40)
                .foregroundStyle(.ypTomato)
                .background(.ypMilkDark)
                .font(.system(size: 20, weight: .semibold))
                .clipShape(.buttonBorder)
        }
    }
    
    func makeMenu() -> some View {
        Menu {
            doneTasksFilter()
            activeTasksFilter()
            allTasksFilter()
        } label: {
            Image(systemName: "slider.vertical.3")
                .frame(width: 70, height: 40)
                .foregroundStyle(.ypMilkDark)
                .background(.ypTomato)
                .font(.system(size: 20, weight: .semibold))
                .clipShape(.buttonBorder)
        }
    }
    
    func doneTasksFilter() -> some View {
        Button {
            tasks = Task.getTasksMock().filter({ $0.isDone == true })
        } label: {
            Image(systemName: "checkmark.square")
            Text("Done tasks")
        }
    }
    
    func activeTasksFilter() -> some View {
        Button {
            tasks = Task.getTasksMock().filter({ $0.isDone == false })
        } label: {
            Image(systemName: "square")
            Text("Active tasks")
        }
    }
    
    func allTasksFilter() -> some View {
        Button {
            tasks = Task.getTasksMock()
        } label: {
            Text("All tasks")
            Image(systemName: "list.bullet.rectangle")
        }
    }
}

private extension TaskView {
    func stringFrom(selectedDate: Date) -> String {
        CustomDateFormatter.dateStringFrom(date: selectedDate)
    }
}

#Preview {
    TaskView()
}
