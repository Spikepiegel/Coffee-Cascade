//
//  CatalogPage.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Kingfisher
import SwiftUI

struct CatalogView<ViewModel: ICatalogViewModel>: View {
    @StateObject
    var viewModel: ViewModel
    @State
    private var isSearchViewPresented = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()

                VStack {
                    CatalogTopNavigationView {
                        isSearchViewPresented = true
                    } onCartButtonTapped: {
                        viewModel.openCartView()
                    }

                    CategoriesScrollView(
                        categories: $viewModel.categories,
                        selectedCategory: $viewModel.selectedCategory
                    )
                    .frame(height: 32)

                    Spacer()

                    RecipeScrollView(
                        recipes: $viewModel.filteredRecipes,
                        selectedRecipe: { recipe in viewModel.productDetailScreen(recipe: recipe) },
                        selectedCategory: $viewModel.selectedCategory
                    )

                    Spacer()
                }
            }
            .onAppear {
                Task {
                    await viewModel.onAppear()
                }
            }
            .navigationDestination(isPresented: $isSearchViewPresented) {
                let productCart: IProductCart = ProductCart.shared
                CatalogSearchView(
                    viewModel: CatalogSearchViewModel(
                        router: viewModel.router,
                        recipes: viewModel.recipes,
                        categories: viewModel.categories,
                        productCartSerivce: productCart
                    )
                )
            }
        }
    }
}
