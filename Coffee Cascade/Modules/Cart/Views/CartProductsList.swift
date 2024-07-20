//
//  CartProductsList.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import SwiftUI
import Kingfisher

struct CartProductsList: View {
    @Binding
    var products: [Recipe]
    @Binding
    var counts: [String: Int]
    var addAction: (Recipe) -> Void
    var removeAction: (Recipe) -> Void

    var body: some View {
        LazyVStack {
            ForEach(products, id: \.self) { product in
                HStack(spacing: 10) {
                    KFImage(URL(string: product.image))
                        .resizable()
                        .frame(width: 90, height: 90)
                        .cornerRadius(16)

                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(CustomFont.custom(.interBold, size: 16))
                            .padding(.leading, 5)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer()

                        ProductStepper(
                            count: $counts[product.productID].unwrap(or: 0),
                            addAction: { addAction(product) },
                            removeAction: { removeAction(product) },
                            buttonSize: 34,
                            countSize: 12,
                            spacing: 15,
                            shouldShowPrice: false
                        )
                        .frame(width: 115, height: 50)
                    }

                    Spacer()

                    VStack {
                        let productCount = counts[product.productID] ?? 0
                        Text(String(format: "$%.2f", product.price * Double(productCount)))
                            .padding(.top, .zero)
                            .padding(.trailing, 10)
                        Spacer()
                    }
                }
                .padding(.leading, 10)
                .frame(height: 90)
            }
        }
    }
}
