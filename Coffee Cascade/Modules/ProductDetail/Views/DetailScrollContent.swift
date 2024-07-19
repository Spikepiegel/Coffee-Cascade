//
//  DetailScrollContent.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import SwiftUI

struct DetailScrollContent: View {
    let recipe: Recipe
    let isCartEmpty: Bool
    @Environment(\.presentationMode)
    var presentationMode
    @State
    private var offset: CGFloat = 0

    var addToCart: (() -> Void)?

    @Binding
    var countOfProducts: Int

    var removeAction: (() -> Void)?

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
                .overlay {
                    if countOfProducts == 0 {
                        AddToCartDetailsButton(addToCart: addToCart)
                            .transition(.opacity)
                    } else {
                        ProductStepper(
                            count: $countOfProducts,
                            addAction: addToCart,
                            removeAction: {
                                withAnimation {
                                    removeAction?()
                                }
                            }
                        )
                        .transition(.opacity)
                    }
                }
                .animation(.easeInOut, value: countOfProducts)
            )
    }
}
