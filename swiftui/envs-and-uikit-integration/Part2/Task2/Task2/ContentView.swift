//
//  ContentView.swift
//  Task2
//
//  Created by Lukasz Fabia on 14/08/2025.
//

import SwiftUI

fileprivate struct UIKitCardExample: UIViewRepresentable {
    
    let title: String
    let subtitle: String
    let desc: String
    
    
    func makeUIView(context: Context) -> UIView {
       UIKitCard(title: title, subtitle: subtitle, desc: desc)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    typealias UIViewType = UIView
    
    
}

fileprivate struct SheetView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
    
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: UIKitViewController())
    }
    
    
    typealias UIViewControllerType = UINavigationController
}

struct ContentView: View {
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Button("Open UIKit sheet"){
                    isPresented.toggle()
                }
                
                UIKitCardExample(title: "Example card", subtitle: "Created in uikit", desc: """
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce a urna mollis, vehicula diam ut, scelerisque enim. Donec sagittis turpis id est bibendum consectetur. Sed ultricies efficitur felis et placerat. Nullam gravida eros lorem, lacinia posuere erat pretium ut.
                    """)
            }
            .navigationTitle("SwiftUI View")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .sheet(isPresented: $isPresented) {
                SheetView()
            }
        }
    }
}

#Preview {
    ContentView()
}
