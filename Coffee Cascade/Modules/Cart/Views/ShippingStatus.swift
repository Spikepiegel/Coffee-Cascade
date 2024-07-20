//
//  ShippingStatus.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import SwiftUI

struct ShippingStatus: View {
    var totalPrice: Double
    var priceFreeShipping: Double

    var body: some View {
        VStack {
            HStack(spacing: 30) {
                Image(systemName: "car.fill")
                    .resizable()
                    .frame(width: 24, height: 24)

                VStack(alignment: .leading) {
                    HStack {
                        Text("Before free shipping")
                            .font(CustomFont.custom(.interLight, size: 16))

                        Spacer()

                        Text("$\(String(format: "%.2f", max(priceFreeShipping - totalPrice, 0)))")
                            .font(CustomFont.custom(.interBold, size: 16))
                    }

                    ProgressBar(value: totalPrice / priceFreeShipping)
                        .frame(height: 8)
                        .cornerRadius(4)
                }
            }
            .padding()
        }
    }
}
