//
//  ProductKFImage.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 08.07.2024.
//

import SwiftUI
import Kingfisher

struct ProductKFImage: View {
    var image: String

    var body: some View {
        KFImage(URL(string: image))
            .placeholder {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
            .resizable()
            .scaledToFill()
            .clipped()
    }
}
