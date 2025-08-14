//
//  TaskListView.swift
//  Task2
//
//  Created by Lukasz Fabia on 09/08/2025.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var manager: TaskManager
    
    var body: some View {
        NavigationStack {
            VStack {
                if manager.tasks.isEmpty {
                    noContent
                }
                else {
                    listTasks
                }
            }
            .navigationTitle("Tasks")
        }
    }
    
    private var noContent: some View {
        Text("No tasks yet.")
    }
    
    private var listTasks: some View {
        List(manager.tasks, id: \.self) { task in
            Text(task)
        }
    }
}

#Preview {
    TaskListView().environmentObject(TaskManager())
}
