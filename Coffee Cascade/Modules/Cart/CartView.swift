//
//  CartView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import SwiftUI

struct CartView<ViewModel: ICartViewModel>: View {
    @StateObject
    var viewModel: ViewModel

    var body: some View {
        VStack {
            CartTopNavigationView(onTapClose: { viewModel.closeCart() })

            ScrollView {
                VStack {
                    ShippingStatus(totalPrice: viewModel.totalPrice, priceFreeShipping: viewModel.priceFreeShipping)

                    CartProductsList(
                        products: $viewModel.products,
                        counts: $viewModel.productCounts,
                        addAction: { recipe in
                            viewModel.addToCart(recipe: recipe)
                        },
                        removeAction: { recipe in
                            viewModel.removeFromCart(recipe: recipe)
                        }
                    )
                }
            }
            .padding(.all, 2)
            
            Spacer()

            PaymentSlider(paymentConfirmed: $viewModel.paymentConfirmed)
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 15)
                .frame(height: 50)
        }
    }
}

