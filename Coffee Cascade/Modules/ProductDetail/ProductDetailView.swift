//
//  ProductDetailView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 08.07.2024.
//

import Kingfisher
import SwiftUI

struct ProductDetailView<ViewModel: IProductDetailsViewModel>: View {
    @State
    private var offset: CGFloat = 0
    @StateObject
    var viewModel: ViewModel

    var body: some View {
        ZStack(alignment: .topTrailing) {
            KFImage(URL(string: viewModel.recipe.image))
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .edgesIgnoringSafeArea([.top, .bottom])

            VStack {
                Spacer()

                DetailScrollContent(
                    recipe: viewModel.recipe,
                    isCartEmpty: viewModel.isCartEmpty, 
                    addToCart: { viewModel.addToCart()},
                    countOfProducts: $viewModel.countOfProducts,
                    removeAction: { viewModel.removeFromCart() }
                )
                .cornerRadius(20)
                .offset(y: self.offset)
            }
        }
    }
}
