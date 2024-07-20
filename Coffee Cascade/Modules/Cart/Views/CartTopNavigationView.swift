//
//  CartTopNavigationView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import SwiftUI

struct CartTopNavigationView: View {
    let onTapClose: () -> Void

    var body: some View {
        HStack {
            Text("CART")
                .foregroundStyle(.black)
                .font(CustomFont.custom(.interSemiBold, size: 24))

            Spacer()

            Button(action: {
                onTapClose()
            }) {
                Image("close-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .padding(.leading, 20)
    }
}
