//
//  RecipeScrollView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import SwiftUI
import Kingfisher

struct RecipeScrollView: View {
    @Binding var recipes: [Recipe]
    @Binding var selectedRecipe: Recipe?
    @Binding var selectedCategory: String?
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(recipes) { recipe in
                        CoffeeView(image: recipe.image, name: recipe.name) {
                            selectedRecipe = recipe
                            preloadNextImages(currentRecipe: recipe)
                        }
                        .id(recipe.id)
                    }
                }
                .onChange(of: recipes) { newRecipes, _ in
                    withAnimation {
                        if let firstRecipe = newRecipes.first {
                            proxy.scrollTo(firstRecipe.id, anchor: .center)
                        }
                    }
                }
                .onChange(of: selectedCategory) {
                    withAnimation {
                        if let firstRecipe = recipes.first {
                            proxy.scrollTo(firstRecipe.id, anchor: .center)
                        }
                    }
                }
            }
            .contentMargins(25)
        }
    }
    
    private func preloadNextImages(currentRecipe: Recipe) {
        guard let currentIndex = recipes.firstIndex(where: { $0.id == currentRecipe.id }) else { return }
        
        let preloadCount = 3
        let endIndex = min(currentIndex + preloadCount, recipes.count)
        
        for i in currentIndex..<endIndex {
            let recipe = recipes[i]
            if let url = URL(string: recipe.image) {
                ImagePrefetcher(urls: [url]).start()
            }
        }
    }
}
