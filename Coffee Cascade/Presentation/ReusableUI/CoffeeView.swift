//
//  CoffeeView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Kingfisher
import SwiftUI

struct CoffeeView: View {
    let image: String
    let name: String
    let onTap: () -> Void

    @State
    private var isLoading = true

    var body: some View {
        ZStack(alignment: .bottom) {
            GestureHandlingView {
                KFImage(URL(string: image))
                    .placeholder {
                        Rectangle()
                            .foregroundColor(.gray)
                            .cornerRadius(36)
                            .shimmer()
                    }
                    .onSuccess { _ in
                        isLoading = false
                    }
                    .onFailure { _ in
                        isLoading = false
                    }
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .scrollTransition(axis: .horizontal) { content, phase in
                        content
                            .offset(x: phase.isIdentity ? 0 : phase.value * -200)
                    }
                    .containerRelativeFrame(.horizontal)
                    .clipShape(RoundedRectangle(cornerRadius: 36))
            }
            .onTapGesture {
                onTap()
            }

            VStack {
                Spacer()
                VStack {
                    GeometryReader { geometry in
                        Text(name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: geometry.size.height, alignment: .top)
                            .background(
                                BlurView(style: .systemMaterialDark)
                            )
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(height: 50)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 36))
    }
}

#Preview {
    let image = "https://athome.starbucks.com/sites/default/files/2021-06/1_CAH_CaffeMocha_Hdr_2880x16602.jpg"
    return CoffeeView(image: image, name: "123", onTap: {
        print("tapped")
    })
}
