//
//  CoffeeView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import SwiftUI
import Kingfisher

struct CoffeeView: View {
    let image: String
    let name: String
    let onTap: () -> Void

    var body: some View {
        ZStack(alignment: .bottom) {
            GestureHandlingView {
                ProductKFImage(image: image)
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
                Text(name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        BlurView(style: .systemMaterialDark)
                    )
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
