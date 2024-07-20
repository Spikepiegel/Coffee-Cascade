//
//  CatalogSearchView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import Kingfisher
import SwiftUI

struct CatalogSearchView<ViewModel: ICatalogSearchViewModel>: View {
    @StateObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""

    var body: some View {
        VStack {
            CatalogSearchTopNavigationView(presentationMode: presentationMode)
                .padding()
                .background(Color.white)

            CatalogSearchBar(searchText: $searchText)
                .padding(.horizontal)

            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 40), count: 2), spacing: 0) {
                    ForEach(viewModel.recipes.filter {
                        searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())
                    }) { recipe in
                        CoffeeSearchView(
                            recipe: recipe,
                            count: $viewModel.productCounts[recipe.productID].unwrap(or: 0),
                            addToCart: { viewModel.addToCart(recipe: recipe) },
                            removeAction: { viewModel.removeFromCart(recipe: recipe) }
                        )
                        .frame(width: 170, height: 250)
                        .onTapGesture {
                            viewModel.productDetailScreen(recipe: recipe)
                        }
                    }
                }
                .padding()
            }
            .padding()
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden(true)
    }
}
