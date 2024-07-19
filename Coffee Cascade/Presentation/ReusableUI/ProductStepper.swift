//
//  ProductStepper.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 19.07.2024.
//

import SwiftUI

struct ProductStepper: View {
    @Binding
    var count: Int
    var addAction: (() -> Void)?
    var removeAction: (() -> Void)?
    var buttonSize: CGFloat = 44
    var countSize: CGFloat = 18
    var spacing: CGFloat = 20
    let shouldShowPrice: Bool
    var body: some View {
        VStack {
            Spacer()

            HStack(spacing: spacing) {
                Button(action: { removeAction?() }) {
                    Image("stepper-remove-icon")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                    
                }
                .padding(.leading, 15)
                .padding([.top, .bottom], 10)

                Text(shouldShowPrice ? "\(count) x $2.99" : "\(count)")
                    .lineLimit(1)
                    .font(CustomFont.custom(.interSemiBold, size: countSize))

                Button(action: { addAction?() }) {
                    Image("stepper-add-icon")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                .padding(.trailing, 15)
                .padding([.top, .bottom], 10)
            }
            .background(Color.white)
            .cornerRadius(30)
            .frame(width: 240, height: 80)
            .padding(.bottom, 20)
        }
    }
}
