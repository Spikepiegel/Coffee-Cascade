//
//  CatalogPage.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import SwiftUI
import Kingfisher

struct CatalogView<ViewModel: ICatalogViewModel>: View {
    @StateObject var viewModel: ViewModel
    @State private var selectedRecipe: Recipe?

    var body: some View {
        ZStack {
            Color.white
            .ignoresSafeArea()

            VStack {
                
                CatalogTopNavigationView()
                
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

//                CatalogBottomNavigator()
//                    .padding(.bottom, 5)
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
    }
}

#Preview {
    let viewModel = MockCatalogViewModel()
    return CatalogView(viewModel: viewModel)
}


