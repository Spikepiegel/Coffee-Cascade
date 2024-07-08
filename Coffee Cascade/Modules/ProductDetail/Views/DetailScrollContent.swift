//
//  DetailScrollContent.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import SwiftUI

struct DetailScrollContent: View {
    let recipe: Recipe
    @Environment(\.presentationMode) var presentationMode
    @State private var offset: CGFloat = 0
    @State private var isDragging = false

    var body: some View {
        BlurView(style: .dark)
            .frame(height: UIScreen.main.bounds.height / 2)
            .offset(y: offset)
            .overlay(
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            CloseButtonImage(width: 10, height: 10, padding: 12)
                        }
                        .padding(.trailing, 15)
                    }

                    DetailScrollOverlayContent(recipe: recipe)
                }
                .padding(.top, 20)
            )
    }
}

#Preview {
    let mockModel = MockCatalogViewModel()
    let recipe = mockModel.recipes[0]
    return DetailScrollContent(recipe: recipe)
}
