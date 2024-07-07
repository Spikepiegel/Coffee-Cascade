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

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(recipes) { recipe in
                        CoffeeView(image: recipe.image, name: recipe.name)
                            .id(recipe.id)
                            .transition(.slide)
                    }
                }
                .onChange(of: recipes) {
                    withAnimation {
                        proxy.scrollTo(recipes.first?.id, anchor: .center)
                    }
                }
            }
            .contentMargins(25)
        }
    }
}
