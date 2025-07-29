//
//  Button.swift
//  Task6
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

// https://www.justinmind.com/blog/button-design-websites-mobile-apps/
// recreate animated button
// with background is white with border
// on hover backgroud goes into night blue color

struct PrimaryButtonModifier: ViewModifier {
    @Binding var wasTapped: Bool    
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
            .background(wasTapped ? Color.arapawa : .white)
            .foregroundStyle(wasTapped ? .white : Color.arapawa)
            .font(.caption)
            .fontWeight(.regular)
            .overlay(
                     Capsule()
                         .stroke(wasTapped ? Color.clear : Color.arapawa, lineWidth: 1)
                 )
            .clipShape(Capsule())
            .scaleEffect(wasTapped ? 1.1 : 1)
            .animation(.easeInOut(duration: 0.2), value: wasTapped)
    }
}
