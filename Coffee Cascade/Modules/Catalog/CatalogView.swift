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
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.white, .blue],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                CategoriesScrollView(categories: $viewModel.categories, selectedCategory: $viewModel.selectedCategory)
                                    .frame(height: 80)
                
                RecipeScrollView(recipes: $viewModel.filteredRecipes)
            }
            

        }
        .onAppear {
            Task {
                await viewModel.onAppear()
            }
        }
    }
}

#Preview {
    let viewModel = MockCatalogViewModel()
    return CatalogView(viewModel: viewModel)
}
