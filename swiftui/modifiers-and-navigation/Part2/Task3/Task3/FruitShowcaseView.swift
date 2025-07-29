//
//  ItemShowcase.swift
//  Task3
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

struct FruitShowcaseView: View {
    let fruit: Fruit
    
    @State private var isPresentedSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: fruit.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 3)

            } placeholder: {
                ProgressView()
            }


            Text(fruit.name)
                .font(.title)
                .fontWeight(.heavy)
            
            HStack(spacing: 10) {
                Text("Weight (g)")
                    .foregroundStyle(.secondary)
                Image(systemName: "scalemass")
                Text(String(format: "%.2f", fruit.weightInGrams))
                    .bold()

            }
            
            HStack(spacing: 10) {
                Text("Quantity")
                    .foregroundStyle(.secondary)
                Image(systemName: "numbers")
                Text(String(format: "%.2f", fruit.quantity))
                    .bold()
            }
            
            Button("Read more") {
                isPresentedSheet = true
            }
            
        }
        .navigationTitle(fruit.name)
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isPresentedSheet) {
            NavigationStack {
                VStack {
                    Text(fruit.description)
                        .italic()
                        .padding()
                    
                    Spacer()
                }
                .navigationTitle("About \(fruit.name)")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Close") {
                            isPresentedSheet = false
                        }
                    }
                }
            
            }
        }

    }
}


#Preview {
    FruitShowcaseView(fruit: Fruit.dummies()[1])
}
