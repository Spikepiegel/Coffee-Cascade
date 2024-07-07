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
                colors: [.custom(.mainTopGradient), .custom(.mainBottomGradient)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                CategoriesScrollView(
                    categories: $viewModel.categories,
                    selectedCategory: $viewModel.selectedCategory
                )
                .frame(height: 80)
                
                
                RecipeScrollView(recipes: $viewModel.filteredRecipes)
                
                CatalogBottomNavigator()
                    .padding(.bottom, 5)
            }
        }
        .onAppear {
            Task {
                await viewModel.onAppear()
            }
        }
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe
    var namespace: Namespace.ID

    var body: some View {
        VStack {
            KFImage(URL(string: recipe.image))
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 36))
                .matchedGeometryEffect(id: recipe.id, in: namespace)
                .padding()

            Text(recipe.name)
                .font(.largeTitle)
                .padding()
            
            Spacer()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let viewModel = MockCatalogViewModel()
    return CatalogView(viewModel: viewModel)
}
