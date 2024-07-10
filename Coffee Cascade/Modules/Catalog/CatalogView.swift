//
//  CatalogPage.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import SwiftUI
import Kingfisher

enum NavigationDestination {
    case searchView
}


struct CatalogView<ViewModel: ICatalogViewModel>: View {
    @StateObject var viewModel: ViewModel
    @State private var selectedRecipe: Recipe?
    @State private var isSearchViewPresented = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()

                VStack {
                    CatalogTopNavigationView {
                        isSearchViewPresented = true
                    }
                    
                    CategoriesScrollView(
                        categories: $viewModel.categories,
                        selectedCategory: $viewModel.selectedCategory
                    )
                    .frame(height: 32)

                    Spacer()

                    RecipeScrollView(
                        recipes: $viewModel.filteredRecipes,
                        selectedRecipe: $selectedRecipe,
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
            .fullScreenCover(item: $selectedRecipe) { recipe in
                ProductDetailView(recipe: recipe)
            }
            .navigationDestination(isPresented: $isSearchViewPresented) {
                CatalogSearchView(
                    viewModel: CatalogSearchViewModel(
                        recipes: viewModel.recipes,
                        categories: viewModel.categories
                    )
                )
            }
        }
    }
}


#Preview {
    let viewModel = MockCatalogViewModel()
    return CatalogView(viewModel: viewModel)
}


