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
    var body: some View {
        KFImage(URL(string: image))
            .placeholder {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
                    .clipped()
            }
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.6)
            .clipped()
            .scrollTransition(axis: .horizontal) { content, phase in
                content
                    .offset(x: phase.isIdentity ? 0 : phase.value * -200)
            }
    }
}

#Preview {
    let image = "https://athome.starbucks.com/sites/default/files/2021-06/1_CAH_CaffeMocha_Hdr_2880x16602.jpg"
    return CoffeeView(image: image)
}
