//
//  AddToCartDetailsButton.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 18.07.2024.
//

import SwiftUI

struct AddToCartDetailsButton: View {
    var addToCart: (() -> Void)?

    var body: some View {
        VStack {
            Spacer()
            Button(action: { addToCart?() }) {
                HStack(spacing: 8) {
                    Image("cart-icon")
                        .resizable()
                        .frame(width: 22, height: 22)
                    Text("Add to cart")
                        .font(CustomFont.custom(.interSemiBold, size: 20))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .layoutPriority(1)
                }
                .padding([.top, .bottom], 20)
                .padding([.leading, .trailing], 30)
            }
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(30)
            .frame(width: 200, height: 80)
            .padding(.bottom, 20)
        }
    }
}
