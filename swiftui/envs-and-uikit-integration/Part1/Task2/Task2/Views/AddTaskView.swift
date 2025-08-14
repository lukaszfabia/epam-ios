//
//  AddTaskView.swift
//  Task2
//
//  Created by Lukasz Fabia on 09/08/2025.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var manager: TaskManager
    @State private var currentTask: String = ""
    
    private var addButtonDisabled: Bool {
        currentTask.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(text: $currentTask) {
                        Text("eg. Go with dog")
                    }
                } header: {
                    Text("Title")
                }
            }
            .navigationTitle("Add task")
            .toolbar {
                ToolbarItem {
                    Button(action: addNewTask, label: {Image(systemName: "plus")})
                        .disabled(addButtonDisabled)
                }
            }
            
        }
    }
    
    private func addNewTask() {
        withAnimation {
            manager.tasks.append(currentTask)
            currentTask = ""
        }
    }
}

#Preview {
    AddTaskView()
}
