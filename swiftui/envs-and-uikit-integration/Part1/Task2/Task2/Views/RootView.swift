//
//  RootView.swift
//  Task2
//
//  Created by Lukasz Fabia on 09/08/2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var manager: TaskManager = .init()
    
    var body: some View {
        TabView {
            Tab("List", systemImage: "checklist.unchecked") {
                TaskListView()
                    .environmentObject(manager)
            }

            Tab("Add", systemImage: "document.badge.plus.fill") {
                AddTaskView()
                    .environmentObject(manager)
            }

            Tab("Remove", systemImage: "trash.circle") {
                RemoveTaskView()
                    .environmentObject(manager)
            }
        }
    }
}

#Preview {
    RootView()
}
