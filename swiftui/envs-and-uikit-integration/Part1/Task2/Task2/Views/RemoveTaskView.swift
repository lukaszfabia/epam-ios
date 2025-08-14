//
//  RemoveTaskView.swift
//  Task2
//
//  Created by Lukasz Fabia on 09/08/2025.
//

import SwiftUI

struct RemoveTaskView: View {
    @EnvironmentObject var manager: TaskManager
    
    var body: some View {
        NavigationStack {
            VStack {
                if manager.tasks.isEmpty {
                    noContent
                } else {
                    listTasks
                }
            }
            .navigationTitle("Remove Task")
            .toolbar {
                ToolbarItem {
                    Button(action: removeAllTasks, label: {Image(systemName: "trash")})
                }
            }
        }
    }
    
    // MARK: ui
    
    private var noContent: some View {
        Text("No tasks to remove.")
    }
    
    private var listTasks: some View {
        List {
            ForEach(manager.tasks, id: \.self) {task in
                Text(task)
            }
            .onDelete(perform: removeTask)
        }
    }
    
    // MARK: ui logic and calls manager
    
    private func removeTask(at index: IndexSet) {
        withAnimation {
            manager.tasks.remove(atOffsets: index)
        }
    }
    
    private func removeAllTasks() {
        withAnimation {
            manager.tasks.removeAll()
        }
    }
    
}

#Preview {
    RemoveTaskView()
        .environmentObject(TaskManager())
}
