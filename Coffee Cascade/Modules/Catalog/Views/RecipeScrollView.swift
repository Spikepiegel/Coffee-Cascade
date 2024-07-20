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
    var selectedRecipe: (Recipe) -> ()
    @Binding var selectedCategory: String?
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(recipes) { recipe in
                        CoffeeView(image: recipe.image, name: recipe.name) {
                            selectedRecipe(recipe)
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

struct ShimmerView: View {
    @State private var isAnimating = false

    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.3), .gray.opacity(0.1), .gray.opacity(0.3)]), startPoint: .leading, endPoint: .trailing))
            .rotationEffect(Angle(degrees: 70))
            .offset(x: isAnimating ? 300 : -300)
            .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
    }
}
