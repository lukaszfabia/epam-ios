//
//  Primary.swift
//  Task6
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

struct PrimaryButton: View  {
    let text: String
    let action: () -> Void
    
    @State private var wasTapped = false
    
    var body: some View {
        Button(text, action: {
            wasTapped.toggle()
            action()
        })
            .modifier(PrimaryButtonModifier(wasTapped: $wasTapped))
    }
}
