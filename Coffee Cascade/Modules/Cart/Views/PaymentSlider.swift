//
//  PaymentSlider.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import SwiftUI

struct PaymentSlider: View {
    @State
    private var offsetX: CGFloat = 0
    @Binding
    var paymentConfirmed: Bool
    @State
    private var isProcessing = false

    var body: some View {
        VStack {
            Spacer()
            if paymentConfirmed {
                Text("Success Payment!")
                    .font(CustomFont.custom(.interBold, size: 24))
                    .foregroundColor(.gray)
            } else if isProcessing {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(2.0)
                    .padding()
            } else {
                HStack {
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 45)
                            .overlay(
                                HStack {
                                    Image("debit_card_icon")
                                        .resizable()
                                        .frame(width: 65, height: 45)
                                        .offset(x: offsetX)
                                        .gesture(
                                            DragGesture()
                                                .onChanged { value in
                                                    let newOffsetX = value.translation.width
                                                    let dragThreshold = geometry.size.width - 90
                                                    if self.offsetX >= dragThreshold {
                                                        self.isProcessing = true
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                            withAnimation {
                                                                self.paymentConfirmed = true
                                                            }
                                                        }
                                                    }

                                                    if newOffsetX >= 0, newOffsetX <= geometry.size.width - 60 {
                                                        self.offsetX = newOffsetX
                                                    }
                                                }
                                                .onEnded { value in
                                                    let dragThreshold = geometry.size.width - 100
                                                    if self.offsetX >= dragThreshold {
                                                        self.isProcessing = true
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                            withAnimation {
                                                                self.paymentConfirmed = true
                                                            }
                                                        }
                                                    } else {
                                                        withAnimation {
                                                            self.offsetX = 0
                                                        }
                                                    }
                                                }
                                        )
                                    Spacer()
                                }
                            )
                            .padding(.horizontal)
                    }
                    .frame(height: 80)
                }
                .padding(.bottom, 20)
            }
        }
    }
}
