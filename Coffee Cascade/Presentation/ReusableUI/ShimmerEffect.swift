//
//  ShimmerEffect.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 18.07.2024.
//

import SwiftUI

struct ShimmerEffect: ViewModifier {
    @State
    private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, Color.white.opacity(0.4), .clear]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .offset(x: phase * geometry.size.width * 1.5, y: 0)
                    .mask(content)
                }
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}

extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerEffect())
    }
}
